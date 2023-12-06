Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="B4CUyaYr"
Received: from mout.web.de (mout.web.de [217.72.192.78])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90AC5269F
	for <git@vger.kernel.org>; Wed,  6 Dec 2023 03:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1701863537; x=1702468337; i=l.s.r@web.de;
	bh=6bTPJiNA+Mi1lrwk0KTi0BGp1K1afYsH2/D0QAhzAXY=;
	h=X-UI-Sender-Class:From:To:Subject:Date:In-Reply-To:References;
	b=B4CUyaYr9b/H5A0QJuaHjlOBvN8JHVZfzwg2nzc2++jK8MsNwDC5XZqza3bAc8x/
	 QkDMCR18BAYlGhXh7v8be+QeSL36zlS7cw4NFRbuIaTDfxYFx6ZvpqKh907t3zpWm
	 1KGRNAoDMceiftOW4Wuzkb73dudr+vPvpmeq4SvMxFm3GVptsYujk4Ye9orScx+wr
	 6pbeqvMUgk0nnzHDuGisiC2AcsdDVHvGhWqrKe5xbNeehrlkKuIe7gLSVPW6PVC1d
	 nybrqHcUL4S9tX9R/JssfftDuE6Pe1BLEMHS1J7XUQi58DTIVkb2VOiKvfRxLSjRJ
	 RC5M9gIWLlcQJdt9OA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from Mini-von-Rene.fritz.box ([79.203.29.38]) by smtp.web.de
 (mrweb106 [213.165.67.124]) with ESMTPSA (Nemesis) id
 1MhWkj-1rgctO0Tfn-00eaDC for <git@vger.kernel.org>; Wed, 06 Dec 2023 12:52:17
 +0100
From: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
To: git@vger.kernel.org
Subject: [PATCH 6/7] worktree: standardize incompatibility messages
Date: Wed,  6 Dec 2023 12:52:00 +0100
Message-ID: <20231206115215.94467-7-l.s.r@web.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231206115215.94467-1-l.s.r@web.de>
References: <20231206115215.94467-1-l.s.r@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:I8SB8o8bwuwcdSxsp3m++j9CZILjSILBmD4NBPaKa8NNAupDJMQ
 gXIbiOkXz4pRRgSONGLQrsfxggDxBDQXAhdTLgi7QCWKMM61WeKZkTKNGEymCyWI7lA8bAm
 bdk8lc2m8Fw45pwHO883UynbBBiyKruye43A8xi+sC8A2tz7JdY71071Odjh23lTMRuNrhX
 ovsxjXlWKRY5BxkGsEzAw==
UI-OutboundReport: notjunk:1;M01:P0:4K4FP00/rkc=;50MBU669GK0oog3ZvxFLn1DSopp
 VS+rHZNXRP3Q0NBWPPYc1E6t9IQIG/jR/v9KINHqcGssJ6VuSoXUQSGP2FGNbMBbGhKrXHt7Q
 zSSim6L5MaLY26gJnms8McDsHiALD9U9dcSPuda/Sz4lK965nj0BZNhE5/BH+1LfB5DuPKmPl
 nvs1njIQUaNrO/1lzKFgpq8NhD/zJbKV9E5dud0Vvjhlh3/BybqAixloj9nX7YP7UAJC0qhLJ
 fxJr2kdyirxHpxHH4c3KDN0IpomwI1LmRnir9Q30+62++x5oye8MK3Jp/RaNeXL0FWOMsrtWV
 wzUxZ9caOblKPngtK1LQv5Ys7XOQyFI4KMjNUzsZSHxweXOYpUfOKBsxMNAbXIqnipo31EtmX
 GpfBtd4rFE03MhSKXQ3WSZB/wUDCfO/8bjADm1aogAQ1knqyiQ5jDDySTIVt3TtEQ6s/DGpqt
 CtsNyjtLhA9Ns12L+0i+BM+34IwyGlnOvdvd5Gzvj+wOXOWHZowSGINDIqBYIJrivrsY/HCSk
 a+mhJRrhKGlteB5hTJy8fEyWyotn3IqbSVNc4MWs7e1pp9FE+7eYoi02M6lvRe61cZSEjogTd
 x1jHqCMxgVPMw8WA7yHxTOprTGv0rXPqiw5gSGyBXQw2eNy2CmDX0lfs2F1lmobxM30NNQiRE
 teQuuuOZ3TLuoprXlTWupU/oe3ZaPOqjs+BfmgYF0VmI5KAKfuvEcZVVPkj0x8EveE8spKKl7
 AgVqnDeRoUiskNSvrEH4WvLVk9+Tb67oQYaXkHWIgTA/bmnufeCmFJAXRBRLzkCu72sIULcHb
 JIulfTf4GpkmkganRQPP65NPvAg0eI1pervgaGUJeowWL3fIx3S+divqDeZ/80lKhVo9KwX2v
 mh6b6XM96CyNjfLfDwgdcXq7hqvAGcy38rYDZIE06zOmhMZYbk+RqAhZCy0qRQlAQqPkvK/1w
 6ZiNOMulNe+dHVSYCNnlJfxQ+Q8=

Use the standard parameterized message for reporting incompatible
options for worktree add.  This reduces the number of strings to
translate and makes the UI slightly more consistent.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 builtin/worktree.c      | 17 +++++++++--------
 t/t2400-worktree-add.sh |  2 +-
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 62b7e26f4b..036ceaa981 100644
=2D-- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -730,11 +730,11 @@ static int dwim_orphan(const struct add_opts *opts, =
int opt_track, int remote)
 	}

 	if (opt_track) {
-		die(_("'%s' and '%s' cannot be used together"), "--orphan",
-		    "--track");
+		die(_("options '%s' and '%s' cannot be used together"),
+		    "--orphan", "--track");
 	} else if (!opts->checkout) {
-		die(_("'%s' and '%s' cannot be used together"), "--orphan",
-		    "--no-checkout");
+		die(_("options '%s' and '%s' cannot be used together"),
+		    "--orphan", "--no-checkout");
 	}
 	return 1;
 }
@@ -806,13 +806,14 @@ static int add(int ac, const char **av, const char *=
prefix)
 	if (!!opts.detach + !!new_branch + !!new_branch_force > 1)
 		die(_("options '%s', '%s', and '%s' cannot be used together"), "-b", "-=
B", "--detach");
 	if (opts.detach && opts.orphan)
-		die(_("options '%s', and '%s' cannot be used together"),
+		die(_("options '%s' and '%s' cannot be used together"),
 		    "--orphan", "--detach");
 	if (opts.orphan && opt_track)
-		die(_("'%s' and '%s' cannot be used together"), "--orphan", "--track");
+		die(_("options '%s' and '%s' cannot be used together"),
+		    "--orphan", "--track");
 	if (opts.orphan && !opts.checkout)
-		die(_("'%s' and '%s' cannot be used together"), "--orphan",
-		    "--no-checkout");
+		die(_("options '%s' and '%s' cannot be used together"),
+		    "--orphan", "--no-checkout");
 	if (opts.orphan && ac =3D=3D 2)
 		die(_("'%s' and '%s' cannot be used together"), "--orphan",
 		    _("<commit-ish>"));
diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
index df4aff7825..245656b53a 100755
=2D-- a/t/t2400-worktree-add.sh
+++ b/t/t2400-worktree-add.sh
@@ -711,7 +711,7 @@ test_dwim_orphan () {
 	local fetch_error_text=3D"fatal: No local or remote refs exist despite a=
t least one remote" &&
 	local orphan_hint=3D"hint: If you meant to create a worktree containing =
a new orphan branch" &&
 	local invalid_ref_regex=3D"^fatal: invalid reference: " &&
-	local bad_combo_regex=3D"^fatal: '[-a-z]*' and '[-a-z]*' cannot be used =
together" &&
+	local bad_combo_regex=3D"^fatal: options '[-a-z]*' and '[-a-z]*' cannot =
be used together" &&

 	local git_ns=3D"repo" &&
 	local dashc_args=3D"-C $git_ns" &&
=2D-
2.43.0

