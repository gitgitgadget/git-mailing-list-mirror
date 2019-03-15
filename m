Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.2 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 239A320248
	for <e@80x24.org>; Fri, 15 Mar 2019 20:43:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726639AbfCOUnf (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Mar 2019 16:43:35 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45246 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbfCOUne (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Mar 2019 16:43:34 -0400
Received: by mail-pf1-f196.google.com with SMTP id v21so7113452pfm.12
        for <git@vger.kernel.org>; Fri, 15 Mar 2019 13:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Yml8zuteLtpB6BWFtztqoSmAnMi2BlpIVRYG2gBKSC0=;
        b=GXsqdzfqKScd5LrhpzrntB6F/zzzORhbawOM7hAJrd/4jT5XPa3zc1RZyi8YmcZG/i
         w5WICOpgoME0hJEiWa8rf02cTcv/GYQVgA7dlIT4sV9ON56gT+hoeYtgur+gsu9z/Sk+
         Yxz6k/oO3wMGgp16JWx86N+IAHntMrECowU/2iH2Oe4RPf2/hVJf0q0t5skl545kCHjU
         L0wol7WefILh6LpSb9Q0CxvxNJgb3e2Zvql8NJ+L5eLllZ1fcR+YTjBWsZe4o9ErRnsE
         xHbS4GTFoYMWwfcgL/QTipIhRWz1AF0hudGB9p5ze911qZCXLpro4hU9AC01fg7/D8eh
         8TRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=Yml8zuteLtpB6BWFtztqoSmAnMi2BlpIVRYG2gBKSC0=;
        b=mex3BDrhlxwpdXCXEd6lm7O3OPGS7DMCIAOuabGWWPwaehrsWE9Ca3is5Fe8PrwOph
         7TCs9pMgbqEQS2cj2DppWLQ1A7BdouXSMk0qIvisTTl+ctqvO6Ki30ZX+3BhueU2ilmh
         9eTs39v1sOsZEjdvPwJ1oMOvhmNxbp4PDf/3lYIRLUDUWgdN6GMg0aOWGVqduVilWEKz
         zI/GNZm1QkxoR+RyQchZ4EpknpWPnEIb0Th/H4u0MTGyPoNvR2KdNxaJ63FT9jsqsLqn
         9hSR3eBylrHweDccz+Eo0XgBnL0i98fhbF+mNfwywsqghenEo7sXZ0SIMILYQo17vu9r
         vgBA==
X-Gm-Message-State: APjAAAVdOpuq1x/FJwH/jLKZ9+f5+iA5Q6BWlWl/c3tsvuE6ktsOv7k3
        t5PZshCF3GVJlRhcmvUiHB3SLHn4h+VqoQ==
X-Google-Smtp-Source: APXvYqzve3wv1igorGRW3yW95pZxvC4FVp7aYZIGtpalqeI5Ki75xplUTmNEfhCxmWoVkbTFazYEag==
X-Received: by 2002:a62:f5c9:: with SMTP id b70mr1581976pfm.255.1552682613510;
        Fri, 15 Mar 2019 13:43:33 -0700 (PDT)
Received: from google.com ([2620:0:100e:913:5bb:3076:546:99b0])
        by smtp.gmail.com with ESMTPSA id b8sm4464510pfi.129.2019.03.15.13.43.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Mar 2019 13:43:32 -0700 (PDT)
Date:   Fri, 15 Mar 2019 13:43:27 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, git@jeffhostetler.com
Subject: Re: [PATCH 2/2] trace2: randomize/timestamp trace2 targets
Message-ID: <20190315204327.GE47591@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, git@jeffhostetler.com
References: <cover.1552519463.git.steadmon@google.com>
 <17ec237ba7498251a3ff64eec259d6f61c8f5ccc.1552519463.git.steadmon@google.com>
 <87h8c6baif.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87h8c6baif.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019.03.14 00:49, Ævar Arnfjörð Bjarmason wrote:
> 
> On Thu, Mar 14 2019, Josh Steadmon wrote:
> 
> > When the value of a trace2 environment variable contains instances of
> > the string "%ISO8601%", expand them into the current UTC timestamp in
> > ISO 8601 format.
> 
> Any reason not to just support feeding the path to strbuf_addftime(), to
> e.g. support a daily/hourly log?

No reason not to. Seems reasonable to me.

> > When the value of a trace2 environment variable is an absolute path
> > referring to an existing directory, write output to randomly-named
> > files under the given directory. If the value is an absolute path
> > referring to a non-existent file and ends with a dash, use the value as
> > a prefix for randomly named files.
> >
> > The random filenames will consist of the value of the environment
> > variable (after potential timestamp expansion), followed by a 6
> > character random string such as would be produced by mkstemp(3).
> >
> > This makes it more convenient to collect traces for every git
> > invocation by unconditionally setting the relevant trace2 envvar to a
> > constant directory name.
> 
> Hrm, api-trace2.txt already specifies that the "sid" is going to be
> unique, couldn't we just have some mode where we use that?
> 
> But then of course when we have nested processes will contain slashes,
> so we'd either run into deep nesting or need to munge the slashes, in
> which case we might bump against a file length limit (although I haven't
> seen process trees deeper than 3-4).
> 
> Just to pry about the use-case since I'm doing similar collecting, why
> are you finding this easier to process?

Basically, our collection setup prefers smaller files that are
"finished" earlier, rather than long-lived files that are constantly
appended to.

> With the current O_APPEND semantics you're (unless I've missed
> something) guaranteed to get a single process tree in nested order,
> whereas with this they'll all end up in separate files and you'll need
> to slurp them up, sort the whole thing and stitch it together yourself
> without the benefit of stream-parsing it where you can cheat a bit
> knowing that e.g. a "reflog expire" entry is always coming after the
> corresponding "gc" that invoked it.

Yeah, that is not an issue for us, although I can see why others would
prefer single file. I suppose we can just modify the envvar to point to
our newly-generated file before we spawn any child processes?
