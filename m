Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC1551F453
	for <e@80x24.org>; Tue, 29 Jan 2019 22:58:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727687AbfA2W63 (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Jan 2019 17:58:29 -0500
Received: from mail-wm1-f45.google.com ([209.85.128.45]:35806 "EHLO
        mail-wm1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726846AbfA2W63 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jan 2019 17:58:29 -0500
Received: by mail-wm1-f45.google.com with SMTP id t200so19749940wmt.0
        for <git@vger.kernel.org>; Tue, 29 Jan 2019 14:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=/j1IJdJiix2qQZb98V20xX10/pipHZtSxpFuFjQpkZc=;
        b=UzEHkuBbF7x63aKwNXyUEyKSbyqwlgTlef/O97HIVwlWtxi8BL1gOaMD2S7E58x+WT
         fBJwb5Cb6Lh6XThMYRjNuAooOJRukDFdbb1BG3M2S2tFiRKuQy803ENvCnOoiPyw9nLc
         WqsSrDpUoDmqDwI1omtX4BLdmlyhZ5T44AopRxKnvUH1YZ3AOkueBmBYbpGsrkrr4FlQ
         S1bM4WHC73t6FaJnAOcXBknYdjW0SmDFcAHxTK1FRrwvBxkrLd2Dc0Y2Vt70Y9gJkOJc
         9mvB3PDywLJKNMvRMTRFHob0smIm9EAutdSEN/DURKuHmlMcyvr5dvTc5/d1g30khZof
         kasw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=/j1IJdJiix2qQZb98V20xX10/pipHZtSxpFuFjQpkZc=;
        b=S+sS/z4r+kXo6I3FlN+y5ESk698WNJ1SMM32xsOFXJoGxaS0dGAwJ1hlQdKLlrfFB3
         JqKtgzTV5Qz0nHuK6nwmL9sDylblqy4yj168Hr4h44DQ3IYho+co/Bf3g6T5AFT5Vq38
         ZJdZT2zs7e39rc7TrGx8OjGOcb57zF4KM4h+6gDR/dJ/rKQUGAL/nbn/Rk77/sHcW2zo
         +SEQ5pYlaC5ayw4hSjUZQId6g0TRW1C1vwqP0Em+E/yuzMB4v/YpYplig4BPJ5DCIVM1
         OQzlA3hb0ih8Ah4/6DAWEVKDjDsCL+mYxWPbMXmldjQAS46nZ9jECKSIPd2DUnlcWYIn
         dllw==
X-Gm-Message-State: AJcUukfdc8zD/EiS+cbDeXnhjCooknEsfy9eAvHODDDMrGN7Tw75fSV/
        U8L7HcFq+2OYbza71ekGf1A=
X-Google-Smtp-Source: ALg8bN5rDZu+X9Gjz1IAQETrV1X0L72/kpNB6j0s8hA6b3qEaWwAli5jWF3oW30n5Va4s/U4iZZaRw==
X-Received: by 2002:a1c:5fd7:: with SMTP id t206mr24120286wmb.145.1548802707263;
        Tue, 29 Jan 2019 14:58:27 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id h17sm113270153wrt.59.2019.01.29.14.58.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 Jan 2019 14:58:26 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeremy Huddleston Sequoia <jeremyhu@apple.com>
Cc:     git@vger.kernel.org, peff@peff.net,
        Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH (Apple Git) 04/13] t4014: git --version can have SP in it
References: <20190129193818.8645-1-jeremyhu@apple.com>
        <20190129193818.8645-5-jeremyhu@apple.com>
Date:   Tue, 29 Jan 2019 14:58:26 -0800
In-Reply-To: <20190129193818.8645-5-jeremyhu@apple.com> (Jeremy Huddleston
        Sequoia's message of "Tue, 29 Jan 2019 11:38:10 -0800")
Message-ID: <xmqqwomn5awd.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeremy Huddleston Sequoia <jeremyhu@apple.com> writes:

> Because the default Git version string looks like "git version
> 2.10.0-1-g480871e09e", this was mostly OK, but people can change this
> version string to arbitrary thing while compiling, which can break the
> assumption if they had SP in it.  Notably, Apple ships modified Git with
> " (Apple Git-xx)" appended to its version number.

I am not sure if that customization is a sensible thing to do in the
first place, but ...

>  
> -git_version="$(git --version | sed "s/.* //")"
> +git_version="$(git --version | sed "s/git version //")"
>  

... this is good, simply because in help.c::cmd_version() we see

        int cmd_version(int argc, const char **argv, const char *prefix)
        {
                ...
                printf("git version %s\n", git_version_string);

i.e. no matter how heavily modified git_version_string[] is, we will
always show "git version" at the beginning (unless a builder goes
one step further to customize the version string by modifying the
source, at which point all bets are off).

To save reviewers and readers from wasting time wondering what
happens when a company, which is even less reasonable than Apple,
modifies the version number to include "git version" in it, the
updated sed expression probably should anchor the pattern to the
left edge to clarify the intention, even though it would not make
any difference in practice, i.e.

	sed 's/^git version //'

