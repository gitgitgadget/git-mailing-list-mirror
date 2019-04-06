Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1EE8720248
	for <e@80x24.org>; Sat,  6 Apr 2019 05:33:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725951AbfDFFdK (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 Apr 2019 01:33:10 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43764 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725290AbfDFFdK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Apr 2019 01:33:10 -0400
Received: by mail-pg1-f194.google.com with SMTP id z9so1238789pgu.10
        for <git@vger.kernel.org>; Fri, 05 Apr 2019 22:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=i+DGRVMb+xpV4HEPRDWHj5uy0tIYWwttoDLXLfUrKGo=;
        b=cHe9Segh02xausapWuaSRd1+cP+67lPCXhCQQE+595LSRoqIstexvubhggmy9ny85o
         y50oodlgEb0+BMsojczeUeweHBysGESqosuIJBMvaHZGEI4w1pmwfzwLni7+VmpKKo0E
         k0rjmeWUD84V5KWrELUUAEG6TL/bU2x6UG/OSYZ0vcKPAfnNhWPBGKRVp+/A6LnlTfnl
         Kbo0XDkX3fKRsoR3AKASrCTWsQuWo7K3rrTycwOFqL4ytSy9+D4MGe0dH3BbeFA2rufh
         jvKAezj2bCU2a0Pmh8W5RmSXNOdKbRf+l9MD7aGNNkIQgXik0sEx6UQUaSXQA9P4XmsP
         pg6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=i+DGRVMb+xpV4HEPRDWHj5uy0tIYWwttoDLXLfUrKGo=;
        b=YSrKWnCRFcHLkHg9ViESlDk8waCeE8Gwcg+OeShchLjev+TZ6hs122vYLpdrX54TYB
         zVoKn+1z7R20qJMgqjz9pB94LkgIZmCW1n2wKH7jgnERyHlmwVMw3a74gxqxkdqx4sWT
         yWkNcK3yjwBUn2Q8+398jovPWX4ZiR9b5BVR/2acCN+HqJoBEpMhTWZMoe1+aIIyORuD
         Jz0IPi0pQViP2GCuE14uvadvKvXaXoRymv7fm5dStNX/YABF7rsGzRw8vA/lYp1KjZzx
         3yu/xAZMfrWGgLc7MdZsANt+K4wQo1KbBvu5rVte3z0EYAfQOzEwFpyPyKPKG2xSxTRh
         Toew==
X-Gm-Message-State: APjAAAUgvU/6k+wWRNhHSblkPJkPY9oD04Oy+c2q0HFEjlhh1RjG194u
        Jv8bKXnlWj30t/oGvgKTd28aZA==
X-Google-Smtp-Source: APXvYqxuAwmDQxPLNikvMcvPjci6HO6zjrE2k4WOZewoEC5tU+GUlDQG2v0tEmizUbV4MZle+V4biw==
X-Received: by 2002:a65:625a:: with SMTP id q26mr16385800pgv.68.1554528789683;
        Fri, 05 Apr 2019 22:33:09 -0700 (PDT)
Received: from localhost ([2601:602:9200:32b0:e077:74b2:7faa:e131])
        by smtp.gmail.com with ESMTPSA id n65sm67089008pfb.160.2019.04.05.22.33.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Apr 2019 22:33:09 -0700 (PDT)
Date:   Fri, 5 Apr 2019 22:33:08 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/7] t: introduce tests for unexpected object types
Message-ID: <20190406053308.GC37216@Taylors-MBP.hsd1.wa.comcast.net>
References: <cover.1554435033.git.me@ttaylorr.com>
 <ef6b4f380435d9743a56f47f68c18123bf0a0933.1554435033.git.me@ttaylorr.com>
 <20190405105033.GT32732@szeder.dev>
 <20190405182412.GC2284@sigill.intra.peff.net>
 <CAPig+cQ7f6C-YBE5LT3qiXSyjpqQQEknmE8eHdQJvzCAzkBNPA@mail.gmail.com>
 <20190405205345.GB8166@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190405205345.GB8166@sigill.intra.peff.net>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 05, 2019 at 04:53:45PM -0400, Jeff King wrote:
> On Fri, Apr 05, 2019 at 03:25:43PM -0400, Eric Sunshine wrote:
>
> > On Fri, Apr 5, 2019 at 2:24 PM Jeff King <peff@peff.net> wrote:
> > > On Fri, Apr 05, 2019 at 12:50:33PM +0200, SZEDER Gábor wrote:
> > > > > +   git cat-file commit $commit |
> > > > > +           perl -lpe "/^author/ && print q(parent $blob)" \
> > > > > +           >broken-commit &&
> > >
> > > > Wouldn't a 'sed' one-liner suffice, so we won't have yet another perl
> > > > dependency?
> > >
> > > Heh, this was actually the subject of much discussion before the patches
> > > hit the list. If you can write such a one-liner that is both readable
> > > and portable, please share it. I got disgusted with sed and suggested
> > > this perl.
> >
> > Trivial and portable 'sed' equivalent:
> >
> > git cat-file commit $commit | sed "/^author/ { h; s/.*/parent $blob/; G; }"
>
> I always forget about the hold space. That's pretty readable (though
> being sed, it's terse enough that I actually think the perl is more
> readable; that may be personal taste, though).

Ah, very nice. Thanks Eric, your sed-fu is much stronger than mine ;-).

I share Peff's view that this might be less readable than its Perl
counterpart, but am similarly sympathetic to the notion that more Perl
is a bad example in 't'.

I think that I'll take this for v2 and get rid of the Perl.

Thanks,
Taylor
