Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB5E31FAFB
	for <e@80x24.org>; Mon, 10 Apr 2017 02:39:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751350AbdDJCjY (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Apr 2017 22:39:24 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:36644 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751004AbdDJCjX (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Apr 2017 22:39:23 -0400
Received: by mail-io0-f194.google.com with SMTP id 68so13287656ioh.3
        for <git@vger.kernel.org>; Sun, 09 Apr 2017 19:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=tsVkv8jbDE9xhwmjN1zSk83V6ltZgFLCQP0oOfEoMOc=;
        b=gAGIkYfc2oQu2uC8WK182hiuy3AQun1wrpJWgHfIcYm2fvdcXcxtXLfk3Tc7aBNPNG
         fRQU4ebWhM4CU95QvQSGa4S/iZH3NwbB0vIMbZMu2cZcy6uOLHt2CKIFGNfVfyqBKgqz
         BFvK9VnOEcoQf12zcpbg6wEpFxrUDr9Sh3vvMeGpUc4N2ldyRwokD1QAM8LGZHX8OJba
         BSI7RolOP8o7jQ3eaALp2afIkugQo7nJVJ4G8BS2NFhf2SN2uvut68GpIEzrtKRijtxe
         02/gV6BwfNDQ7UModoGL2T2sH5wuKUKpdMG0mF0c1Cc2RcoT8P1h8F5BNMw5SYibUVTr
         xWng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=tsVkv8jbDE9xhwmjN1zSk83V6ltZgFLCQP0oOfEoMOc=;
        b=SF1fBoeoaIW62imZLgwb7kPNkPDz9B5dCxzvQTRyluEzeBCcRa0AjQfs3/IxzMUD1d
         gTB/wdRPVvzYtnzn+zPwPUD0Wz8X1oXWxnU6EU3LKjp2FpcJvAT4iyiF/HXaiNMB7vMf
         YqRZOEyZHMpUf6g8oBQBYPnj2F3l4qPV2ENm+iTcJZyhyHnOiXOyoeSsHyedxUqAF2b2
         GXdg4hQrOceN6mGNY2/Uu+2YHo3yOref+TDi5hY4OqdPaTshQ0Zuar6nDFZA87MFrpuQ
         OHAtjBJNUOentefco4FLUxWJJgN+dw4Enb8KjA5NpNw9t72HLSzOSMcRKn0MVugU4e1e
         VA/w==
X-Gm-Message-State: AFeK/H2SqJcfNT1JM5cgeV6ZuwrXkEhATEbXtuzMQYlpRcU0j8CkM/fFxc4A7qsjITRBk4FOkx+VvFMbEoosOw==
X-Received: by 10.107.163.83 with SMTP id m80mr51915042ioe.74.1491791962787;
 Sun, 09 Apr 2017 19:39:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.134.34 with HTTP; Sun, 9 Apr 2017 19:39:02 -0700 (PDT)
In-Reply-To: <20170408132506.5415-7-avarab@gmail.com>
References: <20170408132506.5415-1-avarab@gmail.com> <20170408132506.5415-7-avarab@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
Date:   Mon, 10 Apr 2017 11:39:02 +0900
X-Google-Sender-Auth: TGGvPX3qIjHl5kIwE8k2EcKtFA4
Message-ID: <CAPc5daV2mFs90AaKv9HnhPfwZ4_dyt5cFvb8ZJJQmXjto+0AbQ@mail.gmail.com>
Subject: Re: [PATCH 06/12] log: add -P as a synonym for --perl-regexp
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Jeffrey Walton <noloader@gmail.com>,
        =?UTF-8?Q?Micha=C5=82_Kiedrowicz?= <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 8, 2017 at 10:25 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> Add a short -P option as a synonym for the longer --perl-regexp, for
> consistency with the options the corresponding grep invocations
> accept.
>
> This was intentionally omitted in commit 727b6fc3ed ("log --grep:
> accept --basic-regexp and --perl-regexp", 2012-10-03) for unspecified
> future use.
>
> Since nothing has come along in over 4 1/2 years that's wanted to use
> it, it's more valuable to make it consistent with "grep" than to keep
> it open for future use, and to avoid the confusion of -P meaning
> different things for grep & log, as is the case with the -G option.

I initially had a strong reaction to the above "4 1/2 years entitles us to
do anything that might inconvenience future developers" reasoning, but
as long as we already have -E for extended regexp usable, even if we
will never be able to use -G for basic regexp, I am OK with giving -P for
pcre to be consistent with "git grep". I'd be even supportive if others
agree with this change.

Thanks.
