Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE2F1202A0
	for <e@80x24.org>; Sat, 18 Nov 2017 10:20:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1764502AbdKRKUm (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Nov 2017 05:20:42 -0500
Received: from mout.web.de ([212.227.17.12]:58194 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1764468AbdKRKUV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Nov 2017 05:20:21 -0500
Received: from [192.168.178.36] ([91.20.49.242]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Le4Po-1ex5Lv1JlM-00px89; Sat, 18
 Nov 2017 11:20:07 +0100
Subject: Re: [PATCH] config: avoid "write_in_full(fd, buf, len) != len"
 pattern
To:     Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
References: <20171115124043.17147-1-phillip.wood@talktalk.net>
 <20171117220633.6yoovfgpbr3rsykr@sigill.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <f3038984-1cd8-e11f-61fd-10bf0cc33e2d@web.de>
Date:   Sat, 18 Nov 2017 11:20:04 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20171117220633.6yoovfgpbr3rsykr@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:WOyfwXomx7JJltzYi5CIbmwYyso+v0oWCX6EZXmaibKT6rlDYFt
 RCrYtBWqDDnl1ZcqkU/KyXljn1ItTbvQXmVBPA2DhoQGP0kgBZ2UP4kKfm8AcIIshZiwgmi
 pxgAATC8bHo2Zy/02XPfC8HltQ4p6qzGxCuCApzsL1qNZtQPDQXpk1OEzhagzEgojwb7TIw
 tAPp0WyCZ90Gtg9uyIcYQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:uYnvzEWmBso=:MqXpb7AH6q3eCNVM6QtiDf
 o2z003fiGYD0ZAUFApKignYVGZSZf7ZiXHI+Lhzm42zbqluzd2ECDc3JIQwYU6iedxaDkZwmp
 69TCZWecksQnLeRzWMtjaB0+sbAA+QV/ISPuQiI5DsivEquG1baAyi3wX09xER60e/O+glFtf
 L6xaR8H1VFanAW1Hq3eTzqmsDRQH6SA8AUdFZEzwzuRmtEAXkgjHK9/P9dAD/yPRLcRXG2tSq
 YgbVbDCVQ57bEsKqurmSox5494Km9ph04iLrrUKA2qMj3ohgfEYBPoW7ZNt0gD2QdG8OvCBC5
 gkPc/Xb/TPF6EFdVz8fgNgdP5HlffT3IQFyCxUPSWXUdPMBUtK4399ZFAkX3TZZ8dvrGweA5W
 9lIcqv9GbAjzUjFrKK+gudvj8lbVvOxb2Vj6W6LuIT+fT1Jc7jsph1o5XSi5XEAj0Yd7nKw+9
 WAb/VZVyR2X5gFbDzAcj13fLmYW4OXdj3Ce59/wDahW3GfjmD/5BsCp9YxsOObamAo1LXwV3p
 daZZIxCm5py/qe6HBPvNdGHyUQWMAm3RvMlXdCByS1hJ5h4ihjgMvv7N280et9y2aaboBxaIF
 WwbGFqOn+2icc3x983A0nnPQ8SBh5twBY8791QW8rCb9VAef7VKWqky/zSsW579gkMYRWLHvh
 TsnLbD6PuzSOgpC+F4k2l44NSLryZeqPjyS43JiGhFVGE+QqQwKqFxA4b7vtWr86KJRkYZ5+4
 VyFWdmIz6aI0oA+Kl7nw8jFvhFqkb7ATDA7hPRctbcAoUKh0+7mWJaxJEyuh1HXTRkN4u3TZ6
 3DuFVsAKRjBHiqgSF6F0SJ/tegSqRMGoxkpD8+148bdseDzzQA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 17.11.2017 um 23:06 schrieb Jeff King:
> There's one more case in write_section() that uses "==". That's not
> actually wrong, but I wonder if we'd want to make it "< 0" for
> consistency.

Actually it *is* wrong.

-- >8 --
Subject: [PATCH] config: flip return value of write_section()

d9bd4cbb9cc (config: flip return value of store_write_*()) made
write_section() follow the convention of write(2) to return -1 on error
and the number of written bytes on success.  3b48045c6c7 (Merge branch
'sd/branch-copy') changed it back to returning 0 on error and 1 on
success, but left its callers still checking for negative values.

Let write_section() follow the convention of write(2) again to meet the
expectations of its callers.

Reported-by: Jeff King <peff@peff.net>
Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 config.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/config.c b/config.c
index 903abf9533..3f079c77ad 100644
--- a/config.c
+++ b/config.c
@@ -2315,7 +2315,7 @@ static ssize_t write_section(int fd, const char *key)
 	struct strbuf sb = store_create_section(key);
 	ssize_t ret;
 
-	ret = write_in_full(fd, sb.buf, sb.len) == sb.len;
+	ret = write_in_full(fd, sb.buf, sb.len);
 	strbuf_release(&sb);
 
 	return ret;
-- 
2.15.0
