Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6BDD82036D
	for <e@80x24.org>; Wed, 22 Nov 2017 00:32:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751429AbdKVAcp (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Nov 2017 19:32:45 -0500
Received: from mail-qk0-f179.google.com ([209.85.220.179]:42899 "EHLO
        mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751372AbdKVAco (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Nov 2017 19:32:44 -0500
Received: by mail-qk0-f179.google.com with SMTP id a194so14597252qkc.9
        for <git@vger.kernel.org>; Tue, 21 Nov 2017 16:32:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=5raViItD/qKP7y7k6VK3bSE8bsWO0RNY6Y2wzONmn1Q=;
        b=Ndl4lLsl0L0XMzBpKuKdiQQhAIh8DS6hRthTMR+hURKzq0re8hNud6lsrCteUm7p8v
         RgggMOwJYG11chTzEhcScayLueSPLCLW5+J+DI5mUYgdxyVRHj/DxTuWD1ii8Q39qg+k
         +xFmLef5MkE4gkpuZijKPenyyzdJrIC+5j2VMy91KAZSQcW/+U/z4KX9MZJnHd6fBrMD
         wQ0ulRrIsME4XM/n67nP7137DZvAyKKZcsLWOsX5OBsW6leld+ItQsLT6ndlN4v3Tbh0
         Bo3qM0mkkI5bfLE2zW6PQ6NZqby081dmIN3xT4XmW84rPFMq/auhN10vkvmF/zqLUAVa
         +EPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=5raViItD/qKP7y7k6VK3bSE8bsWO0RNY6Y2wzONmn1Q=;
        b=AnACAY1MaB5p0JUlVTTR2/8TY7Z2FTt1K0M2mogbcmUxLbf5UukLX3hytd6llAkVDX
         4g2p0J9czpTfDKfWBBOdPP6yKYvJ+i6MSHTHu8EBoeo12nmehqOq3KqxxKB2BQiNykuf
         8oloYsxJ/8Ntj07LLf6VD1iSjqDmrbb44TSx2aJ0tQLX6a8mXzX4G++1f1a8h9GFQgap
         IFWbU/xyAPFSaobq1GWnx2LwiNUSfNvdnqsTAq3tGIFu6JKJmsex7XrkwmXWRH5U69f0
         50nm4rjs5xZ9gA5/7edad3Naa8RBzJAzWkTJh6Klv+z1GDkEK3ZZvL7tGajK1QQk7GHK
         ZQ6w==
X-Gm-Message-State: AJaThX7H3E3HsXaIxB+xEwOi3rkBfjcPVT9dPpSqjvVUr7ae07ddGDRw
        iwjKCd98c9149mNZ+ov9mGLP/+qpLjNM+34F4FcILnDR
X-Google-Smtp-Source: AGs4zMYz8rQWZhHyshF2vkHqYEx24pLx3OZkhFCy61EM6a4GajaVurwGd84Tx/nwCu7sLZDRF29QPfiDadhAPvt3P7w=
X-Received: by 10.55.203.156 with SMTP id u28mr30414973qkl.353.1511310763348;
 Tue, 21 Nov 2017 16:32:43 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.85.179 with HTTP; Tue, 21 Nov 2017 16:32:42 -0800 (PST)
In-Reply-To: <20171121155815.46ih4ld4cp7n544l@sigill.intra.peff.net>
References: <20171120202607.tf2pvegqe35mhxjs@sigill.intra.peff.net>
 <20171120202643.s2cywlqykayq5qdb@sigill.intra.peff.net> <CAPig+cRDNmjmM2Ed+mwqf7JZ76CxA3Eh7-UV6k=LFngZ3YE_sQ@mail.gmail.com>
 <20171121155815.46ih4ld4cp7n544l@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 21 Nov 2017 16:32:42 -0800
Message-ID: <CAGZ79kbNQCzmkQDFY+gxEuZDPziehZdhgReCzpk3oxn=fpv=UQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] p5550: factor our nonsense-pack creation
To:     Jeff King <peff@peff.net>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 21, 2017 at 7:58 AM, Jeff King <peff@peff.net> wrote:
> On Mon, Nov 20, 2017 at 06:55:51PM -0500, Eric Sunshine wrote:
>
>> On Mon, Nov 20, 2017 at 3:26 PM, Jeff King <peff@peff.net> wrote:
>> > p5550: factor our nonsense-pack creation
>>
>> s/our/out/, I guess.
>
> Heh, yes. I even fixed it once, but I have the funny habit of noticing
> such typos while reading the "todo" list of "rebase -i" and fixing them
> there. Which of course has no impact whatsoever on the commit. :-/
>

That happened to me a couple of times as well before.
This sounds like a UX bug on first thought.

On second thought the text after the abbreviated hash can be
user dependent IIRC, by setting some format option how to populate the
rebase instruction sheet using log, so it would not be easy to take
fixes from that line into the commit for a fixup.
