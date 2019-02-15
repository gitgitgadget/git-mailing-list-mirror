Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 934DE1F453
	for <e@80x24.org>; Fri, 15 Feb 2019 19:28:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729458AbfBOT2z (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Feb 2019 14:28:55 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35958 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbfBOT2y (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Feb 2019 14:28:54 -0500
Received: by mail-wr1-f68.google.com with SMTP id o17so11522042wrw.3
        for <git@vger.kernel.org>; Fri, 15 Feb 2019 11:28:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=A5XBpPxnxnzU3B+06yZPyngR6UHOhgZLqJfWdpmOhs8=;
        b=eE2fihQx9q4bxKIAqwPkXPpSQi4FeGkrGaHew56bbLyI6OZTkiOYWOFZsk+eRoJOYF
         o/IFroK9kpd2/t61mZ6kkOsPo2eb0KNVHoMkUqlfg89dJdnt+Ew++7bxGVDipEdhR7aG
         ZYaO+xfww/oKZ0nacFaHDKcj8b0n1Llx2k3UUYa4+ExQ7pN7e98AJQbKALUiKrPBJjDp
         gKgEHTOu7e0YgGOd/o/lZ0MWokHI+ZUvM/jSLp8PLaIQ+XF6J/yq0J0qjTTPUDHj0M3q
         Mpd4cVZxPSsYlZsamud9LtAXc52N0T1Mb8m5TFkPOpT/SB7HcDl+kWrK7MzSDNCU8fNZ
         f0JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=A5XBpPxnxnzU3B+06yZPyngR6UHOhgZLqJfWdpmOhs8=;
        b=jKbVaB4oo7lchyKFsFPiZ5lshzxlbNLJq1ju42lKndvIO7bo/1ASDQxWkOv2/IQkTn
         osPBWP3PRebeqiyoyv/+/jrIK26Lhb2MXK8E0Yjo966l/ee5HyXAfGNAu1pfqODcrY8y
         MIwSOYv+phAhocx14TXTN74iIrACPxb3IuDnGrshHuZClEoTiEoaNpb97n3LkOTGPlUv
         Ccqv9QkOTYxi9a0FN1yBeEfpYg7pEdIJMirD0QEpx5b9wAUtjzwfwFpn9OxbO8ZALXx7
         7L9s4wdJ0lx4rXr3NiGefnMDMmiRrUiHFJ1LRKTAsTEqvZ9nhR1odgApAXTBoioNGiCb
         5WPA==
X-Gm-Message-State: AHQUAuYM6ny3JwYMSbE2VnwUhcxKrHrfR3uGFHaMZbA3NuH0XASZrSvX
        rQcTKx6Y6DfM9Jln6vWUTU4=
X-Google-Smtp-Source: AHgI3IZKIQ9MqlaRUpcpC+27ehHYxptptkBF3OzwHFdzQd2/eOqW1Pp33w89uF1HPM0CRZFK6BOSKw==
X-Received: by 2002:adf:f343:: with SMTP id e3mr7195154wrp.205.1550258932348;
        Fri, 15 Feb 2019 11:28:52 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id y20sm11066175wra.51.2019.02.15.11.28.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Feb 2019 11:28:51 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Git Mailing List <git@vger.kernel.org>,
        vincent.guittot@linaro.org
Subject: Re: [Bug report] git diff stat shows unrelated diff
References: <20190214082258.3mh3hcr2l6dl3wuf@vireshk-i7>
        <CABPp-BGstumw1eyZ++0itk-AR0Bk5zd0AchgznBpMq35a6ScUg@mail.gmail.com>
        <xmqqmumy6mxe.fsf@gitster-ct.c.googlers.com>
        <20190215185202.GA28019@dev-l>
Date:   Fri, 15 Feb 2019 11:28:51 -0800
In-Reply-To: <20190215185202.GA28019@dev-l> (Denton Liu's message of "Fri, 15
        Feb 2019 10:52:02 -0800")
Message-ID: <xmqq4l946ebw.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> On Thu, Feb 14, 2019 at 02:10:53PM -0800, Junio C Hamano wrote:
>
>> It might be _possible_ to spend a year (i.e. 4 cycles) to start
>> warning when two-dot notation is used for "git diff" (only, not any
>> plumbing like "git diff-files") and tell the user to use the more
>> logical two-end notation "git diff A B" and then eventually error
>> out when two-dot notation is used, while retaining the three-dot
>> notation throughout and to the eternity.  I am not sure if it is
>> worth the deprecation cost, though.
>> 
> Instead of outright deprecating it, would it make sense to include a
> configuration option, say "diff.sensibleDots", that would enable a user
> to set the dots to the other form if they desire?

I doubt that such a change helps anybody more than it hurts.
Defining A..B to mean something totally different based on a hidden
config will hurt those who want to help others.  It would even hurt
those who are new to Git and blindly set such configuration because
their local guru tells them to and then goes on to read code
snippets and docs on the web outside our control that have been
written with the established meaning of what A..B and A...B mean to
"git diff".

There is nothing sensible in using dots, i.e. range notation,
between A and B _if_ you are trying to compare A and B, i.e. two
endpoints.  Just use "diff A B" and you are OK.
