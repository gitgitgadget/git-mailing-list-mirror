Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11CFF1F859
	for <e@80x24.org>; Sat,  6 Aug 2016 20:58:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752359AbcHFU6b (ORCPT <rfc822;e@80x24.org>);
	Sat, 6 Aug 2016 16:58:31 -0400
Received: from mout.web.de ([212.227.17.11]:50165 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752336AbcHFU6a (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Aug 2016 16:58:30 -0400
Received: from [192.168.178.36] ([79.213.113.59]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0MWjAd-1blZ3M4C5r-00Xv0E; Sat, 06 Aug 2016 00:30:08
 +0200
Subject: Re: [PATCH 2/2] nedmalloc: work around overzealous GCC 6 warning
To:	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <cover.1470326812.git.johannes.schindelin@gmx.de>
 <57360f4885bdd5c36e190bea288f1e1f7f706071.1470326812.git.johannes.schindelin@gmx.de>
 <57A3BA26.5080601@web.de> <xmqqk2fwyx8h.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1608051728380.5786@virtualbox>
 <xmqqk2fuvpzm.fsf@gitster.mtv.corp.google.com>
Cc:	git@vger.kernel.org
From:	=?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <57A5136E.20802@web.de>
Date:	Sat, 6 Aug 2016 00:30:06 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.2
MIME-Version: 1.0
In-Reply-To: <xmqqk2fuvpzm.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:+w4GNrb0yhptquiD/SuyGLvFof1ejDew9K4SqOowpX8adR1fI3X
 wTHW2emvsR07bPiFRDJPzyiL0qDGvFU9eheKvP0lmLZ8p+vlXVgXbBWuESN4qo2rUDTbvT7
 2LZY8tnAMGXw/mRc4Dfj4RIGDXmLYyzO/+aZXCON3KJEvNxlMJIYi6aiZ5SDJe22sv1+hxZ
 3tAHPNMsuKY8TvmobaOOg==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:7EJMNHHnB1k=:REFrLHAz4D7f3B+aVP7HJR
 dHRmTrsQTQ8NoH0LEz8BfzsDzGo/Lqqs2ncSdRG/ZegIafyp2nIxLGAYuPeLKDPLzQX6n8bMq
 lUTa3clug3JlIrS+lcSpxldylZMAehOvPJ+cTEmMhQ2z93NuWnIqmNBOx8LaiwmP0hsCDohwD
 5OABc3YsS5SlwCAp0XNk0gCM8+sbWvfMbU0SNnEvzh469/HfMFDrebC+pvGNb4koijmZVQO4k
 P04MbFrijigzf1ysGi1f/m5fdbSTsgnsfv4FVgEVjviekBUiM8CUzjSGdjyQp80S7uYHFeRl7
 eRrcaadzL30M9QPPXAAnktpEeOod3PYIh0yRUcPLR+sooGdj1WvqN8uLNQM9RSwBQnSg5BkFe
 TIY9WoRYCIXRAooHOERgy27wHq5wk1owUhNuluzB5J5NHXrWPbd2P3X7RcB0ltB9DA4rIkcMg
 yreJ6gXKdDKnNl4l2ql1tvB5B37zJOUCGwgWid9EnoO12kYNT2hfbm37BKO4hR9OPtE7/wLvd
 VZhZ0QlC3CK5muZ455EaCejJJB2m2l+RW/e/OMZOsrjWXTpSm9zxo5gTrkqpwoPUgzZuvWDUg
 RuuQ0gAPghQWNatCUTeprosAW+c3R5aSJsRrJU5lLe6wOZrDAlweGz7O9AYgnYs2vhOFxcQV8
 2XG9FGMVrXtS8OYTiPBPnZ/LjKFaiaj+2yzwfWqXvJTEOT5DS5oE2tdkN0KMhMA4xaeaOkibs
 MCBscgzVORGrpoExI9WD7/hrvP9OiCAobsfh4hqxo1HPSUWtTv6m9wsj67l8pCyCV5fpEvz+v
 ub1Y0/Q
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Am 05.08.2016 um 23:57 schrieb Junio C Hamano:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
>> Hi Junio & René,
>>
>> On Thu, 4 Aug 2016, Junio C Hamano wrote:
>>
>>> Let's try it this way.  How about this as a replacement?
>>
>> I like it (with the if (s2) test intead of if (s1), of course). But please
>> record René as author, maybe mentioning myself with a "Diagnosed-by:"
>> line.
>
> Hmph.  I cannot do that unilaterally without waiting for René to
> respond, though.  In any case, with only header and footer changes,
> here is what will appear in 'pu'.

It's fine with me, thanks. :)  Minor comments below.

> Thanks.
>
> -- >8 --
> From: René Scharfe <l.s.r@web.de>
> Date: Thu, 4 Aug 2016 23:56:54 +0200
> Subject: [PATCH] nedmalloc: work around overzealous GCC 6 warning
>
> With GCC 6, the strdup() function is declared with the "nonnull"
> attribute, stating that it is not allowed to pass a NULL value as
> parameter.
>
> In nedmalloc()'s reimplementation of strdup(), Postel's Law is heeded
> and NULL parameters are handled gracefully. GCC 6 complains about that
> now because it thinks that NULL cannot be passed to strdup() anyway.
>
> Because the callers in this project of strdup() must be prepared to
> call any implementation of strdup() supplied by the platform, so it
> is pointless to pretend that it is OK to call it with NULL.
>
> Remove the conditional based on NULL-ness of the input; this
> squelches the warning.

My commit message would have been much shorter, probably too short.  But 
perhaps add here: "Check the return value of malloc() instead to make 
sure we actually got memory to write to."

> See https://gcc.gnu.org/gcc-6/porting_to.html for details.
>
> Diagnosed-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> Signed-off-by: René Scharfe <l.s.r@web.de>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>   compat/nedmalloc/nedmalloc.c | 9 ++++-----
>   1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/compat/nedmalloc/nedmalloc.c b/compat/nedmalloc/nedmalloc.c
> index 677d1b2..2d4ef59 100644
> --- a/compat/nedmalloc/nedmalloc.c
> +++ b/compat/nedmalloc/nedmalloc.c
> @@ -955,12 +955,11 @@ void **nedpindependent_comalloc(nedpool *p, size_t elems, size_t *sizes, void **
>    */
>   char *strdup(const char *s1)
>   {
> -	char *s2 = 0;
> -	if (s1) {
> -		size_t len = strlen(s1) + 1;
> -		s2 = malloc(len);
> +	size_t len = strlen(s1) + 1;
> +	char *s2 = malloc(len);
> +

You added this blank line.  OK.

> +	if (s2)
>   		memcpy(s2, s1, len);
> -	}
>   	return s2;
>   }
>   #endif
>
