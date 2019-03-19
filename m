Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9AC3220248
	for <e@80x24.org>; Tue, 19 Mar 2019 00:25:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbfCSAZu (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Mar 2019 20:25:50 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35444 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726438AbfCSAZu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Mar 2019 20:25:50 -0400
Received: by mail-wr1-f68.google.com with SMTP id w1so13129217wrp.2
        for <git@vger.kernel.org>; Mon, 18 Mar 2019 17:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=5egiqUd9XDhiGhhq1wzKCHokpUtlFy80u9r0Zser++w=;
        b=pXo5TZu5ZMDPR3DBgI5uJKVfFj36WGb1HL5NJA0j7pC6N0tOpQAathgn2q+AYu5RSZ
         tOPL2xqQu3Bsln8CjQ15Eiktv2cE+Y+yRWril7mhBY9K5XESadQ1+gveEtBBzgsGL9G+
         S+xe/yIjrvPtO7YzvISAwh/+uoWKb29NPQnlY0ykytZTlnMSrElhqdQ0CEKB0vNn5Dqg
         HrJ/u/h1GcBvRwJTD6QpAbt/B+7IiAm2zAATp7+s/AHAzwKTsVbK4UcDnD7ECt6DsqMn
         krWMHh1QQhb7ZQ0BREHrl5bE/3WER8zf3ImPm3bm5HQmX+nPEKT4aRu17XW6lA7Gb9VO
         +9Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=5egiqUd9XDhiGhhq1wzKCHokpUtlFy80u9r0Zser++w=;
        b=i4WBRf++YTROpu8pIonPmNEt+n2LuoTEtB527faU1b+xqutSkkvl3pEIri14oE/c/0
         OReY/h3lNX45GqOYEKxTAnXRBhNNUXqA3r3lYa3WSkU0b0xOH1VlWi32Eb4tN0qrB9fQ
         3kdRHNc7FI30kG98BhFh+m8oRBQg+/ut6Bz8EPN7FMueqYxTOcco1Em5Av7QMFL52b8Z
         Ks2+zbi4yO5WYKAy8yiQWVebO+L3V6AfgAT8PplGt9J4rV0kFU8WodSU4dodK6z3q/ai
         WEWx/bdAGYBQShAgl4mUJv5i6Ka9KlPC+yqPs+Fc4B18p5yrdWAG3kw/9ASQUkmDfcRh
         Xzuw==
X-Gm-Message-State: APjAAAW950RUHasJN0IpnkI3/zwO//YhoDw6uqdK7HoVDF3XrGZE/3bg
        bQ0hUvN7ttoEjFMbnZeS15Y=
X-Google-Smtp-Source: APXvYqwig6pArqCXLuj1VBWjERoRDFm5Noi653jPzu5il2WQiOQNDrLn7ckure+W9zjzmQrVXLMDOA==
X-Received: by 2002:adf:9103:: with SMTP id j3mr14185551wrj.236.1552955148043;
        Mon, 18 Mar 2019 17:25:48 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id v9sm27423778wrg.84.2019.03.18.17.25.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Mar 2019 17:25:46 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 2/3] parse-options: make OPT_ARGUMENT()  more useful
References: <pull.163.git.gitgitgadget@gmail.com>
        <pull.163.v2.git.gitgitgadget@gmail.com>
        <10775638ad8f2ef9b64b8dbaf71b80d8546e81d8.1552562701.git.gitgitgadget@gmail.com>
        <20190315031553.GB28943@sigill.intra.peff.net>
        <xmqq7ecw7vbb.fsf@gitster-ct.c.googlers.com>
        <20190318210424.GA29661@sigill.intra.peff.net>
Date:   Tue, 19 Mar 2019 09:25:46 +0900
In-Reply-To: <20190318210424.GA29661@sigill.intra.peff.net> (Jeff King's
        message of "Mon, 18 Mar 2019 17:04:24 -0400")
Message-ID: <xmqqd0mnzp4l.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> The way it is written, I think the intent is that you would do:
>
>   OPT_ARGUMENT("foo", &saw_foo, ...),
>   OPT_ARGUMENT("no-foo", &saw_no_foo, ...),
>
> I'm happy to punt on it until it ever comes up (which I suspect may be
> never).

Yeah, having to have one extra element like the above may be ugly
and less optimal API design, but something that is survivable, and
when we actually need to use it, find it too ugly to live, and are
motivated to fix it, it will be fixed, so I won't be too worried
about it, either.
