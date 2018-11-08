Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 55EE91F453
	for <e@80x24.org>; Thu,  8 Nov 2018 20:52:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbeKIGaG (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Nov 2018 01:30:06 -0500
Received: from mail-it1-f202.google.com ([209.85.166.202]:38867 "EHLO
        mail-it1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726875AbeKIGaG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Nov 2018 01:30:06 -0500
Received: by mail-it1-f202.google.com with SMTP id j190-v6so114704itj.3
        for <git@vger.kernel.org>; Thu, 08 Nov 2018 12:52:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ipjX9o/Gbh8atooqj6FnXF/dIskHI0lMVWA56DylEyM=;
        b=cMIGKh7uZ1dIfl2j5xly7SksSuu3hRXCgkZeVrV1ml1Kgv7IGNfUPO0DByc+FKkdd1
         fGAO1HjfZJ6KrCL0gb17MGop+w+Ftzk/cxskK9qcbJcwkdmIX61GZsNN13py6L3uS63n
         Irjatoe2RhKaQk9ARhjzh8U4LTXWBFoaLJXpAsD7qYf5svLtDtchaVP6N850hvFuDkeJ
         HhBT/ROtB+BJJbTxHeC+oy06l2YPyq8aNrVXNubwo8wAmGMwr037NsNTEWkyK/s1Jncl
         Zu+7gTcuGgXyS+KkhasZb9MTfPnRZr3L/Jyc1GZpgTTZMOMLiOQcbqe9CnZeHb7FvNUO
         SLsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ipjX9o/Gbh8atooqj6FnXF/dIskHI0lMVWA56DylEyM=;
        b=EvPv/pO1cfNg3Po71xP2ExSu/QRogxu3RJRbokJEUsktMZZCCsPFi5JhrClgVrP9E4
         veNsm5AY9+emV4fLwcMkU24E0JAnXj1MczcB5RhVWdF079Z+QC7LED4Ra7g4BpzySshT
         OYqdzI0PXOrD82gV7AuUZya0VaH7ac+Y6AeejwjHzShYEuvdkMtBVZIUOim4xViqGFuA
         tU0gDTIpfn5lOYrDw7iPFQOSfHvmrKOXPDEAJLujJF5Z/KO2zCzTAe8V8DDhNWNOYie6
         Bjq52FU7hDgY7JLcMqX9qqSVuS5OlvlWBkSa0x5hkdhRhzzWkMiGIrSjv4e4stfIEuaM
         B/Og==
X-Gm-Message-State: AGRZ1gJA7PI7Qh5PokOagrR8VRH0lRgFw6lg9fbo/twc2DmRTQmFWSb6
        xRpu/0iJFUKsJj8EHEadIt7raMHQjRAbP/630EIK
X-Google-Smtp-Source: AJdET5c76sU0cRvnjDMbiQpz6vE7+LvtzIMA3RjGWn5MxomIA1mS5q5Y/hIxo8/SGjRQ2QGIHIMYbAAdic8xtC7wF0xH
X-Received: by 2002:a24:3303:: with SMTP id k3-v6mr2244775itk.2.1541710372619;
 Thu, 08 Nov 2018 12:52:52 -0800 (PST)
Date:   Thu,  8 Nov 2018 12:52:49 -0800
In-Reply-To: <xmqq7ehyybnd.fsf@gitster-ct.c.googlers.com>
Message-Id: <20181108205249.195494-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqq7ehyybnd.fsf@gitster-ct.c.googlers.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: Re: [PATCH 1/2] ls-remote: do not send ref prefixes for patterns
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     jonathantanmy@google.com, peff@peff.net, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Jeff King <peff@peff.net> writes:
> 
> > Since b4be74105f (ls-remote: pass ref prefixes when requesting a
> > remote's refs, 2018-03-15), "ls-remote foo" will pass "refs/heads/foo",
> > "refs/tags/foo", etc to the transport code in an attempt to let the
> > other side reduce the size of its advertisement.
> 
> Jonathan, seeing 2b554353 ("fetch: send "refs/tags/" prefix upon CLI
> refspecs", 2018-06-05), I am guessing that you are doing the proto v2
> work inherited from Brandon?

Sorry for the late reply - I had some personal events, but I should be
able to look more at Git stuff from now on.

Well, it's true that I have been fixing some bugs related to protocol
v2.

> Having to undo this is unfortunate, but
> I agree with this patch that we need to do this until ref prefix learns
> to grok wildcards.

It is unfortunate, although as far as I can tell, the performance
improvements from "git fetch" (which I think is the more frequent
command called) remain, so it might not be so bad. I see from your
What's Cooking that these patches are to be merged to master, which I
agree with.
