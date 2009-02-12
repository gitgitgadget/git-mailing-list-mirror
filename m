From: Jacob Helwig <jacob.helwig@gmail.com>
Subject: [PATCH] Add 'rm -f' equivalent to 'git rm' example of filter-branch --index-filter
Date: Thu, 12 Feb 2009 10:01:10 -0800
Message-ID: <1234461670-25657-1-git-send-email-jacob.helwig@gmail.com>
References: <AB13D1C5-4464-49B5-8314-FCB1E249BF22@semanticart.com>
Cc: Jacob Helwig <jacob.helwig@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 12 19:09:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXfzs-0006Pg-H6
	for gcvg-git-2@gmane.org; Thu, 12 Feb 2009 19:09:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760138AbZBLSHn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2009 13:07:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760109AbZBLSHn
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Feb 2009 13:07:43 -0500
Received: from wf-out-1314.google.com ([209.85.200.172]:28190 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758305AbZBLSHl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2009 13:07:41 -0500
Received: by wf-out-1314.google.com with SMTP id 28so936560wfa.4
        for <git@vger.kernel.org>; Thu, 12 Feb 2009 10:07:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=d3E0gVlTRwgDY3eF4VIx3JiPOGEWg7JPtKwJ0uk8Zas=;
        b=JOdzswnFnxL04Rdo8eTev3kHjHmerCIZIQWxwEVM5m/sSrnpQfSToda13T32M2Sz53
         CsEiQbLVnYUkV9MO1T8ognp9IkVIlK/7Bsbp47fXNW+f6fKM5Hq3fB7tb4UFkZGMi7MQ
         snqXLiSP41f2y65f2mZXKERoK0s9lQ+rIZOvo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=LOapiY95l8vH5QaJLyoheIKu9DCV9mLin2BhtWYcL4EwkB3O9+v7gzgCbM+6BYa/ec
         D7lI5DbQ8jUOJinSr1rhd2D3umwKDW83ujO+QX9WLB/mzb38urAoZ7UM46EpUPIMHdSS
         TcdcCSq21qOP1dgTvFobMU7pPCL8L5uBVlFyk=
Received: by 10.142.108.2 with SMTP id g2mr559818wfc.190.1234461672977;
        Thu, 12 Feb 2009 10:01:12 -0800 (PST)
Received: from localhost.localdomain ([70.102.219.22])
        by mx.google.com with ESMTPS id 28sm403667wfg.31.2009.02.12.10.01.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 12 Feb 2009 10:01:11 -0800 (PST)
X-Mailer: git-send-email 1.6.1.1
In-Reply-To: <AB13D1C5-4464-49B5-8314-FCB1E249BF22@semanticart.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109635>

Signed-off-by: Jacob Helwig <jacob.helwig@gmail.com>
---
 Documentation/git-filter-branch.txt |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
index 451950b..1fbbbb4 100644
--- a/Documentation/git-filter-branch.txt
+++ b/Documentation/git-filter-branch.txt
@@ -212,6 +212,11 @@ git filter-branch --index-filter 'git rm --cached filename' HEAD
 
 Now, you will get the rewritten history saved in HEAD.
 
+As with using `rm filename`, `git rm --cached filename` will fail
+if the file is absent from the tree of a commit.  If it is not important
+whether the file is already absent from the tree, you can use
+`git rm --cached --ignore-unmatch filename` instead.
+
 To rewrite the repository to look as if `foodir/` had been its project
 root, and discard all other history:
 
-- 
1.6.1.1
