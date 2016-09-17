Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 434941FCA9
	for <e@80x24.org>; Sat, 17 Sep 2016 18:26:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754048AbcIQS0J (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Sep 2016 14:26:09 -0400
Received: from mout.web.de ([212.227.15.3]:54082 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753271AbcIQS0H (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Sep 2016 14:26:07 -0400
Received: from [192.168.178.36] ([79.213.113.239]) by smtp.web.de (mrweb002)
 with ESMTPSA (Nemesis) id 0M3Bqx-1atdgn1kCl-00ssxm; Sat, 17 Sep 2016 20:25:42
 +0200
Subject: Re: Two bugs in --pretty with %C(auto)
To:     Anatoly Borodin <anatoly.borodin@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>
References: <nrje96$q7s$1@blaine.gmane.org>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <db20ae0c-9c33-1e65-b201-1b6a9ed11340@web.de>
Date:   Sat, 17 Sep 2016 20:25:24 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <nrje96$q7s$1@blaine.gmane.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:FdJQf+Nel+SCLlnwGDq1/QlBa0bYrXhKCpO+lOhqJ7P1SQ/e/1H
 E+8AltcWEzqFqxMHxWSLwmTXJ9vCsq6EY++FdmItTPkHwq1YYxbcWKMPuY8fO2iBNJkKo4m
 jGD9szc0KjwLGMBt/Hp5qeykc4Q8TnxdmFMdxzLQ0c+MN/9z4pFNA9eAtfHvmZQoViNvCvA
 upkFHj3JRgne8/gl+3HAA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:bh1fbnKLVKE=:DTb7ekUJo+aSQ1SIiP44dr
 pZMdrb1eJFkBEZ+2/udfFxn8ASSTQwPkMxCJWy4AydxIMlgEu6sWMu7JBJ0mIALt+I7e2Hyam
 xqajdkXz+XO6Y/37/s8Zivz8Jc0MBZYv5FkbNbZnR2HauSrepyQ1Imy7pP2nmNEl5ctatOXs8
 ANEDaHiNmQVHFc7mVNe0ColEZ2sW2A5c88yaruUA3oJ9lhJySkYqXOtTbj3xQqUaWMVQYQIQM
 2uGL28D6WeIsx4OyC0hI9LgcCYSdm3YADfVJw/OUTXb9IJwHKucdHdeOomC89TAiIE2XYeg+u
 PiskfsOE4ntByXGrkgOILKecLIFCVeboU80gM+kQLHG3TvDbceJvxgbkSq03T8EFx2m5z+DP5
 7JZwmg9ITjpYnIIcLsiweQRS/5myIkuyfAoMg7M2u8qhPcLfWkpECZzsftCgTNt+9zwSgRNky
 JIO47x4ptKrFy8MuLoRv53AyZii0d4pFmLyw82nTQkBrzx3YdAw+Yzxdl2pHyfqiz5+rHIYHG
 NJQGXfUODQp0N9zs9XWevGrGYI7pLb6e81QCWb4f4Y7X0jIJ8CxEOAPu+qsHO9atwvDeSm6uB
 eMlIOdu8KBLqUSE7lpDOs1ZOIf/eAdlHWlfFaKyzYLeXCKe7N2kWQwv1VVfrzOqbs4CaId1EV
 CqzyoozmdU4TdSQ21/gwAQu4FLS0VMuH3qi74upAUBkizn0CU8P91wzQCKVkq2PwTmMZLbciW
 tb+RxkGC5H1kWknJpz0bQJOhHmIUXdk8rrBtJ3U1YOjkdGz1Nvq4ICoOKJSzYLBRZPjHQel2J
 Y9DhiMN
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 17.09.2016 um 14:51 schrieb Anatoly Borodin:
> Hi All!
> 
> First bug:
> 
> 	git log -3 --pretty='%C(cyan)%C(auto)%h%C(auto)%d %s'
> 
> prints %h with the default color (normal yellow), but
> 
> 	git log -3 --pretty='%C(bold cyan)%C(auto)%h%C(auto)%d %s'
> 
> shows %h with bold yellow, as if only the color was reset, but not
> the attributes (blink, ul, reverse also work this way). %d and %s are
> printed with the right color both times.
> 
> Second bug, maybe related to the first one:
> 
> 	git log -3 --pretty='%C(bold cyan)%h%C(auto)%d %s %an %h %h %s'
> 
> The first line looks as expected. Well, almost: the '(' of %d is bold
> yellow.
> 
> The second line looks like this:
> 
> * %h, %s, %an with bold cyan;
> * %h with bold yellow;
> * %h with normal yellow and %s with normal white (default colors).
> 
> PS git version 2.9.2

Well, in both cases you could add %Creset before %C(auto) to get what
you want.

I'm not sure how just how automatic %C(auto) is supposed to be, but you
expected it do emit the reset for you, right?  Sounds reasonable to me.
The following patch implements that behavior.

Duy, what do you think?

-- >8 --
Subject: pretty: let %C(auto) reset all attributes

Reset colors and attributes upon %C(auto) to enable full automatic
control over them; otherwise attributes like bold or reverse could
still be in effect from previous %C placeholders.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 pretty.c                   | 2 ++
 t/t6006-rev-list-format.sh | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/pretty.c b/pretty.c
index 9788bd8..493edb0 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1072,6 +1072,8 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 	case 'C':
 		if (starts_with(placeholder + 1, "(auto)")) {
 			c->auto_color = want_color(c->pretty_ctx->color);
+			if (c->auto_color)
+				strbuf_addstr(sb, GIT_COLOR_RESET);
 			return 7; /* consumed 7 bytes, "C(auto)" */
 		} else {
 			int ret = parse_color(sb, placeholder, c);
diff --git a/t/t6006-rev-list-format.sh b/t/t6006-rev-list-format.sh
index a1dcdb8..f6020cd 100755
--- a/t/t6006-rev-list-format.sh
+++ b/t/t6006-rev-list-format.sh
@@ -225,7 +225,7 @@ test_expect_success '%C(auto,...) respects --color=auto (stdout not tty)' '
 
 test_expect_success '%C(auto) respects --color' '
 	git log --color --format="%C(auto)%H" -1 >actual &&
-	printf "\\033[33m%s\\033[m\\n" $(git rev-parse HEAD) >expect &&
+	printf "\\033[m\\033[33m%s\\033[m\\n" $(git rev-parse HEAD) >expect &&
 	test_cmp expect actual
 '
 
-- 
2.10.0


