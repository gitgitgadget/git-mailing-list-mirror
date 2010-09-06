From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 04/15] gettextize: git-clean clean.requireForce messages
Date: Mon,  6 Sep 2010 12:21:33 +0000
Message-ID: <1283775704-29440-5-git-send-email-avarab@gmail.com>
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
X-From: git-owner@vger.kernel.org Mon Sep 06 14:22:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Osait-0000aR-5h
	for gcvg-git-2@lo.gmane.org; Mon, 06 Sep 2010 14:22:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753551Ab0IFMWV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Sep 2010 08:22:21 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:62334 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752554Ab0IFMWO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Sep 2010 08:22:14 -0400
Received: by mail-ww0-f44.google.com with SMTP id 40so6463612wwj.1
        for <git@vger.kernel.org>; Mon, 06 Sep 2010 05:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=+KWcczNyKcNxgv9VzpERrlvSC+bBziW1tZkXlOgQxpE=;
        b=Lt/Zs1u5L5IyhWpP2lDCIh3UbudXVvidv25LbLq/s6yhAxYnF2RPPCD2VP+a5OF1/a
         EQlcnp7PBTXbF9Sd+Zq8JEHMbV+hu7KrxyiChGGabFeb/SplqQZGIzWLGO/DKgylwx5b
         NI30/kYNJHUdXsr+lkVkDMPWVHflTnQy2cCCM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=XVZms231rYVkyMChJlOJw2FCBW3QcpgDOPZYqYzwZl9J/T1Dc09KtxGGX0Eh8Vk1Y4
         EPOqv+nQ/JBE8al4hxyAP2hpsqEUpSZHlJ+Khng0zo/WXx/cTp2/A0G/KsyRl7gYYDrY
         WEg1yu0G/7Ke1n9EtuRpC8tdJGz6X/qP6SJlQ=
Received: by 10.227.134.136 with SMTP id j8mr906525wbt.206.1283775733966;
        Mon, 06 Sep 2010 05:22:13 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id p82sm3297372weq.3.2010.09.06.05.22.11
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 06 Sep 2010 05:22:12 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.3.313.gcd15
In-Reply-To: <1283638229-14199-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155557>

Split up the "clean.requireForce set/defaults to true..." die()
message to make it easier to translate.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/clean.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/builtin/clean.c b/builtin/clean.c
index 10dde87..642d767 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -78,8 +78,12 @@ int cmd_clean(int argc, const char **argv, const cha=
r *prefix)
 		die(_("-x and -X cannot be used together"));
=20
 	if (!show_only && !force)
-		die("clean.requireForce %s to true and neither -n nor -f given; "
-		    "refusing to clean", config_set ? "set" : "defaults");
+		if (config_set)
+			die(_("clean.requireForce set to true and neither -n nor -f given; =
"
+				  "refusing to clean"));
+		else
+			die(_("clean.requireForce defaults to true and neither -n nor -f gi=
ven; "
+				  "refusing to clean"));
=20
 	if (force > 1)
 		rm_flags =3D 0;
--=20
1.7.2.3.313.gcd15
