Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E56D2055E
	for <e@80x24.org>; Wed,  1 Nov 2017 17:10:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752396AbdKARJ7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Nov 2017 13:09:59 -0400
Received: from mout.web.de ([212.227.17.11]:57437 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751428AbdKARJ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Nov 2017 13:09:58 -0400
Received: from [192.168.178.36] ([91.20.50.251]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LvSU3-1dANRS233j-010bOv; Wed, 01
 Nov 2017 18:09:53 +0100
Subject: Re: [PATCH 2/2] sequencer.c: check return value of close() in
 rewrite_file()
To:     Simon Ruderich <simon@ruderich.org>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Ralf Thielow <ralf.thielow@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <22afeefa-cdd5-cd32-0a7c-6bad4de79f05@web.de>
 <06c33d3cfa35c0524ede2970ee3169d6c62eb5c1.1509547231.git.simon@ruderich.org>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <44fa927f-d4bc-9396-0a50-bc2366d4fadc@web.de>
Date:   Wed, 1 Nov 2017 18:09:49 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <06c33d3cfa35c0524ede2970ee3169d6c62eb5c1.1509547231.git.simon@ruderich.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:rp+TpPQXQIdr4FQWUbUHROJOTnNAIavIQHHFknaa/LH9EoYSAOp
 KWw8RfgpY0OT4A1Uyw3ui+DNqTjvxFsLXJhjWu8dTKnN647Obq7rb+fZtEuM5H/aSeL4fEC
 N16b+jOGd/2Ek7hBkq9aRYRvQhejQhcrA5GOa0n6/YCY/J9GCj7zzBb1WXz5HUlWUI5BC2L
 Oqhg1kvwNvXmWF8dpFgmg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:glv0howuFY4=:UZW7Ov4+gtc2FqyhOanOCk
 u8RI6XF0AKU3x5lBGQl36ZZWnuAUgD/ro1e7tWcXMLj1omTyixVsP87728QrtVTxKCuWiFSpm
 kwTbjioHWG53AmUnAli/NF/0cKn9l9B7wfUaCepFyuUPW6yEloea/nymjn2SdZoqRIyYed5sL
 pado1KfBl6TrhnIsD/KWxx/U7WkJXqnDZDMdUIOvb0IVa5pR3VRv8w+cqp/4D7/qqFoSYWv9P
 AF+FV2Sk8c05R+3XQF3qdcUutPe4mqK38Ztg5zbrqADwfg6hNmkLSN0PklBJxyip8NAa+uIbM
 Uny/BvImSQkQR2zXh0y9ty/etluT6vlApQ6NZfpQFG2UWQup0x+tV/kUWyPsYxVV/F0qwEKpI
 IkOMLpyQWKYe0fByYcKiL+kCy3cetSRN6PoAgL8oZoXdnH5Zuo6EsC11AyYgh7GMVnOAoSdR/
 dO4LltS1PMCslOJ1xFBnG0r3Lu/SWYwixOu+bJRL268UOHORCTBnASdeh4/nMKXrBZ7MpY8Xw
 1FjB702P4NqhH1B37zLukL7agfweWOSDfsIp0waWJs/6/Y/y1PCvXWkJf3Xbo+659+4L71tcz
 wveRYkS1A/vWmBmJBj1dH51Ak3NKC4+lEL7QPJvveBN5ciWq8J81Th1rynrUmQhcSmNcuP0LY
 5GNNM243tT9BEMdX3wSxWlOxgH4/hem29QN6LIj1KzyfvPSBBs1N6wwMsEqjsetX9ElYlDt3v
 yg55Jjx3KDcWCYlyBJ5ghTilmdz8GzDCwXkUSkWtWuTA6teYfd8W8n5bK2Lx4Lq19jcAQXKAG
 EhvohkiCBjZnpgJJPqaDQuNG7eHWo4DKkNDi97dieLdN9lcafA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 01.11.2017 um 15:45 schrieb Simon Ruderich:
> Not checking close(2) can hide errors as not all errors are reported
> during the write(2).
> 
> Signed-off-by: Simon Ruderich <simon@ruderich.org>
> ---
> 
> On Wed, Nov 01, 2017 at 02:00:11PM +0100, René Scharfe wrote:
>> Most calls are not checked, but that doesn't necessarily mean they need
>> to (or should) stay that way.  The Linux man-page of close(2) spends
>> multiple paragraphs recommending to check its return value..  Care to
>> send a follow-up patch?
> 
> Hello,
> 
> Sure, here is it.
> 
> Regards
> Simon
> 
>   sequencer.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/sequencer.c b/sequencer.c
> index f93b60f61..e0cc2f777 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -2673,7 +2673,8 @@ static int rewrite_file(const char *path, const char *buf, size_t len)
>   		return error_errno(_("could not open '%s' for writing"), path);
>   	if (write_in_full(fd, buf, len) < 0)
>   		rc = error_errno(_("could not write to '%s'"), path);
> -	close(fd);
> +	if (close(fd) && !rc)
> +		rc = error_errno(_("could not close '%s'"), path);
>   	return rc;
>   }
>   
> 

Looks good to me, thank you!

René
