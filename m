Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F13259C80
	for <git@vger.kernel.org>; Sun,  5 Oct 2025 15:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759679739; cv=none; b=bPMBdHGy7LfXfre11Hle2q/aCHweTv0tzREKzhvQk5cdbJZVDj8ss8iQ/uC05Xh0RhGPD895BDFuKsxtObyWYbJPBJDbQWYlo8wLF11Wah1G5U7geh+e84GS/X85/oogp7CkHXPYWbSs6xLIme/THTT8pR5BToWrEjqVymav9PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759679739; c=relaxed/simple;
	bh=sh6KK1Ttd3lch5RhvclIv6lKvuoDuvFDFnnrR9Yusuo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=L8uWE+FenkJv2rLXYQvM/FbomqMtFgMQy31WS4jB75fFy13JHPBmvThx6lm7bVgdus51gq7vkh75ZTcZSX5qhcSILzMgx04GscAzz9Wrcx3ydIlAXI/tnwDDxpst7+9QCxWVDos5cwPlfmheoBDpZZcdLllaJ6KJQJ7eqd5UIfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=R5OOm/Qd; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="R5OOm/Qd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1759679725; x=1760284525; i=l.s.r@web.de;
	bh=Zka/wKbEMyoN0eeYGbyXyT09La5nwUCDz7lAXtCo8zY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=R5OOm/Qd4X/RDT2fu7Rk9LmEfqZGqlEpT4+SDh3ZTQ+qJ+DeXDctD4IXxL60oyO/
	 WIPqMMOQx+0eCP1vIGTiphuAxSbhfY+1t4T2e1GiAW4xGn31gwV3mcWQJUmLVRYGc
	 QF9Kvdt9wPgXRSBVPIHYEIfvudvvCjnt2hp+LIw/6N8wVDTMCy+iScJrFAgvjuhZM
	 TWiNLa2Q6WYL8m4cWDvSewohi931fnVF27jvYDil9B5H3htfb1rqJx/w6v+pS5sXS
	 8qJE1cNUihOXuQRzpDvPrLAZkH+SDIa/5Xjt5xrS1PEr7p3Hb7257DMExj73x3Y4F
	 1Z0RBEHAU6rvneOuMg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.16.132]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MIyeG-1upZ9b1vEA-00YOpC; Sun, 05
 Oct 2025 17:55:25 +0200
Message-ID: <187aac4d-18b6-41df-a181-7f42e3cbc0d4@web.de>
Date: Sun, 5 Oct 2025 17:55:24 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 2/5] add-patch: document that option J rolls over
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Cc: "Windl, Ulrich" <u.windl@ukr.de>, Junio C Hamano <gitster@pobox.com>,
 Phillip Wood <phillip.wood@dunelm.org.uk>
References: <c72518099a3b465c8761e41210fe3fcb@ukr.de>
 <17ef29a7-5214-4729-82eb-92a2af33e465@web.de>
Content-Language: en-US
In-Reply-To: <17ef29a7-5214-4729-82eb-92a2af33e465@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wKpbKiFYJKUpm2IZsXrDqn5C9hkexmXb90NDQs/3a6G3gjZrCEM
 JmTZSxkKS/VPgRaIdwGKRccv4CxtbQJK3iFVKL3JE5DlJ06somYVW4sFrzjsyWjCllBTBne
 YM9TWYrLrkdmF43QTcYH0Jy0CZDNozY6ZX+cKnnqdOnEqhWvyVr3pPlrbPONJvuxpfhZB0A
 rXs3genCcLL/FNFnA0yrg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:i8coB/DSVdY=;KLC4XUaUM1srnNQ+bKHfI1Y5nJM
 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

The variable "permitted" is only not reset after moving to a different
hunk, so it only accumulates permission and doesn't necessarily reflect
those of the current hunk.  This may be a bug, but is actually useful
with the option J, which can be used at the last hunk to roll over to
the first hunk.  Make this particular behavior official.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 Documentation/git-add.adoc |  2 +-
 add-patch.c                |  4 ++--
 t/t3701-add-interactive.sh | 18 ++++++++++++++----
 3 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-add.adoc b/Documentation/git-add.adoc
index 3266ccf105..5c05a3a7f9 100644
=2D-- a/Documentation/git-add.adoc
+++ b/Documentation/git-add.adoc
@@ -343,7 +343,7 @@ patch::
        g - select a hunk to go to
        / - search for a hunk matching the given regex
        j - go to the next undecided hunk
-       J - go to the next hunk
+       J - go to the next hunk, roll over at the bottom
        k - go to the previous undecided hunk
        K - go to the previous hunk
        s - split the current hunk into smaller hunks
diff --git a/add-patch.c b/add-patch.c
index 912266a3f8..bef2ba7a25 100644
=2D-- a/add-patch.c
+++ b/add-patch.c
@@ -1398,7 +1398,7 @@ static size_t display_hunks(struct add_p_state *s,
=20
 static const char help_patch_remainder[] =3D
 N_("j - go to the next undecided hunk\n"
-   "J - go to the next hunk\n"
+   "J - go to the next hunk, roll over at the bottom\n"
    "k - go to the previous undecided hunk\n"
    "K - go to the previous hunk\n"
    "g - select a hunk to go to\n"
@@ -1493,7 +1493,7 @@ static int patch_update_file(struct add_p_state *s,
 				permitted |=3D ALLOW_GOTO_NEXT_UNDECIDED_HUNK;
 				strbuf_addstr(&s->buf, ",j");
 			}
-			if (hunk_index + 1 < file_diff->hunk_nr) {
+			if (file_diff->hunk_nr > 1) {
 				permitted |=3D ALLOW_GOTO_NEXT_HUNK;
 				strbuf_addstr(&s->buf, ",J");
 			}
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index d9fe289a7a..d5d2e120ab 100755
=2D-- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -334,7 +334,7 @@ test_expect_success 'different prompts for mode change=
/deleted' '
 	cat >expect <<-\EOF &&
 	(1/1) Stage deletion [y,n,q,a,d,p,?]?
 	(1/2) Stage mode change [y,n,q,a,d,j,J,g,/,p,?]?
-	(2/2) Stage this hunk [y,n,q,a,d,K,g,/,e,p,?]?
+	(2/2) Stage this hunk [y,n,q,a,d,K,J,g,/,e,p,?]?
 	EOF
 	test_cmp expect actual.filtered
 '
@@ -521,7 +521,7 @@ test_expect_success 'split hunk setup' '
 test_expect_success 'goto hunk 1 with "g 1"' '
 	test_when_finished "git reset" &&
 	tr _ " " >expect <<-EOF &&
-	(2/2) Stage this hunk [y,n,q,a,d,K,g,/,e,p,?]? + 1:  -1,2 +1,3          =
+15
+	(2/2) Stage this hunk [y,n,q,a,d,K,J,g,/,e,p,?]? + 1:  -1,2 +1,3        =
  +15
 	_ 2:  -2,4 +3,8          +21
 	go to which hunk? @@ -1,2 +1,3 @@
 	_10
@@ -550,7 +550,7 @@ test_expect_success 'goto hunk 1 with "g1"' '
 test_expect_success 'navigate to hunk via regex /pattern' '
 	test_when_finished "git reset" &&
 	tr _ " " >expect <<-EOF &&
-	(2/2) Stage this hunk [y,n,q,a,d,K,g,/,e,p,?]? @@ -1,2 +1,3 @@
+	(2/2) Stage this hunk [y,n,q,a,d,K,J,g,/,e,p,?]? @@ -1,2 +1,3 @@
 	_10
 	+15
 	_20
@@ -805,7 +805,7 @@ test_expect_success 'colors can be overridden' '
 	<YELLOW>(1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,e,p,?]? <RESET><MAGENTA=
>@@ -3 +3,2 @@<RESET>
 	<CYAN> more-context<RESET>
 	<BLUE>+<RESET><BLUE>another-one<RESET>
-	<YELLOW>(2/2) Stage this hunk [y,n,q,a,d,K,g,/,e,p,?]? <RESET><MAGENTA>@=
@ -1,3 +1,3 @@<RESET>
+	<YELLOW>(2/2) Stage this hunk [y,n,q,a,d,K,J,g,/,e,p,?]? <RESET><MAGENTA=
>@@ -1,3 +1,3 @@<RESET>
 	<CYAN> context<RESET>
 	<BOLD>-old<RESET>
 	<BLUE>+new<RESET>
@@ -1354,4 +1354,14 @@ do
 	'
 done
=20
+test_expect_success 'option J rolls over' '
+	test_write_lines a b c d e f g h i >file &&
+	git add file &&
+	test_write_lines X b c d e f g h X >file &&
+	test_write_lines J J q | git add -p >out &&
+	test_write_lines 1 2 1 >expect &&
+	sed -n -e "s-/.*--" -e "s/^(//p" <out >actual &&
+	test_cmp expect actual
+'
+
 test_done
=2D-=20
2.51.0
