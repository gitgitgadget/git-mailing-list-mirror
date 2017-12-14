Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C7AB1F406
	for <e@80x24.org>; Thu, 14 Dec 2017 08:57:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751226AbdLNI5H (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Dec 2017 03:57:07 -0500
Received: from mail-it0-f53.google.com ([209.85.214.53]:37211 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751175AbdLNI5G (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Dec 2017 03:57:06 -0500
Received: by mail-it0-f53.google.com with SMTP id d137so9405505itc.2
        for <git@vger.kernel.org>; Thu, 14 Dec 2017 00:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=qEUQLm0ZvUDjT4xCM03fOXDu1cQImrb9802r/Qp8Egw=;
        b=PlGo/8BDz9y80AfbqHLnpg3iXPZaxZi/YFlwvHwJ9XvTIETjX8VzjVV+rqi2hBlWR8
         T4Ow3v3QHPEqEq2iTHjuWUAlG8Cf0CvGPxK0zSTDcBiTW7xVOotMafY5C3O51R8ANQnA
         9B/rCs1DP2A5WaLklI3kyPPojmIV3uXuh3REX7lL4Cztx16co0kfZ8lOLYAKAICzjEe1
         hG02moc74PQfbAtWQgoGMlWUAQkbdC66ynP1PDZxlpT4420u7tfCjVBo315JNnMfXjQ3
         A0N5+k0088reew7oBbvV5QY4v8nUtws56wwzGgMWOevncLPndfm0rjMJ94gqK1+Hkgw5
         pVKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=qEUQLm0ZvUDjT4xCM03fOXDu1cQImrb9802r/Qp8Egw=;
        b=WXluGwpf2Zk6EcmL03+gq30o5Ldpy9Fq8lAeAMVsmfVfF7SxNpu3evE9Nlr+eBoNHB
         3Ewg+DnaPs3TVHKodQB3MfS3OfXLj3+iHqxnNZqLpRlrzavG+nVj4o6hMx7kW3mwwVWZ
         emerBNnMByPOCaRioAcKfuhu3dPaO99OBhRWufK6E3EnH4rOgGy/5sHhQ86gR8de6kjd
         P/9lHCGTBVhu7tHAcdKKDxH2EVymY+WRHVzJfRtAacZi2/tV4+pvD7MpUv4ChEpAlJky
         znMrydSW2WJR+MS5T2c7H2e3HHOsJjUhymad1q0Nob+HjIpkD0IaFNRIK5GRh7ea1Gzm
         DY5A==
X-Gm-Message-State: AKGB3mK0nfxa8aT0M/i3UU4leyXkenZ5o8FuYcaS9CiZM38LoDOSnpg4
        bMxzv8tHZ6LCNOwwRwItbX6G3QLQ6SvDuGnJD/4=
X-Google-Smtp-Source: ACJfBov6ZnAtWqyTdNFXMgu2E9jjtKlQ0Otmf2zwjHt5asAVdUMEn04kDcGhza7qwA4xZ3oZvGjHamXZ5XG6FOWbA0Y=
X-Received: by 10.36.124.197 with SMTP id a188mr2318099itd.63.1513241825778;
 Thu, 14 Dec 2017 00:57:05 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.28.137 with HTTP; Thu, 14 Dec 2017 00:57:05 -0800 (PST)
In-Reply-To: <xmqqfu8ewepg.fsf@gitster.mtv.corp.google.com>
References: <20171213151344.2138-1-chriscool@tuxfamily.org>
 <20171213151344.2138-4-chriscool@tuxfamily.org> <xmqqfu8ewepg.fsf@gitster.mtv.corp.google.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 14 Dec 2017 09:57:05 +0100
Message-ID: <CAP8UFD1OAwTNAe94DPuJJSAvTa7ojH3sdsK_fkfsW4LUAw+u=Q@mail.gmail.com>
Subject: Re: [PATCH 3/8] perf/aggregate: implement codespeed JSON output
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Thomas Rast <tr@thomasrast.ch>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 13, 2017 at 9:33 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Christian Couder <christian.couder@gmail.com> writes:
>
>>  my $resultsdir = "test-results";
>> +my $results_section = "";
>>  if (exists $ENV{GIT_PERF_SUBSECTION} and $ENV{GIT_PERF_SUBSECTION} ne "") {
>>       $resultsdir .= "/" . $ENV{GIT_PERF_SUBSECTION};
>> +     $results_section = $ENV{GIT_PERF_SUBSECTION};
>>  }
>
> ...
>
>> +     my $executable;
>> +     if ($results_section eq "") {
>> +             $executable = `uname -o -p`;
>> +     } else {
>> +             $executable = $results_section;
>> +             chomp $executable;
>> +     }
>
> Aside from portability of 'uname -o' Eric raised, I wonder if the
> platform information is still useful even when perf-subsection is
> specified.  With the above code, we can identify that a single
> result is for (say) MacOS only when we are not limiting to a single
> subsection, but wouldn't it be equally a valid desire to be able to
> track performance figures for a single subsection over time and
> being able to say "On MacOS, subsection A's performance dropped
> between release X and X+1 quite a bit, but on Linux x86-64, there
> was no such change" or somesuch?

Yeah, I agree that it would be useful. Unfortunately it looks like the
number of fields in Codespeed is limited and I am not sure what will
be more important for people in general. Another option would be to
have "MacOS" in the "environment" field. Or maybe there is a need for
a generic way to customize this. For now I just tried to come up with
something sensible for what AEvar and me want to do.

> IOW, shouldn't the "executable" label always contain the platform
> information, plus an optional subsection info when (and only when)
> the result is limited to a subsection?
>
> By the way, $results_section that is not an empty string at this
> point must have come from $ENV{GIT_PERF_SUBSECTION}, and from the
> way the environment variable is used in t/perf/run, e.g.
>
>                 (
>                         GIT_PERF_SUBSECTION="$subsec"
>                         export GIT_PERF_SUBSECTION
>                         echo "======== Run for subsection '$GIT_PERF_SUBSECTION' ========"
>                         run_subsection "$@"
>                 )
>
> I do not think we expect it to have a trailing LF.  What's that
> chomp doing there?

It's a silly mistake I made when I reorganized the patches just before
sending them. The chomp should be after "$executable = `uname -o -p`;"
(so in the other branch of the "if ... else"). I will fix this in the
next version.
