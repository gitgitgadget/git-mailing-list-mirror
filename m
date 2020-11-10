Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60229C388F7
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 11:38:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFCE620659
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 11:38:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="hktKeqOv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728345AbgKJLif (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Nov 2020 06:38:35 -0500
Received: from mout.web.de ([217.72.192.78]:43559 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726721AbgKJLie (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Nov 2020 06:38:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1605008308;
        bh=aby5in2tszG5JQM60JKKfbpo0EDkz85XvVu8oVDNkk4=;
        h=X-UI-Sender-Class:Subject:To:References:Cc:From:Date:In-Reply-To;
        b=hktKeqOv2oyhgY1zlkE9T6ZCVahtWBnDtKyI0Ylj8pbbDdMyoMUN7JWT71cdezWBs
         DPZwKqaqkdyoJJVZBLWSoSA8MhPx6O5rvz/UiW++ZFjEMOlAv+1ofJKUAtkKLQBblq
         Q8kYkcz2ne+AD2csVr0OT6Jiv7+0eeMIGjfNwHSQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.17.45]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mf3qK-1k50lq2bL0-00gWEK; Tue, 10
 Nov 2020 12:38:28 +0100
Subject: Re: Request for change 610e2b9240 reversal
To:     Jean-Yves Avenard <jyavenard@mozilla.com>, git@vger.kernel.org
References: <CA+phgpFS_MOKOib5+yAE7U2QPMqMD_t+yXhR29UG9aSO4pgk+A@mail.gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Barret Rhoden <brho@google.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <171b9a99-d48a-babe-168b-a7cd410e4635@web.de>
Date:   Tue, 10 Nov 2020 12:38:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CA+phgpFS_MOKOib5+yAE7U2QPMqMD_t+yXhR29UG9aSO4pgk+A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cfBUyix6pxR79H8NVNl4rHAC29Y67o0JJlFevjAJOR7ex20hePK
 8XTm3jD4KT9eYihUKR7zl+q5nJhZnLlaYzaWjcMWGo86ard8hC0Q5n7HXVRON5PpSeBljQ9
 M1Wij9+1+dRK7HgE2e9FuwfApF5jYaFSCHc4psA4vJDEJ2zTWToyEv+Z4QY4UICMx9o4ujT
 fpuaQ6tO5qS5NwV3ba45A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:aOYyBmOLYx8=:DPrxYXromFnAjxqohznnAW
 C3Yt2fw9T/B2lLywoe15ZCxxIi8eYcr+JTOc/0rxpGa+gqjM4ny27tlfzlLhFwBbAWxiE0Mzu
 /8bD7mBGgBevI6LxYjyFXHDiD4UUC66Rt2bKJewAWq+Kf/Sm0tgqw3KJecjyVwJDW6WHXZ9DR
 sPCBnfMQ4WPFzcvYLSJDMAxzpn0o98uUDkkmKzi1/3vYg+jzpfwA6EooM0cfwg14m36DqLSRQ
 zwirXnMCul3iOqQMMwYTCKugvoQQ/mDQVJczNfeYDhIfBojKSji8bOxdOvkpvGxFxloCsSEuz
 yQylyy+FSDW4YngEQX8j0DcjGg0qSBnj+0XyqKoz/CJ5Cr92/C+ia93iMSCiDYwxTZB3ydri+
 oYuh1d6nAMS5ryWrm8XdErKh+dGcNgI9tARtCqYq2A8l9fzftSIfZ1FPnFmPVFHiygtcb396B
 CTObC0bVYLPwqIJ6ahnXpcwG51w+COIlNbLzCBum4WaLZiX5xRT+WzBPU8IpB8H2P+IdTJLQn
 VsgyUqQUUdLv4lOQfbWyacfDaSlagsHl18x+79JAYrGHWXjuZhXGZALD52WTvyuCAL6hEdFqK
 AYt/CGAjAhT3hVM8h18DJPG8LW90pJtOxPqgDEJbugiRu3PBegAWjtGyCzDD6SRX01juk9by6
 nVlp3Ys8UNokjwAuhqLNJMGv7fPV3vqKB9S/RmfX7GlhwqVdw5VdNCyiVMTqH7GLRKOqRc/q0
 H3MJqo7CPGPiLLR0jxlClkSQ77GDO3UJHsdFxT9L+mJh/guEvN6PLOYlzD7G2x3NFrBL9HGzs
 NLUtuImh/m+LK3TaCDHgC7BsPDdHWNRQZvrI5EulkI7Oy5mDI4ECoRoJtWvSHnsF0/MS78Fbw
 nTQRfaQoHEYzLymVGjAg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 08.11.20 um 12:15 schrieb Jean-Yves Avenard:
> Hi
>
> At Mozilla we use a mercurial repository, however many developers are
> using a git repository; we maintain two git mirrors, mozilla-unified
> accessed via the cinnabar plugin and a geck-dev native git mirror.
>
> Our repositories contain a .git-blame-ignore-revs that is used for
> both repositories.
> https://searchfox.org/mozilla-central/source/.git-blame-ignore-revs
>
> That git was ignoring invalid entries (for the currently in use repo)
> is a requirement for our use.
> Following the merge of 610e2b9240  jc/blame-ignore-fix later we have
> lost the ability to run git blame on any of our files.
>
> Could we get that change reversed?
> If it ain't broken, don't fix it as they say.

That looks like one tidily maintained ignore list!

I saw that coming ([1], [2]), but didn't communicate my doubts clearly
enough and undermined them when I wrote that I'd run into the same issue
due to laziness.  So I feel some responsibility for your trouble.  Your
actual use case is not lazy -- it uses the fundamental fact that Git
object IDs are practically unique worldwide, without synchronization
between repositories, i.e. they form a single flat namespace.

610e2b9240 (blame: validate and peel the object names on the ignore
list, 2020-09-24) introduced two changes: Support for peeling tags and
rejection of non-commits after peeling.  Here's a patch for silently
ignoring such non-commits read from a file.

Ren=C3=A9


[1] https://public-inbox.org/git/40488753-c179-4ce2-42d0-e57b5b1ec6cd@web.=
de/
[2] https://public-inbox.org/git/1fa730c4-eaef-2f32-e1b4-716a27ed4646@web.=
de/

=2D- >8 --
Subject: [PATCH] blame: silently ignore invalid ignore file objects

Since 610e2b9240 (blame: validate and peel the object names on the
ignore list, 2020-09-24) git blame reports checks if objects specified
with --ignore-rev and in files loaded with --ignore-revs-file and config
option blame.ignoreRevsFile are actual objects and dies if they aren't.
The intent is to report typos to the user.

This also breaks the ability to use a single ignore file for multiple
repositories.  Typos are presumably less likely in files than on the
command line, so alerting is less useful here.  Restore that feature by
skipping non-commits without dying.

Reported-by: Jean-Yves Avenard <jyavenard@mozilla.com>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 oidset.c                     | 5 +++--
 t/t8013-blame-ignore-revs.sh | 4 ++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/oidset.c b/oidset.c
index 2d0ab76fb5..5aac633c1f 100644
=2D-- a/oidset.c
+++ b/oidset.c
@@ -72,9 +72,10 @@ void oidset_parse_file_carefully(struct oidset *set, co=
nst char *path,
 		if (!sb.len)
 			continue;

-		if (parse_oid_hex(sb.buf, &oid, &p) || *p !=3D '\0' ||
-		    (fn && fn(&oid, cbdata)))
+		if (parse_oid_hex(sb.buf, &oid, &p) || *p !=3D '\0')
 			die("invalid object name: %s", sb.buf);
+		if (fn && fn(&oid, cbdata))
+			continue;
 		oidset_insert(set, &oid);
 	}
 	if (ferror(fp))
diff --git a/t/t8013-blame-ignore-revs.sh b/t/t8013-blame-ignore-revs.sh
index 24ae5018e8..b18633dee1 100755
=2D-- a/t/t8013-blame-ignore-revs.sh
+++ b/t/t8013-blame-ignore-revs.sh
@@ -39,10 +39,10 @@ test_expect_success 'validate --ignore-rev' '
 	test_must_fail git blame --ignore-rev X^{tree} file
 '

-# Ensure bogus --ignore-revs-file requests are caught
+# Ensure bogus --ignore-revs-file requests are silently accepted
 test_expect_success 'validate --ignore-revs-file' '
 	git rev-parse X^{tree} >ignore_x &&
-	test_must_fail git blame --ignore-revs-file ignore_x file
+	git blame --ignore-revs-file ignore_x file
 '

 for I in X XT
=2D-
2.29.2
