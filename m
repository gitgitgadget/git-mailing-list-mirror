Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 157BB20954
	for <e@80x24.org>; Fri,  1 Dec 2017 21:47:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751390AbdLAVrN (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Dec 2017 16:47:13 -0500
Received: from mail-io0-f170.google.com ([209.85.223.170]:35410 "EHLO
        mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751169AbdLAVrN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Dec 2017 16:47:13 -0500
Received: by mail-io0-f170.google.com with SMTP id q15so12782829ioh.2
        for <git@vger.kernel.org>; Fri, 01 Dec 2017 13:47:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ASNqyJStlIVNbHbEqeXe0EHeLKtXilnCjxyD87TMIMo=;
        b=Og9WeVLO1s30u440EAI0+o5EfqEdZeIAKHZ5SXqkwIlxehilCjYkVO+iLikbcnAlyP
         0rVZ7VSos0835ZOOtX7drwK+nsrvSkJRLZx62e/FWx7gyHyezP5w4/M7kh4w7z67sWg5
         +gx2ixzzQh2Ls71ox/FviM4zjgfc8M7HMQSIHt0JEp9U3Mkoqw3YFLdpUHCs5pR+LWzb
         ZPHwJ/SM9xVxG9dsskIOrFHs6YLrM8C9p5O2D4BkkMHuCTE6bi74r8PWcXANidpjVKOc
         LGOk3m+qg3q7B0ZeG4Iz8I+/qzzTIWi1qDueKpc+7jcwDGp5OeQ1TdSLvLOma099zZK/
         Vzwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ASNqyJStlIVNbHbEqeXe0EHeLKtXilnCjxyD87TMIMo=;
        b=j+TC21UUYQ1QMPKujZAJcUIBetlLFbbBpVyPHV1zFEBozdyv9m6JuyJPBERvoGPnZ4
         mWtMnKxC8YwHzk5Z+eAco+0MJOs0qi05nbv5yxOZGEgww3Yy9bpuhwAQtaVjgc1sqaXW
         imDgiEAiGB6OrgSkBjXBOit9Mh/GdbuXBy9ITT1bkNrFr2JdG/49XCTChU1q6yCLbZaI
         9YGLW846fE23qsfSuZwsp9zJrlMA+zCJd/btqb6/X2QRHKfu1qxSLZBzWQYqIKhnAH5b
         QnMSrTyH51nmjpfnYx5waAoZemJQ9da8lCaMsaGAZLkeZUgf8zEuu5CvzBnjzrXsQcfQ
         eyrQ==
X-Gm-Message-State: AJaThX58LnUcPRRHTUbtmguCvlBp5FjqG3u0M+cbAwX8bOkpHTbsuMTD
        nsxP+4Uu6g/0VStxRW8KuxA1Ww==
X-Google-Smtp-Source: AGs4zMabboKIRCkBDs1tnIL/vnTRpHDhE5F+MLjJ81OOUg6nkEkLjZ8d/nvOH6fS3oA02ne+Pwceyw==
X-Received: by 10.107.18.38 with SMTP id a38mr15290346ioj.58.1512164832055;
        Fri, 01 Dec 2017 13:47:12 -0800 (PST)
Received: from google.com ([2620:0:100e:422:c566:3db2:9a4b:28d7])
        by smtp.gmail.com with ESMTPSA id j185sm1078326itd.2.2017.12.01.13.47.10
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 01 Dec 2017 13:47:11 -0800 (PST)
Date:   Fri, 1 Dec 2017 13:47:09 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Ralf Thielow <ralf.thielow@gmail.com>
Cc:     git <git@vger.kernel.org>, Stefan Beller <sbeller@google.com>
Subject: Re: git-clone ignores submodule.recurse configuration
Message-ID: <20171201214709.GA61710@google.com>
References: <CAN0XMOJnQX-gSnpHaiJUYr4X4-WT91oT3Xv3gDtKYjX7J3ObVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAN0XMOJnQX-gSnpHaiJUYr4X4-WT91oT3Xv3gDtKYjX7J3ObVw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/01, Ralf Thielow wrote:
> Today I played around a bit with git submodules and noticed
> that the very handy configuration "submodule.recurse" is not
> working for the git-clone command.
> 
> "git help config" tells me that submodule.recurse affects
> all commands that have a --recurse-submodules option.
> git-clone seems to be an exception which is also mentioned in
> a workflow example in Documentation/gitsubmodules.txt that
> says:
> 
>   # Unlike the other commands below clone still needs
>   # its own recurse flag:
>   git clone --recurse <URL> <directory>
>   cd <directory>
> 
> So this seems to be a known issue. Is someone already
> working on this or has a plan to do it? Or is there a reason
> not doing this for git-clone but for git-pull?

When we introduced the "submodule.recurse" config we explicitly had it
not work with clone because a recursive clone ends up pulling data from
other sources aside from the URL the user explicitly provides.
Historically there have been a number of security related bugs with
respect to cloning submodules so we felt it was best to require a
recursive clone to be requested explicitly, at least for the time being.

-- 
Brandon Williams
