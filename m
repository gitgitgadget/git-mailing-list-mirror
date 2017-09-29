Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3DDF420281
	for <e@80x24.org>; Fri, 29 Sep 2017 19:50:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752464AbdI2TuE (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Sep 2017 15:50:04 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:49734 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752280AbdI2TuE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Sep 2017 15:50:04 -0400
Received: by mail-pf0-f171.google.com with SMTP id l188so311081pfc.6
        for <git@vger.kernel.org>; Fri, 29 Sep 2017 12:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VKnmfUMqw30zpOnxts+X/yh7qp0cpugZKEW9iLrnbKk=;
        b=wEI88cdZvczvgY4ZwxnS2sJimBTr5A6Y5zisz0Jgo9ZfWSwKywU6hlZHHIbSUndrxM
         nwBi4k6v5MbENupl3VNGQ5HMYPhfPRp0Ra4AwCoSFjYt4GqwbdeNLMTf2XLSQUIa0285
         UrzfUsgaMoKgC0uilmwbpOuEqv1o0N7YKzf4VICEjDM99kfSgd7ywWMhD72lFWl+K8QW
         x+VZ55s3zHKmV3p40i5De6RYudUwJxBaa+m+Nla0ad1nYQmooikljiY4QvXrbwi63mSn
         Sh3o625t8biPYjjxx1gVAVFxmMEEuM8WmDIWiT89FsmsyiBsB0fHilOxP7OV2kaQu2XB
         hyHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VKnmfUMqw30zpOnxts+X/yh7qp0cpugZKEW9iLrnbKk=;
        b=U/j/dQsA2YuvVxYbx2xMCl5fDIPYNUQ6ooPwOew4xd1Gf+Epp+8avMDuQgxoDhV/U0
         L4++NsXMPNVO/jRD26Ni8VVxoXI2zojPdk/P8fBydSaEeTUYMD+bpAbU1P2qTqUR33HU
         kN7V/rRY+9VtN2UnSUF0HXxao9PPwQHzAT4KCFyV4ITFvcP9ZwW5Q0oEJgN+jQddgFvi
         IiGpEGzbfJC/pyzyECSk2m01HS/QQVj7w9RGg1LW+F7DS4i4WXM0baLS6NE88VSIQlc/
         Xb/0+VBM2PAH9fS0iS4cSEMQJWUCDLddG3SRC7aQwo5UyloZ6xwrvgqLfPkxB+TrGyRD
         k/6g==
X-Gm-Message-State: AMCzsaVKDUfJmq4mc6zkgn6JpbogCmajBeFgKJrhNJS424c6K04EGN/7
        T2lcJ5Om6jcm9xWncgOlfTZ61w==
X-Google-Smtp-Source: AOwi7QBZicHoha/fgoJJUvV3eOYwRITxVoxlfD1OusJubCiva27iGl51dfSovD2zFoyCJumcMhBvIQ==
X-Received: by 10.159.245.141 with SMTP id a13mr3352673pls.441.1506714603237;
        Fri, 29 Sep 2017 12:50:03 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:c55b:7140:f55d:7eed])
        by smtp.gmail.com with ESMTPSA id r12sm7847615pfd.187.2017.09.29.12.50.01
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 29 Sep 2017 12:50:02 -0700 (PDT)
Date:   Fri, 29 Sep 2017 12:50:00 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] clang-format: adjust line break penalties
Message-ID: <20170929195000.GE177031@google.com>
References: <073f00fa11930a3607e34828e7563e1b2dc27d2a.1506709551.git.johannes.schindelin@gmx.de>
 <20170929184032.GK19555@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170929184032.GK19555@aiede.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/29, Jonathan Nieder wrote:
> Hi Dscho,
> 
> Johannes Schindelin wrote:
> 
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  .clang-format | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> Well executed and well explained. Thank you.
> 
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
> 
> Going forward, is there an easy way to preview the effect of this kind
> of change (e.g., to run "make style" on the entire codebase so as to be
> able to compare the result with two different versions of
> .clang-format)?
> 
> Thanks,
> Jonathan

I don't think there's an easy way to do this yet (I'm sure we can make
one) though the biggest barrier to that is that most of the code base
probably isn't consistent with the current .clang-format.

I also took a look at the patch and agree with all your points.  I'm
sure we'll still have to do some tweaking of these parameters but I'll
start using this locally and see if I find any problems.

-- 
Brandon Williams
