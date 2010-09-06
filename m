From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 09/15] gettextize: git-notes GIT_NOTES_REWRITE_MODE error message
Date: Mon,  6 Sep 2010 12:21:38 +0000
Message-ID: <1283775704-29440-10-git-send-email-avarab@gmail.com>
References: <1283638229-14199-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Jan=20Kr=C3=BCger?= <jk@jk.gs>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 06 14:23:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Osaiv-0000aR-HC
	for gcvg-git-2@lo.gmane.org; Mon, 06 Sep 2010 14:22:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753927Ab0IFMWg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Sep 2010 08:22:36 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:42959 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753676Ab0IFMWf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Sep 2010 08:22:35 -0400
Received: by mail-wy0-f174.google.com with SMTP id 22so2884659wyf.19
        for <git@vger.kernel.org>; Mon, 06 Sep 2010 05:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=cjggTe2mVUMMlHrwQq00U0blm4HuUnSb5WzZxcU3y4M=;
        b=qH5kfVs0fSbHs1w8B2ldZI1+n/4FFwHgBGF0aI2cX+YPdYF87e7tre+Jp+f6miItpw
         GtGxYWGAcIRvS7y6XsXgetDa9N4GylQtlOnnfZygrEG8YJuki3PkM8w0wxz/QmcNP1Pn
         HPQhZFU9DXUYwzSPR5xg+AV2mD9Yi5aWws+Bs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=uPfxiKaRpdNGISMXVbcvyWNeVRP92CMuuopna1hgBzPW8B+K+wY6yMGsiuBCkpror/
         dsl83L7QrE3zy7aahiC1MUiVqgWo/lUzFdW9LkM0QNH2+zWJuOk+FSi/r3WHnnaUbHkj
         H8CWDoeF/Qm80foWEy6aaj2Y0aH/0bu7eP6ck=
Received: by 10.216.15.10 with SMTP id e10mr2802369wee.21.1283775754504;
        Mon, 06 Sep 2010 05:22:34 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id p82sm3297372weq.3.2010.09.06.05.22.33
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 06 Sep 2010 05:22:33 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.3.313.gcd15
In-Reply-To: <1283638229-14199-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155563>

Use sprintf format for the error message that's displayed if
GIT_NOTES_REWRITE_MODE is invalid, and leave a note in a TRANSLATORS
comment indicating what the message means.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/notes.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index d171f6f..fe58a41 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -371,8 +371,10 @@ struct notes_rewrite_cfg *init_copy_notes_for_rewr=
ite(const char *cmd)
 		c->mode_from_env =3D 1;
 		c->combine =3D parse_combine_notes_fn(rewrite_mode_env);
 		if (!c->combine)
-			error("Bad " GIT_NOTES_REWRITE_MODE_ENVIRONMENT
-			      " value: '%s'", rewrite_mode_env);
+			/* TRANSLATORS: The first %s is the name of the
+			   environment variable, the second %s is its value */
+			error(_("Bad %s value: '%s'"), GIT_NOTES_REWRITE_MODE_ENVIRONMENT,
+					rewrite_mode_env);
 	}
 	if (rewrite_refs_env) {
 		c->refs_from_env =3D 1;
--=20
1.7.2.3.313.gcd15
