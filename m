Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B08020259
	for <e@80x24.org>; Wed,  7 Dec 2016 12:06:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752184AbcLGMG0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Dec 2016 07:06:26 -0500
Received: from mail-io0-f182.google.com ([209.85.223.182]:33302 "EHLO
        mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752100AbcLGMGZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2016 07:06:25 -0500
Received: by mail-io0-f182.google.com with SMTP id j65so706952903iof.0
        for <git@vger.kernel.org>; Wed, 07 Dec 2016 04:06:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=EnQn5wGATOGm3vl85Pfb7wB/5Lm+l5vJa9czGka/qZg=;
        b=DN16OIz1x9jabIDN0x0BS/h5n9IrPn+WPKp5ryW/lKus8jY2L7vkYleysJclyxJLJ8
         PAJkzIOygI5hwVuJZcsTb4jSfhf0ZwQILKhrI6NTmemBY41e9wcbTF8OTi4wDX6oNDIU
         Yo3+4M2BkmzR+nnEpsavfqpyZuSIHp5P1GAZczX323i+vU3ABnNMUqf7sd9Z/lCM5QlP
         dIRe9aVfhYsSgudg3QddomDZIYkY6cr7E9z8Ner+yOmxk83pCrHVSCkNEUXalnN0Zjxy
         K5WYzlcNwxvs6SAcLW36PWDqPpSCQt8xzgnO4gSBNiVx2qePlgBwVQ+8nz038bxgw2sA
         xPhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=EnQn5wGATOGm3vl85Pfb7wB/5Lm+l5vJa9czGka/qZg=;
        b=VbwAJ/DStzHA9m6aFK/xpQIhLn1esck0U2EKNGLrXPAuXCQsuP1Qo7E+ufpSfP47Rb
         h2bq5GLsBDyMUtXyAOC0V8W2hOW1Wq1b0NVKuGzcQSGHROzJpQMJFEZ8V1Lkpd3K8eos
         8/zNWk9zpcXtbz70pmjwpmX9krYUuRl0Dz70A0gdav6U6Rc8fbc1p+/eWnwrE3wsNjKZ
         BzdxucxBVaBmIuhHgSnkKyxLcXPLaQiPoUirjf+i+rQUgY7iSsBfhQ1rH62XpoH+YRgl
         ugTEsW5t4LrGdvYB5Qp9+PIGBoblF9ROS0Dj86Q5VDXVC2KXpy7KHGHPs5a8tG6AIyCW
         9KBg==
X-Gm-Message-State: AKaTC00474Vthnp4/RUySl/SoMrRGxvt22G3WKN/XxJHhEUngh7CjIrTkGheFS1hpbMAmYzBlOnSY2P6yF/IfQ==
X-Received: by 10.107.53.165 with SMTP id k37mr60803713ioo.74.1481112384540;
 Wed, 07 Dec 2016 04:06:24 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.142.137 with HTTP; Wed, 7 Dec 2016 04:06:24 -0800 (PST)
In-Reply-To: <a492fb63-3642-1f97-4668-a927352169f9@gmx.net>
References: <01020157c38b19e0-81123fa5-5d9d-4f64-8f1b-ff336e83ebe4-000000@eu-west-1.amazonses.com>
 <01020157c38b1ad5-0f90c88e-2077-4155-94e9-7d71dbbac38f-000000@eu-west-1.amazonses.com>
 <b54f7f46-a3c0-3334-24fa-e8d1e7d8f653@gmx.net> <CAFZEwPNZCSGzeabHMH6wihz-51OUMMtnBMsffwJJVm9G8Fn=tw@mail.gmail.com>
 <a492fb63-3642-1f97-4668-a927352169f9@gmx.net>
From:   Pranit Bauva <pranit.bauva@gmail.com>
Date:   Wed, 7 Dec 2016 17:36:24 +0530
Message-ID: <CAFZEwPOyw+OQ=umqmjqvSVtXvDKiC5ic-BTbHhT160rh5VWz1w@mail.gmail.com>
Subject: Re: [PATCH v15 12/27] bisect--helper: `get_terms` & `bisect_terms`
 shell function in C
To:     Stephan Beyer <s-beyer@gmx.net>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Stephan,

On Wed, Dec 7, 2016 at 4:35 AM, Stephan Beyer <s-beyer@gmx.net> wrote:
> Hey Pranit,
>
> On 12/06/2016 10:14 PM, Pranit Bauva wrote:
>>>> +
>>>> +     if (argc == 0) {
>>>> +             printf(_("Your current terms are %s for the old state\nand "
>>>> +                    "%s for the new state.\n"), terms->term_good,
>>>> +                    terms->term_bad);
>>>
>>> Very minor: It improves the readability if you'd split the string after
>>> the \n and put the "and "in the next line.
>>
>> Ah. This is because of the message. If I do the other way, then it
>> won't match the output in one of the tests in t/t6030 thus, I am
>> keeping it that way in order to avoid modifying the file t/t6030.
>
> I think I was unclear here. I was referring to the coding/layouting
> style, not to the string. I mean like writing:
>
>         printf(_("Your current terms are %s for the old state\n"
>                  "and "%s for the new state.\n"),
>                terms->term_good, terms->term_bad);
>
> The string fed to _() is the same, but it is split in a different (imho
> more readable) way: after the "\n", not after the "and ".

Thanks for clearing it out. This seems a sensible change.

>>>> +                     die(_("invalid argument %s for 'git bisect "
>>>> +                               "terms'.\nSupported options are: "
>>>> +                               "--term-good|--term-old and "
>>>> +                               "--term-bad|--term-new."), argv[i]);
>>>
>>> Hm, "return error(...)" and "die(...)" seems to be quasi-equivalent in
>>> this case. Because I am always looking from a library perspective, I'd
>>> prefer "return error(...)".
>>
>> I should use return error()
>
> When you reroll your patches, please also check if you always put _()
> around your error()s ;) (Hmmm... On the other hand, it might be arguable
> if translations are useful for errors that only occur when people hack
> git-bisect or use the bisect--helper directly... This makes me feel like
> all those errors should be prefixed by some "BUG: " marker since the
> ordinary user only sees them when there is a bug. But I don't feel in
> the position to decide or recommend such a thing, so it's just a thought.)

It is seems a good change, I will do it. Let other's comment on what
they think in the next re-roll.

Regards,
Pranit Bauva
