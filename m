Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C9B620401
	for <e@80x24.org>; Wed, 21 Jun 2017 21:51:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752530AbdFUVvX (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Jun 2017 17:51:23 -0400
Received: from mail-pg0-f50.google.com ([74.125.83.50]:36446 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752524AbdFUVvW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2017 17:51:22 -0400
Received: by mail-pg0-f50.google.com with SMTP id u62so63074001pgb.3
        for <git@vger.kernel.org>; Wed, 21 Jun 2017 14:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=xjxlUFWGg/tBAJyDH/anmQ0gSCSjgpEYFJ39Waah5gU=;
        b=fAGmNM9H6qXyzj9I1y8V7yqVWhYzU8ugIOb4k3oeGG0hzhOC6t5bhpOuqSlckR8FR6
         D2SEPl9hVIMKaf1Xe8O8MVo2ntDLdWa3D2N0V9vPyYK8ID0Jx+O4TXy2rHdEQRzAm1VB
         Xb9h8fgo6fyQOlAvIgAo5ZSTuUaHaw1iWpfqZLP2rf/bHj8Rk0ShLYkjturC3iFR0KlA
         0ngIGpSFxSfL+f4ISoWB6PcdqMorc7BJ5LetSdTcKkiZxol8U6yV5Uwz2mVMj4lIjZF7
         d2+ZKz+lF7Co9V/fC32gSPiZajHFgrS6q0X64tzT7eRTGzLti6Pa+2BY9FGompD/8XsF
         ju7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=xjxlUFWGg/tBAJyDH/anmQ0gSCSjgpEYFJ39Waah5gU=;
        b=T3VW3V4MJ1AyOZlAHN3Yufm+QaNN+XjXGiBOTwBVLz9qtgRYqlxaJPjE+L19jADJGa
         RkYtVmd3BePQ1l3MnpBMDP7let7kbVcyixOQmbgJ8ye2jOZt1gbCmMyWXymHaoh/XpRy
         eZlBTAVIidwRoAgS6B2habVZKwOnH32Ghgmwoik1F5jHxA9TcC85vwfY9+wJngH6MApk
         R8j7Qvbnj0IIW+QROQXg0asi1XvXVu81EaTndGRtpN7CyW5oIbWBIO3mGaxVhJifOb29
         kXFv5NfxBOUBml5Ok1+cHFQbyM2VkmtjGUu47i8qzEBsUJKatSLNvDAEHcXmPhLBQF0S
         H1AA==
X-Gm-Message-State: AKS2vOybQG5tv1xpK9yF8PaF0Oq7D2xaTli4PHIGE9IzxsMnIx+8BqKm
        jKzCoToBjF9qjfwSIPEfcGgRvgfvLHzugCo=
X-Received: by 10.84.131.101 with SMTP id 92mr40879268pld.279.1498081861452;
 Wed, 21 Jun 2017 14:51:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.161.227 with HTTP; Wed, 21 Jun 2017 14:51:00 -0700 (PDT)
In-Reply-To: <xmqqtw39m2y6.fsf@gitster.mtv.corp.google.com>
References: <CAGZ79kaqjQYmkt77kk5m=fdBfbZAvwd0YhhT7=O5b-FkQmDfHg@mail.gmail.com>
 <20170620024816.20021-1-sbeller@google.com> <20170620024816.20021-5-sbeller@google.com>
 <xmqq7f05p1z7.fsf@gitster.mtv.corp.google.com> <CAGZ79kYUpJxX-wBU=ALPgJwVaA8h_iJRtAu3T7p4J7qmy=U4dg@mail.gmail.com>
 <xmqq7f05niwt.fsf@gitster.mtv.corp.google.com> <CAGZ79kZnDdtB6O5jnt7ouG-qoOS90kZALqZB_-gOT0OQcJzvRg@mail.gmail.com>
 <xmqqtw39m2y6.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 21 Jun 2017 14:51:00 -0700
Message-ID: <CAGZ79kbvYBR2M1BRxUPx_e0m8h0TFLx+D44Ueh4XZ6bRMhr7qg@mail.gmail.com>
Subject: Re: [PATCH 04/26] diff.c: introduce emit_diff_symbol
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 21, 2017 at 2:43 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>>>> I looked through out code base and for enums this is
>>>> actually strictly enforced, so I guess I have to play
>>>> by the rules here as I do not want to be the first
>>>> to deviate from an upheld standard.
>>>
>>> You sound like you are trying to find an excuse "not to play by the
>>> rules".  Don't.
>>
>> When the rules are not yielding best results, adapting the rules
>> should be considered.
>
> I do not think anybody is saying that it is unreasonable to have a
> wish that it would be wonderful if we could use C99 features.
>
> Trailing comma at the end of enum is the least interesting addition
> (it is a fix for a previous editions' brown-paper-bag mistake).  I'd
> be delighted if we can drop support for older compilers and start
> using designated initializers, for example.
>
> Finding other's violation of the current coding guideline is *not*
> the right way to promote for that future, however.

In practice it is, though.

Due to the nature of this project we cannot obtain a world view
of our users (and compilers used), such that it is impossible to say
when the last usage with a strict C89 happens.

If however there is code violating the C89 style for a long
enough time and nobody speaks up, we can assume we can
safely upgrade to C99.

To do this in a controlled (ideal) way, we would have a
single location in the code where we'd use a new desired
feature from C99, such that a "rollback" to strict C89 is
easy either by reverting to the old style or even just reverting
a commit as the occurrence was in a dummy file.

By violating the style guide in more than just one place
this is cumbersome and should not be done, which is
why I said I will not do it in this series.

Thanks,
Stefan
