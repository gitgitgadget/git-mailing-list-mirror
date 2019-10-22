Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 760F91F4C0
	for <e@80x24.org>; Tue, 22 Oct 2019 20:43:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731452AbfJVUnG (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Oct 2019 16:43:06 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44924 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727582AbfJVUnG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Oct 2019 16:43:06 -0400
Received: by mail-pg1-f195.google.com with SMTP id e10so10644889pgd.11
        for <git@vger.kernel.org>; Tue, 22 Oct 2019 13:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WB0smknWASmncIFd6fZ0WuCzKPaXoHWuFV5Awyxc3MY=;
        b=gOl9rIsz/aQ6PeMs82ExNdVQkOmEAhe8W0QC2JuYEK2zoqw7f4P3X6/xprebwsx2U6
         cB4s4BDhUj8NllRHU7XEmSeeGylCHXiXUOHMNYTE1pFGq7hUN07Y/+43jCkjUzntPiSO
         f4bO0SdjEZOPOYTnbv2xIlyhpUK0nl1858XxbxteInjrTvjGcO8vgadO5yfk99p8O9bk
         2ReA2cUKkyLPYngOrfxUG1I6U4ue6qsxIrX29Btx8UfFP8YYsQyzG2CsR7+hsyeyLpTK
         ZJJyvIUm/AQ4jtVjA7O/NnrYtaFPueHIdXATBP7Tf/yuehMJC40a5ie3TiV07h+YbZCp
         H1Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WB0smknWASmncIFd6fZ0WuCzKPaXoHWuFV5Awyxc3MY=;
        b=Fj9UrGtWKs8xhp+0WOgSUfghc6xIZdfz3LpyxlURh8viSGfmhOcspZATzy8WnY0xrs
         PTkNa/8Jr8i3OCtLBkKBMUtM/qyydyBGdfwS04s0G2vgFQa6/mBDCwWvL2Ek8hVsxCg5
         Of77ZefRoIlrsvNquvM459XSHEOSy2RoAr8YLQO9tBiqwHVVADcXwwS0DWPSNWUuAPlG
         Xsw97IfdOSVzQThDv5UuA/g6rGPDKmydC7WjEisvMZhircIKOaFlAVdeLwTbV3YYwBEb
         T5bF+rKo2H6NK9gmDngzNhImUI4n2pczCg5wmcsCxdsi+xNBR33UiplAEVfvGwCUJk1Y
         CuEw==
X-Gm-Message-State: APjAAAVKCEX49xvmpYHgZ4exNFsrAiOd+NoaNcNqaKckPNur6+5S1Lmh
        Jkck2BGkrebpV0T5LZn96i+cGw==
X-Google-Smtp-Source: APXvYqzRGohW6ltIL5vK9K45CPHKdJSCIOsiCZYtl2Hu/tPnv+wQ39WNlT1EGhiVwPw+LvPNnMaSRA==
X-Received: by 2002:a63:2224:: with SMTP id i36mr5959885pgi.9.1571776984844;
        Tue, 22 Oct 2019 13:43:04 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id s191sm18187470pgc.94.2019.10.22.13.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 13:43:04 -0700 (PDT)
Date:   Tue, 22 Oct 2019 13:42:59 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Heba Waly <heba.waly@gmail.com>
Cc:     Heba Waly via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] config: add documentation to config.h
Message-ID: <20191022204259.GC9323@google.com>
References: <pull.405.git.1571357219.gitgitgadget@gmail.com>
 <2e42eafb5db6192829e9e206e9e9905b31f8e8a6.1571357219.git.gitgitgadget@gmail.com>
 <20191018225155.GA9323@google.com>
 <CACg5j26DuAUm9WR9-4awF7BeGCy81d5kMhhcsePyp3Kxh2DTGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACg5j26DuAUm9WR9-4awF7BeGCy81d5kMhhcsePyp3Kxh2DTGg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 20, 2019 at 09:35:17PM +1300, Heba Waly wrote:
> On Sat, Oct 19, 2019 at 11:52 AM Emily Shaffer <emilyshaffer@google.com> wrote:
> >
> > On Fri, Oct 18, 2019 at 12:06:59AM +0000, Heba Waly via GitGitGadget wrote:
> > > From: Heba Waly <heba.waly@gmail.com>
> >
> > Hi Heba,
> >
> > Thanks for the patch!
> >
> > I'd like to highlight to the community that this is an Outreachy
> > applicant and microproject. Heba, when you send the next version, I
> > think you can add [Outreachy] manually to the PR subject line - that
> > should draw the attention of those in the community who are invested in
> > helping Outreachy applicants.
> Good idea! I wanted to add it to the email subject but as I decided to
> use gitgadget
> I had no control over the subject.

Hm, it looks like you already figured out how to add it to the title of
the PR. :)

> > >
> > > This commit is copying and summarizing the documentation from
> > > documentation/technical/api-config.txt to comments in config.h
> >
> > I think in the GitGitGadget PR you've got some great comments from Dscho
> > about how to format your commit message; please take a look at those and
> > feel free to reach out to me if you're still not sure what's missing or
> > not.
> Will do.
> > > Signed-off-by: Heba Waly <heba.waly@gmail.com>
> >
> > One thing I miss in this change is the removal of the contents of
> > Documentation/technical/api-config.txt (or maybe the removal of the file
> > itself). I'd prefer to see at least for api-config.txt to say something
> > like "Please refer to comments in 'config.h'"; or, more drastically, for
> > api-config.txt to be removed entirely.
> >
> > Having both pieces of documentation standing independently means that
> > someone who's trying to add new information about the config API won't
> > know where to add it; eventually they'll add something to config.h but
> > not api-config.txt, or vice versa, and the two documents will go out of
> > sync. So we want to move the documentation, rather than copy it.
> That makes sense, thanks for the explanation.
> I wasn't sure if it should be removed or not so I decided to leave it
> until I'm asked otherwise.
> So I assume api-config.html will be removed too?

That shouldn't be tracked - this is generated from api-config.txt as
part of the build. So don't worry about this part.

> > > +
> > > +/**
> > > + * Value Parsing Helpers
> > > + * ---------------------
> >
> > It may not make sense to have the header here in the middle of the doc.
> >
> > I wonder whether we need the headers at all anymore; or, whether it
> > makes more sense to put this header in the long comment at the top with
> > just the list of function names (so someone knows where to look), and
> > leave the per-function explanations inline with the function they
> > describe?
> I see your point Emily, but in the CodingGuidelines file it was
> advised to refer to strbuf.h
> as a model for documentation, I noticed that strbuf.h used headers
> this way so I decided
> to replicate that.

Ok! Sure.

> > I made a couple of smallish comments about general formatting, but I'm
> > also interested to know whether you were able to move the entire
> > contents of api-config.txt across to here. Was there anything that you
> > couldn't find a place for?
> Yes, everything is moved.
> > Thanks a lot for this change, and congrats on getting your first review
> > out! Welcome! :)
> >
> >  - Emily
> >
> Thanks a lot Emily for the detailed and helpful feedback!
> 
> Heba
