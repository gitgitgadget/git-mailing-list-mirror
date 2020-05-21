Return-Path: <SRS0=Ny9l=7D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66AA4C433E0
	for <git@archiver.kernel.org>; Thu, 21 May 2020 09:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2100E206BE
	for <git@archiver.kernel.org>; Thu, 21 May 2020 09:51:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="jySDXxCD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728922AbgEUJvv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 May 2020 05:51:51 -0400
Received: from mout.web.de ([212.227.15.4]:59173 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728834AbgEUJvu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 May 2020 05:51:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1590054697;
        bh=BwEGtvE7VkGtABozLus7zwuLGLVwY7JohVudDVw93xI=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=jySDXxCDD7wj8xfEwNlUqx/JsHYfdrMsN2r6z92yuHTeDrRypHfLTDJTOtUkky+FX
         nk/4L7PqGU7Y5aUJpYL7D5DPCGK2ylv0GvIRORFy8ECH2o4hHkADNaJhv16fVA4ZxE
         cBL7S74F9jyXeKACdCHashrOjDn0WruF8knsKOKA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.24.188]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M1lTm-1imcPT19dy-00tklC; Thu, 21
 May 2020 11:51:37 +0200
Subject: Re: invalid tree and commit object
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Brandon Williams <bwilliamseng@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>
References: <CALN-EhTpiLERuB16-WPZaLub6GdaRHJW8xDeaOEqSFtKe0kCYw@mail.gmail.com>
 <d963242a-72f3-7f42-7c95-ea5148f74804@web.de>
 <xmqqpnbduiec.fsf@gitster.c.googlers.com>
 <938f0818-7e57-b883-009f-01db88ef8f65@web.de>
 <xmqqh7wovoop.fsf@gitster.c.googlers.com>
 <aab9512b-a70a-0f5b-5cdc-5d40acd343d0@web.de>
 <2937d635-52a9-5e69-b3d2-fbde415b7315@web.de>
 <xmqq4ksmsaks.fsf@gitster.c.googlers.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <8cdbcd9b-b18d-d1d0-eec7-16f4139dbaf9@web.de>
Date:   Thu, 21 May 2020 11:51:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <xmqq4ksmsaks.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HvggMy5xWDrNrPMT+b/uQ++KzNKMeLP7OjsielQJG/kPCsJAzZW
 fGHQUDgHFH9wbv5gxevKKpn+7TbOWJkv2ccjlQU0yC2hFD83orBjMm/JSi9Pqf/3BnbN3jr
 rZKavj0cQ2KVMMepwK0rBLhWwmoaV5tpg8wUcY2n4HEYvx3U4/XRjcKiWrR+RTaJNy/sfsc
 r48W9GFTDDS2CbcB4LS4g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hnkcD0GviHM=:J/AvRwdCEpPwnyKvqh+yu9
 IRgkzWLuSo9qolIsN0aWuU7Nn59wnRRhGMfR3Hd5JG5RmduRRGXI/ETV7u3eDIhtShjTPUglG
 Z1/h/UdikMrjsKQAKXTaYnYjeRP5r5qHWsHkkJzFzxzxICnTHjXiCg8Qdj4jopOUWqEC/YT1N
 65eL+KJPBeci8ENQDVUDUNabfo3D09WD5iMUzWlDJSaf2AwiklXluinEYlDoHxGf7FTYn8U0+
 MxNYEbSo4cRnEkXDVjwgpT22aGIt3HOLKkca7CN1+NK9Oe3rHZsbz+FGgS4H7tQHK9cJltgwS
 opebVUfqr0sLot8Mo8Jf2Qz/8Duzsa4oEjcwNNY257SX5NcAuQCvVcskdFhLFACH8+cnkHfyq
 INQyoT8etaAauy3+zufcPIbz99RVN8t91THKqz6CgEOGuyOT7xgwdfas3keSt0MysQXHvA2Ng
 a1CTosVAyQsnU/6sHT3v6AzkHtG1gr7eCdjwK+Ewy/BERYGRdfiQlPViA1xi9VdGCvgHK9iLA
 fs5mzB2Vd2fkkx+ubgeoEtiIhO2KOTp3GjI6IiBEyLKNhh/4JflTgsjaJyHgLe9FgTVNmBaE/
 YzyyTBtwlAAWb01PN+mQpoQycG9R/U2AAK1iPdH1KNP85repb/5lLnw49P8rrIIX64zZlihSP
 zgGzAtsDPnW1x9Oyj2mTebFfU1eYLqjxmKseP7lOLuqQ9UkGBoiHMntaFBgbX5O7+ZCR9R81P
 gGHdmf+bEFiLIxUDRyKUH6kEbm7DBwA6BpcL1pnodTkWrnT4zEPLpdQ237YuPQXlSXlDwauX2
 sm+z6DbqAMoyxSQDTP+tApoXn+uJSpfJ6WpJOinFZcAdy6hWmNRoserOIu93idh5LMdlFF+Dh
 PaUuP/5TwAWpCfxvB7gK5mzfWnJydxzvohOEaVS3KI6m3fdp4eJO5Ez9upTDvHvnUGp4hulbD
 aSBiAAmlojpj3tir8f5QXIaMZYvPbl6gYgJ6P+AQmCCKAK1y3coHWMS84KsYN1oIcbQIC8v4c
 ff7I/Qo/PNLauCVocVMzL5mu7ZvpF43jOJD42DZr/YJkcRd6jWPBvLKDr6FAQjA281/QVxR9O
 MO7i+6gq2tkLV8hheZ7LZicU1Us33iS9XHrpCIaTrPkJDIXhrYZjxJm3saBVBUCenJwA56Q9O
 CKDxEZCtK2jK7/El/txGGsrQkfSVu3TGNkdSnrGIE9fMO4M5oguhzXYPKy4/R0HI7NFkfSAN4
 xhHpejGZwDVY+d/CI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 11.05.20 um 18:25 schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>> +
>> +	/*
>> +	 * There can be non-consecutive duplicates due to the implicitly
>> +	 * add slash, e.g.:
>
> s/add slash/added slash/, or even "added slash at the end of the
> name of a tree object".

Thanks for spotting the typo.  I think the short one suffices as the
sentence below (and earlier comments) already cover it.

>> +	 *
>> +	 *   foo
>> +	 *   foo.bar
>> +	 *   foo.bar.baz
>> +	 *   foo.bar/
>> +	 *   foo/
>> +	 *
>> +	 * Record non-directory candidates (like "foo" and "foo.bar" in
>> +	 * the example) on a stack and check directory candidates (like
>> +	 * foo/" and "foo.bar/") against that stack.
>> +	 */

> 	Side note. this is nice but is subtle.  I'd need to retrace
> 	the thoughts on this part again later to convince myself
> 	that we are not missing anything.

Yes, it's tricky, and we do miss something, as I mentioned in the test
coverage thread.  I'll reply with patches.

Ren=C3=A9
