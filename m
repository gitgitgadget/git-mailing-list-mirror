From: "Eric Raible" <raible@gmail.com>
Subject: PATCH] Documentation: Tweak use case in "git stash save --keep-index"
Date: Mon, 7 Jul 2008 22:18:03 -0700
Message-ID: <279b37b20807072218o19dabd97y2c4edc62fb980ca4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>, szeder@ira.uka.de
X-From: git-owner@vger.kernel.org Tue Jul 08 07:19:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KG5bX-00074F-7q
	for gcvg-git-2@gmane.org; Tue, 08 Jul 2008 07:19:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750994AbYGHFSJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2008 01:18:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750888AbYGHFSI
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jul 2008 01:18:08 -0400
Received: from wf-out-1314.google.com ([209.85.200.171]:45928 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750796AbYGHFSF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2008 01:18:05 -0400
Received: by wf-out-1314.google.com with SMTP id 27so2398111wfd.4
        for <git@vger.kernel.org>; Mon, 07 Jul 2008 22:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=NpsDvcLNdt/2MP5gpc5kiM2M0hOarIj5Fyjt/dAsY5c=;
        b=Ec4ehydvwfkAZqHdZ6igCN42/7Z2O8XEWy1l1yiPYvNxIIpGCO1HvAvAao5mh3iB1n
         GH0AvYnPi/pBGG7IguTV/dxwI39K27FobBPK6kY4JJX7ZsmjdFrQH7VpslovCE+0G/Jy
         ti33qdwuNmhnALifLCOI9ThcQAH+cWuIfQGlA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=TGsN7pEz8Pc83IAtSUdNF9BGsghSsQaLog/yuFuqOqA0sRN8z/NdYtZWG6Vn1T35z2
         mddGxURp6m4RUJFp0BJGVsUNPxR0ge4BVZqwpC/TJrtoogLxKSUXzo12AnjwuYU76j3W
         CCbpiJVdLLnmZ4Lsq+bB0MJ+Gt/ZlwPODSaOs=
Received: by 10.142.142.14 with SMTP id p14mr1643307wfd.114.1215494283454;
        Mon, 07 Jul 2008 22:18:03 -0700 (PDT)
Received: by 10.142.14.12 with HTTP; Mon, 7 Jul 2008 22:18:03 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87715>

The documentation suggests using "git stash apply" in the
--keep-index workflow even though doing so will lead to clutter
in the stash.  And given that the changes are about to be
committed anyway "git stash pop" is more sensible.

Additionally the text preceeding the example claims that it
works for "two or more commits", but the example itself is
really tailored for just two.  Expanding it just a little
makes it clear how the procedure generalizes to N commits.

Signed-off-by: Eric Raible <raible@gmail.com>
---
Note that this is relative to Junio's pu branch (v1.5.6.2-397-g20210bb)

 Documentation/git-stash.txt |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index df26901..bf241da 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -201,9 +201,10 @@ $ git add --patch foo
 $ git stash save --keep-index
 $ build && run tests
 $ git commit -m 'First part'
-$ git stash apply
+$ git stash pop
+... repeat above five steps until one commit remains ...
 $ build && run tests
-$ git commit -a -m 'Second part'
+$ git commit foo -m 'Remaining parts'
 ----------------------------------------------------------------

 SEE ALSO
-- 
1.5.6.1.1073.g489ff.dirty
