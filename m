Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E735B1F597
	for <e@80x24.org>; Fri,  3 Aug 2018 21:45:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731952AbeHCXng (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Aug 2018 19:43:36 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:36843 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729876AbeHCXnf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Aug 2018 19:43:35 -0400
Received: by mail-wm0-f46.google.com with SMTP id w24-v6so7831028wmc.1
        for <git@vger.kernel.org>; Fri, 03 Aug 2018 14:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=/SXOpcXjY3O+f/4VlingW6IMqfIBvi/C0xpgeszNn08=;
        b=fWWw9UwkA/iWKNyHADCc9tx0bXWjhz3ovM7aGClYSouf0y864FK+aZ5HHkMlRCeOLY
         7wX1DPZm8lOxElbUNziGBxZmSNjMelFcAAGrJRoxCtRc24xKpTFjGIN4ZYB/4kxzOwz+
         rVmYmyXWyYGGLKF6PgQ5QK+lFjEHCn4ipT5bV3BumTLgg0WpsMWN4N8ya6E4/ssC7jRP
         WjBYbG1v0FHZxaNv7wpGP9FqDniZoJUvvJqZGO95O/1eegzgywTN0OfkzDkPlNZCDfyn
         MsRukI/CtRgJsyY8AmceXvf4aJ6zWiRkzeyALZCxTV+RQj3cyYkJCBDtFWXk7OSSf5PI
         re7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=/SXOpcXjY3O+f/4VlingW6IMqfIBvi/C0xpgeszNn08=;
        b=k6hZwbZLyJgSccmMARlDO32NpiBwKJQhxDCs2M/xSPZfvGhWageavdxik+VXVjf54A
         8j6e8VemiqJZwnLvN21GYoWSgQCwztHfbn1WuxWoPUKwHR+pXjbGx84iHQ670nvOUhHz
         MQiFCcLe1zp+1Y9imRolpMshVoCGeyd23hHptj0+TEiYTxwqUqqVLo/GH4YStpNBKYV9
         dYi9LyNiAAeOMtt/i5dB4XB0TJv7YaJ/xBrYljo/sfKQN17AW1/mOJ8Zm//5tYeWc8m6
         ogwYkw6ultmy5JH9MdEuUcd3Ai5htNK+k8Z+1Rx1heQj46kNHyahffs4v5uCp4Xu0Zlw
         Cz1Q==
X-Gm-Message-State: AOUpUlEmQIUmuRfIBXNODGqr0QKA3eQSvihM7TdUXCk5kJ+ySVK+ool4
        qwf/wVXSVo/SIMFXeNqDrGg=
X-Google-Smtp-Source: AAOMgpdN8IjHvqm7KXDltvvmRmSVtvhqEe4103GvxoJmbw26Vh6HBHcPO6lZWbMg3k759B4vHI1sDQ==
X-Received: by 2002:a1c:2b43:: with SMTP id r64-v6mr5525713wmr.96.1533332729666;
        Fri, 03 Aug 2018 14:45:29 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id i23-v6sm502394wmf.24.2018.08.03.14.45.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 Aug 2018 14:45:28 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Brandon Williams <bmwill@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Aug 2018, #01; Thu, 2)
References: <xmqq4lgcz81f.fsf@gitster-ct.c.googlers.com>
        <20180803180912.GD106068@genre.crustytoothpaste.net>
        <xmqqwot7wayf.fsf@gitster-ct.c.googlers.com>
        <20180803184508.GE106068@genre.crustytoothpaste.net>
        <xmqqo9ejwag9.fsf@gitster-ct.c.googlers.com>
        <xmqqk1p7wa7t.fsf@gitster-ct.c.googlers.com>
        <20180803193256.GA164578@google.com>
        <xmqqftzvw6xi.fsf@gitster-ct.c.googlers.com>
        <CAGZ79kZdPP+q9iuQioUU+2JkfH4n1mkkHrXaJzxGVwhxvbKZ1Q@mail.gmail.com>
Date:   Fri, 03 Aug 2018 14:45:28 -0700
In-Reply-To: <CAGZ79kZdPP+q9iuQioUU+2JkfH4n1mkkHrXaJzxGVwhxvbKZ1Q@mail.gmail.com>
        (Stefan Beller's message of "Fri, 3 Aug 2018 13:43:07 -0700")
Message-ID: <xmqq600rw2dj.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> - The second part of having an immediate plan is *very* nice
>   to see, though I would argue that it could be improved
>   by having these updates in the thread instead of summarized
>   unrelated to that thread.
>
>   We do not do this for now due to tooling issues, I suppose.

I need the current draft of "What's cooking" message that I haven't
sent out (and the committed copy on 'todo' branch, which is a copy
of what was already sent out) to be the single place I go that
drives my day-to-day integration work anyway.  I don't have time to
jump around 30-70 discussion threads (assuming there only is one
active one per each topic in flight) to see what the last tentative
verdict I gave to each one of them before deciding which ones to
merge to 'next' in day's integration run.

You are welcome to split these pieces out of the "What's cooking"
report and spray them into the original message, or write a bot to
do so.

> Is there a better way to start a workflow discussion?

My take on it is not to discuss ways to add more to other's workload
to worsen the bottleneck in the first place, and instead try to do
things you would think you can do to help, see if it actually helps,
and then after that encourage discussit as a way for others to do to
help the project, perhaps?
