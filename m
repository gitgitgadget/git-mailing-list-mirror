From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH (resend)] post-receive-email: remove spurious commas in email subject
Date: Wed, 11 Aug 2010 10:14:13 +0200
Message-ID: <1281514453-23855-1-git-send-email-Matthieu.Moy@imag.fr>
References: <4C581E98.6090504@digium.com>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Aug 11 10:18:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oj6W2-0001cr-6E
	for gcvg-git-2@lo.gmane.org; Wed, 11 Aug 2010 10:18:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757837Ab0HKISU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Aug 2010 04:18:20 -0400
Received: from imag.imag.fr ([129.88.30.1]:36735 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752900Ab0HKISS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Aug 2010 04:18:18 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id o7B8EFc3016264
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 11 Aug 2010 10:14:15 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1Oj6Rz-0001p3-C8; Wed, 11 Aug 2010 10:14:15 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1Oj6Rz-0006DM-A0; Wed, 11 Aug 2010 10:14:15 +0200
X-Mailer: git-send-email 1.7.2.1.52.g95e25.dirty
In-Reply-To: <4C581E98.6090504@digium.com>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Wed, 11 Aug 2010 10:14:16 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153200>

The previous form produced subjects like

  [SCM] project.git branch, foo, updated. ...

The new one will produce the lighter

  [SCM] project.git branch foo updated. ...

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
"Kevin P. Fleming" <kpfleming@digium.com> writes:

> On 08/03/2010 08:10 AM, Matthieu Moy wrote:
>
>> I am the only one bothered by these extra commas in email subject? If
>> so, I can live with it, but I thought I'd give it a try ;-).
>
> No, I've removed them in our local copy as well, but never bothered to
> send the changes to the list :-)

I guess it's time to get this into git.git then ...

 contrib/hooks/post-receive-email |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/hooks/post-receive-email b/contrib/hooks/post-receive-email
index 30ae63d..09c5241 100755
--- a/contrib/hooks/post-receive-email
+++ b/contrib/hooks/post-receive-email
@@ -203,7 +203,7 @@ generate_email_header()
 	# Generate header
 	cat <<-EOF
 	To: $recipients
-	Subject: ${emailprefix}$projectdesc $refname_type, $short_refname, ${change_type}d. $describe
+	Subject: ${emailprefix}$projectdesc $refname_type $short_refname ${change_type}d. $describe
 	X-Git-Refname: $refname
 	X-Git-Reftype: $refname_type
 	X-Git-Oldrev: $oldrev
-- 
1.7.2.1.52.g95e25.dirty
