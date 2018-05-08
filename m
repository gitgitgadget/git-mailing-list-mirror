Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A0E2B200B9
	for <e@80x24.org>; Tue,  8 May 2018 17:24:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755499AbeEHRYB (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 May 2018 13:24:01 -0400
Received: from mail-yb0-f179.google.com ([209.85.213.179]:34456 "EHLO
        mail-yb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755430AbeEHRX6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 May 2018 13:23:58 -0400
Received: by mail-yb0-f179.google.com with SMTP id b14-v6so11418383ybk.1
        for <git@vger.kernel.org>; Tue, 08 May 2018 10:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iLob+R78qJArobEFkB8nRGacxC8/8iGC1+ilW39XnvY=;
        b=omKoLIcmw6JuihenyPzBF6medqk8bEGwImv2I/+8ZS202Pr+2l5CtfKQRu7UYhgVcE
         3n/o4CppDu34FPai5FILKpbGMJT/mcPQ05bWgEs4B5jHHQvloNL/Cwk8LBHxjdePy54T
         795MaUpTgYUJpfUodX0LHt3JX2rcceY9cASVXMNlcGj8kjDrnFfrK764msreu7btIqD9
         d6dK2wiQcdX+GIBA3s2MQV/3QDRF5HKlQSpJvBdAeBod5Vfh6SIPDUo2Cr5zWbTxWclq
         x5ruCcDbFpG41dhwTBFdzdYMCz/g6CSwFTHsaELb8tGexFfHvNiT7mKjvJ6DtvlG/BbL
         X9QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iLob+R78qJArobEFkB8nRGacxC8/8iGC1+ilW39XnvY=;
        b=att+0TSTmSrchk4087SSnDFgAjjLbV7gpUZIexopXn+O3b3N6vcW5xodrdbVBM+l1t
         Yg0pxF8sQDChRXtfAxnClR849T1cc4M8eGtGmAS8VpJsL41yYFowEusgn896tOcEoZyg
         GG/gL/cMngxjtYOZqzn23NFT4aCNs6yFEfiPHvdt67ID7WuSi6mW19XoXawlxUVkLy8y
         AkawKeHueWDFvlLeB9hxNd+EmDPE0EombjbX3ErKlUzpqkpKGW9Os3cyggkH32OEBUE3
         wmfPoWrIP/AZ82uvqITnjSsbe3HwF83eJHr3DSloAa1ThErYryPRtWWK7b+dWVd4swVM
         Tp0A==
X-Gm-Message-State: ALQs6tBUiZkGtgji67aN1jxCBi2Z7je1qmOwtESBaI870HS9QFslzuz/
        D0tHr8ZLvyK1xIN8ukrjO6PQdBV7vK+zv8ki9CWfuCLogVo=
X-Google-Smtp-Source: AB8JxZozgTahVL35LC/zqED6+EDK+3yIs1ETHdy40wkImsV3Wb3/+dgDcRRqe2Z57JUDE16Oeov97rYGyxWT46A8EIQ=
X-Received: by 2002:a25:6cc2:: with SMTP id h185-v6mr26413044ybc.307.1525800237206;
 Tue, 08 May 2018 10:23:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf90:0:0:0:0:0 with HTTP; Tue, 8 May 2018 10:23:56 -0700 (PDT)
In-Reply-To: <20180508155627.19245-1-pclouds@gmail.com>
References: <CACsJy8AkfNfupdr1MqZSaxNCbPwBVzxXNMMqPvwif0NtuCxDaA@mail.gmail.com>
 <20180508155627.19245-1-pclouds@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 8 May 2018 10:23:56 -0700
Message-ID: <CAGZ79kZiwX-QFnkTfRHby38GYBDwj-0Dyv3_PWPXtnWr+112CA@mail.gmail.com>
Subject: Re: [PATCH] pack-format.txt: more details on pack file format
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 8, 2018 at 8:56 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <=
pclouds@gmail.com> wrote:
> The current document mentions OBJ_* constants without their actual
> values. A git developer would know these are from cache.h but that's
> not very friendly to a person who wants to read this file to implement
> a pack file parser.
>
> Similarly, the deltified representation is not documented at all (the
> "document" is basically patch-delta.c). Translate that C code in
> English.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>
> ---
>  I noticed that these object type values are not documented in
>  pack-format.txt so here's my attempt to improve it.

Thanks for sending this patch!

>
>  While at there, I also add some text about this obscure delta format.
>  We occasionally have questions about this on the mailing list if I
>  remember correctly.

Let me see if I can understand it, as I am not well versed in the
delta format, so ideally I would understand it from the patch here?

>
>  Documentation/technical/pack-format.txt | 41 +++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
>
> diff --git a/Documentation/technical/pack-format.txt b/Documentation/tech=
nical/pack-format.txt
> index 8e5bf60be3..2c7d5c0e74 100644
> --- a/Documentation/technical/pack-format.txt
> +++ b/Documentation/technical/pack-format.txt
> @@ -36,6 +36,47 @@ Git pack format
>
>    - The trailer records 20-byte SHA-1 checksum of all of the above.
>
> +Valid object types are:
> +
> +- OBJ_COMMIT (1)
> +- OBJ_TREE (2)
> +- OBJ_BLOB (3)
> +- OBJ_TAG (4)
> +- OBJ_OFS_DELTA (6)
> +- OBJ_REF_DELTA (7)
> +
> +Type 5 is reserved for future expansion.

and type 0 as well, but that is not spelled out?

> +Deltified representation

Does this refer to OFS delta as well as REF deltas?

> is a sequence of one byte command optionally
> +followed by more data for the command. The following commands are
> +recognized:

So a Deltified representation of an object is a 6 or 7 in the 3 bit type
and then the length. Then a command is shown how to construct
the object based on other objects. Can there be more commands?

> +- If bit 7 is set, the remaining bits in the command byte specifies
> +  how to extract copy offset and size to copy. The following must be
> +  evaluated in this exact order:

So there are 2 modes, and the high bit indicates which mode is used.
You start describing the more complicated mode first,
maybe give names to both of them? "direct copy" (below) and
"compressed copy with offset" ?


> +  - If bit 0 is set, the following byte contains bits 0-7 of the copy
> +    offset (this also resets all other bits in the copy offset to
> +    zero).
> +  - If bit 1 is set, the following byte contains bits 8-15 of the copy
> +    offset.
> +  - If bit 2 is set, the following byte contains bits 16-23 of the
> +    copy offset.
> +  - If bit 3 is set, the following byte contains bits 24-31 of the
> +    copy offset.

I assume these bits are exclusive, i.e. if bit 3 is set, bits 0-2 are not
allowed to be set. What happens if they are set, do we care?

If bit 3 is set, then the following byte contains 24-31 of the copy offset,
where is the rest? Do I wait for another command byte with
bits 2,1,0 to learn about the body offsets, or do they follow the
following byte? Something like:

  "If bit 3 is set, then the next 4 bytes are the copy offset,
  in network byte order"


> +  - If bit 4 is set, the following byte contains bits 0-7 of the copy
> +    size (this also resets all other bits in the copy size to zero_.
> +  - If bit 5 is set, the following byte contains bits 8-15 of the copy
> +    size.
> +  - If bit 6 is set, the following byte contains bits 16-23 of the
> +    copy size.

bits 4-7 seem to be another group of mutually exclusive bits.
The same question as above:
If bit 6 is set, where are bits 0-15 of the copy size?

> +
> +  Copy size zero means 0x10000 bytes.

This is an interesting caveat. So we can only copy 1-0x10000 bytes,
and cannot express to copy 0 bytes?

> The data from source object at
> +  the given copy offset is copied back to the destination buffer.
> +
> +- If bit 7 is not set, it is the copy size in bytes. The following
> +  bytes are copied to destination buffer
> +- Command byte zero is reserved for future expansion.

Thanks,
Stefan
