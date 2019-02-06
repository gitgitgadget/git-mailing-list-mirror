Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.2 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,URIBL_DBL_SPAM,URIBL_RED shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 850311F453
	for <e@80x24.org>; Wed,  6 Feb 2019 00:16:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727399AbfBFAQC (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Feb 2019 19:16:02 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:46504 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727004AbfBFAQC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Feb 2019 19:16:02 -0500
Received: by mail-qt1-f194.google.com with SMTP id y20so6030630qtm.13
        for <git@vger.kernel.org>; Tue, 05 Feb 2019 16:16:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=BPgwdCRZ2BXenjSb2SrTshESHRa3YnI8RD89BM9aM2Q=;
        b=TdsAUm/CQZ74k0yW5BVt5g0wlHpe90aRNa0tTZdSdMTaDKylInzB94i1zGR51Z2kjq
         ZeLViWY/dXtkFZjOMG2aKE/7K7yBku/4+jVo9mgas32aLv2I+UoTG+ev6mRo8cBFyCDE
         Y7JkTzC2qJSgPzV2e4i0asmnz8ecRYWXEOoADyxq7S/q7z9naFhfhtHTUI/QpWa3J4La
         S/GQAt4joFbIQ1dU2s5YuauhbbR1FyoV3+lcubhTakCnlSU/zRHEH9qsOPHUvmdUkzVa
         cbJ0DO6ghPrY2Vd3HU64miIAQq7U/kfIMsiHY48fSv+LhszNP/fKmZE/BGam/VHtxXTw
         CYSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=BPgwdCRZ2BXenjSb2SrTshESHRa3YnI8RD89BM9aM2Q=;
        b=sX8+8ENKffFA83+mlkF5A0/9V4PnmzhwRw4BVcp5yk8O7+HpCsk7JEoiZaqZoQBNcm
         NGs25TqXIqn5mSZGImAXisPFplEupCFLznigNftWNDYrbR/1WEn2f7nH1IjAh5gh2fXc
         6lOECwWl6F1fVtvW4WsU5MtxV/s/0uP7MSpglsDES3aLJgf44xShZw3Vqes7jyxsAGAs
         up2vdd0UKTkYBpgU8kzHvzKI4S8W13NNyl460LTSGSf+0oShHc7LbBXHkr/eiSXXEcYC
         9f8o+9rTgwjQRe3y3qEbj0CXeg7dBiktSSNpskyibQPn+Fugvf1eSVzIxtHu+yENWmQC
         gAaw==
X-Gm-Message-State: AHQUAuYVOKNjNLggY+v9EuSnlDCq1mnVV/5A9Oj595Z4grtmwMGz8k/E
        avU4vE0ZiLwzd3dDhyEWPUs=
X-Google-Smtp-Source: AHgI3IaOFg7mUirs4i8+HhhFHsC25rW7ZMI5sy84ylUk3m0XGJIW8hLgp3/x9Q8zvr4GRVhvZIWfOQ==
X-Received: by 2002:ac8:3078:: with SMTP id g53mr5684569qte.77.1549412160913;
        Tue, 05 Feb 2019 16:16:00 -0800 (PST)
Received: from whubbs1.gaikai.biz ([100.42.103.5])
        by smtp.gmail.com with ESMTPSA id k22sm14197322qtm.73.2019.02.05.16.15.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Feb 2019 16:15:59 -0800 (PST)
Received: (nullmailer pid 795 invoked by uid 1000);
        Wed, 06 Feb 2019 00:15:58 -0000
Date:   Tue, 5 Feb 2019 18:15:58 -0600
From:   William Hubbs <williamh@gentoo.org>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        chutzpah@gentoo.org, williamh@gentoo.org
Subject: Re: [PATCH v6 2/2] config: allow giving separate author and
 committer idents
Message-ID: <20190206001558.GB734@whubbs1.gaikai.biz>
References: <20190204184850.10040-1-williamh@gentoo.org>
 <20190205195212.25550-3-avarab@gmail.com>
 <xmqqef8mrnnj.fsf@gitster-ct.c.googlers.com>
 <87k1iekkea.fsf@evledraar.gmail.com>
 <20190206000413.GA734@whubbs1.gaikai.biz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190206000413.GA734@whubbs1.gaikai.biz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 05, 2019 at 06:04:13PM -0600, William Hubbs wrote:
> On Tue, Feb 05, 2019 at 10:14:37PM +0100, Ævar Arnfjörð Bjarmason wrote:
> > 
> > On Tue, Feb 05 2019, Junio C Hamano wrote:
> > 
> > > Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:
> > >
> > >> +static int set_ident_internal(const char *var, const char *value,
> > >> +			    struct strbuf *sb, const int flag)
> > >> +{
> > >> +	if (!value)
> > >> +		return config_error_nonbool(var);
> > >> +	strbuf_reset(sb);
> > >> +	strbuf_addstr(sb, value);
> > >> +	author_ident_explicitly_given |= flag;
> > >> +	ident_config_given |= flag;
> > >> +	return 0;
> > >> +}
> > >> +
> > >> +static int set_ident(const char *var, const char *value)
> > >> +{
> > >> +	if (!strcmp(var, "author.name"))
> > >> +		return set_ident_internal(var, value, &git_author_name,
> > >> +					  IDENT_NAME_GIVEN);
> > >> +	else if (!strcmp(var, "author.email"))
> > >> +		return set_ident_internal(var, value, &git_author_email,
> > >> +					  IDENT_MAIL_GIVEN);
> > >> +	else if (!strcmp(var, "committer.name"))
> > >> +		return set_ident_internal(var, value, &git_committer_name,
> > >> +					  IDENT_NAME_GIVEN);
> > >> +	else if (!strcmp(var, "committer.email"))
> > >> +		return set_ident_internal(var, value, &git_committer_email,
> > >> +					  IDENT_MAIL_GIVEN);
> > >> +	else if (!strcmp(var, "user.name"))
> > >> +		return set_ident_internal(var, value, &git_default_name,
> > >> +					  IDENT_NAME_GIVEN);
> > >> +	else if (!strcmp(var, "user.email"))
> > >> +		return set_ident_internal(var, value, &git_default_email,
> > >> +					  IDENT_MAIL_GIVEN);
> > >> +	return 0;
> > >> +}
> > >
> > > In the v5 patch from William, author_ident_explicitly_given and
> > > committer_ident_explicitly_given were set separately depending on
> > > what variable was given (e.g. user.name marked both, author.name
> > > marked only author but not committer_ident_explicitly_given).  In
> > > the original before the addition of this feature with v6, giving
> > > user.name would have set both, as we can see below.
> > >
> > > Is this change intended?
> > >
> > > Or did you find that committer_ident_explicitly_given is no longer
> > > useful and the variable is not used anymore?
> > 
> > No, that's a mistake of mine when porting this over, but also clearly a
> > blindspot in our tests since they all pass with this.
> > 
> > I haven't dug (don't have time right now) to check what the effect of
> > that is. William?
> 
> I attempted to save your patches to apply them, but didn't have any luck

More info here. I use mutt and when I tagged the patches and saved them
to a mailbox, they went to a mailldir type folder, and "git am" didn't
seem to like that, but I'll try again.

> Also, according to Junio's report, my patch is already merged to next,
> so if you give me your patch based on that, I'll take a look, but it may
> be a day or so.

Sorry, I misread, my patch is not in next.

But, Junio's discussion above is why I didn't make this change. I don't
know the code base all that well, so I didn't want my first patch to
possibly introduce regressions. :-)

William
