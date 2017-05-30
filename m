Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 987E52027C
	for <e@80x24.org>; Tue, 30 May 2017 17:12:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750992AbdE3RMW (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 May 2017 13:12:22 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:33592 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750811AbdE3RMV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2017 13:12:21 -0400
Received: by mail-pf0-f177.google.com with SMTP id e193so78026888pfh.0
        for <git@vger.kernel.org>; Tue, 30 May 2017 10:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=O3F1Im9btFsBpDW4kIMm6QSs0zkPCtR5VBLdT+TYKVI=;
        b=LjhO3gHSGCGPPtdZOCdHgkrXQlDw8aBt79OHxGydy/IJsQam0BsjWmV60fBEwG/4WW
         rY8ZR9jM67V2sG5k5jyb16uA2lgFgw1YajjmbVHLiNj169nPNSxHi/8WKC8ZmYUAJFkF
         EEeDmTRVWLnpDLUc8L/xbhvsvUQefxyD/6lQcugNKxAF4263tE2kGw1SAoQPGiAzFk0+
         1+u+KZbza05f+jyYuPCh50Kmkx9C3RdWQ8wW0tPYxRM0NFqY41Uwc2mtvnh+87Ny7NkM
         KyHrQN9Wdip3Z2Dex4J+8IHpwiXp+SKilcrIdNgRSaukwrvCNHwrssqXe/7n5T7te5mX
         pt1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=O3F1Im9btFsBpDW4kIMm6QSs0zkPCtR5VBLdT+TYKVI=;
        b=pY247qDlhss6ULMHja87v+mpDDy5V6bJCZ0EMjxP+HLKl5XK2+xA95AJiDQWmGLQCh
         FT4L6WXO9M7dLblJ5r0PVTeA4jAKxthCiFkSUAGGqASFxdXvvnWy9j7UxBvzh8jxrs44
         JLc7emQr1ERfvRNpfTVTOvbTMX2QTARIvPlIVB/9MnU/XMVaO5jLJTvWiO4GCz5r8O5K
         JnQVjTCFgEFp4QWAoi0rce7KtQeok3ULCt17HfElMtiOard4RSVGZdghxDEDON51sdxB
         3KF0mDNGXmtW0fuPXbo4nbIW0Caqo/jOhZPR2E0HgR69MFMZ+03b8xlqBfOcDrLtYLdR
         BC2g==
X-Gm-Message-State: AODbwcANdzSmrkvvb+5Z+2I+KLTrtTXY4b8ED90FUmTemkbfLFgZZA5q
        v9qpcqwWF23NJo66
X-Received: by 10.84.169.3 with SMTP id g3mr28517969plb.37.1496164340212;
        Tue, 30 May 2017 10:12:20 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:308e:e3d5:272e:65c])
        by smtp.gmail.com with ESMTPSA id y2sm22846986pfk.1.2017.05.30.10.12.18
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 30 May 2017 10:12:19 -0700 (PDT)
Date:   Tue, 30 May 2017 10:12:17 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Jeff King <peff@peff.net>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [WIP/RFC 00/23] repository object
Message-ID: <20170530171217.GB2798@google.com>
References: <20170518232134.163059-1-bmwill@google.com>
 <20170522193535.7cgivd6pmmqhw7ze@sigill.intra.peff.net>
 <CACsJy8DmsG_+ASEkisUTLejVkiOmYytvTCTQs=RCH6q=BeDAhg@mail.gmail.com>
 <CACBZZX5GRxecDQkoqLv55FLuiSohGSR3U1U+sG0vFFpexcc54A@mail.gmail.com>
 <CACsJy8AtMNAE=5jihV+sYZqyx40JCJ0hkZAvqFbkOU1g5sZSYA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACsJy8AtMNAE=5jihV+sYZqyx40JCJ0hkZAvqFbkOU1g5sZSYA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/29, Duy Nguyen wrote:
> On Mon, May 29, 2017 at 6:23 PM, Ævar Arnfjörð Bjarmason
> <avarab@gmail.com> wrote:
> >>> That said, even if we never reached the point where we could handle all
> >>> submodule requests in-process, I think sticking the repo-related global
> >>> state in a struct certainly could not hurt general readability. So it's
> >>> a good direction regardless of whether we take it all the way.
> >>
> >> I doubt we would reach the point where libgit.a can handle all
> >> submodule operations in-process either. That would put libgit.a in a
> >> direct competitor position with libgit2.
> >
> > Wouldn't that be a good thing? We already have some users (e.g.
> > Microsoft) choosing not to use libgit and instead use git.git because
> > the latter is generally more mature, if git.git gains more libgit
> > features without harming other things it'll be more useful to more
> > people.
> 
> Whether it's a good thing might depend on view point. Similar to linux
> kernel, we might want some freedom to break ABI and refactor the code.
> But I think it's too early  to discuss this right now. There's lots of
> work (the "die()" minefield comes to mind) before we reach the point
> where libgit.a may be good enough for external use.

My personal end goal is making the code easier to parse and to make
submodule work easier.  I know I've only worked on the project for a
short time but I already regret some of the submodule changes that I've
made because they are straight up hacks which I want to eradicate sooner
rather than later (just look at my patches to get 'git grep' to handle
submodules...).

I wasn't thinking about libgit2 and don't really haven't thought too
much about the possibility of being in competition with that project.

-- 
Brandon Williams
