Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A818E1F424
	for <e@80x24.org>; Mon, 23 Apr 2018 13:56:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755207AbeDWN4E (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 09:56:04 -0400
Received: from mail-wr0-f181.google.com ([209.85.128.181]:40564 "EHLO
        mail-wr0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755010AbeDWN4D (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Apr 2018 09:56:03 -0400
Received: by mail-wr0-f181.google.com with SMTP id v60-v6so41547568wrc.7
        for <git@vger.kernel.org>; Mon, 23 Apr 2018 06:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=XWsRNRtW5/rAVe22iM2E8FFn2Ez85DSVo10l2H0C6oE=;
        b=mr5gOyOyje3X1kmZ75kRK045Qh/WHSyvkC12s2ZEBxiCfwlGbfcYcCRIGM9gG2vVMv
         n6rLufjap4m9huR4oKUuIJVaA/cYfGCgrRCroTEHMhW+YwwWLjJEbkph86IUw1vhsDcX
         RH94LIGtsGdT4lGlNxu0OfZzJ8HdctbTg/6VAWn4zbgYrbYsR5sXU3mh7pTkBQzHomLU
         Rs/c+JeXClnwBZrOhfMdvf1o6RtYB6H6JmQxsbOt5oJA45BCYfoSYwNf8QBoED3NuNgK
         gWZv+uejclGWJ6eI1thYJyaIrKsZzHuHHK51OGpKtfcGJss+gfwLgAW5KBBlIuQSStna
         YiwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=XWsRNRtW5/rAVe22iM2E8FFn2Ez85DSVo10l2H0C6oE=;
        b=Lf7wrh7Bbc3nAA8Nd3E/wpJqh9B6ERF9JmQs7h0MHpkXFObKpmLy+sTO+KnOb5201X
         gMYxjLQHLtZVndsdykNABcmeJXD2BqnQyDzjVTBXCAxWAJ4/SdzPdZqr0ICJaA/rEG8U
         fgUR9kGGS4f5ZXiQy9sx/zzicN1TAYftBz4RpgDaydZ05t+ZOg3MXcf0pnPYG4/nroNV
         SG3hM+oYG/n8yDQU/AOils1nTdtlhdU6NzhD0qP2OBfsXkZs8SfCPGI2luOReXd1Bs0p
         CBv8PW+yq45X6G0dboGiebJnIWd3/Qh4BIts5+tjFly8BTtluZi/T3jV4XeePfBxTD90
         BkFg==
X-Gm-Message-State: ALQs6tDJIXf8bglFV+K0xlDGu4TGso8zcO47Qara2kvIjqRnADEO3Spm
        sMekJb9C3fh+x5xdlq/5RJs=
X-Google-Smtp-Source: AIpwx4+eESeQ+WhvMggLKFAfGV39OsfQ9T5E6aFoBjrRnRlnkUXnfzpgKPvz8RavKYHZRjXTg6pGtQ==
X-Received: by 10.28.144.134 with SMTP id s128mr10262121wmd.26.1524491762243;
        Mon, 23 Apr 2018 06:56:02 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 109-v6sm8920652wra.32.2018.04.23.06.56.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Apr 2018 06:56:01 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Apr 2018, #02; Tue, 17)
References: <xmqqzi22tlfx.fsf@gitster-ct.c.googlers.com>
        <20180422201755.GA92212@syl.local>
        <xmqqo9iaakaw.fsf@gitster-ct.c.googlers.com>
        <20180422233848.GA50345@syl.local>
Date:   Mon, 23 Apr 2018 22:56:01 +0900
In-Reply-To: <20180422233848.GA50345@syl.local> (Taylor Blau's message of
        "Sun, 22 Apr 2018 16:38:48 -0700")
Message-ID: <xmqq36zm9gcu.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> For now, the Message-ID that I was referring to is:
> 20180410001826.GB67209@syl.local. [1]

Thanks.
