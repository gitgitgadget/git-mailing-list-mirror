Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C849A207EC
	for <e@80x24.org>; Thu, 29 Sep 2016 18:13:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934571AbcI2SNg (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Sep 2016 14:13:36 -0400
Received: from mout.web.de ([212.227.15.4]:54644 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934368AbcI2SNe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2016 14:13:34 -0400
Received: from [192.168.178.36] ([79.213.113.239]) by smtp.web.de (mrweb002)
 with ESMTPSA (Nemesis) id 0Mg7Vd-1bb17m2ZK1-00NO82; Thu, 29 Sep 2016 20:13:15
 +0200
Subject: Re: Two bugs in --pretty with %C(auto)
To:     Anatoly Borodin <anatoly.borodin@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>
References: <nrje96$q7s$1@blaine.gmane.org>
 <db20ae0c-9c33-1e65-b201-1b6a9ed11340@web.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <b032fcbc-045b-7822-f9d4-84930cbf6b41@web.de>
Date:   Thu, 29 Sep 2016 20:13:05 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <db20ae0c-9c33-1e65-b201-1b6a9ed11340@web.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:F0Q83rwQj/RXE/D4ykK1zD4pf0UINSwrVZSxQnnKYP2Fxe7rl81
 1DWU5g5rghPdScyYsze1OnXz352Tu1e9bnMj48Z3VQqA0nfyEVOuD6l170lIo0mpnTysZ2m
 9QQmMpFERP0BpJkJmcK2/otGGlHkPFTofoDlHnAglDPctNMgb5pGvB+ZYkkGICt5XqSxKXz
 3RVe3Ze4iJLKjGCvL25nw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:RA5fOoCPZQg=:S5sEjl+wfhqjOogM43+KcL
 Ra4L5d9X6pam/sQIunsVYEvXy6VUc8Cb6TWMcFb4SnqqHyc03+QqRPkTeY7fb1dKh/CvASC6z
 AjK9CiEdP0Szo8YyypawueBUpZTOiGYLaagbEwT3yhV2ZRHhYBwg8Sg1TWS5ZYoUHjU3s21IY
 RA0U9t3lx/j2cfM7DGNYCPDam/DosdeCH8wMK59PFxznbg1/DRAse+LBWJbgPLs0/bxx4dXGu
 kmvoQxbghRI3v8GI6919fsnY/myVEDptlJE+Yna34I2DHy395821f+gxsublGLkj+8RXMD+0P
 04SQPkeK09+0ztoepCNtbE+7Rdu+3i9Aq+QNmNCHNg1OhUlYdmdr/UXsLS6WfdV+MGJ/FmfMy
 ErjnlTbsRXqknSeFZTHrlrsfjymM0SQQLt+IAFFnRxd4BiKh7GSWg1xtjtytPvD53u4/bSZac
 jVNdj/UBYwWzrKluoBHD9WAy96x4mVr4wf7GNIcmu6U2DFZ/Fep3tOsfw0JX09qzQmpYlWkRQ
 ioal2fXAk1zzPPsQgzNRHbB9y4wqvh7S715g6tVlGh2ePtoq3OoOgBew7ezgdT8K2jeRl+YJ7
 gkbxSxyM8RSYNXc6AtXYNiURaGGBV+kJNyEAX8UKs6Ov2y2R28FVzGr3NKvvNB6qVOJB0W+Yd
 SR6GoKFxUWn0PBUBgDul+1QbP9T1hi1gOF8/bu3HSHSBJz23ocVvtaiUpTEWsVqvE2lzS/4lv
 ULc706O350OX1iXrmnJxo6SMQF0WbzuxOQy6E9NWWtt7PHybGRN0Aph9lTAmUIpreN9VMplvT
 VCqu59I
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 17.09.2016 um 20:25 schrieb René Scharfe:
> diff --git a/pretty.c b/pretty.c
> index 9788bd8..493edb0 100644
> --- a/pretty.c
> +++ b/pretty.c
> @@ -1072,6 +1072,8 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
>  	case 'C':
>  		if (starts_with(placeholder + 1, "(auto)")) {
>  			c->auto_color = want_color(c->pretty_ctx->color);
> +			if (c->auto_color)
> +				strbuf_addstr(sb, GIT_COLOR_RESET);
>  			return 7; /* consumed 7 bytes, "C(auto)" */
>  		} else {
>  			int ret = parse_color(sb, placeholder, c);

We could optimize this a bit (see below).  I can't think of a downside;
someone adding a prefix would be responsible for adding a reset as well
if needed, right?

-- >8 --
Subject: [PATCH] pretty: avoid adding reset for %C(auto) if output is empty

We emit an escape sequence for resetting color and attribute for
%C(auto) to make sure automatic coloring is displayed as intended.
Stop doing that if the output strbuf is empty, i.e. when %C(auto)
appears at the start of the format string, because then there is no
need for a reset and we save a few bytes in the output.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
Reverts the change to t6006, so we'd need another test for this.
Anatoly? :)

 pretty.c                   | 2 +-
 t/t6006-rev-list-format.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/pretty.c b/pretty.c
index 493edb0..25efbca 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1072,7 +1072,7 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 	case 'C':
 		if (starts_with(placeholder + 1, "(auto)")) {
 			c->auto_color = want_color(c->pretty_ctx->color);
-			if (c->auto_color)
+			if (c->auto_color && sb->len)
 				strbuf_addstr(sb, GIT_COLOR_RESET);
 			return 7; /* consumed 7 bytes, "C(auto)" */
 		} else {
diff --git a/t/t6006-rev-list-format.sh b/t/t6006-rev-list-format.sh
index f6020cd..a1dcdb8 100755
--- a/t/t6006-rev-list-format.sh
+++ b/t/t6006-rev-list-format.sh
@@ -225,7 +225,7 @@ test_expect_success '%C(auto,...) respects --color=auto (stdout not tty)' '
 
 test_expect_success '%C(auto) respects --color' '
 	git log --color --format="%C(auto)%H" -1 >actual &&
-	printf "\\033[m\\033[33m%s\\033[m\\n" $(git rev-parse HEAD) >expect &&
+	printf "\\033[33m%s\\033[m\\n" $(git rev-parse HEAD) >expect &&
 	test_cmp expect actual
 '
 
-- 
2.10.0

