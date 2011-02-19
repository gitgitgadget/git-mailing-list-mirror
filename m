From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 62/72] gettextize: git-clean clean.requireForce messages
Date: Sat, 19 Feb 2011 19:24:45 +0000
Message-ID: <1298143495-3681-63-git-send-email-avarab@gmail.com>
References: <1298143495-3681-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 19 20:28:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqsTt-0003Eb-B8
	for gcvg-git-2@lo.gmane.org; Sat, 19 Feb 2011 20:28:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756235Ab1BST2e convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Feb 2011 14:28:34 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:39339 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756110Ab1BST2T (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Feb 2011 14:28:19 -0500
Received: by mail-ey0-f174.google.com with SMTP id 27so2347149eye.19
        for <git@vger.kernel.org>; Sat, 19 Feb 2011 11:28:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=aPbQoHnW+H6/o4izFd18CLvpWuNub9m+Zcbv5cVsjn0=;
        b=ZZKpUxh9cZ89QGuQ8DsYRzigGSpyqqda30CVYYk4gbahBH3Np91PYTQElqymvEhT9U
         aocAy7+hsF6y2H9hlMJH5njVLilk8rONMb15lM62HBeKvqZ8Yt7m8AqMKbNCrR8noG6m
         N58GLd3g7AVCOQhHzyDgBbO0EP5/LmPmFd9Xw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=s0XeO3/1zVSVYZr9j9uRxS6Hcg50e0H1khSFplS6w/lo/SbD39V/zmaaQ4+zBt/GDl
         5zvzmDjxoI29g3vV1UeTX4ZnR+Da1xQQf1OTwkYtao+OgXb9IybZY96bWwlYn3jlLcdp
         6P1l/VxgxOnYjfHYN1F/rguB575sLLKf4yO9A=
Received: by 10.213.98.203 with SMTP id r11mr2574862ebn.10.1298143699076;
        Sat, 19 Feb 2011 11:28:19 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id b52sm3205790eei.7.2011.02.19.11.28.18
        (version=SSLv3 cipher=OTHER);
        Sat, 19 Feb 2011 11:28:18 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1298143495-3681-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167345>

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
