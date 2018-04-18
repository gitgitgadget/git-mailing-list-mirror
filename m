Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C5511F404
	for <e@80x24.org>; Wed, 18 Apr 2018 15:09:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752514AbeDRPJW (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Apr 2018 11:09:22 -0400
Received: from mail-oi0-f52.google.com ([209.85.218.52]:33131 "EHLO
        mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750872AbeDRPJV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Apr 2018 11:09:21 -0400
Received: by mail-oi0-f52.google.com with SMTP id 126-v6so1896151oig.0
        for <git@vger.kernel.org>; Wed, 18 Apr 2018 08:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=hQAy3FwWd8TwBrF2laSKzK7PqfDLSHoJmICsGwQ9YdM=;
        b=koLuxm11ah68YGqZn5uU97FPCB6Z+1BAe651GlJjx7spDk150FIcOWNxXp6q5qofVf
         bAkv6FV/uvTImtB7z83r191oXhlcDNljKDLMTX27fbsgqqGKobprIeK0A2y6lh4RVnWD
         ECmOloqixJ6oN/k1fXAZBI+Wvb1wZiuxioqDKLOaZ61+O3qSIixtDHpugfXs69PvFFKF
         /W1akVWwgXcDU8H93sP3ciABAexuk2aO//KHs6S4qcSSzsWr7icGkhi7s0pW7Do4MhYU
         RDKv7mag8zD8URzaSpwb2e6EVai7O7rZqvB4Gg9cZEeIMkc8ZBoL+RfHi/aA2Ud0HFJ0
         dtpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=hQAy3FwWd8TwBrF2laSKzK7PqfDLSHoJmICsGwQ9YdM=;
        b=ZFpLUU2z6shkCoaqbY2cevICZnAoqNWbTNA9rExVFrqNqfvd8QbNTrrIuB8YKHpZsJ
         w8S0dGlTJIqMKa56b1kiOKWCSlW8u3EhnZg7azaDWOyBBxH2sfMvbOshrW3k4AIUm5yA
         g6xnQ/L38KG8x0VilgFGR30bBg7Yg7L34MiHD0U3uXuN7dBgBU4ke6WSvhpgsfQo53AP
         HTB5QxN71qAnyqZVJMAGjUVUnKBj5hxlaqIuifL4AhLrYTBdRzPAg2in7zGn7toHVXJg
         0qQ3K83g2tXyvTNo6Fm6tiDgwP5sIbCzqDzxIPRO3daE+wVz9Rlpbo6nNjIdIjgdzD9k
         AFbA==
X-Gm-Message-State: ALQs6tATJ6c/dEvzMEZRQNGrQRIsNK96AdOcLLSQsm83v2J5oJYfGxfE
        OMjlw79iiLs74TavGnwetTpmCLNevQjFeRtFMkI=
X-Google-Smtp-Source: AIpwx48L4oFDidGiofv1TO6YboLpVIkagxV94VSjCc6DXJbja57ZKfHnmEu1S/fJSi0R0xS4ObLPO/3hE3EHJnaGq4M=
X-Received: by 2002:aca:1217:: with SMTP id 23-v6mr831117ois.228.1524064160742;
 Wed, 18 Apr 2018 08:09:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.198.152 with HTTP; Wed, 18 Apr 2018 08:08:50 -0700 (PDT)
In-Reply-To: <xmqq604pji2f.fsf@gitster-ct.c.googlers.com>
References: <20180417181300.23683-1-pclouds@gmail.com> <xmqq604pji2f.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 18 Apr 2018 17:08:50 +0200
Message-ID: <CACsJy8CU255jmXFRXVEQUBCvUiDhRHLyTOhMorzyCDYZ4aF9xg@mail.gmail.com>
Subject: Re: [PATCH/RFC] completion: complete all possible -no-<options>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 18, 2018 at 5:43 AM, Junio C Hamano <gitster@pobox.com> wrote:
> So, the earlier mention of "clone --no-checkout" sounded about not
> losing this historical practice, but (desirabilty of magic number 4
> aside) this "show first handful of --no-foo" feature is not about
> historical practice but is forward looking, in the sense that you do
> not mark "important" negated options in the source, which would be a
> way to handle the histrical "clone --no-checkout", but let the
> machinery mechanically choose among --no-foo (with the stupid choice
> criterion "first four are shown").

Well you kinda mark important in the source too. --no-checkout for
exampled is declared as OPT_BOOL(0, "no-checkout"... and parse-options
code has to add the double-negative form --checkout back [1].

The "first four" is chosen after carefully examining all commands and
observing that none of them have more than 4 "important" --no-. But
yes it is questionable and I should be able to do better to separate
the favorable --no- from the other extra and most-of-the-time-useless
--no- options.

> That allows other commands to
> have many --no-foo form without overwhelming the choices, but I am
> not sure if it is much better than a possible alternative of only
> showing --no-foo for more "important" foo's when show_gitcomp() is
> asked to list all of things. It would certainly be a more involved
> solution, that might require an update to the way how the choices
> are precomputed (you'd end up having to keep a separate "use this
> list when completing '--no-'" in addition to the normal list).

I did think about this alternative and was still undecided. Suppose
that you have less than 4 "important" --no- options, showing some
extra ones to me does not really hurt anything and if we could show
more options (within the same screen space) we should. But on the
other hand maintaining this magic number could be a maintenance
nightmare... Yeah I think I'm shifting towards no magic number now.

[1] These double negative options will _always_ show up,  there is no
easy way to hide them because they don't start with --no-. But we
don't have a lot of options starting with "no-" so it's probably fine.
-- 
Duy
