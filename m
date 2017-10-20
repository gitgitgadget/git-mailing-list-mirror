Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E0DB5202A2
	for <e@80x24.org>; Fri, 20 Oct 2017 21:27:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752631AbdJTV1n (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Oct 2017 17:27:43 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:53019 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752346AbdJTV1m (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Oct 2017 17:27:42 -0400
Received: by mail-qt0-f194.google.com with SMTP id 31so20097619qtz.9
        for <git@vger.kernel.org>; Fri, 20 Oct 2017 14:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=EDGY6rwyl2toH2iJtZ31Q0vXNVgdJdZ5w1wWaP3Tm20=;
        b=qxJ2IH5IUjNwJK62obj54hGGfiCvB2CmY7GG0L8qTL43aWKn+F8wy+cztN7C+LNyXP
         mfA7cBpf3kM/ZNIRWGXYIk09eGE9YU+Xkc3DtLhpa5thc8pcm9kiqVyeJU4uLKC49H1v
         NlmJ+ODHwRXVUJFZOh2D0Yg4cSf4q2NVHxtw3ACENvPw02K5VMdEGlp2AN9p9rwJ0Fx9
         D6KxC3/lU0gPXlICQ0QyMHLf6ywy9nNTFhnFM1nfi29Z5zW2GWxc8men9+VB9JuXqXkR
         owTrHhCMHmLG2f0dWvfZ3JcEvteu7T7jdmDJYvNOg1W1vk3fyq6I8DrcZCikNDoKTD/9
         x3zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=EDGY6rwyl2toH2iJtZ31Q0vXNVgdJdZ5w1wWaP3Tm20=;
        b=D+bhwIwkGX8BFK++pYknnZwoHE2IK6Skqg5j42clg9sgKsbSjKV4s7dnY0MB0lm9Ug
         7CYu0oYpwQ+Ia1bFRmo1QU63TRQX3H16TlxiZcXQV6yKNDfh3Bv2e4RW6IYl9QgeZRfd
         7GZHDOV+hAjQ56a0iQLuyz9J0eb0AYLd5EGpVE19w1nn3DdaneqjkQt5kZDNy0YAmQkC
         m24UvovIjY/aAuLlPEpWexOlqbg1DHXu+sqoLMQKe6OslGLhKZLTRCTZzWVTmTJm8WVF
         GZDo+HMfM3fOfhLt3RPmPxPTaq2wRnXW41ZMRdLD+X2zCJHsgbTCS23IosR8/Rm3bUU8
         LODQ==
X-Gm-Message-State: AMCzsaW4zbwINnK+X1cVVgkshBGO5kV87buHbfrFb/36mkDSlNoGvVKL
        UvEdTyvxIogrBIQ+POWifoUgfR19yJDHGxIROhFA+w==
X-Google-Smtp-Source: ABhQp+RuvG8GgbUZS6n3btBj7gRuQ2bXaQTEcqixmM9A7gHHM0spy2CqcmQnPCOX7xuAD/nwR2gDMf/sHlMdDPyoISc=
X-Received: by 10.237.37.132 with SMTP id x4mr8950608qtc.224.1508534861689;
 Fri, 20 Oct 2017 14:27:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.70 with HTTP; Fri, 20 Oct 2017 14:27:40 -0700 (PDT)
In-Reply-To: <20171020055058.s5dgxyfjnqtlxv4d@sigill.intra.peff.net>
References: <20171019210140.64lb52cqtgdh22ew@sigill.intra.peff.net>
 <20171019210730.sgm4g4tmor2dgjv7@sigill.intra.peff.net> <CAGZ79kYTmUnM+fcf222-cvwB3Fg4+J_xy28E7A3AYryx4qDf_w@mail.gmail.com>
 <20171019232337.zfd7occtjboem7f4@sigill.intra.peff.net> <20171020055058.s5dgxyfjnqtlxv4d@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 20 Oct 2017 14:27:40 -0700
Message-ID: <CAGZ79kaSu+nHHntFPWbkXk1TC4ys9htesRg9HHXcpK+Y6MwZeg@mail.gmail.com>
Subject: Re: [PATCH 2/3] t5615: avoid re-using descriptor 4
To:     Jeff King <peff@peff.net>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 19, 2017 at 10:50 PM, Jeff King <peff@peff.net> wrote:
> On Thu, Oct 19, 2017 at 07:23:37PM -0400, Jeff King wrote:
>
>> So one trick is that we can't just set it to a higher number. We have to
>> also open and manage that descriptor. It might be enough to do:
>>
>>   if test -n "$BASH_VERSION"
>>   then
>>       exec 999>&4
>>       BASH_XTRACEFD=999
>>   fi
>> [...]
>> I think it might be workable, but I'm worried we're opening a can of
>> worms. Or continuing to dig into the can of worms from the original
>> BASH_XTRACEFD, if you prefer. :)
>
> So this is the best I came up with (on top of my other patches for
> ease of reading, though I'd re-work them if this is the route we're
> going to go):
>
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 14fac6d6f2..833ceaefd2 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -377,7 +377,12 @@ fi
>  #
>  # Note also that we don't need or want to export it. The tracing is local to
>  # this shell, and we would not want to influence any shells we exec.
> -BASH_XTRACEFD=4
> +if test -n "$BASH_VERSION"
> +then
> +       exec 999>&4
> +       BASH_XTRACEFD=999
> +       silence_trace="999>/dev/null"
> +fi
>
>  test_failure=0
>  test_count=0
> @@ -627,14 +632,16 @@ test_eval_ () {
>         #     be _inside_ the block to avoid polluting the "set -x" output
>         #
>
> -       test_eval_inner_ "$@" </dev/null >&3 2>&4
> -       {
> -               test_eval_ret_=$?
> -               if want_trace
> -               then
> -                       set +x
> -               fi
> -       } 2>/dev/null 4>&2
> +       eval '
> +               test_eval_inner_ "$@" </dev/null >&3 2>&4
> +               {
> +                       test_eval_ret_=$?
> +                       if want_trace
> +                       then
> +                               set +x
> +                       fi
> +               } 2>/dev/null '"$silence_trace"'
> +       '
>
>         if test "$test_eval_ret_" != 0 && want_trace
>         then
>
> I really hate that extra eval, since it adds an extra layer of "+" to
> the tracing output in bash.
..
> So I dunno. It does solve the problem in a way that the individual test
> scripts wouldn't have to care about. But it's a lot of eval trickery.
>

I agree. Maybe just stick with the original patch?

Thanks,
Stefan
