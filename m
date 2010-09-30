From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 11/16] send-email: use (?:) instead of () if no  match variables are needed
Date: Thu, 30 Sep 2010 13:43:04 +0000
Message-ID: <1285854189-10240-12-git-send-email-avarab@gmail.com>
References: <1285854189-10240-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Ryan Anderson <rda@google.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 30 15:44:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1JR1-0001Ej-9u
	for gcvg-git-2@lo.gmane.org; Thu, 30 Sep 2010 15:44:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756077Ab0I3NoW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 30 Sep 2010 09:44:22 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:42011 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754656Ab0I3NoV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Sep 2010 09:44:21 -0400
Received: by mail-wy0-f174.google.com with SMTP id 28so1858034wyb.19
        for <git@vger.kernel.org>; Thu, 30 Sep 2010 06:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=+rvq07ScwHscoa8I86/469owfQdcbqR49UrwPZMJFFQ=;
        b=J/smb+O23AA4CtjhXH1Pxyif7TyjMyFw3o9jTbRMex5oevA4PzrDt4Vq5napJl5Ty3
         BXz/GH2eRUNgQXnbnM08+bE+oDmVA5SBD2V5XMgmT5Eb2QA7IEFpw3+lPdQczJnv02ij
         Ng0xkEr1DFRXTIDBdm5PrgKeK9M467+Tkiqe0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=lhHZJUHA2CEHZ6oYcWpzQaqZyovcQZLR11yeKR519GxxpKpkhljB0CrvJbS7uhjNWr
         Y3NVv0jBVyTZkhJiQ5jwz9KBuTeKncL5KKSdyWCi7NKz7uSqBYXCHZetgNlV9UscI0DC
         SzCoXyozRJcoGpiAYuc2BK3X5Hir99sHNUgLg=
Received: by 10.216.10.145 with SMTP id 17mr3055125wev.27.1285854260859;
        Thu, 30 Sep 2010 06:44:20 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id e56sm6328567wer.46.2010.09.30.06.44.19
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 30 Sep 2010 06:44:19 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.159.g610493
In-Reply-To: <1285854189-10240-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157660>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-send-email.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index c012b95..5a0c4a8 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -365,7 +365,7 @@ my(%suppress_cc);
 if (@suppress_cc) {
 	foreach my $entry (@suppress_cc) {
 		die "Unknown --suppress-cc field: '$entry'\n"
-			unless $entry =3D~ /^(all|cccmd|cc|author|self|sob|body|bodycc)$/;
+			unless $entry =3D~ /^(?:all|cccmd|cc|author|self|sob|body|bodycc)$/=
;
 		$suppress_cc{$entry} =3D 1;
 	}
 }
--=20
1.7.3.159.g610493
