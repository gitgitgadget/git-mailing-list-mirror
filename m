Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D923F1F404
	for <e@80x24.org>; Wed, 14 Feb 2018 21:24:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031225AbeBNVYn (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 16:24:43 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:37942 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031276AbeBNVYl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Feb 2018 16:24:41 -0500
Received: by mail-pg0-f66.google.com with SMTP id l24so2573355pgc.5
        for <git@vger.kernel.org>; Wed, 14 Feb 2018 13:24:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=V74KbGeM2q85h8I7vGyxCvRGxT9NGA/oI8A8bNOdodg=;
        b=NhGuygwekHtaiYyQr90XZtUSBtQ3PgmRDMdSw0YTYDQL87YbitlttQta+BonA+zY/s
         GWo2Gqg/z4xKJmP85v1CurXByAlouNotConilEtuxXfX07fn2VJr1J84Xme4oQNy43x1
         JZUiPdtIE9420ReoGOZ2s2MRABenG0binY/HtGz6aqIGvz9x1/ak/oD/ss2CMK9YkQ1o
         +ElQkpK0rvuVaJomrreDiNdPi5jYQCR5Rk7cTudR964bbUEhLmF/2HE5aTRvOVKRFhGU
         7O+rulnbDtYeGhAd1g9HP2MiEAjFeCPyhWhW9CXEzUw+AXjVNaq7YqnlOA/9sch4XSbA
         wWqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=V74KbGeM2q85h8I7vGyxCvRGxT9NGA/oI8A8bNOdodg=;
        b=CGpQrQ8NgAg0+txejCRaaD5EUEHg/VTOaXV0WSB1y7GydhdTucXEy2ad/kt2yOfmu5
         0g3KzG+peuAXrCxtSNt76jkA2T8Z4WYi9OyiIbcSjjQZ8xiBq6ophZBpaoqwXOEzrGqH
         n1uGF4Jl7VQNQljw8KKeXp01RgTtzeSbL9mjJvxf0Xq63T96opm+atrTOWLzRzjyPBQu
         SIZJolVMudU/S3lTVvISeOAjZg0GbuWlkCs9Ah0OSrNoYANkBlxVOLQzwRxhes21G6My
         igMDqyiJ6r26cNK8PM44LyFniR2g9/FKPQRzLYbUJYXu3aXxxenl9tXId4bDeOy3JNMw
         p/cw==
X-Gm-Message-State: APf1xPB6zawTm/l8Mf4VSEXdvU7RScyGTOeSC7v/j5kMyKHV2Cn6gd5h
        p5xESSVtrt1xROkssoTjUl9mtA==
X-Google-Smtp-Source: AH8x225AXF1oq7o/7navIZP0xQ9Af0uFbE9g9ryOdt4HbMoI2D04fcKDdCKgd17g2SLSVDE6JKhBqw==
X-Received: by 10.98.194.201 with SMTP id w70mr412699pfk.188.1518643480557;
        Wed, 14 Feb 2018 13:24:40 -0800 (PST)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id i27sm11216700pfi.32.2018.02.14.13.24.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Feb 2018 13:24:39 -0800 (PST)
Date:   Wed, 14 Feb 2018 13:24:38 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, j6t@kdbg.org, sbeller@google.com,
        avarab@gmail.com, pclouds@gmail.com
Subject: Re: [PATCH v2 06/37] diff: rename 'this' variables
Message-ID: <20180214212438.GC139458@google.com>
References: <20180129223728.30569-1-bmwill@google.com>
 <20180214185959.221906-1-bmwill@google.com>
 <20180214185959.221906-7-bmwill@google.com>
 <xmqqh8qjmfq5.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqh8qjmfq5.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/14, Junio C Hamano wrote:
> Brandon Williams <bmwill@google.com> writes:
> 
> > Rename C++ keyword in order to bring the codebase closer to being able
> > to be compiled with a C++ compiler.
> >
> > Signed-off-by: Brandon Williams <bmwill@google.com>
> > ---
> 
> The patch is not as bad as renaming "this" and leaving "that" behind
> but in the original, "this" and "this_dir" were treated as a pair.
> "this" was a score for a single item in the directory, "this_dir"
> was the sum of these scores for entries in the directory.
> 
> So renaming "this" to "sum" and leaving "this_dir" as-is looks like
> readability regression.  Perhaps replace "this_dir" with "sum_changes"
> and "this" with "changes" instead, or something like that?

100% agree.  I tried to spend time on each of these changes to come up
with a meaningful name, but sometimes wasn't able to understand the
section of code (with the limited context I had with some areas) and
wasn't able to come up with the best name.  I'll change this.

> 
> >  diff.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/diff.c b/diff.c
> > index 0a9a0cdf1..d682d0d1f 100644
> > --- a/diff.c
> > +++ b/diff.c
> > @@ -2601,7 +2601,7 @@ static long gather_dirstat(struct diff_options *opt, struct dirstat_dir *dir,
> >  	while (dir->nr) {
> >  		struct dirstat_file *f = dir->files;
> >  		int namelen = strlen(f->name);
> > -		unsigned long this;
> > +		unsigned long sum;
> >  		char *slash;
> >  
> >  		if (namelen < baselen)
> > @@ -2611,15 +2611,15 @@ static long gather_dirstat(struct diff_options *opt, struct dirstat_dir *dir,
> >  		slash = strchr(f->name + baselen, '/');
> >  		if (slash) {
> >  			int newbaselen = slash + 1 - f->name;
> > -			this = gather_dirstat(opt, dir, changed, f->name, newbaselen);
> > +			sum = gather_dirstat(opt, dir, changed, f->name, newbaselen);
> >  			sources++;
> >  		} else {
> > -			this = f->changed;
> > +			sum = f->changed;
> >  			dir->files++;
> >  			dir->nr--;
> >  			sources += 2;
> >  		}
> > -		this_dir += this;
> > +		this_dir += sum;
> >  	}
> >  
> >  	/*

-- 
Brandon Williams
