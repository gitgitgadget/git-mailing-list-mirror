Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69A6720248
	for <e@80x24.org>; Wed,  6 Mar 2019 23:42:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726010AbfCFXmo (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Mar 2019 18:42:44 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37452 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfCFXmo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Mar 2019 18:42:44 -0500
Received: by mail-pg1-f196.google.com with SMTP id q206so9688125pgq.4
        for <git@vger.kernel.org>; Wed, 06 Mar 2019 15:42:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nLYx2mM8Gqa3an5kHROTSiTDOJuizYDQf7RuJ/wDH2o=;
        b=gpDWnzHa90uyQA+AqHim0ePC2aahsC6pxpCFmuTWrBiJgvqVPi3pzxH1jUaa2XBEUz
         DhlmM6h7WxhyRmXz2aFy9iOqKwPezvUYwp6qotBrYGb6YhrKhGDN2s2aBnOX2b2xA6C0
         w93xNcklUihYLqqLJcxkuUICRhw875UAYeoMtgtUanrG87Xd9hnOruD+5uDEqms3sOCx
         ltFwq4uN8PfG0MrsnHG9oCXGJAgGJgFCT4uAzNo4DxAj+xMf5aaxEnIe5NDBK7O4khLn
         LKp0EEfc7LgsOJQwuJSLustom5/9g++Y3lbF3sv4dPGjFNp5fQSkC8VlmnBh66UwJfAS
         d3ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nLYx2mM8Gqa3an5kHROTSiTDOJuizYDQf7RuJ/wDH2o=;
        b=YNS3IcPqdC1Mz+GYoIBVayCGwhr+ltN5KuiBC73T+9xfi82bZIxkk5MOMton3hqn7r
         tZj8g83mS5g0HL6KQBbCroKPZjc+9oOK4R64+QjaRtwVq9tMhe54PJFxJMc6e9Fy26Cx
         8UnpoPuGD0RuBrUVMsFdBxtad2d5JSbeFgfgbM5uW79fsIN+RYT+6DxiXqKLryE+DEri
         pNaUDZv9s/tgBqlJZyuBCktr51FhISOQycmeJ7jKjJPk3JTDqkHg8RLZDZ3XrcEx87nx
         7ulHpH2ZNwUG7jVp2M4ZCdcOmLX24vxlUJSIImou0yIIdXFdgHYSNb8uJjXtgM5KMW9/
         Cosg==
X-Gm-Message-State: APjAAAUxmSZwZ1o9Mwkg6Yu95vmWEzDHTt2WONigHnt3JH47ZCCuwnZ9
        694O5H9B04ZKBNG4YGvPuir0PA==
X-Google-Smtp-Source: APXvYqzwP8xynll9VAeGojduqii53HqqUZPVPgKLYwqlnHOLLE4Qg/p3RHJewpwfOHS66MlSwaL5pg==
X-Received: by 2002:a17:902:bd06:: with SMTP id p6mr9761347pls.130.1551915763007;
        Wed, 06 Mar 2019 15:42:43 -0800 (PST)
Received: from localhost ([2601:602:9200:32b0:44e5:978c:280e:8d47])
        by smtp.gmail.com with ESMTPSA id c130sm8745822pfb.145.2019.03.06.15.42.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Mar 2019 15:42:41 -0800 (PST)
From:   Taylor Blau <me@ttaylorr.com>
X-Google-Original-From: Taylor Blau <ttaylorr@github.com>
Date:   Wed, 6 Mar 2019 15:42:36 -0800
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] builtin/config.c: don't print a newline with --color
Message-ID: <20190306234236.GE27082@Taylors-MBP.hsd1.wa.comcast.net>
References: <b5ca6391fd0273fb7d6b92bc5ada96df93bc5cf2.1551487219.git.me@ttaylorr.com>
 <xmqqtvgk69ik.fsf@gitster-ct.c.googlers.com>
 <20190303174214.GF23811@sigill.intra.peff.net>
 <xmqqlg1vw9f2.fsf@gitster-ct.c.googlers.com>
 <xmqqh8cjw7ob.fsf@gitster-ct.c.googlers.com>
 <20190305042050.GE19800@sigill.intra.peff.net>
 <xmqqva0xvp6b.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqva0xvp6b.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 05, 2019 at 02:57:32PM +0900, Junio C Hamano wrote:
> Yup, that would be a very sensible first step, regardless of what
> the next step is.
>
> After that, choices are
>
>  (1) we'd introduce new inconsistency among --type=<type> by
>      matching what --type=color does to what --get-color does, to
>      allow us to revert that documentation update, or

I suppose... though I think that if others agree, I'd rather update the
documentation instead of introduce some inconsistency.

Yes, there's an argument to be made that if we're encouraging users to
go from '--get-color' -> '--type=color', that the two should behave the
same, but I don't think the cost we pay for behavioral equivalence
between the two is worth inconsistency among '--type=color' and all the
rest.

>  (2) we'd drop LF from all --type=<type>, that makes everything
>      consistent and risk breaking a few existing scripts while doing
>      so, and get yelled at by end users, or

As you indicate, I think that this option is one we should _not_ do. In
the interpolation example you shared earlier in the thread, script
writers most likely want and expect a trailing LF after each invocation
of 'git config'.

I'd argue that this case is more common than not wanting a LF when
interpolating with `--type=color`, so I agree it seems the tradeoff here
is not a good one.

>  (3) we stop at this documentation update and do nothing else.

To restate my response to (1), I think that the documentation update in
isolation makes the most sense here. I, too, was surprised in the same
way that Peff was when we stumbled upon this, but I think that
ultimately the consistency is most favorable.

Thanks all for your discussion and feedback.


Thanks,
Taylor
