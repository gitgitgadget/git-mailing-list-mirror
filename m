Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 99A701F453
	for <e@80x24.org>; Tue,  5 Feb 2019 18:08:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727551AbfBESIR (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Feb 2019 13:08:17 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41070 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726685AbfBESIR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Feb 2019 13:08:17 -0500
Received: by mail-wr1-f68.google.com with SMTP id x10so4664546wrs.8
        for <git@vger.kernel.org>; Tue, 05 Feb 2019 10:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=xrhBQK/vRzw1SFA6dstpNrSuvvlJHFJ70asKoTJ4r9w=;
        b=sppECiEdNgWUp/stwGHyK2Of0GHiDoIiKWdUy4uGBaq6nAkT7hyvM76iPs+b+SzhyI
         SfNU4XFpg5WC4ImdST8yRzM4YFp5r49N/w73Ix1FU1fGK0VtQHSH2Daq+C3/BYqZ1cNO
         2bN/22jndPYUrgpNCqtYocR9VLg4fw12uKO9G6j/8q5h9nojLPw2aSYyLIpC27zCmAkF
         +XIWH6Hb2jikd3qwifQEFKAs9esp2d6nVijvZPvo3h69/CUmjI8SCKLV9ItDIMAnCZxT
         98rQc+YQEz9fLMhotvMrj2o0Su9QwTIX7th+FiESuYDHwQNjl8LvtmuhJ9upuqgE59RS
         de6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=xrhBQK/vRzw1SFA6dstpNrSuvvlJHFJ70asKoTJ4r9w=;
        b=eCMq4uMxNuy/a/Gf5hS9/8PNKhOkXa54307+rZc3KYMcpz/McIR7maYSj+zyUVniE5
         TnCHZjajAw5bk2hfDBDhnzE1veuewkZi7wGswAlzWTF573/9CZbon+4Q8lGoU2zc9aV9
         iawtDtJp4HOBKVUVBcLsUbKTmBHTjZK9orMCwyCBoKP2KdqPwBxJVDkJ07x94tRwknSj
         qDwYEQwR3QF7YZGODQe1WRWLZc8DnPLP7DfDm4A9nLWSAt1wHXhi7MdYotgo5CFjAO5J
         /UCX283PIfnwmH80a2EWZzOP72rqDMmYrvIjBMJVcWQvmpB8MSDYUI7GaSnHqAhXUrNU
         GfwA==
X-Gm-Message-State: AHQUAua4+tQArNCVVzXRck2F+5PEpxJf5raRX+39d5R24hKI/NPmMsW/
        8T517DhlZsyIzB2NA5lqVJo=
X-Google-Smtp-Source: AHgI3IbLkr2UNtSATW2jOzP3ktyTncv5c0qW/zLqWV1N8qlgYiqIA0/aq5Nb3scXySXgkEtKJCrHGg==
X-Received: by 2002:a5d:6988:: with SMTP id g8mr4450804wru.33.1549390095019;
        Tue, 05 Feb 2019 10:08:15 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id n6sm14842235wmk.9.2019.02.05.10.08.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Feb 2019 10:08:14 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        GIT Mailing-list <git@vger.kernel.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v2 0/2] Using sparse in a CI job
References: <af361187-4d9d-2c41-0850-bf774d5523b2@ramsayjones.plus.com>
Date:   Tue, 05 Feb 2019 10:08:13 -0800
In-Reply-To: <af361187-4d9d-2c41-0850-bf774d5523b2@ramsayjones.plus.com>
        (Ramsay Jones's message of "Tue, 5 Feb 2019 02:24:16 +0000")
Message-ID: <xmqqmunartv6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> Changes in v2:
>
>   - Add a new patch #1, which removes an obsolete use of SPARSE_FLAGS
>   - Actually initialise the new SP_EXTRA_FLAGS variable
>   - Reword the commit message (now #2) to, hopefully, clarify the
>     usage of SPARSE_FLAGS and SP_EXTRA_FLAGS

Thanks.  Applied.
