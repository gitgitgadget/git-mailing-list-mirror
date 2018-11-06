Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B0ABA1F453
	for <e@80x24.org>; Tue,  6 Nov 2018 17:25:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389625AbeKGCvX (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Nov 2018 21:51:23 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35069 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388987AbeKGCvX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Nov 2018 21:51:23 -0500
Received: by mail-wr1-f65.google.com with SMTP id z16-v6so14473292wrv.2
        for <git@vger.kernel.org>; Tue, 06 Nov 2018 09:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Wd55J9ymQCfnawpcXdQuM5+ALReIuLsnIOlcrirag0s=;
        b=bQszAq8jRi3UcWPDqxXWCmD7ZDjY96wmds+c31Yo2uYzXUa/U+a7y1mKQVjXGKue4W
         WFQCCpMFK73ArtaPvDNIIiIC+/P6GbpyUdtGN6yNKHkX244QlGL8b4fMhpjPAixMmOY/
         nV6yIdGmrfcPaNfy4T1+S+3kMGIh/E57jgzII=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Wd55J9ymQCfnawpcXdQuM5+ALReIuLsnIOlcrirag0s=;
        b=WMOW8xwenVHOL1BQntJKq4oJPKOfZVuirIN/0tUcZlsFB96QXuDivXq6IUJZlRuwwF
         n5jwfspTkYG+a8DgTCJxyiabSUdDFmUbsNqw7JN22n3/un2MeFtcFtXsWXLwxGF0WdbF
         tlmVzXj3mpenDOYC4opxsMAflqZn55ulhUmbFTkbJYz7ktxSFNU+2jqcMvkuawQcBblC
         NmhyFwJhEfXaXDT+sVYu/63wPoIOVtogmN00LAwfbv2CVZxIYvsUjjeNpiOtSavYeJXd
         wFoTIL62gKt0Kw6MOqBlBtqEJP/QlZw0TsL2c5cZymDeEhfP3+84sVoVDrRBFy/87kv0
         jUnQ==
X-Gm-Message-State: AGRZ1gKEfRh69W+GmzuDNyIgVdujq3GiurN+SQTNpy8O6LtHXRF5Esxq
        tnnXyDqartBOVANzNGWtFjFOfCKA4kQ=
X-Google-Smtp-Source: AJdET5diI+1gdQhb4ZHeMzuHLXdw2UvmHkRSIL0HSBakrzFytnOcanbwsKBNsPBy8xuQvkY2jDzIvA==
X-Received: by 2002:adf:93e6:: with SMTP id 93-v6mr22921177wrp.311.1541525108045;
        Tue, 06 Nov 2018 09:25:08 -0800 (PST)
Received: from bivouac.eciton.net (bivouac.eciton.net. [2a00:1098:0:86:1000:23:0:2])
        by smtp.gmail.com with ESMTPSA id b10-v6sm3349263wrt.49.2018.11.06.09.25.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Nov 2018 09:25:07 -0800 (PST)
Date:   Tue, 6 Nov 2018 17:25:05 +0000
From:   Leif Lindholm <leif.lindholm@linaro.org>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, lersek@redhat.com,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] format-patch: respect --stat when explicitly specified
Message-ID: <20181106172505.nw2ugm4yb3gmrnk3@bivouac.eciton.net>
References: <20181106104811.14625-1-leif.lindholm@linaro.org>
 <CACsJy8AjY1-KT9x_CXuo+L3-g947OaC5Av0KwuJF-Xkz6VMiPQ@mail.gmail.com>
 <20181106163118.wkvcjvb7uxjvnryk@bivouac.eciton.net>
 <CACsJy8BGMDqiekYLdStfyxNBsW88HKv9Z_KwKjjGrEQuucnDPw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACsJy8BGMDqiekYLdStfyxNBsW88HKv9Z_KwKjjGrEQuucnDPw@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 06, 2018 at 06:13:00PM +0100, Duy Nguyen wrote:
> On Tue, Nov 6, 2018 at 5:31 PM Leif Lindholm <leif.lindholm@linaro.org> wrote:
> > > > diff --git a/builtin/log.c b/builtin/log.c
> > > > index 061d4fd86..07e6ae2c1 100644
> > > > --- a/builtin/log.c
> > > > +++ b/builtin/log.c
> > > > @@ -1009,7 +1009,8 @@ static void show_diffstat(struct rev_info *rev,
> > > >
> > > >         memcpy(&opts, &rev->diffopt, sizeof(opts));
> > > >         opts.output_format = DIFF_FORMAT_SUMMARY | DIFF_FORMAT_DIFFSTAT;
> > > > -       opts.stat_width = MAIL_DEFAULT_WRAP;
> > > > +       if (rev->diffopt.stat_width == -1)
> > >
> > > I don't think we get -1 here when stat_width is not defined. The
> > > "undefined" value is zero but I'm pretty sure we get MAIL_DEFAULT_WRAP
> > > in here unless you specify --stat.
> >
> > From what I could tell, if nothing is specified on command line,
> > rev->diffopt.stat_width is set to -1 at this point (I assumed by
> > rev->cmd_log_init_defaults(), but didn't go digging).
> 
> I thought the same but could find where cmd_log_.. is called by
> format-patch. I was not even sure if I read the code correctly so I
> ran the command through gdb. It was definitely not called.

Huh...

> > The patched version certainly gives the <= 2.16.* behaviour with
> > --stat and still restricts stat lines to 72 characters without.
> >
> > > So I think you can just drop the below assignment. But if you want to
> > > be on the safe side, check for zero stat_width instead of -1 and set
> > > MAIL_DEFAULT_WRAP.
> > >
> > > > +               opts.stat_width = MAIL_DEFAULT_WRAP;
> > >
> > > How about a test to make sure this will not be broken in future?
> >
> > Sure. Only today was the first time I had a look at the git sources,
> > so some guidance would be most appreciated.
> 
> No problem (and if you don't have time to do it, just say the word and
> I will continue; this is my bug after all)

Weeeell, if you're offering, I would certainly appreciate not having
to dig deeper into this. I've got a patch review backlog the length of
my arm in another project...

> > Should I add a function to t/t4014-format-patch.sh and just put
> > something longer than a/file for the expect template?
> 
> First of all the README file in that directory could give pretty good
> basic instructions.
> 
> Back to this test, I think you could start by copying to a new test
> (the whole "test_expect_success" block, optionally including the
> "expect" file creation too), add --stat there and see what it looks
> like. For stat testing, t4052 could also be a good example. Or perhaps
> the test should be added in t4052 because it already supports long
> file name ($name is 120 char long).

(Thanks!)

/
    Leif
