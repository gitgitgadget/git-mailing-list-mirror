Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ABA961F453
	for <e@80x24.org>; Tue,  2 Oct 2018 01:57:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbeJBIi0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Oct 2018 04:38:26 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:42278 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726484AbeJBIi0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Oct 2018 04:38:26 -0400
Received: by mail-io1-f65.google.com with SMTP id n18-v6so447756ioa.9
        for <git@vger.kernel.org>; Mon, 01 Oct 2018 18:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=awjVXCRxIINYRo1I/muf8npxyEoQuqHiH5bFAoiEG0Y=;
        b=lUEK6UKgPXyzin8Upnod7teJgPtCUFw1zDAWuTJl5WKS3em6OgIDXplFdJOdtnFotX
         awTgt7mIYTmUBxsV8W2uC2lvEyt9hEAGG19T2xROZP4WvAO5S/p4UcMlud3aFjzBtk+8
         +U1biOW26LQ9KXSODXLCscZauWM1jV9kHQzBb9oLy8iDiLhYxPMw4e/4krK4uT0jDnl3
         MGcJzdSKqghOyRPcTXdI8pBH+0zzMHYpMX5edLwzCT0Z9P6ukA6ipgngM9jD6TUte9Ua
         3/GNhnLI9dWo73+bcsAmNmrvphDbsvzpad9m7h1qNp8OEergLpBecdBVb4Hp72ikSnav
         wdBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=awjVXCRxIINYRo1I/muf8npxyEoQuqHiH5bFAoiEG0Y=;
        b=hZj6C1SJtH22DeJ88Ub8driV/r4b5VSA5Xzp3ZQcOWZeAV26idcVMnuf7C+ItJkrRr
         P8uM1mqSgyaZXcl0v7203mMZeqxeEx756JgZIib/wwUMd6NNltfnpH6bnwMGLdksESep
         otQ3Yi7OZCheX7vnihZ1YUNOufYxUrifBA6gNIeYAKJJt/DF/KY+gFD8lQogW2O6+osS
         89W8CFWfzbZv6D9g3UOCOVG5yHWHbyRmdU38o5CM8ny3aXt1KbozRBDBPIS40VBvFfXB
         HmrbIlTNIwoqjeaQXgL82dGtZDXWx7I1KGrgF+rbY6cRrjLomJAcz1sqTV9UbHy+cNdb
         ICdg==
X-Gm-Message-State: ABuFfojwAQLRLvToQOGnPB1SgGXbETy3uB4zEAXQlAagixfRZOxlhlzJ
        +4GTqUjiI1j6jAiA6t2S5yigSw==
X-Google-Smtp-Source: ACcGV62j3L33yAL4xRjKyCh6U+FSYWuyS/QFXH4JNpNwWVtfUVpow+iWDUxsKAmbcbcy+ZGLM1qtnQ==
X-Received: by 2002:a17:902:7e0f:: with SMTP id b15-v6mr14199408plm.246.1538445459694;
        Mon, 01 Oct 2018 18:57:39 -0700 (PDT)
Received: from localhost ([2601:602:9200:32b0:e958:2ad1:68d0:890f])
        by smtp.gmail.com with ESMTPSA id j16-v6sm30655317pfk.125.2018.10.01.18.57.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 18:57:38 -0700 (PDT)
Date:   Mon, 1 Oct 2018 18:57:37 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        gitster@pobox.com, sunshine@sunshineco.com, sbeller@google.com
Subject: Re: [PATCH v3 4/4] transport.c: introduce core.alternateRefsPrefixes
Message-ID: <20181002015737.GF96979@syl>
References: <cover.1537466087.git.me@ttaylorr.com>
 <cover.1538108385.git.me@ttaylorr.com>
 <48eb774c9e36f468549a278fd8cf703d8a34af28.1538108385.git.me@ttaylorr.com>
 <20180928053057.GD25850@sigill.intra.peff.net>
 <20180928220557.GB45367@syl>
 <20180929073426.GC2174@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180929073426.GC2174@sigill.intra.peff.net>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 29, 2018 at 03:34:26AM -0400, Jeff King wrote:
> On Fri, Sep 28, 2018 at 03:05:57PM -0700, Taylor Blau wrote:
>
> > > > For example, to advertise only tags, a caller using
> > > > 'core.alternateRefsCommand' would have to do:
> > > >
> > > >   $ git config core.alternateRefsCommand ' \
> > > >       git -C "$1" for-each-ref refs/tags --format="%(objectname)"'
> > >
> > > This has the same "$@" issue as the previous one, I think (which only
> > > makes your point about it being cumbersome more true!).
> >
> > Hmm. I'll be curious to how you respond to my other message about the
> > same topic. I feel that whatever the outcome there is will affect both
> > locations in the same way.
>
> I think they're separate issues, right? I was just confused on the
> earlier patch, but the "git config" command you show above is the actual
> broken case isn't it?

Ah, I certainly had these mixed up on Saturday when I wrote what is
quoted here. As I understand it now, you were talking about the
difference between $@ and "$@", which I did fix (by rewriting the former
to the later).

> I'm not overly concerned since this isn't recommending the technique to
> end users (and in fact the whole point is to give an alternative), but
> it may be worth showing a working command in case anybody runs across
> it.

Completely agree, and thanks for your review.

Thanks,
Taylor
