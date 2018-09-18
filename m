Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82D541F453
	for <e@80x24.org>; Tue, 18 Sep 2018 21:11:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730048AbeISCp5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Sep 2018 22:45:57 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41510 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726821AbeISCp5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Sep 2018 22:45:57 -0400
Received: by mail-wr1-f67.google.com with SMTP id z96-v6so3578558wrb.8
        for <git@vger.kernel.org>; Tue, 18 Sep 2018 14:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MkQ3+oc4nZvRwz4WxiXlEtQhr19/snflbYx+Sk91O+U=;
        b=Hk4ZhwGaLXecUPVm89mGuYZgoEsCwB+hIqSIOHWf2oRwkO6UHamMsjy1gopG6u07pi
         3Ge+55IT11rE6sXwfDU1XALFsxNF34yQuztbkTIEiJjPkrIa97eKjDGLy8Pe729S6PRv
         EajPt7DSgz0qygCewf4KF1Jzjeibkloip89xyMlO4U/xqNhYIvf+jj4sz+BQ8WQgsrD0
         YhvKrx5opTqMAhT1H9KLUB1WlXIoBjSPSwWcJJR/BiipWNHU2d2D+rSydOdZP/Fc6yUo
         cd4ZIMJwG5OPR0/BsQs6xzW+fASM5O20BsWsD8eSV312Ye/AVBvcGcSkvt5RrQPvfq9l
         DKEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MkQ3+oc4nZvRwz4WxiXlEtQhr19/snflbYx+Sk91O+U=;
        b=fSVz4ijbpV/JyNsPf5Niqh8kFgAsIye5BYM+/1yzUld232lTBtSUaaVf64RobIYyJp
         GK1VoXHS2pY/jRpL4qq+27fkbkH5+mO4jvfCcnvPje0CuY6UQ2nghixC3JgFylWkZMVo
         EhjpruvGApaajLylMsxdvtLrJZ5vNT4DYXJI0ZhASpYP8510yQfmcDXA07naXeQH2orO
         jEyh4z2pps+sC53piLg1aMyKW53RuUJpsWEIQrqb9h6DJ0Xmzxx2/r/xMQyZ99GRrzzo
         mFQ48f1oWXThKJDKscrpopkFJ9MVJL6rnEcDYVK6qwip+5UD93u3UCOCoFYYz4Pmz7Kx
         Cafw==
X-Gm-Message-State: APzg51AsfRY2JMzKODsUnHZIRKXOLr8hulZS3Z89QCKyw7jUag2lgyF9
        mUY/oD+hVgUyXzFQ1wrPDuAyOKJu
X-Google-Smtp-Source: ANB0Vdaek8qpZmyPKozMG0Gch+xkaR9U0E1wre7QBxlBBGNBrFG/WkLdxfikxTnmfp86OMzb6Yhuew==
X-Received: by 2002:a5d:4f82:: with SMTP id d2-v6mr1556696wru.261.1537305091178;
        Tue, 18 Sep 2018 14:11:31 -0700 (PDT)
Received: from esm (ipbcc18976.dynamic.kabel-deutschland.de. [188.193.137.118])
        by smtp.gmail.com with ESMTPSA id v2-v6sm1879675wme.36.2018.09.18.14.11.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Sep 2018 14:11:30 -0700 (PDT)
From:   "Eckhard =?iso-8859-1?Q?Maa=DF?=" <eckhard.s.maass@googlemail.com>
X-Google-Original-From: Eckhard =?iso-8859-1?Q?Maa=DF?= <eckhard.s.maass@gmail.com>
Date:   Tue, 18 Sep 2018 23:11:28 +0200
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 0/1] Make 'git commit' not accidentally lose staged
 content
Message-ID: <20180918211128.GA16961@esm>
References: <20180820154120.19297-1-pclouds@gmail.com>
 <20180916063146.9850-1-pclouds@gmail.com>
 <xmqq1s9s82zx.fsf@gitster-ct.c.googlers.com>
 <CACsJy8C5QOLvg4pzy_pThQoyGh9ohdeVHXsuYwQHQypn3oBxkw@mail.gmail.com>
 <xmqq7ejk6i46.fsf@gitster-ct.c.googlers.com>
 <CA+P7+xq1zMM=S+HBTAfTJcPVo35PtUCq+staQ8SnSXxP0RShXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+P7+xq1zMM=S+HBTAfTJcPVo35PtUCq+staQ8SnSXxP0RShXA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 18, 2018 at 12:41:30PM -0700, Jacob Keller wrote:
> I think having both is good. There are a lot of ways to accidentally
> throw away work, and it's pretty frustrating to have it happen. But
> the reflog is also somewhat complicated, and I've definitely seen a
> lot of developers who've never heard of it, and struggle with the
> concept.

It's definitely good to improve on "oh, I screwed up - how can I
recover?" part. 

> I personally think having the nice "it looks like you're about to
> throw away all your changes, are you sure" style of protection using
> something like --clobber-index is useful as a mode, even if we have an
> index log of sorts.

I don't think it's an appealing design. If we have the index reflog
giving us an undo function, then it is (at least for me) irritating to
have additional protection. Furthermore, this protection, to not break
existing workflows, needs to be configurable. This comes with much
baggage on its own. Having then two things which seem to solve the same
problem setting, but somehow different, is in my opinion even more
confusing in the long run.

Greetings,
Eckhard
