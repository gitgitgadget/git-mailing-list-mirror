Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9288C20357
	for <e@80x24.org>; Mon, 10 Jul 2017 17:09:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754643AbdGJRJE (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jul 2017 13:09:04 -0400
Received: from mout.web.de ([212.227.15.3]:60883 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754359AbdGJRJD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jul 2017 13:09:03 -0400
Received: from [192.168.178.36] ([79.237.60.227]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LjrU9-1e5bos3I1R-00bw4e; Mon, 10
 Jul 2017 19:08:39 +0200
Subject: Re: [PATCH] use DIV_ROUND_UP
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
References: <4d2c274a-f6cb-6ea5-304f-51a3152cc436@web.de>
 <20170710072701.cqzztww6mrqr7sli@sigill.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <3f643932-0fe1-26b0-d2bf-a2124a74deca@web.de>
Date:   Mon, 10 Jul 2017 19:08:38 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170710072701.cqzztww6mrqr7sli@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:frESqeh4mCgGHguTNjjStOyFtLJ2kgu0+MOVIDu6/nqnTP+ewVE
 TrGhB3ezM3MzW7ED4Z3rI5mbA/DgJW0orx41rTp2ioxX854RUZE2t3y55PWBtwP0J1GVm2z
 i8j9e+9DNB3z3Mb+kQPr4eS+sqW55IgPo/6LTTnD+iSorzv6/akyUFsAQtWaa9tz1QRKnZk
 yuWvMBFrQaM6G1lC2OzlA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:byvQ3SONssw=:OzyElQiVi1yuhTbODtS7ls
 QLuDQgGILzR8WWTgQjRme2Z2rIGO4xyaxYFqnqUvDitvHWp+lZSaR8q3BMVHQGLYS3qt3+GK3
 G+iBRsKwOwQNwp/TTdQPSqxXHWD+r0m7Wt5qp03BgdRAn70RKIzHUjh+u0SIdsqRp7Y8BMEuJ
 Ud3wKnS8heaOGwCHn68CWwBjuURDg/zC/mc72p0KjZds5v08senYYljvDx79Cg9ii0uPIuGZ3
 n+lUS10pn/9sLLcjC8jJerwAMw2mZOWQkKMT5Zwtmo8/+jhSdTEZ05fGXOUquPzE66YKbgs+b
 IN+jQZJDWSxF6Sl3rfeKeJ21OB6+tO/Z0Iqs/zOFyO3afmCKpVg6jjEpKdpBBZ1Dxk+dIkmbo
 114+o5A00PdxKwfClJz1ECE+LXfxbKTsS0rW2lpD/XpODz9Gtcug00chtXZvKHxqZikHnOZ+V
 tsPUogd62H2pE8f1luSdpCQK8qAyk/xkqyXa7mTS8aMg5hqUYoEs/4CplZ8QzfrIxJn0vW87U
 d0CKPG+zyq442NNaqb5r81Jd143CBwBkDMQTBUddSrwaThcteCj7bvoeCZETuY02dOznssMEW
 1rebtJ0pUrD9ZlwI5oB08jMPlKIyHeSzwlPuvtp/VOi2nSqUeS9Zlv7VNp0llS2AN3l5icLSp
 ZNE9AqEj0r1skORDSaS+24G2soBZhUPXKnrHMksqfuekHox+838B0OoZ25vOs3KDxSs6utbt3
 QbLe5ccp7x8HgRC7AkogWFoA1uAmHV+Q7gffTnnAMbZBLFU9TFYUgtzjN7FeOzHP+vJxrvioq
 K+mV6VY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 10.07.2017 um 09:27 schrieb Jeff King:
> On Sat, Jul 08, 2017 at 12:35:35PM +0200, René Scharfe wrote:
>> diff --git a/ewah/ewah_bitmap.c b/ewah/ewah_bitmap.c
>> index 2dc9c82ecf..06c479f70a 100644
>> --- a/ewah/ewah_bitmap.c
>> +++ b/ewah/ewah_bitmap.c
>> @@ -210,8 +210,8 @@ size_t ewah_add(struct ewah_bitmap *self, eword_t word)
>>   void ewah_set(struct ewah_bitmap *self, size_t i)
>>   {
>>   	const size_t dist =
>> -		(i + BITS_IN_EWORD) / BITS_IN_EWORD -
>> -		(self->bit_size + BITS_IN_EWORD - 1) / BITS_IN_EWORD;
>> +		DIV_ROUND_UP(i + 1, BITS_IN_EWORD) -
>> +		DIV_ROUND_UP(self->bit_size, BITS_IN_EWORD);
> 
> ...this first one is a bit trickier. Our "n" in the first one is now
> "i+1".  But that's because the original was implicitly canceling the
> "-1" and "+1" terms.
> 
> So I think it's a true mechanical conversion, but I have to admit the
> original is confusing. Without digging I suspect it's correct, though,
> just because a simple bug here would mean that our ewah bitmaps totally
> don't work. So it's probably not worth spending time on.

A few lines below there is "self->bit_size = i + 1", so the code
calculates how many words the old and the new value are apart (or by how
many words the bitmap needs to be extended), which becomes easier to see
with the patch.

René
