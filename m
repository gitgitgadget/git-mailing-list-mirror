Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46EF3C4332F
	for <git@archiver.kernel.org>; Fri, 17 Dec 2021 16:49:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239339AbhLQQtW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Dec 2021 11:49:22 -0500
Received: from mout.web.de ([212.227.17.11]:35987 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239325AbhLQQtR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Dec 2021 11:49:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1639759730;
        bh=6Q57TkUBJqVqvsJ8M/wsDFqIdCZrUBzlMDKJhVYnDzQ=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=WUiYIxOW0BQEtQou1eSoDdeydzKpwDpfi3I0GbIxNDb8/IcDE8ecr35NOgnqla2eE
         36tVNMBRIkfI5XixGDqglc+WGN+eZ7XXR2KutBQJp1zNCsWPfpUkuVEN0L74scEaXj
         4LJR/LIlIKQG1joGo2orwpBKFZmFXsi9cP8iZXeE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.22.121]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MLARU-1nGTke1cFG-00IYQN; Fri, 17
 Dec 2021 17:48:50 +0100
Message-ID: <e2e7759e-aa97-1117-6df2-f93a12afb094@web.de>
Date:   Fri, 17 Dec 2021 17:48:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
Subject: Re: Git bug: Filter ignored when "--invert-grep" option is used.
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Dotan Cohen <dotancohen@gmail.com>
Cc:     git@vger.kernel.org, Christoph Junghans <ottxor@gentoo.org>
References: <CAKDXFkMvXJm5+5Qxz2N5NH-s+nptayG_7+yTSPxynZxkOcaVKw@mail.gmail.com>
 <xmqqzgp134i4.fsf@gitster.g>
 <CAKDXFkOXNPTjQRvj7sy54YhH1QGFUsEXYeLKCShJP7_xueRseQ@mail.gmail.com>
 <xmqqee6cbalb.fsf@gitster.g>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqee6cbalb.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:R5cM7xoqCNA9gHLya7nSd7WlRFIG//x2ifcSmMKQObLqekAWwWi
 LRK2EIiZ2x+hv0foDVaT9gj0rVrA0whRf3jX57DFyUcdqYVwTSTaeH/DfmGn0S5JZQMCNxf
 ATHI/rmKP2C84u9BdYWFv/8hHh9/R51FAvfa3yuuNKmjVmFQkT7SFhn5Z3Cf5WmMTnvweNc
 MB2VENSrq/VCDhEGOL/qw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vUp6DVz7+yY=:kaT0ESdl3+vlyuSmRTn6CQ
 yv0AGsJx6Xvl7vflRIhbBjjQWEqfKl5w1wEz704/ixW4OyKipb7vY+qfuRR+ZWMsYyYTh3yQ6
 R69kdkqql3yLw35wTDUkOxHyuB0ZYCcbp4rNSRBgQcBRBCbdrHsf1Jjw93la/HbWaVESSar8q
 xmqIMIlk6Zax4a1lQVVJTxoGS1iPaYHzWkt/plwWygWsvogLCRn+rNYhB+bWdnH7JrSlV/Nh/
 +coXnCmeBEPPksK6pgRcsDNX0QpM2vx3HqGD2OySEWcmWSN7VgROX0FX2Mzi6LnHAssHSsilT
 44pcgQIxQXEpQzQerVmxBntOxxowHtGuyni8UNsTJStfGFAesAtW2l+4SKAhIt0ykbrJDj0Yj
 FdgMv3dA+wBdme/4QkTO3KFwRTvrLC2cmqmswHjp+SMMUycrk3aOV06iBSDHMgcQwyl6+hT+I
 gxVvCZL6YLnXxmQRCYBN7QxX19zZ7UemW87Ot+vB1SmG5u6u60tpU7MHkEOKgsRoM9Nbfb3sl
 DFMUUlKAnRFRYBBROZ2qZ/QiR0rHiKR8mbnvYYf1nNZvQ3C09CkDEVtXFIlBvaQ7zDqO6FmJv
 PXbnGnhruACBbv9GWumg+SXDssEKL4OSCkDCYXPdNzBtzlmj1E+bQ98DU0m6Yij0KKQhYgiSH
 APLbtHEopD4W6ahRNJW16TiyxDnztFispzRueWnojR+O5y0TF7ThF9b6BYN9238+u7weGKAYb
 EywJK3jhavZ5NdS/ZON6PTXL0JIIkis3lCqLyG7AeuX2l21GSnCSOXSaEGR8Ucztbyu4c2sD7
 tNWxh8lWudXr+uqAyzp4Q1RiquKL62f9UaHRwZdY+zu+0NYzyrjxvv3tkAWQw6VfiMD2qJfvd
 DlUIYjwYsJa4ToZg8GsTjuI0k2+LDskaBLmrP7FuFi3dtPYmuLyvkzwBq9Siy9M/q3parGd+i
 jVcxgUkdFDNNlYaJv8btMDE/36tQu2ruD82PA6Zq14Pqhkj6puEkEklONY69k6b41iV7n6TWR
 9ENoROz3gJ3qpNfs/QtTglBTXxNOOJqsAC1HjnLkk72u5CGzpVPYgBDwLBpyRb3G6g==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 16.12.21 um 20:42 schrieb Junio C Hamano:
> Dotan Cohen <dotancohen@gmail.com> writes:
>
>>> I think --author and --grep uses the same internal pattern matching
>>> engine, so with --invert-grep, I would not be surprised if the
>>> command looks for commits that do not have Revert and (or is that
>>> or?  I dunno) not authored by Shachar.
>>
>> Possibly, but the flag is called --invert-grep not --invert-matches so
>> one would expect it to revert grep only.
>
> That is an actionable improvement idea to introduce a synonym ;-)

Documentation/rev-list-options.txt says about --invert-grep:

        Limit the commits output to ones with log message that do not
        match the pattern specified with `--grep=3D<pattern>`.

Both the option name and this sentence suggest that it only should
invert --grep, which makes sense to me.

> But in general, the way the internal "git grep" machinery is exposed
> to the commands in the "git log" family is very limited.  With "git
> grep", it is quite straight-forward to say "report hits for lines
> that has this but not that"
>
>     $ git grep -e this --and --not -e that
>
> but because that the commands in the "log" family already use
> "--not" for a quite different purpose, "git log --grep" cannot even
> express something similar, even to find hits on a single line, let
> alone finding hits on two different lines (i.e. one on the "author"
> header, the other in the message part, of the commit object).

Right, but we can pass in the necessary bit via struct grep_opt.
22dfa8a23d (log: teach --invert-grep option, 2015-01-12) even mentions
that this done in an earlier iteration of that feature.

Representing buffer-level operations like --all-match and this one as
expression nodes would be nice.  At least I suspect that would make
changing the behavior easier, without having to touch as many places.

Anyway, here's a patch that is intended to bring the code in line
with its documentation.  The multiple negations hurt my head, so I
may have snuck in some logic errors, though. :-/

=2D-- >8 ---
Subject: [PATCH] log: let --invert-grep only invert --grep

The option --invert-grep is documented to filter out commits whose
messages match the --grep filters.  However, it also affects the
header matches (--author, --committer), which is not intended.

Move the handling of that option to grep.c, as only the code there can
distinguish between matches in the header from those in the message
body.  If --invert-grep is given then enable extended expressions (not
the regex type, we just need git grep's --not to work), negate the body
patterns and check if any of them match by piggy-backing on the
collect_hits mechanism of grep_source_1().

Collecting the matches in struct grep_opt is a bit iffy, but with
"last_shown" we have a precedent for writing state information to that
struct.

Reported-by: Dotan Cohen <dotancohen@gmail.com>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 grep.c         | 22 +++++++++++++++++++---
 grep.h         |  2 ++
 revision.c     |  4 ++--
 revision.h     |  2 --
 t/t4202-log.sh | 19 +++++++++++++++++++
 5 files changed, 42 insertions(+), 7 deletions(-)

diff --git a/grep.c b/grep.c
index fe847a0111..beef5fe47e 100644
=2D-- a/grep.c
+++ b/grep.c
@@ -699,6 +699,14 @@ static struct grep_expr *compile_pattern_expr(struct =
grep_pat **list)
 	return compile_pattern_or(list);
 }

+static struct grep_expr *grep_not_expr(struct grep_expr *expr)
+{
+	struct grep_expr *z =3D xcalloc(1, sizeof(*z));
+	z->node =3D GREP_NODE_NOT;
+	z->u.unary =3D expr;
+	return z;
+}
+
 static struct grep_expr *grep_true_expr(void)
 {
 	struct grep_expr *z =3D xcalloc(1, sizeof(*z));
@@ -797,7 +805,7 @@ void compile_grep_patterns(struct grep_opt *opt)
 		}
 	}

-	if (opt->all_match || header_expr)
+	if (opt->all_match || opt->no_body_match || header_expr)
 		opt->extended =3D 1;
 	else if (!opt->extended)
 		return;
@@ -808,6 +816,9 @@ void compile_grep_patterns(struct grep_opt *opt)
 	if (p)
 		die("incomplete pattern expression: %s", p->pattern);

+	if (opt->no_body_match && opt->pattern_expression)
+		opt->pattern_expression =3D grep_not_expr(opt->pattern_expression);
+
 	if (!header_expr)
 		return;

@@ -1057,6 +1068,8 @@ static int match_expr_eval(struct grep_opt *opt, str=
uct grep_expr *x,
 			if (h && (*col < 0 || tmp.rm_so < *col))
 				*col =3D tmp.rm_so;
 		}
+		if (x->u.atom->token =3D=3D GREP_PATTERN_BODY)
+			opt->body_hit |=3D h;
 		break;
 	case GREP_NODE_NOT:
 		/*
@@ -1825,16 +1838,19 @@ int grep_source(struct grep_opt *opt, struct grep_=
source *gs)
 	 * we do not have to do the two-pass grep when we do not check
 	 * buffer-wide "all-match".
 	 */
-	if (!opt->all_match)
+	if (!opt->all_match && !opt->no_body_match)
 		return grep_source_1(opt, gs, 0);

 	/* Otherwise the toplevel "or" terms hit a bit differently.
 	 * We first clear hit markers from them.
 	 */
 	clr_hit_marker(opt->pattern_expression);
+	opt->body_hit =3D 0;
 	grep_source_1(opt, gs, 1);

-	if (!chk_hit_marker(opt->pattern_expression))
+	if (opt->all_match && !chk_hit_marker(opt->pattern_expression))
+		return 0;
+	if (opt->no_body_match && opt->body_hit)
 		return 0;

 	return grep_source_1(opt, gs, 0);
diff --git a/grep.h b/grep.h
index 3e8815c347..6a1f0ab017 100644
=2D-- a/grep.h
+++ b/grep.h
@@ -148,6 +148,8 @@ struct grep_opt {
 	int word_regexp;
 	int fixed;
 	int all_match;
+	int no_body_match;
+	int body_hit;
 #define GREP_BINARY_DEFAULT	0
 #define GREP_BINARY_NOMATCH	1
 #define GREP_BINARY_TEXT	2
diff --git a/revision.c b/revision.c
index 1981a0859f..97a06bc8fe 100644
=2D-- a/revision.c
+++ b/revision.c
@@ -2493,7 +2493,7 @@ static int handle_revision_opt(struct rev_info *revs=
, int argc, const char **arg
 	} else if (!strcmp(arg, "--all-match")) {
 		revs->grep_filter.all_match =3D 1;
 	} else if (!strcmp(arg, "--invert-grep")) {
-		revs->invert_grep =3D 1;
+		revs->grep_filter.no_body_match =3D 1;
 	} else if ((argcount =3D parse_long_opt("encoding", argv, &optarg))) {
 		if (strcmp(optarg, "none"))
 			git_log_output_encoding =3D xstrdup(optarg);
@@ -3778,7 +3778,7 @@ static int commit_match(struct commit *commit, struc=
t rev_info *opt)
 				     (char *)message, strlen(message));
 	strbuf_release(&buf);
 	unuse_commit_buffer(commit, message);
-	return opt->invert_grep ? !retval : retval;
+	return retval;
 }

 static inline int want_ancestry(const struct rev_info *revs)
diff --git a/revision.h b/revision.h
index 5578bb4720..3f66147bfd 100644
=2D-- a/revision.h
+++ b/revision.h
@@ -246,8 +246,6 @@ struct rev_info {

 	/* Filter by commit log message */
 	struct grep_opt	grep_filter;
-	/* Negate the match of grep_filter */
-	int invert_grep;

 	/* Display history graph */
 	struct git_graph *graph;
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 7884e3d46b..765742fdbc 100755
=2D-- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -2010,4 +2010,23 @@ test_expect_success 'log --end-of-options' '
        test_cmp expect actual
 '

+test_expect_success 'set up commits with different authors' '
+	git checkout --orphan authors &&
+	test_commit --author "Jim <jim@example.com>" jim_1 &&
+	test_commit --author "Val <val@example.com>" val_1 &&
+	test_commit --author "Val <val@example.com>" val_2 &&
+	test_commit --author "Jim <jim@example.com>" jim_2 &&
+	test_commit --author "Val <val@example.com>" val_3 &&
+	test_commit --author "Jim <jim@example.com>" jim_3
+'
+
+test_expect_success 'log --invert-grep --grep --author' '
+	cat >expect <<-\EOF &&
+	val_3
+	val_1
+	EOF
+	git log --format=3D%s --author=3DVal --grep 2 --invert-grep >actual &&
+	test_cmp expect actual
+'
+
 test_done
=2D-
2.34.0
