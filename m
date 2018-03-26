Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 56D0B1F404
	for <e@80x24.org>; Mon, 26 Mar 2018 17:57:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752654AbeCZR50 (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Mar 2018 13:57:26 -0400
Received: from mail-wr0-f180.google.com ([209.85.128.180]:44700 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752618AbeCZR5Z (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Mar 2018 13:57:25 -0400
Received: by mail-wr0-f180.google.com with SMTP id u46so19803413wrc.11
        for <git@vger.kernel.org>; Mon, 26 Mar 2018 10:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=nNwD+MAHTzQJcNBaToQ2WkujQOKcgUO+kRAAZLa+CNw=;
        b=NiyWmjVN4nIh+4LLXxNNnWSHxk7yUdy10UVIU5jfUoaPfHsHGEGmnNo2Tic7Rbijle
         vCJKeBzZ/wuaxImyGw7bxONqxkFNq9fI7wpX79IWyBbxGINWhSoj5ijhyHUqZRftja+d
         54vQJoyDiRIz+OPOiWUSy0+ROVKh9K6PFzzTAMQiEodtoccmL8a17CU9u78PsSa9K2N+
         lVerLj2fFcvnGLPz5U/tzoPuTVDkV7CakVO3ttx2Wi1Xvz5v5a71IuWF0N2swCrFf2i5
         sxv3P7adMRkdjZ3EkLf8iZltauEilWv6d+Hjgu7aryI7oJjBdXeaxq7xRqr3e1vSKYmJ
         J1lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=nNwD+MAHTzQJcNBaToQ2WkujQOKcgUO+kRAAZLa+CNw=;
        b=p+mzJn4zXrq9e58pMtLuidWkExfY4NQS3E532KX8fQ635lvagHNLFEcsJ8iD9MlKpd
         n7Hx5LxZHQ30WdWoTMneED7RU5iSdQEK2gS4i0YXaK/W/k9jgB/6wfxGeOtbzdP1s1cx
         P4HepaZmXRt0+3wEJZYskv7t0PO039wS/TJoYujZTVZV5y4JFOEARKV5AC7HBkpeZS4c
         MgAOf3k66YGMoYhDH52efloMwoDH7N3xOUCneK1YBdQmXzSZmgSjDxhOtqKNRL1Yc9Jj
         tMs0hsTav268EFe5huLZEHAX3FQMCToxs8RxPMVcuYaZ1wGsVYgs856wUuliQ3a9dOch
         yemA==
X-Gm-Message-State: AElRT7FjtKUXfg6d+5KV2fLu6OpVj7BEaQ7x6LtdAc6RJf4Ve5xgSDdw
        nS1p3BJU0hv7udGyNe5z91A=
X-Google-Smtp-Source: AG47ELsnSLIohMscuuzXgvnH93e1UIHEcBNobFpYVaH2L4nZoOD5M0sfxEOazNIgYNYrshEA0Q7zFg==
X-Received: by 10.223.139.68 with SMTP id v4mr33113703wra.23.1522087043931;
        Mon, 26 Mar 2018 10:57:23 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id g4sm23048021wrd.1.2018.03.26.10.57.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Mar 2018 10:57:22 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Wink Saville <wink@saville.com>, jeffhost@microsoft.com,
        Git List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC PATCH v5 0/8] rebase-interactive
References: <cover.1521779249.git.wink@saville.com>
        <cover.1521839546.git.wink@saville.com>
        <CAKk8isqj3OusAE8OJtcys0a-Yj9fgQNn=DtLe-ZGYNzcKp=-3Q@mail.gmail.com>
        <xmqq7eq2h0wa.fsf@gitster-ct.c.googlers.com>
        <CAKk8isoJQrikitO7ezRajgphUXYR6207k4UkXP6r57WJEFBaDA@mail.gmail.com>
        <CAKk8ispSgNgZxS7KfuOyxfU53tzesvNyLRaNXFZa3K7SCbaRkQ@mail.gmail.com>
        <xmqqzi2ude4w.fsf@gitster-ct.c.googlers.com>
        <9ca76d31-828d-0b6f-5069-375792c1f55d@jeffhostetler.com>
Date:   Mon, 26 Mar 2018 10:57:22 -0700
In-Reply-To: <9ca76d31-828d-0b6f-5069-375792c1f55d@jeffhostetler.com> (Jeff
        Hostetler's message of "Mon, 26 Mar 2018 13:01:50 -0400")
Message-ID: <xmqqh8p2d8jh.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Hostetler <git@jeffhostetler.com> writes:

> I defined that routine to take a uint64_t because I wanted to
> pass a nanosecond value received from getnanotime() and that's
> what it returns.

Hmph, but the target format does not have different representation
of inttypes in different sizes, no?  

I personally doubt that we would benefit from having a group of
functions (i.e. format_int{8,16,32,64}_to_json()) that callers have
to choose from, depending on the exact size of the integer they want
to serialize.  The de-serializing side would be the same story.

Even if the variable a potential caller of the formetter is a sized
type that is different from uintmax_t, the caller shouldn't have to
add an extra cast.

Am I missing some obvious merit for having these separate functions
for explicit sizes?
