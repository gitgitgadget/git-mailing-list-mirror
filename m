Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDEB34EF19
	for <git@vger.kernel.org>; Tue, 21 Oct 2025 18:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761069785; cv=none; b=ZBXs1S9Eurf5nkO53CUBFQWwurg1WiZUNrqpWuu55vvaRxQGYRvBnRASFFz0xNHJFSqxMxOmsOAHF3QEYkBn29wpZFxq++RX7wPIPnTPvsQjwDXZsWq7nHlLMc1a/Xeen8t7WLqdin5FAUSEAJTuIpZozVL/3nAyAVK15d7S1T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761069785; c=relaxed/simple;
	bh=WlS8H2iAHRviVV47F6OxVkTA6gA2/uuzgYDc1yrCdZw=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=rS+1qHhzOaGDDTL5WL7Kgeg/FhLf65a7LNvA1C4h4ADB6HlreT1/Bf2L2d232/2UmN9p91jbJmMAG1oSiJYXQq9R+ossWE+RbxE6Ir+wV93SYvGiBkxiPvdOUoGH9J8SA1WBLiq7o7YvDkhgrAh5xQp+FwInn8l/HsAKuBUIjH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=KB7+CoV6; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="KB7+CoV6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1761069773; x=1761674573; i=l.s.r@web.de;
	bh=XglGqM+pOVW1IMQhm6e0WGmQ5gtWMlDTReY0y1OZVJo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=KB7+CoV6pS3y95j6IMCx3L1AZmUDI8+uaFvUtwb9VijKfinQL34nqaBs/kMe/lHD
	 ikG/Xb0Jhs3Uaf8pp3qE5D9UT9kzstdznoCpSgqtW9zFcOdT4xFEe0pu+2hQshzLl
	 pxRVdHJiJIHlCUT/sEWb9DTQeeqKTHnOuKdkOCfTa429THMerJStQRASZpXb+UDLU
	 4nLCKI0xTr2j635R5UD7giShj37EySQyniJw+RyhG5aKKo2EYnxVfSxp8jPz3HY8n
	 deUeGvCjSuUZwBITGWRn+VeocV3B4xH0Eq9oBEcLIiDa9eDcoJee0tHAAIuNGrmo+
	 Llf6NWzxoCexbjtPgA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.30.88]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MdwNg-1uaHiV1yyM-00m38m; Tue, 21
 Oct 2025 20:02:53 +0200
Message-ID: <0188c766-d788-476d-a4d4-f95a6f59b31b@web.de>
Date: Tue, 21 Oct 2025 20:02:53 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Git List <git@vger.kernel.org>
Cc: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] add-patch: fully document option P
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:y84a2q5N5ILoM2IttQEQg3b5nNusogovN/+qGpG0qZAp37WmJnd
 UifzGrZuOSCdPdJqjBtsJhf7MMOWJzhEIUtVm0AYJXAynNChVqrLAksx+TumRzk2s7Lt5lU
 ijBVPzBB88NgYNvcxQKB6s1VzzL7PZZ1fiHbJ9H1scgo9lpkjYNQgRnrFL+GRbjRziMoheh
 1oxAN6RuvnmbCM9DH//MQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:/GOub3OaIYE=;7u22Ar3EcNhGuUqyLvP0cmXBvyi
 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

Show option P in the prompt and explain it properly on a dedicated line
in online help and documentation.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 Documentation/git-add.adoc |  1 +
 add-patch.c                |  5 +++--
 t/t3701-add-interactive.sh | 44 +++++++++++++++++++-------------------
 3 files changed, 26 insertions(+), 24 deletions(-)

diff --git a/Documentation/git-add.adoc b/Documentation/git-add.adoc
index 3116a2cac5..6192daeb03 100644
=2D-- a/Documentation/git-add.adoc
+++ b/Documentation/git-add.adoc
@@ -349,6 +349,7 @@ patch::
        s - split the current hunk into smaller hunks
        e - manually edit the current hunk
        p - print the current hunk
+       P - print the current hunk using the pager
        ? - print help
 +
 After deciding the fate for all hunks, if there is any hunk
diff --git a/add-patch.c b/add-patch.c
index 9402dc71bc..ae9a20d8f2 100644
=2D-- a/add-patch.c
+++ b/add-patch.c
@@ -1416,7 +1416,8 @@ N_("j - go to the next undecided hunk, roll over at =
the bottom\n"
    "/ - search for a hunk matching the given regex\n"
    "s - split the current hunk into smaller hunks\n"
    "e - manually edit the current hunk\n"
-   "p - print the current hunk, 'P' to use the pager\n"
+   "p - print the current hunk\n"
+   "P - print the current hunk using the pager\n"
    "? - print help\n");
=20
 static size_t dec_mod(size_t a, size_t m)
@@ -1547,7 +1548,7 @@ static int patch_update_file(struct add_p_state *s,
 				permitted |=3D ALLOW_EDIT;
 				strbuf_addstr(&s->buf, ",e");
 			}
-			strbuf_addstr(&s->buf, ",p");
+			strbuf_addstr(&s->buf, ",p,P");
 		}
 		if (file_diff->deleted)
 			prompt_mode_type =3D PROMPT_DELETION;
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index b5e6edcb9e..851ca6dd91 100755
=2D-- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -48,8 +48,8 @@ test_expect_success 'unknown command' '
 	git add -N command &&
 	git diff command >expect &&
 	cat >>expect <<-EOF &&
-	(1/1) Stage addition [y,n,q,a,d,e,p,?]? Unknown command ${SQ}W${SQ} (use=
 ${SQ}?${SQ} for help)
-	(1/1) Stage addition [y,n,q,a,d,e,p,?]?$SP
+	(1/1) Stage addition [y,n,q,a,d,e,p,P,?]? Unknown command ${SQ}W${SQ} (u=
se ${SQ}?${SQ} for help)
+	(1/1) Stage addition [y,n,q,a,d,e,p,P,?]?$SP
 	EOF
 	git add -p -- command <command >actual 2>&1 &&
 	test_cmp expect actual
@@ -332,9 +332,9 @@ test_expect_success 'different prompts for mode change=
/deleted' '
 	git -c core.filemode=3Dtrue add -p >actual &&
 	sed -n "s/^\(([0-9/]*) Stage .*?\).*/\1/p" actual >actual.filtered &&
 	cat >expect <<-\EOF &&
-	(1/1) Stage deletion [y,n,q,a,d,p,?]?
-	(1/2) Stage mode change [y,n,q,a,d,k,K,j,J,g,/,p,?]?
-	(2/2) Stage this hunk [y,n,q,a,d,K,J,g,/,e,p,?]?
+	(1/1) Stage deletion [y,n,q,a,d,p,P,?]?
+	(1/2) Stage mode change [y,n,q,a,d,k,K,j,J,g,/,p,P,?]?
+	(2/2) Stage this hunk [y,n,q,a,d,K,J,g,/,e,p,P,?]?
 	EOF
 	test_cmp expect actual.filtered
 '
@@ -521,13 +521,13 @@ test_expect_success 'split hunk setup' '
 test_expect_success 'goto hunk 1 with "g 1"' '
 	test_when_finished "git reset" &&
 	tr _ " " >expect <<-EOF &&
-	(2/2) Stage this hunk [y,n,q,a,d,K,J,g,/,e,p,?]? + 1:  -1,2 +1,3        =
  +15
+	(2/2) Stage this hunk [y,n,q,a,d,K,J,g,/,e,p,P,?]? + 1:  -1,2 +1,3      =
    +15
 	_ 2:  -2,4 +3,8          +21
 	go to which hunk? @@ -1,2 +1,3 @@
 	_10
 	+15
 	_20
-	(1/2) Stage this hunk [y,n,q,a,d,k,K,j,J,g,/,e,p,?]?_
+	(1/2) Stage this hunk [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]?_
 	EOF
 	test_write_lines s y g 1 | git add -p >actual &&
 	tail -n 7 <actual >actual.trimmed &&
@@ -540,7 +540,7 @@ test_expect_success 'goto hunk 1 with "g1"' '
 	_10
 	+15
 	_20
-	(1/2) Stage this hunk [y,n,q,a,d,k,K,j,J,g,/,e,p,?]?_
+	(1/2) Stage this hunk [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]?_
 	EOF
 	test_write_lines s y g1 | git add -p >actual &&
 	tail -n 4 <actual >actual.trimmed &&
@@ -550,11 +550,11 @@ test_expect_success 'goto hunk 1 with "g1"' '
 test_expect_success 'navigate to hunk via regex /pattern' '
 	test_when_finished "git reset" &&
 	tr _ " " >expect <<-EOF &&
-	(2/2) Stage this hunk [y,n,q,a,d,K,J,g,/,e,p,?]? @@ -1,2 +1,3 @@
+	(2/2) Stage this hunk [y,n,q,a,d,K,J,g,/,e,p,P,?]? @@ -1,2 +1,3 @@
 	_10
 	+15
 	_20
-	(1/2) Stage this hunk [y,n,q,a,d,k,K,j,J,g,/,e,p,?]?_
+	(1/2) Stage this hunk [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]?_
 	EOF
 	test_write_lines s y /1,2 | git add -p >actual &&
 	tail -n 5 <actual >actual.trimmed &&
@@ -567,7 +567,7 @@ test_expect_success 'navigate to hunk via regex / patt=
ern' '
 	_10
 	+15
 	_20
-	(1/2) Stage this hunk [y,n,q,a,d,k,K,j,J,g,/,e,p,?]?_
+	(1/2) Stage this hunk [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]?_
 	EOF
 	test_write_lines s y / 1,2 | git add -p >actual &&
 	tail -n 4 <actual >actual.trimmed &&
@@ -579,11 +579,11 @@ test_expect_success 'print again the hunk' '
 	tr _ " " >expect <<-EOF &&
 	+15
 	 20
-	(1/2) Stage this hunk [y,n,q,a,d,k,K,j,J,g,/,e,p,?]? @@ -1,2 +1,3 @@
+	(1/2) Stage this hunk [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]? @@ -1,2 +1,3 @@
 	 10
 	+15
 	 20
-	(1/2) Stage this hunk [y,n,q,a,d,k,K,j,J,g,/,e,p,?]?_
+	(1/2) Stage this hunk [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]?_
 	EOF
 	test_write_lines s y g 1 p | git add -p >actual &&
 	tail -n 7 <actual >actual.trimmed &&
@@ -595,11 +595,11 @@ test_expect_success TTY 'print again the hunk (PAGER=
)' '
 	cat >expect <<-EOF &&
 	<GREEN>+<RESET><GREEN>15<RESET>
 	 20<RESET>
-	<BOLD;BLUE>(1/2) Stage this hunk [y,n,q,a,d,k,K,j,J,g,/,e,p,?]? <RESET>P=
AGER <CYAN>@@ -1,2 +1,3 @@<RESET>
+	<BOLD;BLUE>(1/2) Stage this hunk [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]? <RESET=
>PAGER <CYAN>@@ -1,2 +1,3 @@<RESET>
 	PAGER  10<RESET>
 	PAGER <GREEN>+<RESET><GREEN>15<RESET>
 	PAGER  20<RESET>
-	<BOLD;BLUE>(1/2) Stage this hunk [y,n,q,a,d,k,K,j,J,g,/,e,p,?]? <RESET>
+	<BOLD;BLUE>(1/2) Stage this hunk [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]? <RESET=
>
 	EOF
 	test_write_lines s y g 1 P |
 	(
@@ -796,21 +796,21 @@ test_expect_success 'colors can be overridden' '
 	<BLUE>+<RESET><BLUE>new<RESET>
 	<CYAN> more-context<RESET>
 	<BLUE>+<RESET><BLUE>another-one<RESET>
-	<YELLOW>(1/1) Stage this hunk [y,n,q,a,d,s,e,p,?]? <RESET><BOLD>Split in=
to 2 hunks.<RESET>
+	<YELLOW>(1/1) Stage this hunk [y,n,q,a,d,s,e,p,P,?]? <RESET><BOLD>Split =
into 2 hunks.<RESET>
 	<MAGENTA>@@ -1,3 +1,3 @@<RESET>
 	<CYAN> context<RESET>
 	<BOLD>-old<RESET>
 	<BLUE>+<RESET><BLUE>new<RESET>
 	<CYAN> more-context<RESET>
-	<YELLOW>(1/2) Stage this hunk [y,n,q,a,d,k,K,j,J,g,/,e,p,?]? <RESET><MAG=
ENTA>@@ -3 +3,2 @@<RESET>
+	<YELLOW>(1/2) Stage this hunk [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]? <RESET><M=
AGENTA>@@ -3 +3,2 @@<RESET>
 	<CYAN> more-context<RESET>
 	<BLUE>+<RESET><BLUE>another-one<RESET>
-	<YELLOW>(2/2) Stage this hunk [y,n,q,a,d,K,J,g,/,e,p,?]? <RESET><MAGENTA=
>@@ -1,3 +1,3 @@<RESET>
+	<YELLOW>(2/2) Stage this hunk [y,n,q,a,d,K,J,g,/,e,p,P,?]? <RESET><MAGEN=
TA>@@ -1,3 +1,3 @@<RESET>
 	<CYAN> context<RESET>
 	<BOLD>-old<RESET>
 	<BLUE>+new<RESET>
 	<CYAN> more-context<RESET>
-	<YELLOW>(1/2) Stage this hunk [y,n,q,a,d,k,K,j,J,g,/,e,p,?]? <RESET>
+	<YELLOW>(1/2) Stage this hunk [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]? <RESET>
 	EOF
 	test_cmp expect actual
 '
@@ -1424,9 +1424,9 @@ test_expect_success 'invalid option s is rejected' '
 	test_write_lines j s q | git add -p >out &&
 	sed -ne "s/ @@.*//" -e "s/ \$//" -e "/^(/p" <out >actual &&
 	cat >expect <<-EOF &&
-	(1/2) Stage this hunk [y,n,q,a,d,k,K,j,J,g,/,s,e,p,?]?
-	(2/2) Stage this hunk [y,n,q,a,d,k,K,j,J,g,/,e,p,?]? Sorry, cannot split=
 this hunk
-	(2/2) Stage this hunk [y,n,q,a,d,k,K,j,J,g,/,e,p,?]?
+	(1/2) Stage this hunk [y,n,q,a,d,k,K,j,J,g,/,s,e,p,P,?]?
+	(2/2) Stage this hunk [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]? Sorry, cannot spl=
it this hunk
+	(2/2) Stage this hunk [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]?
 	EOF
 	test_cmp expect actual
 '
=2D-=20
2.51.1
