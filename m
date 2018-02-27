Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 12DCE1F404
	for <e@80x24.org>; Tue, 27 Feb 2018 18:14:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751539AbeB0SOJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 13:14:09 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:39336 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751455AbeB0SOI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 13:14:08 -0500
Received: by mail-wr0-f194.google.com with SMTP id w77so25815960wrc.6
        for <git@vger.kernel.org>; Tue, 27 Feb 2018 10:14:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ZeFYkH0etC3OgAitm6bt/EU95uMNo4G0/c5Y68y/nVo=;
        b=VwC2SN3w2o65BAuS9ynYlWkWEsK3beivg/yjw9NS4aFjoEYbi4Ac3XhlxUrqySb5cR
         ZNSpPVi1FVQAQeLLZ7Zm+AOl4HqcY+GYeqoTRg5/meSPDhUR2T13VPOUazt8pLmLF5HH
         Zh7f5/hI9cpXVAHUcga+uue60eIkAhqfY5FWGQv0BHlVGriUcauT/ewkf9TP5630uTTJ
         Jv7pJkoPPzP0VzfDa7fygxLnQL6j4c7nZMLBXyLgLmKy2JlPr5UxTeOaXRl1yHFJTzI/
         aAOSfU6EkEYT0amp2C6aV6WVI79HuZO/xUe1SX6batjD+94jk4rtheBSXURVZZvByZau
         wS9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=ZeFYkH0etC3OgAitm6bt/EU95uMNo4G0/c5Y68y/nVo=;
        b=Ct99FsOl9KAyeG3KBU3w2abrFW02DqEHd2vsAoC+SHv+/G+ytVQDo0QhBXO3J5NR5+
         chQD9C+a8AAQ+mA8nsw4DfuH9E8QoJ1cNXITXKtrifncCJZY6+fFLv6DSj2tpjKIp3bY
         zg733Z2p5zlmx5m0PWuxDuMQ7Fo/6EelN2jAAvZo+2GcI6zk7oZ7mibcT1doLb5zUAG6
         ysdWL7VvZ0dQ4Ioa+5uipv60UH3z+ocvg7DijzGmYQlxlxlG+wi8qk5chIzPzF33ihO+
         /tMzkeHL5QzxIggRqTq2QPq7CHqn3PQB8nc67nn29KconWNe0Vc2rPlvipCNkJXxXJfN
         eoMg==
X-Gm-Message-State: APf1xPA9TSM9cJLmWjBQZf1eouxH8rwDg5fRrePf7hbcf7gf8llpi6B9
        CpG2/klerH6Yl283wRw9ksU=
X-Google-Smtp-Source: AG47ELsX3TZUyfuwOvhEa1InMWKuHbAsYKIlqORd8e9Zg4tBHuOOyssTfmLRxwv211JXhPP6zu9LXw==
X-Received: by 10.223.156.147 with SMTP id d19mr10864214wre.272.1519755246955;
        Tue, 27 Feb 2018 10:14:06 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id a62sm114331wmh.40.2018.02.27.10.14.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Feb 2018 10:14:06 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [RFC] Rebasing merges: a jorney to the ultimate solution (Road Clear)
References: <87y3jtqdyg.fsf@javad.com>
        <bbe64321-4d3a-d3fe-8bb9-58b600fabf35@gmail.com>
        <nycvar.QRO.7.76.6.1802270051470.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <87zi3u4pd0.fsf@javad.com>
Date:   Tue, 27 Feb 2018 10:14:05 -0800
In-Reply-To: <87zi3u4pd0.fsf@javad.com> (Sergey Organov's message of "Tue, 27
        Feb 2018 14:57:15 +0300")
Message-ID: <xmqqbmgaqp02.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

> You've already bit this poor thingy to death. Please rather try your
> teeth on the proposed Trivial Merge (TM) method.

Whatever you do, do *NOT* call any part of your proposal "trivial
merge", unless you are actually using the term to mean what Git
calls "trivial merge".  The phrase has an established meaning in Git
and your attempt to abuse it to mean something entirely different is
adding unnecessary hindrance for other people to understand what you
want to perform.
