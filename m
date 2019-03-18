Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76B8820248
	for <e@80x24.org>; Mon, 18 Mar 2019 02:47:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727566AbfCRCrX (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Mar 2019 22:47:23 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51022 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727201AbfCRCrX (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Mar 2019 22:47:23 -0400
Received: by mail-wm1-f67.google.com with SMTP id z11so2922432wmi.0
        for <git@vger.kernel.org>; Sun, 17 Mar 2019 19:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Ix+8kIiqWgMHQi5ZdVcNWZ12EUkNs7KXEGj/F9njyC4=;
        b=cpVdv+lyzG7uOTvMPSxzhmKcILy8+hY71vMYSkeMUkP7VFEZUD/HXRbfEgdgSxs4gc
         mZrC2jW//63TE5yzXkqT/9BGPe5pBLW8tXfgaGS7MWKuoEyWf5UOzcFRDhUpE3s8g3Y5
         SBt+Zvc4gwckVX04OO2YytFqz2Y4YQlulctiLSjVwlVjrb5zgl8OldzCjIC8hz3+8/ah
         oJKYoQAt4ASNfAOYPuAPCWkiYDzfQ5odAFftomxTrNbO8lPhIDpbfy1DdZoZUouLWiUN
         Kfk7t1SjaqwJzgMgazRVEskEVN6FWSQ+1dTJp17VNS0XXzEga7BD9mcETH+ItHh/jMOz
         eUig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Ix+8kIiqWgMHQi5ZdVcNWZ12EUkNs7KXEGj/F9njyC4=;
        b=bcV7xDG0axwuZntbeFjYxw1YlDl1JccGhDguXcdBOTZtoMfreck4kCZmGdXcpUUwMO
         CWwljdJG9jJHSPF8W0HdeMT+1tOMBFroeUYucFyOdD5juIKl0ZNGPY5O7954PkTW6egE
         Uuhv8hr5l7739bVHTaWnydsQEQ1nloKPYHXepDmdPStVTXuUzkZXm1YhuX2Epq9Fu8AC
         ePqvzEXwwr9I4NBGWnAvCTXufcbbX/HFeGeagnMvr7UP/uPXNAhTHifD4mvBJACsfBDN
         WAW8qpAnn0gtb1lCrs+pcgAMuAa1SCjAGx9ShyAZbxeWpXPSPavaK/ku9LYlPZ7ZpRFW
         sxKg==
X-Gm-Message-State: APjAAAV6U3U4o9yGy2Q6c6AYKo+m0bbv1PoLfvruzZHcGpBRHzzePVJl
        I5dIfRbgdaY1lkVEy81Qsgw=
X-Google-Smtp-Source: APXvYqyxnA2MKgRU/tLzL+3XatTKjS52FNSyD9v3lE0uAInTCuqurEotDuw1kx0876d2rGmldr6PNg==
X-Received: by 2002:a1c:f20e:: with SMTP id s14mr9686603wmc.69.1552877241168;
        Sun, 17 Mar 2019 19:47:21 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id h17sm6938007wrq.93.2019.03.17.19.47.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 Mar 2019 19:47:20 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 2/3] parse-options: make OPT_ARGUMENT()  more useful
References: <pull.163.git.gitgitgadget@gmail.com>
        <pull.163.v2.git.gitgitgadget@gmail.com>
        <10775638ad8f2ef9b64b8dbaf71b80d8546e81d8.1552562701.git.gitgitgadget@gmail.com>
        <20190315031553.GB28943@sigill.intra.peff.net>
Date:   Mon, 18 Mar 2019 11:47:20 +0900
In-Reply-To: <20190315031553.GB28943@sigill.intra.peff.net> (Jeff King's
        message of "Thu, 14 Mar 2019 23:15:53 -0400")
Message-ID: <xmqq7ecw7vbb.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> +`OPT_ARGUMENT(long, &int_var, description)`::
>>  	Introduce a long-option argument that will be kept in `argv[]`.
>> +	If this option was seen, `int_var` will be set to one (except
>> +	if a `NULL` pointer was passed).
>
> So this effectively makes it into a "bool" that we keep. I think that's
> fine. It always uses NOARG, so it is not like we would ever need to see
> "we got --foo, and this is the argument it had".
>
> I did wonder if it was possible for "--no-foo" to trigger this (leaving
> the caller who looks at the int unsure if they saw "--foo" or
> "--no-foo"), but it seems that the parse-options code checks for
> OPTION_ARGUMENT before it ever looks at negation.

When a caller that needs to tell --no-foo and lack of any foo
related option arises, we should be able to update the function
further so that the caller can initialize the variable to -1
(unspecified) and make sure that 0 is left upon seeing --no-foo
so it's not a show stopper, I guess.


