Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9670C1F404
	for <e@80x24.org>; Mon, 26 Mar 2018 14:55:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752334AbeCZOzS (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Mar 2018 10:55:18 -0400
Received: from mail-ot0-f178.google.com ([74.125.82.178]:43251 "EHLO
        mail-ot0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752290AbeCZOzQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Mar 2018 10:55:16 -0400
Received: by mail-ot0-f178.google.com with SMTP id m22-v6so20915423otf.10
        for <git@vger.kernel.org>; Mon, 26 Mar 2018 07:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Si/zF8GoV8XG8TyKt6gQnBUXZy6GCvN8ivuqxrcVgn8=;
        b=VAYL8FWZZb4d70cT53j/IyPwWKZ9cJhoUfjmAz7WGuAK4SFUxOmgaZkDnbRnVbxChe
         aXCBUtErL/XtfOcta2FCMYxkDPWYtcmgKtlr3B0OExvsm9bWTO0w97TZqv2K4vSSVgVf
         W8VT8tTMeEDRI6vdyBkmZNAc89kSddfd8t5l83jtvgrQkt/ABrDi5yVI3OAKPeDxOyP3
         4jCZNt4SUPqdSU8hVsSkX/FPJ9pXdcgeP5Y8dJVM8iaPuD7rDHzMR+PC34B3NTzlhLct
         qpJt5u/JIceif2ZziDl3I+5p1STHMazN2Smfiw6LbWX9EhjL6lxoYpEjOMXnkl+EZ8d+
         CaEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Si/zF8GoV8XG8TyKt6gQnBUXZy6GCvN8ivuqxrcVgn8=;
        b=F0CRsVveytkOOA+kHKFVJwlidpI/Aar+rCTOz0zXR8tND0KPYX4fwJfV21NObVP+Vf
         Dg6uVSnZkIhgclTl5Er/XzRHeX/LSrl+yh1Q2GgiWrNjP41JOk+A/l/lVAvLAWY6k5yI
         +m0qgninx2KvkEzdrvv8uVdAeO3imeBIF8AXgQC3+MjuyyfMRJ2W9DVLwRcwzkNFxdn6
         hAkaPS35KGLyOSwTwf+rng8gvWzwoCPIopJ/N0ESuXCI/Z5yHLtNb+jRngB0LJka5klh
         cvDoXEoVRshXvO0WW8O56xfcpDBIYiJQk08FvjT0cTUkdq6z6sugT8EN5/MhCf2ctu8n
         hyaw==
X-Gm-Message-State: AElRT7FwYscJesLXq3XdUBx7tETFjqMlRzJwkFVk/dVHRSiM2tesGEBy
        LdI3Zq78EzUTLZWhe3m0ZDzIsh6CGPcRkyvBqzGhg1EA
X-Google-Smtp-Source: AG47ELtwTbbuFhqADmJt9msGByT8bqXcpgpGPXu2JdizmfPWOJ8Raz3dZn0Jub4fbcpLnrrDqIPQLntXAnks9evcDJQ=
X-Received: by 2002:a9d:624d:: with SMTP id i13-v6mr16738957otk.26.1522076115677;
 Mon, 26 Mar 2018 07:55:15 -0700 (PDT)
MIME-Version: 1.0
References: <20180325205120.17730-1-dnj@google.com> <877epzyi0b.fsf@evledraar.gmail.com>
 <CAD1RUU-EoitBdoXL_JQoP+Q9BuA_6Fq65Ra-f+Atz8YNOV3Cig@mail.gmail.com> <87zi2vvsir.fsf@evledraar.gmail.com>
In-Reply-To: <87zi2vvsir.fsf@evledraar.gmail.com>
From:   Daniel Jacques <dnj@google.com>
Date:   Mon, 26 Mar 2018 14:55:04 +0000
Message-ID: <CAD1RUU9xFBhmo2-2P6TN_oiYR-fFZ+O6UeJsaXQBZG+dE0h3bQ@mail.gmail.com>
Subject: Re: [PATCH v7 0/3] RUNTIME_PREFIX relocatable Git
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 26, 2018 at 10:08 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <av=
arab@gmail.com>
wrote:

> > Oh sorry, I must have missed that. I have a personal preference for
adding
> > brackets for clarity; it leaked into this patch set. I did implement
most
> > of the suggestion, which was to use the escaped Q/E instead of equals.
> >
> > Stylistically I still prefer the braces, but I'll defer to you and
remove
> > them in my pending patch set in case I'm asked to submit another
version.

> If you prefer it that way just keep your version. It's your code and
> it's just a trivial style difference.

> I just mentioned it because in the previous discussion you said "I agree
> it's cleaner" so I inferred that you'd just forgotten about it but meant
> to change it. It's also fine if later you just thought "you know what,
> I'm doing it my way" :)

Honestly there's enough of a delay here that I don't remember, but if I had
to guess I probably just forgot to make the change :)
