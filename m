Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A44A51F803
	for <e@80x24.org>; Mon,  7 Jan 2019 22:12:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbfAGWMR (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Jan 2019 17:12:17 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36128 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726773AbfAGWMR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jan 2019 17:12:17 -0500
Received: by mail-wr1-f66.google.com with SMTP id u4so2096028wrp.3
        for <git@vger.kernel.org>; Mon, 07 Jan 2019 14:12:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=NLzz/BEXi9qNu/JmTL4iv9J+xqSWkuUHShsB9i76nn8=;
        b=W5Sll1YSoVspUYR6JMu9bBtRcNA2Y9N7P1Xt6T6ZgSPVUD9XzZ00/VkMqSe98p0fEz
         Ag5EIPx0NR+RvROu5eyCNxTjNrBxm4Rs18yLD1EPEdBlSfH8L7x9yoOgAv7+xoJ6OTix
         oaYVjSprlvU/y3+tDWZUkQKOrBBWQpWKFXpw6o/5Io1HRVUlFttew7tImQxj/qIxZvGq
         bl8IuBnrmIgCo8vz8HnVphZRo/wE0RjZu0A8xv7eiCs6OD+Y9crvczfa6aTNdWRqiudZ
         uo0wYMWP1Gg26Clfhg8a1b2XvaNFgJ6MgIuhhqv0vsERupSsRQfgt6shDQRBHKuI4fSD
         /99A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=NLzz/BEXi9qNu/JmTL4iv9J+xqSWkuUHShsB9i76nn8=;
        b=p2W5QfeOSeUmNyVWXPiABXLhi75EOWLTfhsV4bPc1Kv0JwmLdq7i08ksnY7nEF9Bud
         /WNBPLyU/JRefXCDBJJ34LJSz2z+Lg76Av7we6ao5LIhLxKBEyJDPcAw9p1DW3Ph2Aae
         R5wdc8cdT2kvtHlBAaC3Dm7aw0S4f6UHGbsL8ayFvPGcXrajZM6MZM4KdzACwfGIUqjO
         xgV15RJvkaqckXYEy7yzk+LiG6uoQGUyGxkdrMlRH5at79QX4XX6pkuYzLCj3O/Owre6
         IgpxD5iYQvaecJtpkkMCBzZEmldCvxvO4cFemHPgB1X5x6+/TAKLMPKobdasMocpqMYR
         DcGg==
X-Gm-Message-State: AJcUukch2WeKYp0J5tnM62sYtFUlAp3VekDRL4qMx4xCPTHXeTxzU/Gn
        VjgUD2jsBvYQf3FswtF1ha4=
X-Google-Smtp-Source: ALg8bN7lmhZzZ/b9fSHzKC4v2zPoU7Ek4K6W4hIT80KO/PNF3ZcWTN//eXsOhwEUQp/fju8U3s4RAg==
X-Received: by 2002:adf:9361:: with SMTP id 88mr50990009wro.204.1546899135129;
        Mon, 07 Jan 2019 14:12:15 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id k26sm6964359wmi.28.2019.01.07.14.12.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 Jan 2019 14:12:14 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 1/1] filter-options: Expand abbreviated numbers
References: <cover.1545261186.git.steadmon@google.com>
        <d324e7836928940a4df0b43da3ffeb8526feac61.1545261186.git.steadmon@google.com>
        <xmqqsgyaircj.fsf@gitster-ct.c.googlers.com>
        <20190107212517.GA54613@google.com>
Date:   Mon, 07 Jan 2019 14:12:13 -0800
In-Reply-To: <20190107212517.GA54613@google.com> (Josh Steadmon's message of
        "Mon, 7 Jan 2019 13:25:17 -0800")
Message-ID: <xmqqva306rsy.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon <steadmon@google.com> writes:

>> > -	`rev-list` for possible "filter-spec" values.
>> > +	`rev-list` for possible "filter-spec" values. Clients MUST
>> > +	translate abbreviated numbers (e.g. "1k") into fully-expanded
>> > +	numbers (e.g. "1024") on the client side, so that the server
>> > +	does not need to implement unit parsing.
>> 
>> I suspect that it is too late now to retroactively say "MUST" here.
>> The best we may be able to do is to say "The sender SHOULD send a
>> plain integer without unit and the receiver SHOULD be prepared to
>> scale an integer with unit".
>> 
>
> In that case, do you think we should also specify that units should be
> interpreted as powers-of-2 rather than powers-of-10?

If we do not document the number scaling elsewhere, then we
certainly should, but I somehow doubt it.

Documentation/git-config.txt does list these explicitly where it
talks about --type=int, but these human-readable scaled integers are
also used in command line arguments as well, so we may want to find
a central place that is clear to the readers that the description
applies to all of them and move the description there.

