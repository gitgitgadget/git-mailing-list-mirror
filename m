Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7574D1F404
	for <e@80x24.org>; Wed,  5 Sep 2018 16:28:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727672AbeIEU7H (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Sep 2018 16:59:07 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45114 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbeIEU7H (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Sep 2018 16:59:07 -0400
Received: by mail-wr1-f66.google.com with SMTP id 20-v6so8294666wrb.12
        for <git@vger.kernel.org>; Wed, 05 Sep 2018 09:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=MC0GthTO+4paCzofoM8+XczbIpa0Oc7cW5y+rdu+bf8=;
        b=qnlu+nlR24jQgMm90kTMlpNVH/uEJMRkcpe6cE7ZkbQ76vkD29aoCSJR5LsoNM5ojB
         iiwzDylzkhh4ytPF0JG0mwEpzr9wMk3UjgKvE3w4Q/qnKb4n/vpBqRNu2iGCrZJ4zgup
         znI9X3ggSPEtA9wOVJOZO6Zishq3vKRVyDwsPEcgAO9s/dS2FWJakwKGzEg7m54cZkV0
         3OYUsdvO6Z5gXfMJRVaqLxR44+2lFPFTbV78S9zBQmuGwtB+e9zqdtf8GZ259kNORG+3
         1JQIgoaE6px0juJOKL3VRbdEm5a+KDzWc32cANVe/HCzwblr8d4e1xPsOsQcc6vtqSVR
         XSTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=MC0GthTO+4paCzofoM8+XczbIpa0Oc7cW5y+rdu+bf8=;
        b=M6BbKUzKXoLznmaVhdqAjJ0BkU8lcXUS1U33MMfx5ZYA9zB7FrwjDl0s6owFZrdfkJ
         WDePMVuYD1qYgaZDvBjFAfO+Z9q0kuD5OTbpLT4lVd5g3d8hGdQyBlJsZqG1GGOUbO1B
         gngkfqft75e4N4nptmKvUZK5bMbrydg5rWCwdsmf+mOXzOPvyrd3GzthQE6ge0v8ruqk
         UYqH0LgLpsl1dYzDKblXMniTdyVMjvjo6t4o0nIj2hy4ZKPAbSmTkAU7q6hKWqRubuaW
         c+IHHmgh6P7Wnn6j2C9VWWDpKUKderZCQ1vlNcgKmObgl1JEWhh9jru5GetiVlRRsthb
         Efxg==
X-Gm-Message-State: APzg51CTJhGXhJinbf+m0cinla3BEsIuyEby4YMJXwz971p9G00+eTic
        87M1ZBZw598FaYfbNxwMVTk=
X-Google-Smtp-Source: ANB0VdaxJ+Sj8Elc0M7IOlivhIEJW+TLVyDTvONO9uHLI4h/YAhMiK6rI0+XWxHbPbgiPKVStZCr3Q==
X-Received: by 2002:adf:afd3:: with SMTP id y19-v6mr27196191wrd.176.1536164889827;
        Wed, 05 Sep 2018 09:28:09 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id d1-v6sm5395058wrc.52.2018.09.05.09.28.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Sep 2018 09:28:09 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: Re*: [PATCH 1/2] rebase -i --autosquash: demonstrate a problem skipping the last squash
References: <pull.30.git.gitgitgadget@gmail.com>
        <8753c4e5fba5bb9cc42fdf438f4a69e702261a15.1535759099.git.gitgitgadget@gmail.com>
        <xmqqd0tt9j0s.fsf_-_@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1809050025480.71@tvgsbejvaqbjf.bet>
Date:   Wed, 05 Sep 2018 09:28:08 -0700
In-Reply-To: <nycvar.QRO.7.76.6.1809050025480.71@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Wed, 5 Sep 2018 00:27:58 +0200 (DST)")
Message-ID: <xmqqin3j6h9j.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Tue, 4 Sep 2018, Junio C Hamano wrote:
>
>> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
>> writes:
>> 
>> > +	test_must_fail git -c core.editor="grep -q ^pick" \
>> > +		rebase -ki --autosquash HEAD~4 &&
>> 
>> When merged to 'pu', this reveals that "git rebase" rewritten in C
>> knows "--keep-empty" but not "-k".
>
> I had already reported this:
>
> https://public-inbox.org/git/nycvar.QRO.7.76.6.1808241803100.73@tvgsbejvaqbjf.bet/

Good that you said there that you'll have it fixed in future updates.

I do not want to leave the project state with failing test at the
tip of 'pu', and I do not want to get distracted in squashing the
fix deep in large sequences of topics that we know will be rerolled
once the prerelease freeze is over anyway, so in the meantime I'll
queue this near the tip of 'pu' to keep the tree sane.

Thanks for eyeballing.
