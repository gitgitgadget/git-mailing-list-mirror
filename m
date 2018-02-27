Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C09541F404
	for <e@80x24.org>; Tue, 27 Feb 2018 05:17:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751664AbeB0FRq (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 00:17:46 -0500
Received: from mail-qk0-f181.google.com ([209.85.220.181]:38439 "EHLO
        mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750981AbeB0FRp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 00:17:45 -0500
Received: by mail-qk0-f181.google.com with SMTP id s198so22063470qke.5
        for <git@vger.kernel.org>; Mon, 26 Feb 2018 21:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=ic3R+XNmpljrIkR3JulliJms8QB2SDfnBD323Pk0Tjw=;
        b=YDdi9zI0jaEm1sna7SCm6ykl2mo5bnmlpGvUO9mNbmMQ2iZzm293ZsDLEyFfRAQBWp
         wD459HaX9oGpVDtHbGzrg1VP71jItHYTAyzgYfMKjy34vRy0oCOsZ7JMRDn5r2zG1m9e
         wxhk8egXgB1bN1Ddwi0b+M6EL9V/lBMiezmxG/XRcSN2a0YWoZF+Ea6grxw5mGXSqRB0
         hmOPtrnhScpJMwgCgIPVBEm1YpEcqU/WRHwRrCtzf7zlaAp9QtwAWs3TdihsPgwPCN6d
         gksAOHhK+og+v3FH0/Bg3SoVc4jw4R1KBZgtPPLZywTksiNNuz4Y1d0gqXb8Ls4eluHh
         IntQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=ic3R+XNmpljrIkR3JulliJms8QB2SDfnBD323Pk0Tjw=;
        b=GQtQZ6qTZTC/jI1M80UCfxcCoW2q7Ium15TYwNzEiGCG89WdM5dvVFaA+JFLR/g31u
         Q8jwBlWkFM9tQyRzD1p4NeWHw09j83jwUj4IeIXLd3KACpxn8IprdsSX5PNfxnqsTqYt
         h/7GpOH8wloEyp731r8AvvF8Mpuxlglf7K4Yc9ym+oImFwQPXJsz3o2X14lCm17sxF/e
         QvWS4wfbezNQTPTKFAjDMS252pW79CyjBVqyk7ZXkecK03av9tAaYgZD+J+qzTyet2wi
         T8cRxWNLcjXqFyEqMbYxoOhsgLM/i+LzDB8Kcybvmdh/ETp6+QazY7AtK8tePGS+AK2N
         hZ0Q==
X-Gm-Message-State: APf1xPDKn++tmerpSm8NsnZEpabdgTwscAc1G+EUZ04isU+Ie2omq9Ep
        6YZubFSYS9ELDLg/n7G3GBGBbb0x2mwdNzuFThzNHw==
X-Google-Smtp-Source: AG47ELu8wG3wQCehc4DjztEE3HGVF+jwjEVHJ1rcAkKPekW6MDX8WjDwDgHB7FVJMiT1uxGW7oI2C5TnD9oMxkO327U=
X-Received: by 10.55.134.133 with SMTP id i127mr21080777qkd.275.1519708664704;
 Mon, 26 Feb 2018 21:17:44 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.142.14 with HTTP; Mon, 26 Feb 2018 21:17:44 -0800 (PST)
In-Reply-To: <392C5E11-A3CA-4D65-B9D4-9EE30258C83A@gmail.com>
References: <20180224162801.98860-1-lars.schneider@autodesk.com>
 <20180224162801.98860-4-lars.schneider@autodesk.com> <CAPig+cQdoicxSMLRbdCfFGXyXLirbRLVJi2QahCSe1ZesVOKBg@mail.gmail.com>
 <392C5E11-A3CA-4D65-B9D4-9EE30258C83A@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 27 Feb 2018 00:17:44 -0500
X-Google-Sender-Auth: j7NUI9fC_GUczfVCs4LYVnbw--w
Message-ID: <CAPig+cSh6YVK_KbinEv+1fwU1Wo4BErfYBZ76KKdhu9dM1D5Dg@mail.gmail.com>
Subject: Re: [PATCH v8 3/7] utf8: add function to detect prohibited UTF-16/32 BOM
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Lars Schneider <lars.schneider@autodesk.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 25, 2018 at 6:35 AM, Lars Schneider
<larsxschneider@gmail.com> wrote:
>> On 25 Feb 2018, at 04:41, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> Is this interpretation correct? When I read [1], I interpret it as
>> saying that no BOM _of any sort_ should be present when the encoding
>> is declared as one of UTF-16BE, UTF-16LE, UTF-32BE, or UTF-32LE.
>
> Correct!
>
>> This code, on the other hand, only checks for BOMs corresponding
>> to the declared size (16 or 32 bits).
>
> Hmm. Interesting thought. You are saying that my code won't complain if
> a document declared as UTF-16LE has a UTF32-LE BOM, correct?

Well, not specifically that case since UTF-16LE BOM is a subset of UTF32-LE BOM.

My observation was more general in that [1] seems to say that there
should be _no_ BOM whatsoever if one of UTF-16BE, UTF-16LE, UTF-32BE,
or UTF-32LE is declared.

> I would say
> this is correct behavior in context of this function. This function assumes
> that the document is proper UTF-16/UTF-16BE/UTF-16LE but it is wrongly
> declared with respect to its BOM in the .gitattributes. Would this
> comment make it more clear to you?
>         /*
>          * If a data stream is declared as UTF-16BE or UTF-16LE, then a UTF-16
>          * BOM must not be used [1]. The same applies for the UTF-32 equivalents.
>          * The function returns true if this rule is violated.
>          *
>          * [1] http://unicode.org/faq/utf_bom.html#bom10
>          */
> I think what you are referring to is a different class of error and
> would therefore warrant its own checker function. Would you agree?

I don't understand to what different class of error you refer. The
FAQ[1] seems pretty clear to me in that if one of those declarations
is used explicitly, then there should be _no_ BOM, period. It doesn't
say anything about allowing a BOM for a differently-sized encoding (16
vs 32).

If I squint very hard, I _guess_ I can see how you interpret [1] with
the more narrow meaning of the restriction applying only to a BOM of
the same size as the declared encoding, though reading it that way
doesn't come easily to me.

>> I suppose the intention of [1] is to detect a mismatch between the
>> declared encoding and how the stream is actually encoded. The check
>> implemented here will fail to detect a mismatch between, say, declared
>> encoding UTF-16BE and actual encoding UTF-32BE.
>
> As stated above the intention is to detect wrong BOMs! I think we cannot
> detect the "declared as UTF-16BE but actually UTF-32BE" error.
>
> Consider this:
>
> printf "test" | iconv -f UTF-8 -t UTF-32BE | iconv -f UTF-16BE -t UTF-8 | od -c
> 0000000   \0   t  \0   e  \0   s  \0   t
> 0000010
>
> In the first step we "encode" the string to UTF-32BE and then we "decode" it as
> UTF-16BE. The result is valid although not correct. Does this make sense?

I'm probably being dense, but I don't understand what this is trying
to illustrate in relation to has_prohibited_utf_bom().
