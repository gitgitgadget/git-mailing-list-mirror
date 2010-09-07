From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 01/20] gettextize: git-clean clean.requireForce braces
Date: Tue,  7 Sep 2010 16:45:36 +0000
Message-ID: <1283877955-19105-2-git-send-email-avarab@gmail.com>
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
X-From: git-owner@vger.kernel.org Tue Sep 07 18:46:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ot1Jb-0001wS-Sk
	for gcvg-git-2@lo.gmane.org; Tue, 07 Sep 2010 18:46:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757933Ab0IGQqY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Sep 2010 12:46:24 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:51017 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757923Ab0IGQqX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Sep 2010 12:46:23 -0400
Received: by wwj40 with SMTP id 40so8411875wwj.1
        for <git@vger.kernel.org>; Tue, 07 Sep 2010 09:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=XivrvKlpNCL6NQLJghaX+8YUXAVuqt+YjWtzC/BsbqU=;
        b=K3cWOwGTCcFhC0oL0eqJpuPBYwN9Wi74A9zSUugrD550BGAe81GB0AQtmERjoSSVrq
         1PsUFZHUPS5i9vpXeskuZ05wWxBJZPyQQeOet8Ub9Yax3Xi83TpyJ/Phwno9YXLnT3g9
         k0v5TqVTC0bQFY3Jp6lfWztHpLAtIdoqDpDX8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=Mf34RuKXbLCpcQV6UvomDJGMBWmOblAehpcYs5O5nnAfQ3g5Z46fpQFdnL+aaxPpPT
         WFYNfoxTY/q7aSYJ07wR3gioYvWfdcoWmDJlW6R6GmFsm0pMjlO0RdH2RoKfJSUjnIYJ
         4p/FvSprUei8t55SzdMAlyjz3IdqsNOhcCD8U=
Received: by 10.227.142.75 with SMTP id p11mr114246wbu.27.1283877981789;
        Tue, 07 Sep 2010 09:46:21 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id k83sm4304468weq.14.2010.09.07.09.46.19
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 07 Sep 2010 09:46:20 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.3.313.gcd15
In-Reply-To: <1283877955-19105-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155710>

Use braces around a nested if/if/else to appease GCC, which'll whine
under -Wall and "suggest explicit braces to avoid ambiguous =E2=80=98el=
se=E2=80=99".

This code was originally added in "gettextize: git-clean
clean.requireForce messages", and tested under clang (which doesn't
whine about perfectly valid uses of C).

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/clean.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/builtin/clean.c b/builtin/clean.c
index 50ade84..52ec17a 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -77,13 +77,14 @@ int cmd_clean(int argc, const char **argv, const ch=
ar *prefix)
 	if (ignored && ignored_only)
 		die(_("-x and -X cannot be used together"));
=20
-	if (!show_only && !force)
+	if (!show_only && !force) {
 		if (config_set)
 			die(_("clean.requireForce set to true and neither -n nor -f given; =
"
 				  "refusing to clean"));
 		else
 			die(_("clean.requireForce defaults to true and neither -n nor -f gi=
ven; "
 				  "refusing to clean"));
+	}
=20
 	if (force > 1)
 		rm_flags =3D 0;
--=20
1.7.2.3.313.gcd15
