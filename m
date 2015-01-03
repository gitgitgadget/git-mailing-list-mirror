From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/3] checkout: add --ignore-other-wortrees
Date: Sat,  3 Jan 2015 16:41:26 +0700
Message-ID: <1420278087-14613-3-git-send-email-pclouds@gmail.com>
References: <1420278087-14613-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Max Kirillov <max@max630.net>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 03 10:42:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y7LDg-0001wX-MZ
	for gcvg-git-2@plane.gmane.org; Sat, 03 Jan 2015 10:42:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751006AbbACJl6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 3 Jan 2015 04:41:58 -0500
Received: from mail-pa0-f50.google.com ([209.85.220.50]:50515 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750966AbbACJl4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Jan 2015 04:41:56 -0500
Received: by mail-pa0-f50.google.com with SMTP id bj1so25284562pad.23
        for <git@vger.kernel.org>; Sat, 03 Jan 2015 01:41:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=sJSFoC2vg8io53BP1G7R5QipxLfOp5OVpfflYX7RASY=;
        b=c+v9we4OxwYfbn3Qo+G3cgloniH7vmINl74djksj/Dy0KaoD5ebUHGQHMFZBi1f88W
         ZRPAtyKj3fzyAYYR1nFmRhJn/lBnEUqZncF0b93YSWUJgFZ0IeWFGoqpEtGnXKxPbSJT
         28nX7FJkaKUSDSJYPtGQ15PnsWx7BQnSNTXf7fJhY4vsY5bTlzHZV65P278fwxZuG+ik
         TbqX6dxJKOBpBdRgKrODSXse6YhRDRC09gRbPldBu3MOkGANQ4MWdUCBgFMaBLK8pfo9
         vg3egYnE3uEe2ssySOHukc0WnQczyRRBLEZscaYjQcN775MLrkwzfJs/br4S6EGkfHdC
         1Y3g==
X-Received: by 10.66.231.141 with SMTP id tg13mr132481955pac.122.1420278116424;
        Sat, 03 Jan 2015 01:41:56 -0800 (PST)
Received: from lanh ([115.73.231.124])
        by mx.google.com with ESMTPSA id iv1sm33607516pbc.87.2015.01.03.01.41.53
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Jan 2015 01:41:55 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 03 Jan 2015 16:41:57 +0700
X-Mailer: git-send-email 2.2.0.84.ge9c7a8a
In-Reply-To: <1420278087-14613-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261991>

Noticed-by: Mark Levedahl <mlevedahl@gmail.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-checkout.txt | 6 ++++++
 builtin/checkout.c             | 6 +++++-
 t/t2025-checkout-to.sh         | 7 +++++++
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkou=
t.txt
index 0c13825..52eaa48 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -232,6 +232,12 @@ section of linkgit:git-add[1] to learn how to oper=
ate the `--patch` mode.
 	specific files such as HEAD, index... See "MULTIPLE WORKING
 	TREES" section for more information.
=20
+--ignore-other-worktrees::
+	`git checkout` refuses when the wanted ref is already checked
+	out by another worktree. This option makes it check the ref
+	out anyway. In other words, the ref can be held by more than one
+	worktree.
+
 <branch>::
 	Branch to checkout; if it refers to a branch (i.e., a name that,
 	when prepended with "refs/heads/", is a valid ref), then that
diff --git a/builtin/checkout.c b/builtin/checkout.c
index d8717ef..8b2bf20 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -37,6 +37,7 @@ struct checkout_opts {
 	int writeout_stage;
 	int overwrite_ignore;
 	int ignore_skipworktree;
+	int ignore_other_worktrees;
=20
 	const char *new_branch;
 	const char *new_branch_force;
@@ -1210,7 +1211,8 @@ static int parse_branchname_arg(int argc, const c=
har **argv,
 		int flag;
 		char *head_ref =3D resolve_refdup("HEAD", 0, sha1, &flag);
 		if (head_ref &&
-		    (!(flag & REF_ISSYMREF) || strcmp(head_ref, new->path)))
+		    (!(flag & REF_ISSYMREF) || strcmp(head_ref, new->path)) &&
+		    !opts->ignore_other_worktrees)
 			check_linked_checkouts(new);
 		free(head_ref);
 	}
@@ -1341,6 +1343,8 @@ int cmd_checkout(int argc, const char **argv, con=
st char *prefix)
 				N_("second guess 'git checkout no-such-branch'")),
 		OPT_FILENAME(0, "to", &opts.new_worktree,
 			   N_("check a branch out in a separate working directory")),
+		OPT_BOOL(0, "ignore-other-worktrees", &opts.ignore_other_worktrees,
+			 N_("do not check if another worktree is holding the given ref")),
 		OPT_END(),
 	};
=20
diff --git a/t/t2025-checkout-to.sh b/t/t2025-checkout-to.sh
index 915b506..f8e4df4 100755
--- a/t/t2025-checkout-to.sh
+++ b/t/t2025-checkout-to.sh
@@ -79,6 +79,13 @@ test_expect_success 'die the same branch is already =
checked out' '
 	)
 '
=20
+test_expect_success 'not die the same branch is already checked out' '
+	(
+		cd here &&
+		git checkout --ignore-other-worktrees --to anothernewmaster newmaste=
r
+	)
+'
+
 test_expect_success 'not die on re-checking out current branch' '
 	(
 		cd there &&
--=20
2.2.0.84.ge9c7a8a
