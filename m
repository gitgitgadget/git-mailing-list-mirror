From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v4 63/73] gettextize: git-clean clean.requireForce messages
Date: Tue, 22 Feb 2011 23:42:22 +0000
Message-ID: <1298418152-27789-64-git-send-email-avarab@gmail.com>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 23 00:45:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ps1vD-0000K1-4z
	for gcvg-git-2@lo.gmane.org; Wed, 23 Feb 2011 00:45:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755592Ab1BVXoj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Feb 2011 18:44:39 -0500
Received: from mail-bw0-f51.google.com ([209.85.214.51]:33701 "EHLO
	mail-bw0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755578Ab1BVXog (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Feb 2011 18:44:36 -0500
Received: by mail-bw0-f51.google.com with SMTP id 10so3866742bwz.10
        for <git@vger.kernel.org>; Tue, 22 Feb 2011 15:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=aPbQoHnW+H6/o4izFd18CLvpWuNub9m+Zcbv5cVsjn0=;
        b=m4eX0dk2mGDaMovdY27fpXAga3uAk5XGOmmMKtASbAO6sRFvAQba79YYJ+CVVK5UwR
         4hxAVFQriErUtBF38dIiFJiMVbTP6PfdnzvFd71y6KyDwaOQtM/vca//HZvxXCYDC3jm
         IyTpGxlXBQzHJtFKTh68zR38LzI1QxtYCaGHI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=gDbvIs8XHm4z6Fx7Ej4/Bt+k0n8f1hXDSet2jGEFVcBuSyyvnDtEREewDSlTmnaHVr
         mHOGNPXwSUTFvg2t/XcRoLRyMssLa2JCo3rT81wBUgeThP/5Z72+3PNqikuA894eTyS6
         rNYoRsMpeGlzJM+LEpz36C86XIYWOd4itMqAI=
Received: by 10.204.23.67 with SMTP id q3mr3060022bkb.54.1298418275297;
        Tue, 22 Feb 2011 15:44:35 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id z18sm4913415bkf.8.2011.02.22.15.44.34
        (version=SSLv3 cipher=OTHER);
        Tue, 22 Feb 2011 15:44:34 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
In-Reply-To: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167611>

Split up the "clean.requireForce set/defaults to true..." die()
message to make it easier to translate.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/clean.c |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/builtin/clean.c b/builtin/clean.c
index 2d0054b..75697f7 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -77,9 +77,14 @@ int cmd_clean(int argc, const char **argv, const cha=
r *prefix)
 	if (ignored && ignored_only)
 		die(_("-x and -X cannot be used together"));
=20
-	if (!show_only && !force)
-		die("clean.requireForce %s to true and neither -n nor -f given; "
-		    "refusing to clean", config_set ? "set" : "defaults");
+	if (!show_only && !force) {
+		if (config_set)
+			die(_("clean.requireForce set to true and neither -n nor -f given; =
"
+				  "refusing to clean"));
+		else
+			die(_("clean.requireForce defaults to true and neither -n nor -f gi=
ven; "
+				  "refusing to clean"));
+	}
=20
 	if (force > 1)
 		rm_flags =3D 0;
--=20
1.7.2.3
