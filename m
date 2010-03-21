From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH] Improve documentation for git-remote-helpers
Date: Sun, 21 Mar 2010 23:51:13 +0530
Message-ID: <f3271551003211121o48f502fp954b649ff4ca8f8b@mail.gmail.com>
References: <f3271551003211026m376b86d6ga915f85a623eddfd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Mar 21 19:21:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtPmX-0008Ih-09
	for gcvg-git-2@lo.gmane.org; Sun, 21 Mar 2010 19:21:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751295Ab0CUSVf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 21 Mar 2010 14:21:35 -0400
Received: from mail-gx0-f217.google.com ([209.85.217.217]:56218 "EHLO
	mail-gx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750799Ab0CUSVe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 Mar 2010 14:21:34 -0400
Received: by gxk9 with SMTP id 9so59694gxk.8
        for <git@vger.kernel.org>; Sun, 21 Mar 2010 11:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=BRs1oE6Q+WMjV73ElNu6KOmhzIAO5VsahCYtz3kRpEc=;
        b=brr2sWH6+tvevW/3ERUJ1ytjcNxajnDI7awApIOmYg3xkid6aNoAx5ovQnPdJ0UWTG
         I2fX/X5DrgwYV2dfT4VM91KJ9nIGmTu6a+OtimBAWkihQpu5pro8L0n7NOEH/2rs6onu
         0/sHidazrTieXtXJ1hPAKMNtEaPu2ZPSkJmRA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=XP4Rj2uauT3tpZlAcQI3bi1pzY8ckFLRZHa52U2vdE5dEr7Likty+D/s/XIFtrw6Vd
         1aqC3EPS3lUP3t/9kO6H94xagrZRal+WON3JihmkbtmaaKcxqok2Nrf1SsMOgy2yiZB+
         +Txc+NtPLMa3BtianjPhKG/FkguJdx74ZdQl0=
Received: by 10.91.85.4 with SMTP id n4mr3163347agl.23.1269195693095; Sun, 21 
	Mar 2010 11:21:33 -0700 (PDT)
In-Reply-To: <f3271551003211026m376b86d6ga915f85a623eddfd@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142848>

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
=A0Documentation/git-remote-helpers.txt | =A0 22 ++++++++++++++++------
=A01 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-remote-helpers.txt
b/Documentation/git-remote-helpers.txt
index 1b5f61a..54b36c8 100644
--- a/Documentation/git-remote-helpers.txt
+++ b/Documentation/git-remote-helpers.txt
@@ -3,7 +3,8 @@ git-remote-helpers(1)

=A0NAME
=A0----
-git-remote-helpers - Helper programs for interoperation with remote gi=
t
+git-remote-helpers - Helper programs for interacting with main git
+programs without linking to them

=A0SYNOPSIS
=A0--------
@@ -13,10 +14,19 @@ DESCRIPTION
=A0-----------

=A0These programs are normally not used directly by end users, but are
-invoked by various git programs that interact with remote repositories
-when the repository they would operate on will be accessed using
-transport code not linked into the main git binary. Various particular
-helper programs will behave as documented here.
+invoked by various git programs that interact with remote
+repositories. =A0For a program to qualify as a remote helper, it must
+implement a subset of the capabilities documented here, and conform to
+the remote helper protocol. Remote helpers interact with the main git
+programs via text streams, and do not link to them.
+
+The curl helper is one such program. It is invoked via
+'git-remote-http', 'git-remote-https', 'git-remote-ftp', or
+'git-remote-ftps', and implments the capabilities 'fetch', 'option',
+and 'push'.
+
+Remote helpers are often useful when native interoperability with a
+foreign versioning system is desired.

=A0COMMANDS
=A0--------
@@ -122,7 +132,7 @@ CAPABILITIES
=A0 =A0 =A0 =A0This helper supports the 'fetch' command.

=A0'option'::
- =A0 =A0 =A0 This helper supports the option command.
+ =A0 =A0 =A0 This helper supports the 'option' command.

=A0'push'::
=A0 =A0 =A0 =A0This helper supports the 'push' command.
--
1.7.0
