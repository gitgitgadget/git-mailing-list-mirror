Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 555E720954
	for <e@80x24.org>; Thu,  7 Dec 2017 18:57:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752483AbdLGS5q (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Dec 2017 13:57:46 -0500
Received: from mail-wm0-f41.google.com ([74.125.82.41]:43798 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750922AbdLGS5p (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Dec 2017 13:57:45 -0500
Received: by mail-wm0-f41.google.com with SMTP id n138so14801209wmg.2
        for <git@vger.kernel.org>; Thu, 07 Dec 2017 10:57:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Oo5yc+zPZiPxGij47d7iFdD3kPK25pE2k22Ze13Bfa4=;
        b=geOFnWbmkOypUx8GcpNpuZ1VO6hqZvkQ9owt/TYNhpEaIQIjfzPi/YoB026jpDBDBB
         JqJuXszA2YvRnWG9l6l/CFqYJCwp3ZhuXh+QQa/svoluhTYzVOaYMK7YBEU9ESMV/wbZ
         ZmIUE5LGgrsvh1XxqyT6wO40vyMaB2wMfNVWaUE98tH8L1mBh5A7zz31+kMVO3BufZ1Z
         eDZNy6gYz0JOrmsjQCSTHzvUb7oFz6GPsWAp9jW+vnhZ4EBjBjW87Yo0fbPTJTytS10M
         JqOCib8T3EJH3DKkTPT7Uak/RnNeRYVvv6DiwxlzMCmq1YtCGw5nsw74MjJpxRPiJDgS
         xLUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Oo5yc+zPZiPxGij47d7iFdD3kPK25pE2k22Ze13Bfa4=;
        b=ijXZNZVuKlBI94CJElgkcbqGxTo3g+sBJEFCiQh/rZgE+Uic6F34ytjsjrJp6yspXl
         n4aTQeXUu5JFPKA9Kv6PNLwM8mxrSpy4VS+xoK5RCNTxwTl0Sze3UsI/FvvEgndi2icI
         2H0YCGGn4SZUtxNT2FfXPv4IFxl4eRTypytstKKKaFfKSsSlkQk1Co39uzp/riMzRz47
         qM7p2IEoNuKmmz1tPB0t4u+dMCcnnXtY6MOGVIUEaQC+CnIkyhpzvK2epdb0u/z604o2
         ec9wAh6xUcrPB1rgBhlf/KNrvbIgCvDu++C/c7m2gdiC7rPoci7rltyWjOkB5/bqYZqw
         H8YQ==
X-Gm-Message-State: AJaThX6cfk4hTuf8bR/oQktZdXUGfYaEVqC2cIV6/RQo4/UrHk2VW/S8
        RVLtPyXnpU+g6VRbxlmC885OapaJt5lxtgjbvzI7CQ==
X-Google-Smtp-Source: AGs4zMbYOIOLdUH+Cy42P02lVv67TzVt+ZEXN//ALWsSuaGNwWel33sGg/tgOe6O8nb0MT6uyChGgCqbUKvI2CWPWEk=
X-Received: by 10.80.208.195 with SMTP id g3mr46375787edf.246.1512673064128;
 Thu, 07 Dec 2017 10:57:44 -0800 (PST)
MIME-Version: 1.0
Received: by 10.80.174.252 with HTTP; Thu, 7 Dec 2017 10:57:23 -0800 (PST)
In-Reply-To: <xmqq8teeftn7.fsf@gitster.mtv.corp.google.com>
References: <CA+P7+xotDPa+=G5ypfyD7gySp6r2SKRAjMSw_0BmvuyyfcjxBw@mail.gmail.com>
 <CA+P7+xouqMi4xo7psM-PmpqcpKre2X1YyYZBLfMDYSSZ8tD_VQ@mail.gmail.com>
 <20171207002234.GA21003@sigill.intra.peff.net> <20171207002439.GB21003@sigill.intra.peff.net>
 <CA+P7+xpoaa5zaF13ageKKjpPKTECU6XjaRdSZy6WOP7Q0TX+yA@mail.gmail.com>
 <20171207005639.GB1975@sigill.intra.peff.net> <CAP8UFD3iL_sRgvhm7YO_jVG5RiNn1=JRW0qvhBEPcUtCorWdYA@mail.gmail.com>
 <xmqq8teeftn7.fsf@gitster.mtv.corp.google.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Thu, 7 Dec 2017 10:57:23 -0800
Message-ID: <CA+P7+xrhgbcogxYa38jEu3PuF5hVNNYPjAq031bYE8bgao168Q@mail.gmail.com>
Subject: Re: git commit file completion recently broke
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Jeff King <peff@peff.net>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 7, 2017 at 7:24 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Christian Couder <christian.couder@gmail.com> writes:
>
>>> I do think it may make sense for
>>> the "short" one to use NULL, like:
>>>
>>>   skip_to_optional_val(arg, "--relative, &arg)
>>>
>>> but maybe some other callers would be more inconvenienced (they may have
>>> to current NULL back into the empty string if they want to string
>>> "--foo" the same as "--foo=").
>>
>> I discussed that with Junio and yeah there are many callers that want
>> "--foo" to be the same as "--foo=".
>
> Yup, the original thread has details and me saying that assuming all
> of them want --foo and --foo= the same is questionable.  The likely
> fix would be to use the _default variant with NULL, which was added
> exactly for cases like this.
>

Slightly more complex. You have to use the _default variant, pass in
arg instead of options->prefix, and then make sure arg was set before
overwriting options->prefix. If you just use _default with NULL, it
will not quite fix the problem.

Thanks,
Jake
