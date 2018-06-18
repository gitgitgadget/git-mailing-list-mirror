Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 858871F403
	for <e@80x24.org>; Mon, 18 Jun 2018 17:48:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935449AbeFRRsP (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Jun 2018 13:48:15 -0400
Received: from mail-yw0-f182.google.com ([209.85.161.182]:34350 "EHLO
        mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934963AbeFRRsO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jun 2018 13:48:14 -0400
Received: by mail-yw0-f182.google.com with SMTP id b125-v6so5946790ywe.1
        for <git@vger.kernel.org>; Mon, 18 Jun 2018 10:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7dSztp0h0QKijwuYzSW3xVucJ4TlgVVoWlzN4vwAISs=;
        b=EabELhQGrSmw37JmYNcMYAuRtunHhMYVJLPrrvG8T+0O+CExIAJbngy2nby4QjKEFX
         u4gAplfZ9EKs1j/FuJl8yeh6Mlo03DJQPJ7cgvf6gKqeGVwoyim6mK3MVkg7urMH+p2n
         By/Vzl7MMWpEOfA1YfqA2yij4dcOqOJvLqRfyD8sVtAC7tkk78W+DmRgu7mq9gLnZaYT
         KZ1przr4ELCdw/yY2cBwkH1vSPbscc3kl52e9ctkfUFQDTFdpRXLQfkfOdfgiP2gxVt4
         36dwPTBhr6NK0rbSm1jl5vgp4PE2GnyXaXHQ1bHF5Ycdw/oHcGjOVl8F+zcgsLQZ6A0Z
         jtFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7dSztp0h0QKijwuYzSW3xVucJ4TlgVVoWlzN4vwAISs=;
        b=b4pap/i1u2wwzcTjPqb0cxdHYBnDiiraBzclPW8L3n1e3Sf6heYCEjkkLm/A2F/n2V
         mLgb8sRZUjA9vz1t18AI2ZVuo9cGqpQ10F1ZgcZtEPA7OCDo1J3FPlq3/Sc7EnZtOzcJ
         xSSlksf1BR7/e3UtuPP55ZX21cBEOCjTRXZtYph4tj2yCzRKmFb60XheflvXtx/zhiEX
         14KlWJGboLtpOT7hwIyInRoJ/9w2fNi52w/9pdmXTqDJDpB4YbAOKknGCAg0fBadRvtE
         w/DW0wB+s611hshPj4dkf/dgS7GarVllZEtV+6hn+dWodgcwsv1PhQkUeGESHT9RwFdV
         CFxA==
X-Gm-Message-State: APt69E3hLrOjpkZL7TJqn6jJ2OUxnfNdNtWcPE8bGzbddLQSzGIw3rV5
        62v8EZOhgOBOkJDn5My79pbvWOFHuk7Upjepk1yuSA==
X-Google-Smtp-Source: ADUXVKKhSV0tsNFXHUBv/7zrsv+glkLrhIDM17E/tbCMzABb97Lr0y4VBkz9UDrYIjd2ZS7/bgkrjQZnGrA0eRdO+5g=
X-Received: by 2002:a0d:f442:: with SMTP id d63-v6mr6486649ywf.238.1529344093507;
 Mon, 18 Jun 2018 10:48:13 -0700 (PDT)
MIME-Version: 1.0
References: <20180616203319.9558-1-szeder.dev@gmail.com>
In-Reply-To: <20180616203319.9558-1-szeder.dev@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 18 Jun 2018 10:48:02 -0700
Message-ID: <CAGZ79kaijLGr4LBWyS5z6QwNzmPkrNVGcatpqW0nnBWwOUe4Mw@mail.gmail.com>
Subject: Re: [PATCH] t7406-submodule-update: fix broken &&-chains
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 16, 2018 at 1:33 PM SZEDER G=C3=A1bor <szeder.dev@gmail.com> wr=
ote:
>
> Three tests in 't7406-submodule-update' contain broken &&-chains, but
> since they are all in subshells, chain-lint couldn't notice them.
>
> Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>

This looks good to me;

Thanks for spotting and fixing it,
Stefan
