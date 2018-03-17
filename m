Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 845CC1F42D
	for <e@80x24.org>; Sat, 17 Mar 2018 07:38:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751924AbeCQHiy (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Mar 2018 03:38:54 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:54131 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751917AbeCQHiy (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Mar 2018 03:38:54 -0400
Received: by mail-wm0-f47.google.com with SMTP id e194so6878280wmd.3
        for <git@vger.kernel.org>; Sat, 17 Mar 2018 00:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=DCWaB6y9ffkVP5crpHCoVFoCX1hGYWeBuQu76lm77bU=;
        b=hmA7UAqPQhOmJXokolFPUCmiy1i1U9nETxkKaYZA43p3yleK2HeEOGsJY1Lbef9nYW
         wkmJtGqzIuLMmt8FyD+VRSGOpKo6g3OP37gWvxYG7+JItzW7l9OirK9u65IwcPi03xN3
         O3M7hvcP9xIANxkzrkhFeaEDqdVTQNKkSzFcNHnHiBuILUsdOxWWQV7zIIak15ZxzRsr
         6EMj6U7M8D/IW+tgC5fzvQbhcVXj4WOqcyZvbunHkLYVYfVEogNnHX3fntnvRP7JFNgc
         vO751S2ZlhTSQk+vZ7gc2Dq9hMQy3mj6eG5zm2yNgvGSz9N4H9ZVsVliZJgoETwMaDEG
         VMWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=DCWaB6y9ffkVP5crpHCoVFoCX1hGYWeBuQu76lm77bU=;
        b=ISofgQlZ9uz8YGrL9p4ibvLXvvPp/V/B2S2HLL4ASR+XciPORsRIOr7wpvsRnTrI6o
         4DMcfVCrPUPyzIZGH5sQBmPhDq9E5DwOm+hzpsXXjzAPia8caQF88DgQ4jMViGG5lN7T
         oj5ztymUQsBODPQrYnkODRtk7sdoEhYjMFOhNcurkMNgluWREkC4iQnbwqUnsaY5WZuL
         Hc+eMYmC1cMhcS5J5DiKgSzGJ0mXF1fCQOou62JAOUuki02l16Fslllb8aLNQOllGQU9
         XPod1RuD2BJJ9qXgKzgodXHgicrHDWP7BYjh6I5Fdk3zEzPFvAyicThV+0Tm/39v5Wpd
         CwPQ==
X-Gm-Message-State: AElRT7FSgEyoZYSCCmKSZmX0phoJrN9GpgTsM2AOcJRAV6YR4WUPJR4G
        MdfX0/voC5Yn+5xTusZSc52L4AxeG57jOmRPsJ0=
X-Google-Smtp-Source: AG47ELtxU5GlH9j6MIXRt8Mm44zWM7ZSHAZS6Jpp5H7I6g4wZlM0/n1rCKlc2OJajhXQ7wH1mWa1zhA2EznLQEalUfg=
X-Received: by 10.80.214.206 with SMTP id l14mr5484296edj.44.1521272332843;
 Sat, 17 Mar 2018 00:38:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.80.158.77 with HTTP; Sat, 17 Mar 2018 00:38:32 -0700 (PDT)
In-Reply-To: <20180316211837.GB12333@sigill.intra.peff.net>
References: <20180316194057.77513-1-git@jeffhostetler.com> <20180316211837.GB12333@sigill.intra.peff.net>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Sat, 17 Mar 2018 00:38:32 -0700
Message-ID: <CA+P7+xpGWZaFMWhN72beUVaV_HuECAAEYhf+UT-CPZUV+Gew4Q@mail.gmail.com>
Subject: Re: [PATCH 0/2] routines to generate JSON data
To:     Jeff King <peff@peff.net>
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        lars.schneider@autodesk.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 16, 2018 at 2:18 PM, Jeff King <peff@peff.net> wrote:
>   3. Some other similar format. YAML comes to mind. Last time I looked
>      (quite a while ago), it seemed insanely complex, but I think you
>      could implement only a reasonable subset. OTOH, I think the tools
>      ecosystem for parsing JSON (e.g., jq) is much better.
>

I would personally avoid YAML. It's "easier" for humans to read/parse,
but honestly JSON is already simple enough and anyone who writes C or
javascript can likely parse and hand-write JSON anyways. YAML lacks
built-in parsers for most languages, where as many scripting languages
already have JSON parsing built in, or have more easily attainable
libraries available. In contrast, the YAML libraries are much more
complex and less likely to be available.

That's just my own experience at $dayjob though.

Thanks,
Jake
