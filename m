Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 20E161FF72
	for <e@80x24.org>; Tue, 24 Oct 2017 18:14:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751548AbdJXSOU (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Oct 2017 14:14:20 -0400
Received: from mail-io0-f170.google.com ([209.85.223.170]:53255 "EHLO
        mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751407AbdJXSOT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Oct 2017 14:14:19 -0400
Received: by mail-io0-f170.google.com with SMTP id 189so24850896iow.10
        for <git@vger.kernel.org>; Tue, 24 Oct 2017 11:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=spfDQhBKoOLB2H8Y33M9UxsgpUJUVwoGXwBvxocaGt0=;
        b=izzBm5dVM4RmGUX/8YWII4ReZj9Z6nISrTFOgK2O3ICzP0e0qm949wtCBorbsOb7qM
         IS3K2Q8hHdjWdPYSL2x3GVUU8Dd9WT5aOENpFigAgN9NVAXEp9v2PzqvA9rN2MOQpJpD
         X78g996iFqeqlWwt8sgBjnB/5qRnUoBYD4cmmTXo5J0iqlT4MropgjkgFS3Ox8YWDExU
         TkoOhP/CiPTnv57BA8V6ajj8fJEgWFaZenE+ri/XFfStAcgYeatrNtFtnhjkofoTnSAS
         5FdpsjwX1g3g3kVFEMeT+xrU1YhDC51kiJV22BPQL2O1qOlr9Tz/QX9ZH8Q4hSzd2b2U
         KGKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=spfDQhBKoOLB2H8Y33M9UxsgpUJUVwoGXwBvxocaGt0=;
        b=IbkGmhwGewKfCdD81LBbw89ctqVAYkhBrDNvk/n8GhQHWWAHDK/w93ai/Ysw8o5SpF
         w8xswpaKFxYHonYCn13bFFUDAEb1KSvIOjXqiv4dh71PpPyOHxKja7G6TZU1z4ZV3u8W
         TBYI3A6r0vM/f4HTEWniHuNv4KCrMayC3Ilmsuy8y8Sw0VRxo639qBVvwATsienschj/
         jes+TwA9A3aSEtRyRaX2/idLb6H2pvLu0e5huv3FxDSTgebgSB9/Hv0f3Xv0De1Njebv
         sLib+z43u5wF6W93nF4GCZQRnKEdaNsJhoHyD9x4hJHIW9ErQZyLBpUPQtgPB+/+u0YO
         Q9eA==
X-Gm-Message-State: AMCzsaUuXOYNMpiDNdi755BUc95TbonNgQnMeRzco/pZiw0bEQgRz5+G
        EAsvt728QACwJ8MZNrHRgq0=
X-Google-Smtp-Source: ABhQp+TJ6vCzS33+niscJiSotKSyShC0Fmy3PCkrGuwessVN2cc1jO6aJNuIMnyXe6PR0LKBJao1Uw==
X-Received: by 10.107.83.22 with SMTP id h22mr24218347iob.40.1508868859073;
        Tue, 24 Oct 2017 11:14:19 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id b13sm359450iod.16.2017.10.24.11.14.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Oct 2017 11:14:18 -0700 (PDT)
Date:   Tue, 24 Oct 2017 11:14:15 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: Consequences of CRLF in index?
Message-ID: <20171024181415.3tvmc36aqi335v66@aiede.mtv.corp.google.com>
References: <D0A67AD8-2D63-4683-9F2A-20B0E8E65D4B@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D0A67AD8-2D63-4683-9F2A-20B0E8E65D4B@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Lars Schneider wrote:

> I've migrated a large repo (110k+ files) with a lot of history (177k commits)
> and a lot of users (200+) to Git. Unfortunately, all text files in the index
> of the repo have CRLF line endings. In general this seems not to be a problem
> as the project is developed exclusively on Windows.

Sounds good.

> However, I wonder if there are any "hidden consequences" of this setup?
> If there are consequences, then I see two options. Either I rebase the repo
> and fix the line endings for all commits or I add a single commit that fixes
> the line endings for all files. Both actions require coordination with the
> users to avoid repo trouble/merge conflicts. The "single fixup commit" options
> would also make diffs into the past look bad. Would a single large commit have
> any impact on the performance of standard Git operations?

There are no hidden consequences that I'm aware of.  If you later
decide that you want to become a cross-platform project, then you may
want to switch to LF endings, in which case I suggest the "single
fixup commit" strategy.

In any event, you also probably want to declare what you're doing
using .gitattributes.  By checking in the files as CRLF, you are
declaring that you do *not* want Git to treat them as text files
(i.e., you do not want Git to change the line endings), so something
as simple as

	* -text

should do the trick.  See gitattributes(5) for details.

I'd be interested to hear what happens when diff-ing across a line
ending fixup commit.  Is this an area where Git needs some
improvement?  "git merge" knows an -Xrenormalize option to deal with a
related problem --- it's possible that "git diff" needs to learn a
similar trick.

Thanks and hope that helps,
Jonathan
