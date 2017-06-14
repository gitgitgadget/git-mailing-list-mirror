Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_WEB,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0D031FA7B
	for <e@80x24.org>; Wed, 14 Jun 2017 03:48:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754122AbdFNDsA (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Jun 2017 23:48:00 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:33867 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754044AbdFNDr6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2017 23:47:58 -0400
Received: by mail-pf0-f176.google.com with SMTP id s66so9256335pfs.1
        for <git@vger.kernel.org>; Tue, 13 Jun 2017 20:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Q0ycH5is388IB/gzcXM5D12jikcXdJRUsGrGDS88eWU=;
        b=hFWhOBLQRs7psxGBrnI3HFY/HR3eDWLRKmES4AOIjgJ8jvl3H/4jTxoPJID6hJhOqS
         IW97tuRpixBnjOCJBNiA+UkVrBB2yERQPPof5SVo0wiM5/OF8Z5QpqXgNU5LkSiUQkTu
         vWa/o7hclBDyLpM91fGrTDXa9GR+ndamn8oKI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Q0ycH5is388IB/gzcXM5D12jikcXdJRUsGrGDS88eWU=;
        b=Ca8G/Tmnl/qNpBPQpjjGRdkYmhgRIKsOUbKOMUzJPblLR2TCbX5icugnnCjWiiKGd+
         apBUcTWI8pGpaW2ktdVUki/z2zwC2mzSCm6tJM4J58eTLY/h9wn15gmNtqrTyDz/t0yE
         SpEqMi6Cvhzeb40cDpUaEzma+Ay9aT/1zST0Awph+bFYAo21kyWP2m5eZgwNne7uqRrC
         Zblz0p7Nu2HGIiQex8RF4yNTvhNOBhNtxes/gogfuFNaa84+JObuvuxLSulq+lN/rlns
         9aEoXI7i1YSuLH36J3eZG03PJqgIn7zX/NI2UA+ry9XbQB13i9o2hOG8nTVdcOvIoPVi
         vIKQ==
X-Gm-Message-State: AKS2vOxHGjFyHj3J26/CINa13pfGOpmCw+Mjh1en8jJesmh9WDZiPl4o
        DcipHBL4n6FyGT3E
X-Received: by 10.99.97.137 with SMTP id v131mr2190015pgb.235.1497412078137;
        Tue, 13 Jun 2017 20:47:58 -0700 (PDT)
Received: from localhost ([122.172.35.3])
        by smtp.gmail.com with ESMTPSA id s131sm26609702pgs.6.2017.06.13.20.47.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Jun 2017 20:47:56 -0700 (PDT)
Date:   Wed, 14 Jun 2017 09:17:54 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, avarab@gmail.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH] send-email: Add tocmd option to suppress-cc
Message-ID: <20170614034754.GI5297@vireshk-i7>
References: <6367777092d93a62cc83c444061dde853ba3369e.1495107179.git.viresh.kumar@linaro.org>
 <20170612043313.GE5297@vireshk-i7>
 <xmqq8tkxp4nw.fsf@gitster.mtv.corp.google.com>
 <xmqqmv9dnkut.fsf@gitster.mtv.corp.google.com>
 <20170613034337.GF5297@vireshk-i7>
 <xmqqk24f7qep.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqk24f7qep.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 13-06-17, 10:23, Junio C Hamano wrote:
> Viresh Kumar <viresh.kumar@linaro.org> writes:
> 
> >> Going back to the core part of your change, i.e.
> >> 
> >> -	foreach my $entry (qw (cccmd cc author self sob body bodycc)) {
> >> +	foreach my $entry (qw (tocmd cccmd cc author self sob body bodycc)) {
> >> 
> >> to think about it a bit more, I notice that all the existing ones
> >> are about CC.  So I am not just not convinced that tocmd belongs to
> >> the same class.  I am inclined to say that it smells quite different
> >> from others.
> >
> > That's right but how do we solve this problem then?
> >
> > Add another optional argument like suppress-to ? I thought that it
> > would be better to override suppress-cc rather than attempting any
> > such thing.
> >
> > I am fine with any solution that address the concerns raised by this
> > patch though.
> 
> I am not sure what problem is being solved, quite honestly.  "I have
> tocmd configured and I want a way not to specify tocmd for a single
> invocation?"  Would something along the lines of 
> 
>     git -c sendemail.tocmd=true send-email ...
> 
> how you do it in general?

Yeah, it works. I can use this instead.

This patch can be dropped now. Thanks.

-- 
viresh
