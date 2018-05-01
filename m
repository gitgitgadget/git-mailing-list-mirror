Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FAF0215F4
	for <e@80x24.org>; Tue,  1 May 2018 16:09:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755600AbeEAQJQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 12:09:16 -0400
Received: from mail-wr0-f181.google.com ([209.85.128.181]:43842 "EHLO
        mail-wr0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753851AbeEAQJP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 12:09:15 -0400
Received: by mail-wr0-f181.google.com with SMTP id v15-v6so11218799wrm.10
        for <git@vger.kernel.org>; Tue, 01 May 2018 09:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zz3vvilsBXGg2O8Sq/q1srnlBrl/qjUb22dEn9LfV58=;
        b=tirQhxNZeak0BRe52Bt3SDnfvrAqCDljDCrWmC2tz3SRZCz3SqtGuAv43pONcgtr92
         AM8e49//6vqEtyJaYreI5b9M6uhfIdsOusNJeLCu6nD4L6ebRJO+SeZg/3r55DvEN1H5
         D/WgkESe1/jUUAF6Fe7WNZBNNx161YTFzXZ0gKYiYnRsL332dRwyVnNi5NWnbhhcQEvk
         6cBdWt9HpdbGjxWU189S3VK+tl0VD8dscJ/ZSh7jYe/pFmRXioz7uw5lDWgSkzTdzfrr
         46TljN/+5x3+ClryNG/GkVAfnHzDoDPaUWKVt3/RHlOoGkvz3AL+fIogKyUMuerw+mBP
         xm3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zz3vvilsBXGg2O8Sq/q1srnlBrl/qjUb22dEn9LfV58=;
        b=iYhZBdD1+XlPh3vtvnp2ktZjbPmVLsnGd6RtJ+awcZtgvWqO/hzHl4W5XDPnH+qx0W
         YbzSoeOwjCDe9Tohb/j+O6KN4y+CH2YiJiNuj5P2g50/ppvm57VwxTu+SWFtFvpkcje9
         SA6fqZ8EILTZKjqDwhZ3BBQCWYpsan2qxn7M+QghJDYFemxLhs3iEtaYlZKB4la/p6Vw
         9nGCXqWp3TdefOtJwVXNForOQWuQSY+F2UtpnMUMHNwpl0y163dpH1FlthD60Tf4nQby
         XGSahF4HYNAERtQyUs+PyVTlhWK8vnEIwA3UEw4q2J8KQpjNxUkTyE5FtgQnZz3biRs3
         JDYA==
X-Gm-Message-State: ALQs6tDSlFUlnj95tY+zhiQkTHafGASOihko9u3nDe+Rfxpz14lvd6W/
        0mKozveuCgIwcGrej52Nnmc=
X-Google-Smtp-Source: AB8JxZpOOBS2g9cYhVzpGTw8oCVK3y1FcRYbV2ySa59Hgfb7mgm5rSPapdfNRK7ea+hi1Z0WSJvYyQ==
X-Received: by 2002:adf:8505:: with SMTP id 5-v6mr4875656wrh.77.1525190954318;
        Tue, 01 May 2018 09:09:14 -0700 (PDT)
Received: from esm (ipbcc18eac.dynamic.kabel-deutschland.de. [188.193.142.172])
        by smtp.gmail.com with ESMTPSA id l69sm8058777wmb.6.2018.05.01.09.09.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 May 2018 09:09:13 -0700 (PDT)
From:   "Eckhard =?iso-8859-1?Q?Maa=DF?=" <eckhard.s.maass@googlemail.com>
X-Google-Original-From: Eckhard =?iso-8859-1?Q?Maa=DF?= <eckhard.s.maass@gmail.com>
Date:   Tue, 1 May 2018 18:09:11 +0200
To:     Matthieu Moy <git@matthieu-moy.fr>
Cc:     Eckhard =?iso-8859-1?Q?Maa=DF?= <eckhard.s.maass@googlemail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        Ben Peart <peartben@gmail.com>
Subject: Re: [PATCH v2] wt-status: use rename settings from
 init_diff_ui_defaults
Message-ID: <20180501160911.GA14477@esm>
References: <c466854f-6087-e7f1-264a-1d2df9fd9b5a@gmail.com>
 <50c60ddfeb9a44a99f556be2c2ca9a34@BPMBX2013-01.univ-lyon1.fr>
 <907020160.11403426.1525172946040.JavaMail.zimbra@inria.fr>
 <20180501114316.GB13919@esm>
 <1652522802.213664.1525177431907.JavaMail.zimbra@matthieu-moy.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1652522802.213664.1525177431907.JavaMail.zimbra@matthieu-moy.fr>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 01, 2018 at 02:23:51PM +0200, Matthieu Moy wrote:
> I'm fine with it as-is. Before your "fix", the config was ignored
> because overwritten by init_diff_ui_defaults() after reading the
> config, so effect of your change is indeed what the commit message
> describes.
> 
> I'm often thinking aloud while reviewing, don't take my comments as
> objections.

No worries, I was wondering while writing the patch to extract it - the
init should be changed to the appropriate location even if there is
consensus to leave all the other knobs as they are, shouldn't it?

Greetings,
Eckhard
