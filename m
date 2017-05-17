Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A8AD201A7
	for <e@80x24.org>; Wed, 17 May 2017 15:27:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753656AbdEQP06 (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 May 2017 11:26:58 -0400
Received: from mout.gmx.net ([212.227.17.22]:49901 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751676AbdEQP0y (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2017 11:26:54 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MS5jy-1dZeC00Eg6-00TAZ4; Wed, 17
 May 2017 17:26:34 +0200
Date:   Wed, 17 May 2017 17:26:32 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     Marc Stevens <marc@marc-stevens.nl>,
        Michael Kebe <michael.kebe@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Jeff King <peff@peff.net>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] sha1dc: fix issues with a big endian platform
In-Reply-To: <xmqq37c4xcr6.fsf_-_@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.21.1.1705171722440.3610@virtualbox>
References: <CACBZZX6nmKK8af0-UpjCKWV4R+hV-uk2xWXVA5U+_UQ3VXU03g@mail.gmail.com>        <006301d2cd83$663b5520$32b1ff60$@marc-stevens.nl>        <CACBZZX5Q9paMbYWH47fdK9GuNrE=F=FwR__E1yZ32EOAMw_w6w@mail.gmail.com>        <CAKKM46vwM9pxyMxTc4jA0z_8vGKdDGCGg9ziKkFAsqr5ULYJxA@mail.gmail.com>
        <007001d2cd88$2b916180$82b42480$@marc-stevens.nl>        <CAKKM46sS_5bVe5a6wNN7SdVoGvwmVxnLAZTxJ+tSftXfZKeGWg@mail.gmail.com> <xmqq37c4xcr6.fsf_-_@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:FTh6zdFuPlbW9Wbs2XniOpA27ZuLVPjX2vgUocB5xFZztuQRjyl
 mGyYXIAD/1NM/Pejnk04uLesxhW4g1DT37dxOfD8K+YYobMfFzSbZOCNqlKciizjQqd9uyY
 JBGexPJ46T0h5WY3TwvsGIYvE9iKX/nkNXfmf5vZize5MVR5fvQV9qa2426OW3Sq4NbBzG6
 gOa5arhngDsEP6WxdQG/Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:7tBTrUEarIo=:n4SUcgCZgccZtBxxkIg4ew
 DPiYY/AiKMgoDjYeBtVUHKZJeeqZiRMn1bJ9nL1SCyFDYSm1cZP0U9GCH5A0p1xdwM1/XBv3r
 +Zcaj18AgniKBBPZOnyBbcm/6j5MHC2vVYYAVErE0qidSCa5IOEbo3HEcQn7TXHDRAjyjRAfx
 wu/c0W8caMXYmCgPdk+CewJZWkLwk3Kh/iNG9U56UpYWlFzfDRdx1gvIkyyO0kiaf56DwF+vv
 MSGlvqjU7PFCMXbIds0eRK3NU3S4M5skcKUMjFdsl+CE40YaQh+m2ND7uzAUPjCbVITz+LSC+
 QeyUgrOGdQFofTPPzC7eFILfMI4lwBqr9oq/MK8UzEBRQZ5sQFURLhch8x4RBk/umj4BYjm2j
 anfzKIuJXqid0yucfaN5xtz9NHoRK5Y8PH+x8mSMAiLBh9Yd7ngBn7yojfhXThST9T+T1H4Kd
 P+Z3cHtCGrM3OA1Ewpjlj1Fxg15jx+kWq5eYJ0hS6uRw1g43DvuD5/0wD9Qcy5Ngbh8RuidMD
 YpR//ipIBbh5U31nUPGJNKa0cRZIKifpI5vwB4TF5oZOWf7B9CLEcMLbsoH0lOqfOQmjm+XaA
 EH9r7XgPYQFnNDwScCZEPX1j53U20EWRHQB+ZaFBkkM/uwyiiE8fm3IXT2IVwX47typMHKDjQ
 U/LpYLbYyb8za9lsCaHIxu4tiu4jJI/kjAGiFODSx3lE2BCOSvZ6pFZgtppQakLG5RUXVf5n9
 aKobiKfVuwkAKJq1kOsMwvDKIYQ9jOz1aLSeVBVMCoEkChpe/6SrNa5Oagvh26VR6j94CzfH/
 9w1ptmC
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 17 May 2017, Junio C Hamano wrote:

> diff --git a/sha1dc/sha1.c b/sha1dc/sha1.c
> index 35e9dd5bf4..ae25318c47 100644
> --- a/sha1dc/sha1.c
> +++ b/sha1dc/sha1.c
> @@ -20,7 +20,7 @@
>   */
>  #if (defined(__BYTE_ORDER) && (__BYTE_ORDER == __BIG_ENDIAN)) || \
>      (defined(__BYTE_ORDER__) && (__BYTE_ORDER__ == __BIG_ENDIAN__)) || \
> -    defined(__BIG_ENDIAN__) || defined(__ARMEB__) || defined(__THUMBEB__) ||  defined(__AARCH64EB__) || \
> +    defined(_BIG_ENDIAN) || defined(__BIG_ENDIAN__) || defined(__ARMEB__) || defined(__THUMBEB__) ||  defined(__AARCH64EB__) || \
>      defined(_MIPSEB) || defined(__MIPSEB) || defined(__MIPSEB__)
>  
>  #define SHA1DC_BIGENDIAN	1
> @@ -1728,7 +1728,8 @@ void SHA1DCUpdate(SHA1_CTX* ctx, const char* buf, size_t len)
>  	while (len >= 64)
>  	{
>  		ctx->total += 64;
> -		sha1_process(ctx, (uint32_t*)(buf));
> +		memcpy(ctx->buffer, buf, 64);
> +		sha1_process(ctx, (uint32_t*)(ctx->buffer));
>  		buf += 64;

There is actually a discussion going on about this. See

https://github.com/cr-marcstevens/sha1collisiondetection/commit/33a694a9ee1b79c24be45f9eab5ac0e1aeeaf271#commitcomment-22158243

for details.

The fixup commit under discussion is here:

https://github.com/cr-marcstevens/sha1collisiondetection/commit/40f07a0c12d525b24ac1235ee8a81bbf33957ca5

Ciao,
dscho
