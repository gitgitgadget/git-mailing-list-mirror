Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 734991F5A1
	for <e@80x24.org>; Tue, 12 Nov 2019 18:37:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfKLShn (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Nov 2019 13:37:43 -0500
Received: from mout.web.de ([217.72.192.78]:40323 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726912AbfKLShn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Nov 2019 13:37:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1573583861;
        bh=lE2LMtrw2iA+msUARnvtV/+ySmLJD+Vtufom/peu0yQ=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=Ys/dBRlU2+3fljFcUmnbh+W46CuamYJXIKS9lYm0GBAfkT0i3Oj1UfE7MHozPonOp
         vzsNyQsEH+Ocy07GZTIhnyf9obwIvM2nh2PN+TBcFWlIWqH5tEn2tiv+5tXYFcZyOv
         LhowDyl8xdBT01vnMos4Gf5TNF+wHtMxFT+DksJQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([91.47.146.29]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Mf0cv-1iFNPQ0U7l-00ObKS; Tue, 12
 Nov 2019 19:37:41 +0100
Subject: Re: coccinelle: adjustments for array.cocci?
To:     Markus Elfring <Markus.Elfring@web.de>, git@vger.kernel.org
References: <50c77cdc-2b2d-16c8-b413-5eb6a2bae749@web.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <5189f847-1af1-f050-6c72-576a977f6f12@web.de>
Date:   Tue, 12 Nov 2019 19:37:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <50c77cdc-2b2d-16c8-b413-5eb6a2bae749@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:s4x8Nvlp34UOfxZXz+xgHZlTAv/I1YK2L+jxge4gUmi/Ph/5vlj
 uNU41ZPZW0xezp2Qp7MTSg6DCPmBNv+aDPzjOuoDrZh9tGQDl35xW73n414TwfEq0A0ExHI
 gn8dztsklI/P+F1D5TpJuEAldp8HWSzMVRCyCmdG4CE54zhMJxLozzlq3VMIfLHqTysx6fI
 DBvnppMNVkV1llZ/HcxIQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:OZNkR1fod90=:PXmyLEYp40oH/ajvkPOjCR
 xfgHRVEboMPWLTIgtQ/siyJVpcFZr55h6lHxpqw33seBBpPjU+BoYtfcEvWPTgiQc3kwkts9A
 DNmm2jJmDDT3Jo2bO53dGZcbY6/zF8FegE/pWTcuA1XWFk/iCeepoi2LddugRLmdb7soLRyCK
 wE1S/zdjsa+3r7BjhwUIV8SMA9C3/Q0Yo+acG4ixydgidsq359hYvBMQ6hwdTbcsTjACh5Me/
 npFjtKd3xOXPzKPnb+T2Ncky6o1KT1NS+x48dMDM5P9aA2gxYr0qJieLgx/yv4V0k/dY24ZcW
 BvlqXncPZR/UQWKtnjGMX2P2kEIvaDkGkU6fUDcLSG7UrvWwuKlUF/AG9twg50wSObrDdUf7l
 z9TkK6wj9sbi9bb2MVcUbk4cJGaI3dVmsZTPOhT7Y7nTv37rdsU2Xs+yMw8Bgp45SlPNqmcWo
 dG/S300xoaEPN+iwKrcgWt2DRUaJPV7f3n/dkXBDI1gdtMghxAhhf/AqCxuP9c5uxNwgY4rOy
 9uLjiY9SpWujVbbNZCgI4nV9KmLxJqWLFvQsOC+PvpF+uHXvl/T2TAbcq0obau+qZ49mLJU0D
 1mPfhcHtGCNHbxZjH/97mmSgEq2fahhP3s+uTVgJLCkkCygqNw2taG/vtX2uS5XjZDf1OOqQ2
 Obq+cLTIL37ht5UivhoXibEjXCi6QrT8AKUdg7czqnoGWnu+XJgLORcha2401TI+k78POYjE6
 n3v9JI6fC9bJ33MmCA160llTSBT5g7MpqQBlkt3WW8dGEHP3hsUogrG2lulHX7+poNFFWUhqd
 BJ6bkAzu+0ewuduWKcYSksbGR3HVLH106jDtOVYgjE13/myR6NYd0HzG7Luk5wa3QLrAKKNuC
 f9DL1B8B7n4f8vmw0m2s4hjCD1QVK7eZHKqJyE+MNitUS7/Lx/Psm2aobnD1aAnQU0ob5J+R8
 IHlb3YIel0NVtr2Wth/V1aHVScX2Nu6XijoK63jE571Y+NRQ68LiebmzNDYz8UkKWiL0elbL2
 nT64VN+wyLf5soufIERKcIS/neVMxNizOcGh3q5zDFexJh8+EtnZKbzTZCPrgkpD/N9/Vxiri
 60HAuF3dYPjv1mCmgZZZVylU7hTNpuPjfixmlMM2ygnJAuSrsEA4t02Zozkk5voHls4EWpMrA
 RIjgQSppcknii5PG/uoXJb/VPQ4zRgbGBbx+Rxd0KqKZqXW8ilqICrLt0dAwlEk8w0sLH78ih
 340dWU59lbiC8DEE4xgfbOc/r4fFYK2x92QRF1Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 12.11.19 um 16:08 schrieb Markus Elfring:
> Hello,
>
> I would like to comment implementation details from
> the commit 177fbab747da4f58cb2a8ce010b3515c86dd67c9 ("coccinelle: use CO=
PY_ARRAY for copying arrays").
>
>
> Do you find the following code variant (for the semantic patch language)=
 also useful?
>
>  memcpy(
> (       ptr, E, n *
> -       sizeof(*(ptr))
> +       sizeof(T)
> |       arr, E, n *
> -       sizeof(*(arr))
> +       sizeof(T)
> |       E, ptr, n *
> -       sizeof(*(ptr))
> +       sizeof(T)
> |       E, arr, n *
> -       sizeof(*(arr))
> +       sizeof(T)
> )
>        )

This reduces duplication in the semantic patch, which is nice.  I think
I tried something like that at the time, but found that it failed to
produce some of the cases in 921d49be86 ("use COPY_ARRAY for copying
arrays", 2019-06-15) for some reason.

> How do you think about the following SmPL code variant?
>
> -memcpy
> +COPY_ARRAY
>        (
> (       dst_ptr
> |       dst_arr
> )
>        ,
> (       src_ptr
> |       src_arr
> )
>        ,
> -       (n) * sizeof(T)
> +       n
>        )

This eliminates duplication in the semantic patch, which is good.  It
messes up the indentation of n in some of the cases in 921d49be86 ("use
COPY_ARRAY for copying arrays", 2019-06-15), though.  Hmm, but that can
be cured by duplicating the comma:

   - , (n) * sizeof(T)
   + , n

Ren=C3=A9
