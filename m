Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 84FF01F576
	for <e@80x24.org>; Fri, 23 Feb 2018 11:00:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751469AbeBWLAN (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 06:00:13 -0500
Received: from mail-oi0-f48.google.com ([209.85.218.48]:34727 "EHLO
        mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751468AbeBWLAM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 06:00:12 -0500
Received: by mail-oi0-f48.google.com with SMTP id c83so5719152oib.1
        for <git@vger.kernel.org>; Fri, 23 Feb 2018 03:00:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fbeZpvbmfdKju8vmt+gF1b0oNxSgPAe1eeckziQ1xss=;
        b=ZjIPydDFSIB7X5wElekCE7wdc8OHWVD5KhQ7zH0AEJSWhtiOa7s3BwteRuXqIjRVFK
         RKZdRZYpw/jIWLdAyCs8sp5jjwydgWWPsUeLR7U6ja8riADtFqx6NjEjEdznP90qdXgf
         vQOnwgq7X7CfIpqQEkp5V9sklWbzmKCVIDf8HQiSNzBjnZc5Cj0x8/urPgDI7YeAy5cL
         oeL/awQrmn/w2yvGPrKheGhmc4SJIgXBUmzR1VVEXYQXK7AHo7hWqCvY2zyRzEj7wCuk
         w1uh3Ra/UEX+/kAUp2ifmrgs8AToWVTLNE6hR19OmFB1LfZWTbUslfar5pHVpt8pcoHC
         mu8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fbeZpvbmfdKju8vmt+gF1b0oNxSgPAe1eeckziQ1xss=;
        b=ZtOm73PBVUJBwIQ+4PRQIWNh+Pc81jGk/YFTfrHps7Ui0udWsr6reMmmFL9tPrmbr6
         8z6j1TDvHb/l99hpbfpiXYmdwVFyCwq/MXiExTWfEumPpvJI1LNkHXcGJRtfjFpJkfLx
         X26wLOWzfFQ3hpSL1gkVPzpofcgcM8P+CuyoTpyyzDO4Uy3THxl0LF1Un4pJCOQMfBhZ
         37w4wN1GF9jJ5RoxUiDO2i2co30xA99bPhU8hRBFliQW9nobL9CEZzRgRhnDvjL+91QK
         mxLU7XYDbfq/qMsKnSsnZKBnzKfR3n2AIgswp0TWJEWQDYODflWrVV2dvwfWWygIKJ48
         Mf1Q==
X-Gm-Message-State: APf1xPAc4PSZ7i3jqwbUQx3Mo87ZqraNWg5llwNhswtoOFhndSm/5mRa
        H5n2OXnmdBcTHY6eyQjR2f/HTFdXRO45VfcW0vs=
X-Google-Smtp-Source: AG47ELsp2OZZ/f6BWqkOrCzarfLzhRZNHPJIeDgUUroy/LaxaTFcUyyibGz2jwSulHdhFu+r+j8usIoNspobMnxMwUI=
X-Received: by 10.202.206.71 with SMTP id e68mr678196oig.34.1519383611426;
 Fri, 23 Feb 2018 03:00:11 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.25.140 with HTTP; Fri, 23 Feb 2018 02:59:40 -0800 (PST)
In-Reply-To: <CACsJy8CQJViiDVuEXH-zkY_yX5AUahJCCshX=jedHhVvfpMUiA@mail.gmail.com>
References: <20180131110547.20577-1-pclouds@gmail.com> <20180209110221.27224-1-pclouds@gmail.com>
 <20180209110221.27224-30-pclouds@gmail.com> <CAM0VKjmJwDUv4gTQ+22SgfX+=PahXRPeP=774hV7mxxm3nXiYg@mail.gmail.com>
 <CACsJy8CQJViiDVuEXH-zkY_yX5AUahJCCshX=jedHhVvfpMUiA@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 23 Feb 2018 17:59:40 +0700
Message-ID: <CACsJy8BG41EkqRXft40sjfUxonPGHhW3ikbzs_y7Xwh=2z6erA@mail.gmail.com>
Subject: Re: [PATCH v3 29/42] completion: use __gitcomp_builtin in _git_notes
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 23, 2018 at 5:33 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Wed, Feb 14, 2018 at 9:29 PM, SZEDER G=C3=A1bor <szeder.dev@gmail.com>=
 wrote:
>> And we could even go one step further:
>>
>>   *,--*)
>>         __gitcomp_builtin notes_$subcommand
>>         ;;
>>
>> This would have the benefit that if any of the remaining subcommands
>> learn --options, then they would be completed right away, without the
>> need to add that subcommand to the case arms.
>
> You read my mind ;-) We won't do this in this series though (but I
> will simplify the code as suggested). parse-options.c does not have
> any concept about these subcommands. So a bit more work and can (and
> will) be done separately.

Actually I misread you. This is not about completing subcommands but
subcommand's options, so it should work nicely. As long as we make
sure we handle error cases correctly (e.g. the user try to complete
options of a non-existing subcommand)
--=20
Duy
