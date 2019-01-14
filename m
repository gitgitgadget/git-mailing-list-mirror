Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 380961F62E
	for <e@80x24.org>; Mon, 14 Jan 2019 21:52:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726732AbfANVwW (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Jan 2019 16:52:22 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37152 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726618AbfANVwW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jan 2019 16:52:22 -0500
Received: by mail-wm1-f68.google.com with SMTP id g67so1190190wmd.2
        for <git@vger.kernel.org>; Mon, 14 Jan 2019 13:52:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=6ONm/lC6Ih8Elji1vfNUs5/DQb1mB1NXMXBgMzkT7KY=;
        b=r8Z+xKMLqhQ7tTvg6PWgxpYtrgTj9yZT5Zj01w3aigLCytgtYiv9XJSn6WlvzijTSK
         oJnfb2Yqgl60xnCrwT5T7jD2OrZ4ytwHwqa4a0C1mlzNZ+YPD7qfiu2iNsEWMpVmLwzt
         9WZArcr3Rx6doOdGgAqKOFkjezeF86WTNCR7GXz0ylV8oyY0jouuQFzzhncNDLDC185q
         9kvferflseaWE1ikbbwLawT8cc0WgQJsRf2IX/2oEhysfwaCfTOYORzvuubJBT20k3Ff
         wRp1CaiBIv6ZhLP4UTh/NXE9p9/DQJRcts4t2VksZ4WI49hmjv/9CtMxzxiB5rzLsoq1
         EQmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=6ONm/lC6Ih8Elji1vfNUs5/DQb1mB1NXMXBgMzkT7KY=;
        b=psh+otD4zHhNZfXPSe4tGsaG/R78cp3Kk94xbX15qRgZPHU9T+JqAEAGDQ7DvdeFg+
         cpSJs0lnb0Xi7sFq5NYy87IHBR3EDeaqtaGGOi1sB0Btj6IdF1DBn6IubMkQIaBg3VXF
         cAQllGCDmkqP7TFLjRHwrlcKL+NRPPWHdBXaueqec13I52vOqnNgmEEsdgwBVb7Oz4qA
         Ut5RpmjUTBMUlFqmoeDGCGncCxgrskxJG0IPbcb1/6lq6zWx7s3kVQsr7ENzPyusVFFQ
         W/wbte6o5tWt7vULLLprPEXGy0VtSAQCJ6k3ci/segZn2tnGHw5E9vcfe876uccWP0lF
         NCTA==
X-Gm-Message-State: AJcUukd072ZdyUUrJQps9wMzl//70G3c+BpHldurPzKmgk8Ng1XcpSjO
        NJbp8kpHh4Q9JcAKy+PGTYYGZmhY
X-Google-Smtp-Source: ALg8bN4tN0L4XxXKIKYQQ1m7eu5ilCToxrxPPmMCo24QYqYLjuDswCrrioAuIm8K3Cpd9+TNs404eQ==
X-Received: by 2002:a1c:8acf:: with SMTP id m198mr874967wmd.143.1547502740139;
        Mon, 14 Jan 2019 13:52:20 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id a187sm28324827wmf.33.2019.01.14.13.52.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 13:52:19 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Maris Razvan <razvan.alex.maris@gmail.com>, git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: Gitignore documentation
References: <CALZbgSQti+t2dA4nm+DCDGxQjsvNJy3UDdqAya16v+Mv5O4Xdw@mail.gmail.com>
        <xmqqzhs3uldb.fsf@gitster-ct.c.googlers.com>
        <20190114213852.GD162110@google.com>
Date:   Mon, 14 Jan 2019 13:52:18 -0800
In-Reply-To: <20190114213852.GD162110@google.com> (Jonathan Nieder's message
        of "Mon, 14 Jan 2019 13:38:52 -0800")
Message-ID: <xmqqsgxuuctp.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> https://public-inbox.org/git/20111107080926.GC30486@elie.hsd1.il.comcast.net/
>
> Any idea what happened there?  Would it be useful for me to rebase
> and revive that series?

No idea what happend there.

Anyway, I quickly read them over and found nothing questionable,
except perhaps the moving of "slash is dropped for the purpose of
the remaining rules" in 1/4 were probably not a great idea (IOW, I
found that it leaves a stronger impression to the readers to say it
upfront in the paragraph), but I do not think it is a show-stopper.

Reviving the topic would indeed be a good idea.

Thanks.



