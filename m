From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 18/72] gettextize: git-branch "(no branch)" message
Date: Sat, 19 Feb 2011 19:24:01 +0000
Message-ID: <1298143495-3681-19-git-send-email-avarab@gmail.com>
References: <1298143495-3681-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 19 20:27:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqsT8-0002tu-TC
	for gcvg-git-2@lo.gmane.org; Sat, 19 Feb 2011 20:27:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755909Ab1BST1l convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Feb 2011 14:27:41 -0500
Received: from mail-ew0-f46.google.com ([209.85.215.46]:56673 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755890Ab1BST1f (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Feb 2011 14:27:35 -0500
Received: by mail-ew0-f46.google.com with SMTP id 5so1970368ewy.19
        for <git@vger.kernel.org>; Sat, 19 Feb 2011 11:27:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=n5/KcB9KDdYP1rxjetBZq/GWMZDUoXNs3lynTUPY7Vo=;
        b=SsUotKgd3wJHKNnzg+VPunR3Jb7MVxf43e2Evd47gEQP7FVQVo5COj4w4Vxy7CPT1h
         bw2odpDNWvNYcPfG0oDb8T2I07lBap4ByjL0Jh2vWfAQzXtLG+GFp/DOB3hvyJL6S4kU
         nswGC7G33ibrvrRYcERS/nebNbG9pfsd2eqxg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=euYh+5rrECyLcvRm7kgot8Aou4CTo6yrfzyJzOvSkhUzLmmX1np50vPef5LSl9V3xl
         OsXm4yR3dgVb8qSuNaLIB7PztBClAmBFF5navSDkuMgQegYthE+pnbI7ySJOvgwy3yVb
         SAcIH9h6YSSTWSOsQyYa1KXGncB7a7HCH4+1w=
Received: by 10.14.52.13 with SMTP id d13mr2454797eec.11.1298143654291;
        Sat, 19 Feb 2011 11:27:34 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id b52sm3205790eei.7.2011.02.19.11.27.33
        (version=SSLv3 cipher=OTHER);
        Sat, 19 Feb 2011 11:27:33 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1298143495-3681-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167324>

Gettextize the "(no branch)" message that's shown by "git branch" when
you're in a detached HEAD.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/branch.c         |    2 +-
 t/t3203-branch-output.sh |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 4c1a256..244589e 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -476,7 +476,7 @@ static void show_detached(struct ref_list *ref_list=
)
=20
 	if (head_commit && is_descendant_of(head_commit, ref_list->with_commi=
t)) {
 		struct ref_item item;
-		item.name =3D xstrdup("(no branch)");
+		item.name =3D xstrdup(_("(no branch)"));
 		item.len =3D strlen(item.name);
 		item.kind =3D REF_LOCAL_BRANCH;
 		item.dest =3D NULL;
diff --git a/t/t3203-branch-output.sh b/t/t3203-branch-output.sh
index 6028748..cf04bb2 100755
--- a/t/t3203-branch-output.sh
+++ b/t/t3203-branch-output.sh
@@ -72,7 +72,7 @@ cat >expect <<'EOF'
   branch-two
   master
 EOF
-test_expect_success 'git branch shows detached HEAD properly' '
+test_expect_success NO_GETTEXT_POISON 'git branch shows detached HEAD =
properly' '
 	git checkout HEAD^0 &&
 	git branch >actual &&
 	test_cmp expect actual
--=20
1.7.2.3
