Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCDDD1F453
	for <e@80x24.org>; Fri, 28 Sep 2018 08:18:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728694AbeI1Okp (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Sep 2018 10:40:45 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40772 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbeI1Oko (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Sep 2018 10:40:44 -0400
Received: by mail-lf1-f65.google.com with SMTP id t22-v6so4307762lfb.7
        for <git@vger.kernel.org>; Fri, 28 Sep 2018 01:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=e2Rp7BREjdR8Dp9Dw9AWxOFHPHShPuGNJBclaCEBBY4=;
        b=Fsb3cuajddpXvDGEB0OWNpsrVPpGelaDboko9wfWM7tF5BAzoyRuTJTJCMhmj84QzJ
         HsGHfdCIfGTQX3ncd0yHMBMQYXCYy1/npyaBBEZQr/ROXlgkDfWN+ZpE4WAKPAg6ZvMs
         8gCfvR5+A3DFXZ5uDcQnSWOFnjYvcp0D8nqnc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=e2Rp7BREjdR8Dp9Dw9AWxOFHPHShPuGNJBclaCEBBY4=;
        b=DboCjKwRDJBqsLVQcfAtbtaJm/yJrkdPlz0rsogKLQ69XoKVO1daD6LXfX59D/qmND
         m1Y0KCclJE5gyV3JR8+kIM91lN1YPAb9D9kUDQAmLwMp49zCrNnpcomCGN4MSNNwL53Y
         cdPa7RkavGvn3XmpKXAkqquV++mHsgx/JmpLGScUIO13qIVPLK5vneaOHrqxUlgmT6Nz
         AllOl+IUoJ53NealIMDrbBPE92o20vGtTOsJuKOGjLrY8k0OZ27OLG7xWmxQwyUjZezU
         dHB14JkBQigucUJcEfB2hU/OPRh740rnWnO72uZvKQp75Pe9u9sjmu5jmqvGIVpN95MU
         eNXA==
X-Gm-Message-State: ABuFfojQIoJN1/sMvwDlOWvZCR7A304rusdCw+Vyr3IC3mqZduqqqQMo
        iJz9FEVcPmkg4ije4BHZYSwywVkqEo5nQxcr
X-Google-Smtp-Source: ACcGV62e3x700+J5I0xcxuU7c6uSDgjzB+nGRZqMZaSIwEBwjGoo2bfMQf4VyiWfW0mjdgCjUeSPuw==
X-Received: by 2002:a19:e013:: with SMTP id x19-v6mr9227583lfg.89.1538122688261;
        Fri, 28 Sep 2018 01:18:08 -0700 (PDT)
Received: from [192.168.43.23] (77.241.135.131.mobile.3.dk. [77.241.135.131])
        by smtp.gmail.com with ESMTPSA id y9-v6sm435078ljk.35.2018.09.28.01.18.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Sep 2018 01:18:07 -0700 (PDT)
Subject: Re: [PATCH] help: allow redirecting to help for aliased command
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <20180926102636.30691-1-rv@rasmusvillemoes.dk>
 <xmqqzhw4mgq3.fsf@gitster-ct.c.googlers.com>
 <20180926184914.GC30680@sigill.intra.peff.net>
From:   Rasmus Villemoes <rv@rasmusvillemoes.dk>
Message-ID: <3677a12b-5b9b-ad2a-1e3a-7de251baa40d@rasmusvillemoes.dk>
Date:   Fri, 28 Sep 2018 10:18:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180926184914.GC30680@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2018-09-26 20:49, Jeff King wrote:
> On Wed, Sep 26, 2018 at 08:16:36AM -0700, Junio C Hamano wrote:
> 
>>
>> If we expect users to use "git cp --help" a lot more often than "git
>> help cp" (or the other way around), one way to give a nicer experience
>> may be to unconditionally make "git cp --help" to directly show the
>> manpage of cherry-pick, while keeping "git help cp" to never do
>> that.  Then those who want to remember what "co" is aliased to can
>> ask "git help co".
> 
> I like that direction much better. I also wondered if we could leverage
> the "-h" versus "--help" distinction. The problem with printing the
> alias definition along with "--help" is that the latter will start a
> pager that obliterates what we wrote before (and hence all of this delay
> trickery).
> 
> But for "-h" we generally expect the command to output a usage message.
> 
> So what if the rules were:
> 
>   - "git help cp" shows "cp is an alias for cherry-pick" (as it does
>     now)

Sounds good.

>   - "git cp -h" shows "cp is an alias for cherry-pick", followed by
>     actually running "cherry-pick -h", which will show the usage
>     message. For a single-word command that does very little, since the
>     usage message starts with "cherry-pick". But if your alias is
>     actually "cp = cherry-pick -n", then it _is_ telling you extra
>     information.

Funny, I never noticed this difference, and that '-h' for an alias would
actually give more information than '--help'. I sort-of knew that -h
would give the synopsis, so I guess I've just gotten used to always use
--help, and just noticed that for aliases that doesn't provide much help.

Adding the 'is an alias for' info to -h sounds quite sensible.

And this could even work with "!" aliases: we define
>     it, and then it is up to the alias to handle "-h" sensibly.

I'd be nervous about doing this, though, especially if we introduce this
without a new opt-in config option (which seems to be the direction the
discussion is taking). There are lots of commands that don't respond
with a help message to -h, or that only recognize -h as the first word,
or... There are really too many ways this could cause headaches.

But, now that I test it, it seems that we already let the alias handle
-h (and any other following words, with --help as the first word
special-cased). So what you're suggesting is (correct me if I'm wrong)
to _also_ intercept -h as the first word, and then print the alias info,
in addition to spawning the alias with the entire argv as usual. The
alias info would probably need to go to stderr in this case.

>   - "git cp --help" opens the manpage for cherry-pick. We don't bother
>     with the alias definition, as it's available through other means
>     (and thus we skip the obliteration/timing thing totally).

It sounds like you suggest doing this unconditionally, and without any
opt-in via config option or a short wait? That would certainly work for
me. It is, in fact, how I expect 'git cp --help' to work, until I get
reminded that it does not... Also, as Junio noted, is consistent with
--help generally providing more information than -h - except that one
loses the 'is an alias for' part for --help.

>     This really only works for non-! aliases. Those would continue to
>     show the alias definition.

Yes.

Thanks,
Rasmus
