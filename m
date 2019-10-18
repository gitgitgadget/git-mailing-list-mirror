Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F8F51F4C0
	for <e@80x24.org>; Fri, 18 Oct 2019 14:47:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408535AbfJROrU (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Oct 2019 10:47:20 -0400
Received: from mail-lj1-f174.google.com ([209.85.208.174]:33060 "EHLO
        mail-lj1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405365AbfJROrU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Oct 2019 10:47:20 -0400
Received: by mail-lj1-f174.google.com with SMTP id a22so6530371ljd.0
        for <git@vger.kernel.org>; Fri, 18 Oct 2019 07:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=/oXXcNAyNIZYEwltgJihOu7z7D3kmOaNa27coe/Y25k=;
        b=tagduvNmeld1IpC2lM1uU7W+rdJ00/q3AQyZUv35KZUV0k2+XTNDMHkoZ35+Q771H9
         /ktiZB9e++NUj0DIz1++vST80yg0RDJMO9j53NujmJJRFzwXnKEgwNb4QI1RQq6Wz+i+
         pZEYrAbLf+wmuTc6LiSO0GOkSqg3Co6iJdD/GfFIIURAWBNwLv7qWy2IGIrshsfXnIby
         twALLlEIKVLbpS6CxailJ3J5wZN+GuPT3DLOqrfe4zUlNQ7wSfakrtOJlOVGpV4zUCxU
         0tkDEj2bgdf+H2SX63suW5cixMYt7bxUOJLrxfD588Qg7m3Q1spUyqZZ+FrhoeWXY6/A
         2vHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=/oXXcNAyNIZYEwltgJihOu7z7D3kmOaNa27coe/Y25k=;
        b=DJdxrxpOajVPs8wBzwrDpGuLO0b5hL7APD6HBkIfmPMP+cHSqhwomVbIwb44yfDUAq
         R2VjNszOcnUbLxtEXNY80c45kepgaCjsye4BTdubCNrxb+0DQx0yCZidMJotAcVdSiAO
         HeC/qsiu9/aHLUQgJfkAwa6173vilC8poBO4KpykbbtmnqSw2F3RCiwlOedI2FCXLOXL
         FKEWEhR1Or1KwvDD6TOjHR91cVl75isNQ+CZsvx0a/MmtsyfytlNhrC7h0wu74W1i0MD
         twCbeTfk7jYNnqeYlYM3YccdDq+yqxOBykYTMsyQ+bcPvgktqVgkveFbWUJGYaiC14RH
         4GhA==
X-Gm-Message-State: APjAAAUnW7yVgHrZrutXJixxBd7/Mo+EoUrXpmmezEV9R9V7gFf5Rz4V
        rtaT8VqQ8MfZZ9jRVZFFn3toS+GolAfGmWCjZMYbF5wY
X-Google-Smtp-Source: APXvYqzWIttCbdqwFUtoUDjCpx8vbA/mZ8JQsIMGINiTbk+T4GaZQYcRHcetvDPaJcZs++ZlTtEF9kM6k/YB4c3d5hM=
X-Received: by 2002:a2e:8941:: with SMTP id b1mr6429999ljk.40.1571410037988;
 Fri, 18 Oct 2019 07:47:17 -0700 (PDT)
MIME-Version: 1.0
X-Google-Sender-Delegation: rcdailey@gmail.com
From:   Robert Dailey <rcdailey.lists@gmail.com>
Date:   Fri, 18 Oct 2019 09:47:06 -0500
X-Google-Sender-Auth: 32cB9syGFkRXwCUPB6-0Z5LPsWg
Message-ID: <CAHd499BWRQxBBNpiP1LaudKFZ8+cot=QW6W52tB6bNPxznyOPw@mail.gmail.com>
Subject: merge.ff with and squash merge
To:     Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If I do this:

$ git config merge.ff false

And then:

$ git merge --squash topic

I get:

> fatal: You cannot combine --squash with --no-ff.

I can work around this by executing:

$ git merge --squash --ff topic

Which essentially negates the `merge.ff` configuration. In this
scenario, wouldn't it make sense for `--squash` to always imply
`--ff`? I mean, I think the configuration is there to help me in the
general case, but when I state I want a squash merge I'm pretty
explicitly asking for a commit and not a fast forward.

Thoughts?
