Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0BE081F453
	for <e@80x24.org>; Fri, 21 Sep 2018 14:07:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389644AbeIUT4i (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Sep 2018 15:56:38 -0400
Received: from mail-it1-f170.google.com ([209.85.166.170]:36994 "EHLO
        mail-it1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389545AbeIUT4i (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Sep 2018 15:56:38 -0400
Received: by mail-it1-f170.google.com with SMTP id h20-v6so2022184itf.2
        for <git@vger.kernel.org>; Fri, 21 Sep 2018 07:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/WF5n2ZEItmnytwcE5zP9nSTziZaerz/CRXYRbeo49o=;
        b=HoGFP5pDMzAKDKS6FG134nf2eg9eIlPcl3QwJQ946bh02OI6BI+/iyojmB6MTf0yDT
         OxcL0ppcGbhDku4LN59iOw3IBcQxZUiIGmUhiy8ftAy9AXo1nP/J7bIYawbAIlam1qf3
         2lV/eQ4cWrUiGHoisp5BHv28FyBtv7FnQpf05V39kcg6SHEyYU8XJiXC2BVCVxDlFcwY
         xTpve0EtDy9ZTitSCXgAoyDDNFegOFt1AFWLHhoI8XuENi6dOeN03liFUZ5Dcn2yvKnV
         i5uLbho+PB4JOpfz6Ge539ZjtC4VMvpa+5qEzcSrSesmtcstZAz4UaP/6HS4b3Erx2iI
         uNkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/WF5n2ZEItmnytwcE5zP9nSTziZaerz/CRXYRbeo49o=;
        b=VQFx0uU0u+GGQS6LJucjh+G8TZg1RjytrZKYuFYAWUoNc123ByeWLkjfULMZyMjZSP
         YOLlCK9z5mdYR85A9SHwRiOSyX2kaeAkZLo99fQOJ05T8cdg3fCwOovnLqkILwd9SXGI
         MSlBxecwXNHIhEti3jFnq0WPT9YJpaeB4ym9GmwHBrCn069gPyPyl7IeNUDXI3KlGfHc
         cWsWUZjBfKqPGGIQqvCymjhbK9Ufw2tQV09jpIPFnpbtpQEEj5HfTS2v9r3jL4hC4/Xt
         Rw/YTTptCOKdl6zpmOA+0VB5ucpTm2PHSjyBGZVPnDkpxc0U7GbaaMxedQ8q5dXy7i1N
         1QVA==
X-Gm-Message-State: APzg51B4B9CVZQPsvVnjg5gAxIMJJWI5Y0zOU6QR5eZDXSInnk+WseSY
        cweRpPr0fDD4MeganJt8OUOWaoco+rw=
X-Google-Smtp-Source: ANB0VdZ8tCQ/ktBvz/OH0s9ZyFva6WAxYdZ2ZP94jzB9NR7yjQwKLKWsHXRWYOOnaWK5oYBL7dGOaA==
X-Received: by 2002:a24:7355:: with SMTP id y82-v6mr5777376itb.30.1537538854676;
        Fri, 21 Sep 2018 07:07:34 -0700 (PDT)
Received: from localhost ([173.225.52.220])
        by smtp.gmail.com with ESMTPSA id t134-v6sm2365854itb.41.2018.09.21.07.07.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 07:07:33 -0700 (PDT)
From:   Taylor Blau <me@ttaylorr.com>
X-Google-Original-From: Taylor Blau <ttaylorr@github.com>
Date:   Fri, 21 Sep 2018 10:07:32 -0400
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] transport.c: introduce core.alternateRefsPrefixes
Message-ID: <20180921140732.GA43093@syl>
References: <cover.1537466087.git.me@ttaylorr.com>
 <3639e9058859b326f64600fcd0b608171b56ce9f.1537466087.git.me@ttaylorr.com>
 <CAPig+cT7WTyBCQZ75WSjmBqiui383YrKqoHqbLASQkOaGVTfVA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPig+cT7WTyBCQZ75WSjmBqiui383YrKqoHqbLASQkOaGVTfVA@mail.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 21, 2018 at 03:19:20AM -0400, Eric Sunshine wrote:
> On Thu, Sep 20, 2018 at 2:04 PM Taylor Blau <ttaylorr@github.com> wrote:
> > The recently-introduced "core.alternateRefsCommand" allows callers to
> > specify with high flexibility the tips that they wish to advertise from
> > alternates. This flexibility comes at the cost of some inconvenience
> > when the caller only wishes to limit the advertisement to one or more
> > prefixes.
> > [...]
> > Signed-off-by: Taylor Blau <me@ttaylorr.com>
> > ---
> > diff --git a/t/t5410-receive-pack.sh b/t/t5410-receive-pack.sh
> > @@ -44,4 +44,15 @@ test_expect_success 'with core.alternateRefsCommand' '
> > +test_expect_success 'with core.alternateRefsPrefixes' '
> > +       test_config -C fork core.alternateRefsPrefixes "refs/tags" &&
> > +       cat >expect <<-EOF &&
> > +       $(git rev-parse one) .have
> > +       $(git rev-parse three) .have
> > +       $(git rev-parse two) .have
> > +       EOF
>
> It's probably a matter of taste as to which is more readable, but this
> entire "cat <<EOF" block could be replaced with a simple one-liner:
>
>     printf "%s .have\n" $(git rev-parse one three two) >expect &&
>
> Same comment applies to previous patch, as well.

That's a good idea. I amended both patches to replace the 'cat <<-EOF
...' block with your suggestion above. It's tempting to introduce it as:

  expect_haves() {
    printf "%s .have\n" $(git rev-parse -- $@)
  }

And call it as:

  expect_haves one three two >expect

But I'm not sure whether I think that this is better or worse than
writing it twice inline. I think that the test is small enough that it
doesn't really matter either way, but I think that I've convinced myself
while composing this email that expect_haves() is an OK idea.

If you feel strongly that it isn't, please let me know, and I'll write
them inline before sending v2.

Thanks,
Taylor
