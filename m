From: "Scott Chacon" <schacon@gmail.com>
Subject: [PATCH] Updated githooks docs to cover pre-push script
Date: Tue, 19 Aug 2008 12:07:18 -0700
Message-ID: <d411cc4a0808191207j28380749i922ae9981f3e32dd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>
To: "git list" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 19 21:08:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVWZE-0003yk-QQ
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 21:08:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752620AbYHSTHW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2008 15:07:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752770AbYHSTHW
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 15:07:22 -0400
Received: from yx-out-2324.google.com ([74.125.44.28]:49436 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751617AbYHSTHV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2008 15:07:21 -0400
Received: by yx-out-2324.google.com with SMTP id 8so28916yxm.1
        for <git@vger.kernel.org>; Tue, 19 Aug 2008 12:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=MV2Y7OJ13BsJWMz6g2nzJPWYdoKL4/jygrlzfO5KaAk=;
        b=cSo3irYxWwtfDWyctte9PP2HmOqkaWCSHOaKdPxbVLO8JXxA6zNvOY15ceXg/hkFQS
         odgouMILXeYUkWkTaUNi/srC3d1ykrl3hgjy4EUo5BkyM4EYKRrc/4lgcimsk4grzwXy
         Fhh29AYDL8/YspZ9IcXxDTi8stjfYsILh66QY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=pR6OMlm+lR2GxE5KWPV1U3g6khuGw8MGd7wt+H0EAULgekQ8CQCKKjYJnLQKek/eUD
         T6xKRWFmgz/cU0ryE0X57DHoGSYy9iRwUuC5Td81uSCs0GKH6K3QaxvBr954ULLBxtDs
         SH8vSCAiiVKeIHGOmA/Ix5DMPbIMRFLed7pyk=
Received: by 10.114.168.15 with SMTP id q15mr7095123wae.167.1219172838660;
        Tue, 19 Aug 2008 12:07:18 -0700 (PDT)
Received: by 10.114.170.3 with HTTP; Tue, 19 Aug 2008 12:07:18 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92907>

The new entry covers how the pre-push script runs and outlines
possible use-cases for the script.

Signed-off-by: Scott Chacon <schacon@gmail.com>
---
 Documentation/githooks.txt |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 046a2a7..939181f 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -299,6 +299,18 @@ This hook is invoked by 'git-gc --auto'. It takes
no parameter, and
 exiting with non-zero status from this script causes the 'git-gc --auto'
 to abort.

+pre-push
+-----------
+
+This hook is invoked by 'git push'. It takes no parameter, and
+exiting with non-zero status from this script causes the 'git push'
+command to abort.
+
+This script is useful for self-enforcing policies, such as running a script
+that checks for code-compliance, running automated tests, etc.  You can
+use this script to help ensure that your pushes are sane in an automatic
+fashion.
+
 GIT
 ---
 Part of the linkgit:git[1] suite
--
1.6.0.GIT
