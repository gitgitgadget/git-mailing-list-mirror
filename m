From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 20/20] gettextize: git-am printf(1) message to eval_gettext
Date: Tue,  7 Sep 2010 16:50:24 +0000
Message-ID: <1283878224-20202-1-git-send-email-avarab@gmail.com>
References: <1283877955-19105-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Jan=20Kr=C3=BCger?= <jk@jk.gs>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 07 18:51:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ot1OE-0004K7-9s
	for gcvg-git-2@lo.gmane.org; Tue, 07 Sep 2010 18:51:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757143Ab0IGQuf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Sep 2010 12:50:35 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:51232 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932144Ab0IGQuc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Sep 2010 12:50:32 -0400
Received: by wwj40 with SMTP id 40so8417190wwj.1
        for <git@vger.kernel.org>; Tue, 07 Sep 2010 09:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=+zKvwqu+V21iFhbm3Yfv7KsaftgiVycLdXaLZlhTLCg=;
        b=TTBj+a30CsKhP02gm0Pdsdv6SC+612nknJOU3YUF5OKUIOg9GobKRmqPzgR437G/y0
         w/YBO/e0w0kjEAMwHMUiu9blZvO5ETg5vKgBVjjIwBrQGPQymCiHt1E+zXFqkE4eNior
         MuCbdZ0YCKJC18wKy+RBndB3fPp/h4PwsfEK8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=jH7ImeHBqgprq9dF3WGCCwJOHlSZcPG4WQgrs4954TxAf58I+hWLNObHbYY14sPbIo
         lPxDRUo+JQYpXTZRteMXhyLyVjBhsqfCCci2CV0U6abes3XtNaS9ztrylNkBJtWMYuuG
         Q/X0FTB9KUzHNNHqZ+mwVKdwd3xu81vEnP3DI=
Received: by 10.227.151.195 with SMTP id d3mr199595wbw.170.1283878230995;
        Tue, 07 Sep 2010 09:50:30 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id w31sm5895861wbd.3.2010.09.07.09.50.30
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 07 Sep 2010 09:50:30 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.3.313.gcd15
In-Reply-To: <1283877955-19105-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155728>

Convert a message that used printf(1) format to use eval_gettext. It's
easier for translators to handle the latter, since the eval format
automatically gives them context via variable names.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-am.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index 6992d92..a13d488 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -778,7 +778,7 @@ did you forget to use 'git add'?"; echo
 	fi
 	if test $apply_status !=3D 0
 	then
-		printf 'Patch failed at %s %s\n' "$msgnum" "$FIRSTLINE"
+		echo "$(eval_gettext "Patch failed at \$msgnum \$FIRSTLINE")"
 		stop_here_user_resolve $this
 	fi
=20
--=20
1.7.2.3.313.gcd15
