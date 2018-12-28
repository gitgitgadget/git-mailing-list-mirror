Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 852171F45B
	for <e@80x24.org>; Fri, 28 Dec 2018 12:32:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727625AbeL1Mcw (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Dec 2018 07:32:52 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43549 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbeL1Mcw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Dec 2018 07:32:52 -0500
Received: by mail-wr1-f65.google.com with SMTP id r10so20800987wrs.10
        for <git@vger.kernel.org>; Fri, 28 Dec 2018 04:32:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=jO9MSUCgzKPvEVjX4Uc0wtE2XZaU+9Y6bRN5+s+XB3M=;
        b=KRnNDiE8SOtK9GTL6sDgV3gIhmWzAO0nBe0rhik9UZqLBycfuXm1K0DZhNEb+QtJsy
         l8B9oCa22Wt78leQkuh0kd7B4mXj5cJxdyQ/7IySq9wWiDHHnH8xBCOsixpyvF2MMUdf
         Y0jFY3E/M+DSRW23cXkzK15rWlo9ESoEPXHZJsSDWRG21mRx13i9e+0xorV42lISjOx8
         GCuXkUfL7hmDO6OPoIN9h3qPxDZWDsRtNBWaSDcv90Tv3rlm4k8jghgnkCZbjO3C7W5o
         WaqfT2jtKyxXTA6Kx8fI/w+Amhx7aS4cqKZmVGs0WKRvG4DmTXncdMEcP4o3HpZPJ0dj
         06lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=jO9MSUCgzKPvEVjX4Uc0wtE2XZaU+9Y6bRN5+s+XB3M=;
        b=Lxw2zgdqqjHSEvPQh8iHc9i5swhyVV745O7ThwSSJ9ziU40byNHMgdd7k30sfi41b9
         KkXG4FQrNKrCOeDNOcWGakMbV8jr8DAzYeLJpT7AW2lbEdM5cjmzd3xF1zWSsKcUohJf
         PlHsTgnuYAI0YcSWGN8TLh4XZR5L78nnqeaUaYHoMgraTyycTX5AUwipy5oGCDGh/t/+
         A8ClrQhsIWlUFdxDTOf8eTDI+7Yg74u288w0CUA8eJ3PaS9Iwd9vCVE/xL50QHLmSpos
         USzePIwiAMskqegjpXxqjrdSJaDEBqimdh2U7zzyCe7KfuLjoi4KipqTuyCXA0+5bgeP
         zXZQ==
X-Gm-Message-State: AJcUukf70UIxE+bZ7ba/+I86PRxMDwW7n5UhEp7VdAHUQ/hXjK1Fk6+a
        FJd49s9a8XyHAndG12THHc4=
X-Google-Smtp-Source: ALg8bN5ZFaoroBR9NayudR7/LNbOAWqeDHwNfP6RNEEEBPbouFDTQoNcp+BFIve5/+GwgGS8OeuTIQ==
X-Received: by 2002:adf:97d1:: with SMTP id t17mr24901955wrb.283.1546000370331;
        Fri, 28 Dec 2018 04:32:50 -0800 (PST)
Received: from szeder.dev (84-236-109-65.pool.digikabel.hu. [84.236.109.65])
        by smtp.gmail.com with ESMTPSA id o81sm67450225wmd.10.2018.12.28.04.32.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Dec 2018 04:32:49 -0800 (PST)
Date:   Fri, 28 Dec 2018 13:32:42 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Gennady Uraltsev <gennady.uraltsev@gmail.com>, git@vger.kernel.org
Subject: Re: Bug in git-remote
Message-ID: <20181228123242.GA6120@szeder.dev>
References: <650b15f4-5e13-7a83-9f2e-072efc4815e4@gmail.com>
 <20181215130204.GZ30222@szeder.dev>
 <nycvar.QRO.7.76.6.1812171347530.43@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <nycvar.QRO.7.76.6.1812171347530.43@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 17, 2018 at 01:50:56PM +0100, Johannes Schindelin wrote:
> Hi Gábor,
> 
> On Sat, 15 Dec 2018, SZEDER Gábor wrote:
> 
> > On Sat, Dec 15, 2018 at 02:14:56AM -0500, Gennady Uraltsev wrote:
> > > I am on git version 2.20.0
> > > 
> > > $ git remote
> > > 
> > > does not show remotes configured in named files in $GIT_DIR/remotes/
> > >
> > > I do not think that this is the intended behavior.
> > 
> > It's a known bug.  When 'git remote' was rewritten as a builtin
> > command in C in commit 211c89682e (Make git-remote a builtin,
> > 2008-02-29) the parts dealing with remotes under 'GIT_DIR/remotes/'
> > were not rewritten.  I don't know whether that was intended or not,
> > but storing remote information as configuration was about two years
> > old back then.  Given that since then '$GIT_DIR/remotes/' got marked
> > as "This mechanism is legacy and not likely to be found in modern
> > repositories", I'm not sure it's worth fixing.  Perhaps it's time for
> > calling it deprecated.
> 
> I would be in favor of deprecating it, and then removing it.
> 
> However, when I tried a similar thing with the completely obsolete
> `$GIT_DIR/branches/` feature, it was shot down IIRC on the mere suspicion
> that there was a single remaining user among the Linux kernel lieutenants.
> 
> And I fear that the suspected workflow of that lieutenant involved having
> those legacy remotes, too.
> 
> Hopefully this issue will be resolved somehow, as it is not exactly a
> splendid idea to keep a legacy feature of a software used by millions,
> just for a single user, I would think.

Well, even if we don't remove support for '$GIT_DIR/remotes/', we
could still mark it as deprecated in the documentation, so hopefully
it won't gain any new users, and users won't waste time digging and
writing bugreports like this.

When, if at all, and how we'll progress beyond that is a separate
question.


Gábor

