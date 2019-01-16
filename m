Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 515F71F62E
	for <e@80x24.org>; Wed, 16 Jan 2019 02:28:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728309AbfAPC2N (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Jan 2019 21:28:13 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38667 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728243AbfAPC2N (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jan 2019 21:28:13 -0500
Received: by mail-pl1-f193.google.com with SMTP id e5so2222510plb.5
        for <git@vger.kernel.org>; Tue, 15 Jan 2019 18:28:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=itYALjx+1ybn5wnmjv4z9kBbPNYmftevxYU+31t/pZ8=;
        b=uiahq3fpBoi4W7McETysyn5OSzi2QvriueHtSCU2RiN9dx4HZAdj2iYlU0hYMwltsB
         B51Wb+vAiILDS9sNIrhl88eI68FrSDO/EvzW1faZfcfliZOYNu8a2Grx0Bzl92XvBIR7
         OoZ8vhGOjo3V1kouQYs2ki7ZgC+i7mmw1QGIewbgGczh3W7UhzAS1sRoXqzcPPs8jGkU
         f0QeIMrWJYen7Ir6dZuwteTNSEEr91yMRl54ls6y8aVgFJ3IJV1E2bT9q+rp2Cu5DLGh
         vQNnrkoEeLa8UrcrV4SEy4pafQO2E4hzb5g8Z0vRYGZwMhqhpohDqwHO3sV87RBVvBS7
         1vEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=itYALjx+1ybn5wnmjv4z9kBbPNYmftevxYU+31t/pZ8=;
        b=mFQMS6uQHl0/PCyVmtZ1NHXcUnDi8SsRc8gijypxuBh83M5CQ14SZ+Vwd9kpyVcA8l
         ++f0QOOtiDcLk3Y9tX1yBZ4kv7d/rMXscD+nnmIhmD8y1UH6DR+WGH8eq1pmzwPlvp7P
         rNBMV3DwZ8cwoJY3bHQ+BLBC+T7cNaGLqUflm4NuhoyUKXweDAb55vR8RaksMpDjVq9a
         Ze2sWHIh0YoDdz/CatdQ8CC6xLDktg1kyaU5XlEVYoJoQ2Q696BczWVL5ThqKKtGQZpl
         Y5ZmMT3nUWSZghi5TUflwn5caM/4/rlmR3U7zLA7pTxrhiw5qTquydvLFpgVoqYgd2Rj
         L7pg==
X-Gm-Message-State: AJcUukfjFOCLCpIPB4WfDGW/acpqbdQsJdjFEWfo88uJ3CrTkehYHIik
        n7+vtIb+GRMN53l80IyjijIji5J8
X-Google-Smtp-Source: ALg8bN4Vh4iLwxvuCPMjPBL04csgWS+/jS1jwkFjChKlBI0TIlhJnHLDLgm0O8Zmc49tsUc2fbP0ww==
X-Received: by 2002:a17:902:9b87:: with SMTP id y7mr7374268plp.336.1547605691702;
        Tue, 15 Jan 2019 18:28:11 -0800 (PST)
Received: from google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id u29sm5019451pgn.23.2019.01.15.18.28.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Jan 2019 18:28:11 -0800 (PST)
Date:   Tue, 15 Jan 2019 18:28:08 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Nate Weaver <wevah@derailer.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>, primenico@gmail.com,
        Git List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [Bug report] Git incorrectly selects language in macos
Message-ID: <20190116022808.GC8864@google.com>
References: <CAKd-JgStGb4Ka9Rs6G2e4ADQKZVrsJMsNGz1sRP_4Ej4=FtxtA@mail.gmail.com>
 <CAKd-JgS3omKbN+OzQL2dUun6Seg9CjDNk8KEj9m83xdTZE=7FA@mail.gmail.com>
 <CAPig+cQWW9kibWYKu5oRDgo_Pt4wVmzkqzbTG=YGvwqRCXcNXw@mail.gmail.com>
 <BF7AD597-5C05-4A7A-8DB6-0FEA2F95AF72@derailer.org>
 <89DD4C7B-7F8B-42C5-81F2-F14D5B2D4CFD@derailer.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89DD4C7B-7F8B-42C5-81F2-F14D5B2D4CFD@derailer.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nate Weaver wrote:

> Upon further digging, this is an issue in gettext's code on macOS:
> The function _nl_language_preferences_default (in langprefs.c) specifically
> breaks early when it sees the literal string "en" in the list (from the
> "AppleLanguages" defaults key), but not when it gets "en-US", etc.

Sorry I missed your other followup.

As you mentioned, the fix is at https://savannah.gnu.org/bugs/?49560.
There isn't a gettext release yet with that fix, so perhaps
https://github.com/Homebrew/homebrew-core/blob/master/Formula/gettext.rb
could be updated to apply that fix as a patch
(https://docs.brew.sh/Formula-Cookbook#patches).

Thanks again and sorry for the noise,
Jonathan
