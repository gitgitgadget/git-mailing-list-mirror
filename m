Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6AC320323
	for <e@80x24.org>; Thu, 16 Mar 2017 22:40:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752380AbdCPWju (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Mar 2017 18:39:50 -0400
Received: from mail-it0-f46.google.com ([209.85.214.46]:38772 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752624AbdCPWjs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Mar 2017 18:39:48 -0400
Received: by mail-it0-f46.google.com with SMTP id m27so6068363iti.1
        for <git@vger.kernel.org>; Thu, 16 Mar 2017 15:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=L3HUKE4xv2iFOwqAhmVCwnDQOdJuxp44uDw6/JBB6Vw=;
        b=OCJYKRHsFKgiu2yT6S4Ji4D207VdJC3nmIOG8YeVtAiqvZPA/N9kDyl0RHFYsBI/wm
         +zhSX2LKszwb6J0NvW49lawwwpJmpvrfvhDt3qLxibpwRABqRmTJp6Wh293SePRXMGRO
         T5g77D3PiHe94b4re3GqSfKLxX+MJQVhxmomrdhsWXE0f8U+YrgxNRwGgW237+cehcRs
         Wa37XzuhLqytNmYotP3pBFmBfUU8lRuoMmP9kUsEvi94WomGY39cRdps+ZN67Iqg/s/u
         f2+bzipCtXiqUBGXjNCCb9ToZNjoDx6xbbK5JcD3j2n11SH4TRnGXEpNuCcK+AF1nruk
         9ECg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=L3HUKE4xv2iFOwqAhmVCwnDQOdJuxp44uDw6/JBB6Vw=;
        b=Ruq86RVd0cpHLSKgvoYQA3L8V75Y58irBRyiLHCqyhzf4SYlEYNhiZjMiN1t3CHrUa
         N+EooWq/bwZ+99SKs7SFJKSi1dtrNEBWrAgbBZh/qIwtR3aDt+4OLH9CkhyUXMMuK1+Z
         OdkihiUxGz7V9Bu+uSxlq6KVKBKbM1Or8+HY7rxZ+zqyyijTskXS3nf69qv91UQUhCTk
         K7LypDEn2pukClWxFBh4XBKwYgSwTcs6onOevPZEUuuYWEzYrurspYd+SfqFws1KjJYL
         GcNM7TdyDy6pGEPCmez0NYY/TSzpZIYVmx3ZnpowDFMfqxPM4V+4Ile04YQmMsqo4fb1
         uFAw==
X-Gm-Message-State: AFeK/H1lVUUtWpXvjjvsooDZT8XKHrof6QgYEovhu7pq0XhXm5O7XjZrJ9z7DIsypIN4zFw4DhyPAivPFzk0RQ==
X-Received: by 10.36.84.199 with SMTP id t190mr129095ita.114.1489703419180;
 Thu, 16 Mar 2017 15:30:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.136.102 with HTTP; Thu, 16 Mar 2017 15:30:18 -0700 (PDT)
In-Reply-To: <20170316220456.m4yz2kbvzv6waokn@sigill.intra.peff.net>
References: <alpine.LFD.2.20.1703161315310.18484@i7.lan> <20170316220456.m4yz2kbvzv6waokn@sigill.intra.peff.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 16 Mar 2017 15:30:18 -0700
X-Google-Sender-Auth: izcx-yNZnNUPxBTVyzRPdrPd8nY
Message-ID: <CA+55aFy1jPPPbKWOH_F31C1kGnWK6Rxhcm8+KARw2atMZs=stQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] Re-integrate sha1dc
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 16, 2017 at 3:04 PM, Jeff King <peff@peff.net> wrote:
>
> There are a few things I think are worth changing. The die() message
> should mention the sha1 we computed. That will be a big help if an old
> version of git tries to unknowingly push a colliding object to a newer
> version. The user will see "collision on sha1 1234.." which gives them a
> starting point to figure out where they got the bad object from.
>
> And to make that work, we have to disable the safe_hash feature (which
> intentionally corrupts a colliding sha1). We _could_ rip it out
> entirely, but since it only kicks in when we see a collision, I doubt
> it's impacting anything.
>
> I also updated the timings in my commit message, and added a basic test.

No complaints about your version.

               Linus
