Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2909120248
	for <e@80x24.org>; Fri, 29 Mar 2019 19:42:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729981AbfC2TmH (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Mar 2019 15:42:07 -0400
Received: from mail-wr1-f48.google.com ([209.85.221.48]:33855 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729652AbfC2TmH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Mar 2019 15:42:07 -0400
Received: by mail-wr1-f48.google.com with SMTP id p10so3992710wrq.1
        for <git@vger.kernel.org>; Fri, 29 Mar 2019 12:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iGnA2xVsSPkjJWN5h7W7+bluYDf9MjI3a56lg3q8X/U=;
        b=B2KHBZyddsnYZnU2pypcgEIESM3gjlRcMnJBnqMg8JoedFgng90n8XTuXCYJXMEXKE
         296A22NgQBqQR2SZKqe+w/hF6Xqo2grs577+V1xXPCejs8Scc9wyRWfRVWlA+ojBhivb
         fFB4NqwBqMC/HYoRLs7jTN9Fo3Zm3c6GyyYMm3wqaYM/eh4Fx2bt7d8bIsDbGaujrTuT
         2EoIphR1EXjswJyE/bYTw/fn5aVqljhlRXCf9gtRm8PGJYEfEIFoJF6CakwtjewOWC95
         m03o6kjQuSoV9m4jr7zkRsDoK9gHmWO6xuisP8Ck3Nq2lrqn56l0Y8z2HdhGhWBaFs3e
         pSlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iGnA2xVsSPkjJWN5h7W7+bluYDf9MjI3a56lg3q8X/U=;
        b=E8/SEb2ba/9qtwX1NX6IlPm101rgEhh+zqRrIofetiSpKD7olU9l1cU+AE+czwAAjB
         RBybxhbTcWJiPM/3zOsaR6hDMuErsxo2RSsTUJzc62cRs84+DysL5x5ozB4ZhON2Bndt
         iFBgmvpj9NdypCwC4kZTIZuMrFt2sLCeeBXtmNBWRwNupbWacMpzvOjKp+DjjDwzpH7W
         7cD1wb5jo/WNW/HGjBPip+OsQMUNNm4RZRWz1qRGZg1KwclL55Jt8exB7j9uuOrXWJvb
         /vHnHLwN0hVJ5CPRFLZwzLSSA8XveXKtj8zafO5x2rfHK50vEqesYj14iXyAL+lEw6Ah
         A3Mg==
X-Gm-Message-State: APjAAAV3MJk4/cmUwqZKzXPxLP8M8a8fzuSOS+i/sIyDhsOyNQjQvWKF
        T+xnb6EAYNU8QdcVF+zBE6U=
X-Google-Smtp-Source: APXvYqyD33qZ9ofnptLskTVdpMDljvsxf657BLboXEeEaTMCcL8D6XVaz5RU+VP/NvUrEiBrd866lw==
X-Received: by 2002:adf:f48d:: with SMTP id l13mr34729739wro.2.1553888525644;
        Fri, 29 Mar 2019 12:42:05 -0700 (PDT)
Received: from szeder.dev (x4dbd3bb2.dyn.telefonica.de. [77.189.59.178])
        by smtp.gmail.com with ESMTPSA id w16sm4391688wrt.84.2019.03.29.12.42.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 12:42:04 -0700 (PDT)
Date:   Fri, 29 Mar 2019 20:42:02 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        git <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Kernel USP <kernel-usp@googlegroups.com>,
        Alex Riesen <raa.lkml@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [GSoC][PATCH v4 1/7] clone: test for our behavior on odd
 objects/* content
Message-ID: <20190329194202.GG32732@szeder.dev>
References: <20190226122829.19178-1-avarab@gmail.com>
 <20190322232237.13293-1-matheus.bernardino@usp.br>
 <20190322232237.13293-2-matheus.bernardino@usp.br>
 <20190328214950.GJ32487@hank.intra.tgummerer.com>
 <CAHd-oW70VNgYmX9=5x0CwoSD2a0ik2AoJyd7T3xiO4O030c5yQ@mail.gmail.com>
 <20190329193158.GN32487@hank.intra.tgummerer.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190329193158.GN32487@hank.intra.tgummerer.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 29, 2019 at 07:31:58PM +0000, Thomas Gummerer wrote:
> >                                             Also every test and job is
> > passing at travis-ci, except by the job named "Documentation"[1]. But,
> > it's weird since these patches don't even touch Documentation/... And
> > master is failing the same job at my fork as well [2]... Any thoughts
> > on that?
> 
> Yeah, this error seems to have nothing to do with your patch series.
> Since the last run of travis on master [*1*] at least the asciidoc
> package doesn't seem to have changed, so from a first look I don't
> quite understand what's going on there.

https://public-inbox.org/git/20190329123520.27549-6-szeder.dev@gmail.com/

