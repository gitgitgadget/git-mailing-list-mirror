Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4846F8F48
	for <git@vger.kernel.org>; Sat, 28 Oct 2023 11:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="YR71/TYK"
Received: from mout.web.de (mout.web.de [212.227.17.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF96E5
	for <git@vger.kernel.org>; Sat, 28 Oct 2023 04:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1698494321; x=1699099121; i=l.s.r@web.de;
	bh=tS9VQ3TQL8OY7XpOYzqXgmHaU2u9D+MO6BriOSZXJNM=;
	h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
	b=YR71/TYKXuqC73Ta0YSnTzrtP9DDLZs7dM/ONZbs531xlCeP4ZMk8vORYOAOEdpV
	 QlAgIiVPl92HtkesVMUcMR1RZZoGOFHF8QLGidopoMw2ItsvvqbymIHq+GYHH0qz0
	 DVIcQclSiSpJHN95dhSW0k57vEJaGFLXtqWA/G5DWD8WKnIINScY8TkFYNkFQSeCx
	 97zwgs6g+emqp/tKtNbQMAzkKRksfgm6oj78YeXe7GwyMdBv6unAbm9ztlDwwkcAc
	 KbGGsaGTt8uSYRDYrmJyXklknlORZPjxCSsQsuqyXkAm+0155X1PBdn95oDl6QMyE
	 pXzfidkwH/AkHXQuYA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.159.209]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MeDMb-1rVUDW2Nc7-00bABl; Sat, 28
 Oct 2023 13:58:41 +0200
Message-ID: <63eade0e-bf2c-4906-8b4c-689797cff737@web.de>
Date: Sat, 28 Oct 2023 13:58:41 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Git List <git@vger.kernel.org>
Cc: John Cai <johncai86@gmail.com>
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] reflog: fix expire --single-worktree
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xt0D/prHsPxWmFxL7F63G3VRUBlfLOtAKuqmpKTZ7r6SspuS1lu
 8ibg8DV9zkRxi0ec6TVNKrM24EJAsMKeGuAPzOz7evWp6nKB//ZRs7u8PYKJl98ybps4CVC
 /r37Wtj4aRE59b1c2aocmsrophPhBPUbiP2y4/YgKiQoGmzvIVj502vLQoutXP/VrwkIrTI
 ZuQOQ294PWl3Xtc3ZP60w==
UI-OutboundReport: notjunk:1;M01:P0:J/gvGZN4heQ=;0ZXCHKGZcMoIuhEWVlDdYNRR9lT
 He+Zc8mc0yRSMWicS1Gsq8p6s7oKKBUeV+yrIqBp8lgT0FX9TM2DCxp3/PlqO5sfSRxM4XLxo
 0b+p6SJrzCVYjN2OmdZilH0eGQvch1Q37gc1vw45K591vIGZj1vX1AE5vOKqVu65smNWIoyKr
 4iTHMDVP+T6PurMEVZRtjd3IbQP0qzEdz+gsCaq0lVSsvr8/yYmnH7syyFElEeXceMwUy+0e5
 xek9/g/S2FMpWkrr04AwY1fql5gDh3EfbI8fOkKiGsaF6ByUBax5JaxiW90aif6MevH4wNJGz
 3rmHt338o7WeCzg6nZadv15h/9scCc6z6Xl0mQQ8FWGIIrHe4vSwdVZ3m9NfKBXMNVJtgM6lQ
 Sv3gt83H8ztQLiK5BcpFmePL3akXyVXM0DfI1XZfOSE9+A+gmn5Hf02nxbbNPi5YEwT0xqTf7
 oEhMSqAYOEjFeknN44TSjNrb0QO1Dy2Qty5ttNhYQEDSJ29xmTSEAM/qU3SIwewirv7wYxATw
 pvyZLWgHP9JYMw8ZVeWxO1xn5u944hRX4UL23eLj2WMSVnxWBTUPD5b+DLnUTkvVIPj1k/Vrl
 xkF8c7O2b8/i7ANaWTm2YH0WG3Gtkq7sONVGcflo5D+1zG8xGM8CVRN6c1ycNA4IO9j8yquW+
 QNu8pucTu20x0WYIv6Fora+u3hUW6P3iXIMrPZU5+RXi2iej0vdUgoJgIorPEIuDXu5s/ji2j
 PA+HnMsASYXvTWLqGJyA4HL9+rsireUhPYpW4gswCC9Z1zRAPgpO5ace8NECUAbhZQ/37Avpo
 GMG9LvrjzkcZCo8FfBYfVaryB0AGT7Fz12s66aRFjFbwVENiQs7b4q0vqYihKVF0SBVsqDHd1
 Fw07dkQ6pJj14NLFHCfMUOfO1GJysrfsuanMFxePZAa1Y16M3fy0FZ9H96Spf6ON04orMkv1o
 7W3mGQ==

33d7bdd645 (builtin/reflog.c: use parse-options api for expire, delete
subcommands, 2022-01-06) broke the option --single-worktree of git
reflog expire and added a non-printable short flag for it, presumably by
accident.  While before it set the variable "all_worktrees" to 0, now it
sets it to 1, its default value.  --no-single-worktree is required now
to set it to 0.

Fix it by replacing the variable with one that has the opposite meaning,
to avoid the negation and its potential for confusion.  The new variable
"single_worktree" directly captures whether --single-worktree was given.

Also remove the unprintable short flag SOH (start of heading) because it
is undocumented, hard to use and is likely to have been added by mistake
in connection with the negation bug above.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 builtin/reflog.c  |  6 +++---
 t/t1410-reflog.sh | 23 +++++++++++++++++++++++
 2 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index df63a5892e..21337292f5 100644
=2D-- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -243,7 +243,7 @@ static int cmd_reflog_expire(int argc, const char **ar=
gv, const char *prefix)
 {
 	struct cmd_reflog_expire_cb cmd =3D { 0 };
 	timestamp_t now =3D time(NULL);
-	int i, status, do_all, all_worktrees =3D 1;
+	int i, status, do_all, single_worktree =3D 0;
 	unsigned int flags =3D 0;
 	int verbose =3D 0;
 	reflog_expiry_should_prune_fn *should_prune_fn =3D should_expire_reflog_=
ent;
@@ -268,7 +268,7 @@ static int cmd_reflog_expire(int argc, const char **ar=
gv, const char *prefix)
 		OPT_BOOL(0, "stale-fix", &cmd.stalefix,
 			 N_("prune any reflog entries that point to broken commits")),
 		OPT_BOOL(0, "all", &do_all, N_("process the reflogs of all references")=
),
-		OPT_BOOL(1, "single-worktree", &all_worktrees,
+		OPT_BOOL(0, "single-worktree", &single_worktree,
 			 N_("limits processing to reflogs from the current worktree only")),
 		OPT_END()
 	};
@@ -318,7 +318,7 @@ static int cmd_reflog_expire(int argc, const char **ar=
gv, const char *prefix)

 		worktrees =3D get_worktrees();
 		for (p =3D worktrees; *p; p++) {
-			if (!all_worktrees && !(*p)->is_current)
+			if (single_worktree && !(*p)->is_current)
 				continue;
 			collected.worktree =3D *p;
 			refs_for_each_reflog(get_worktree_ref_store(*p),
diff --git a/t/t1410-reflog.sh b/t/t1410-reflog.sh
index 6c45965b1e..09e7f3cdac 100755
=2D-- a/t/t1410-reflog.sh
+++ b/t/t1410-reflog.sh
@@ -446,6 +446,29 @@ test_expect_success 'expire with multiple worktrees' =
'
 	)
 '

+test_expect_success 'expire one of multiple worktrees' '
+	git init main-wt2 &&
+	(
+		cd main-wt2 &&
+		test_tick &&
+		test_commit foo &&
+		git worktree add link-wt &&
+		test_tick &&
+		test_commit -C link-wt foobar &&
+		test_tick &&
+		test-tool ref-store worktree:link-wt for-each-reflog-ent HEAD \
+			>expect-link-wt &&
+		git reflog expire --verbose --all --expire=3D$test_tick \
+			--single-worktree &&
+		test-tool ref-store worktree:main for-each-reflog-ent HEAD \
+			>actual-main &&
+		test-tool ref-store worktree:link-wt for-each-reflog-ent HEAD \
+			>actual-link-wt &&
+		test_must_be_empty actual-main &&
+		test_cmp expect-link-wt actual-link-wt
+	)
+'
+
 test_expect_success REFFILES 'empty reflog' '
 	test_when_finished "rm -rf empty" &&
 	git init empty &&
=2D-
2.42.0
