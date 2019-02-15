Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0339E1F453
	for <e@80x24.org>; Fri, 15 Feb 2019 20:12:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390308AbfBOUMq (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Feb 2019 15:12:46 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39484 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbfBOUMq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Feb 2019 15:12:46 -0500
Received: by mail-wm1-f68.google.com with SMTP id z84so3799287wmg.4
        for <git@vger.kernel.org>; Fri, 15 Feb 2019 12:12:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Jxms4kxgcY6xjY9XdNOq2ITzO5kUq0HuvMURdVg75A4=;
        b=RC0QgFgZQJj2dq4Mt+7LuMlA/aW/Rhvwb2Ln4tWWSHtOxZTQ2cAzCrcupllQg+wArI
         y26ajK/SejWot2WU4CDwv7Bs4IwnZVJVRM2MzzgWWv3T0hRhAGa5QSMIsmDgI14dypBn
         XuNO7UIvYSTzrfkc1rxKkazJnwU1pImnyfzEYO2ncd1uXeeqa8psJo4XhxY6blEns5yB
         LtNp+ajyyR2dfuhBwn+RKBkEevDpH6dQTSKV7wzjWJQi18zxRLLqilPiLVrMO6p6di5o
         ekVxIBaXZI+rsGKXpQAo7oUqN5bOWrIMXPwNUcr2qQSbLN9v1gP8iH8An9iFUfRP+gqm
         3yZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Jxms4kxgcY6xjY9XdNOq2ITzO5kUq0HuvMURdVg75A4=;
        b=JtVP0fLfRVtz+kf4U67FiYJ9rIxXyY+hikoQVb7I2xjoMcV+b++3AMZgPwckhx23C/
         j0i9ObYOblFSMtvj3SL8peFIrd8aK5xC134l9Bwfj4wc8o7rKp9w+eNtvRVRuZ//16Jr
         yzO2Zf1/fTAZDn96Uhb1b0yM0gg7Yuf1+C2wGmp2BynE5ghLqsdHZWpZe3CyIueIip6w
         YvDQ2Evh0bRLnQ/hLwqDLRm7ibxrvuCUmLTFnVbiabEIvVnXpqV+PuFpH4zpiOQH8mQv
         QyIfR1dqYlanWNIzgx1pBGABk7u8PPPXuedmlCQzM0BxPl2EzivGhOc0U2zBf+QgqeRe
         T8vA==
X-Gm-Message-State: AHQUAuZn6J2u8g3Lgd+ukaXd943eKCcCCaEN7DkN7ANs2ZRIQ5ubFOvZ
        4N/OO+BXwZDuX5j+1biRuVs=
X-Google-Smtp-Source: AHgI3IZ1EGtkhkFRKrIcqSUKPkWYbqVDwkv1/pqTYPY9wewjcf6FsP1KNRs2MhCpyVBsze7xGqNDcA==
X-Received: by 2002:a1c:7f0c:: with SMTP id a12mr7440006wmd.89.1550261564288;
        Fri, 15 Feb 2019 12:12:44 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id y25sm4702023wma.6.2019.02.15.12.12.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Feb 2019 12:12:42 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Git Mailing List <git@vger.kernel.org>,
        vincent.guittot@linaro.org
Subject: Re: [Bug report] git diff stat shows unrelated diff
References: <20190214082258.3mh3hcr2l6dl3wuf@vireshk-i7>
        <CABPp-BGstumw1eyZ++0itk-AR0Bk5zd0AchgznBpMq35a6ScUg@mail.gmail.com>
        <xmqqmumy6mxe.fsf@gitster-ct.c.googlers.com>
        <20190215185202.GA28019@dev-l>
        <CABPp-BEmPQb4Q_38S2A_68m+Cu75VDDD2UV0qWBDjL1OUAug9Q@mail.gmail.com>
Date:   Fri, 15 Feb 2019 12:12:41 -0800
In-Reply-To: <CABPp-BEmPQb4Q_38S2A_68m+Cu75VDDD2UV0qWBDjL1OUAug9Q@mail.gmail.com>
        (Elijah Newren's message of "Fri, 15 Feb 2019 11:25:43 -0800")
Message-ID: <xmqqzhqw4xqe.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

>> Instead of outright deprecating it, would it make sense to include a
>> configuration option, say "diff.sensibleDots", that would enable a user
>> to set the dots to the other form if they desire?
>
> I think Junio's suggested steps would still have to come first, and
> there may also need to be a time period after two-dot notation is an
> error before we were to try to repurpose it for something else (e.g.
> to make it behave the same as triple-dot).  Adding a config to change
> things now without both a deprecation and error period would invite
> horrible surprises and bug reports; people need time and warning to
> change workflows and fix existing scripts that might be out there.

Historically, it was a mistake to allow A..B to be used for two
endpoints, which was made back when we haven't thought things
through.  That is why I stopped "warn to deprecate and then
completely remove", as I do not think it would help people very much
if "git diff A B" can be spelled with two-dots.

But in a distant future long after that happens, by the time nobody
remembers what A..B meant for "git diff", I do not think I'd
strongly be opposed to reusing it to mean something different.
