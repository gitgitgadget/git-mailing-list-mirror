Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 99F601F6DC
	for <e@80x24.org>; Sun, 29 Jan 2017 12:45:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751178AbdA2MpQ (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Jan 2017 07:45:16 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33127 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751036AbdA2MpM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Jan 2017 07:45:12 -0500
Received: by mail-wm0-f65.google.com with SMTP id v77so9403672wmv.0
        for <git@vger.kernel.org>; Sun, 29 Jan 2017 04:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZguTNfZa/6EtI2dgLc4UafdNb/p5XPHHDq9C31ZsDPk=;
        b=E4X01dHuUZoFemdUDvLhePE3LQSeusD9vpyEiLTcCksGXLuK13acf7wIIW9Tswyrb6
         SGxr1Y+yE939lqHSE0Iue+AFVGjjhi+HI4FI7yHtta6dGIrXXrYDBCULdshvi4ZYZFPS
         M9W6nnmQwGtT9j7Vf1V2sOHvqhUwUfrz+xUrsAZmbSxM8QWqzBwYDzeeeQTR0w6PwTUn
         CQwImeToAtKfoII6iztU6ALuyWDioee80mWpF1kPtqnPjzHUCS8CVezVzizsAn2VCRK+
         s16VuNNKCP649u3swl6+x3dFAAnv+j3G+2MxsSljZnJmRhxzxvkeZdOOMaVaFGkqvEWY
         TdbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZguTNfZa/6EtI2dgLc4UafdNb/p5XPHHDq9C31ZsDPk=;
        b=es6Vi/A/hFTmwl2E13WTzRxDUgGYeMUYv1Pw46t+tGGAFG74RCkO03INpuL9xkifQi
         os0Oxla2JVQOxF+Qh9SBvVQhAAdEH6FUZvesD73UILzZiavRlQtDoaIINjTTrskxzmMe
         LdObvGfZ5n/ODGam4PEJetG/PGv3aeoG1qf4V1/Cqv0kvM1jBuMLKhJVndhhn+6+ps68
         xy3T4xcYM6Y1pMJFlDc1Em6es56AqbwLG42AglEmFfDr33wTdsVXcVZj2ajQlTnYGnFC
         D//7t7o41UKKwGiNLK16zxzySGhsi5C+AqlbTpnNqRJeHIQ4BkuP85dFsyJOh1r23ceb
         emKw==
X-Gm-Message-State: AIkVDXID7F6FmotkH+aUqkr3yfSkPyiioENY2dZAOAIDqxW6tcHWkuJg1l7x6uWJ3P4H/A==
X-Received: by 10.28.109.27 with SMTP id i27mr9818792wmc.54.1485693531932;
        Sun, 29 Jan 2017 04:38:51 -0800 (PST)
Received: from localhost ([2a02:c7f:c42b:f900:5e51:4fff:fee9:57af])
        by smtp.gmail.com with ESMTPSA id m84sm13520419wmf.10.2017.01.29.04.38.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 29 Jan 2017 04:38:50 -0800 (PST)
Date:   Sun, 29 Jan 2017 12:39:11 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Stephan Beyer <s-beyer@gmx.net>,
        Marc Strapetz <marc.strapetz@syntevo.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/3] stash: introduce push verb
Message-ID: <20170129123911.GC31189@hank>
References: <20170121200804.19009-1-t.gummerer@gmail.com>
 <20170121200804.19009-3-t.gummerer@gmail.com>
 <xmqqziihskbi.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqziihskbi.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/23, Junio C Hamano wrote:
> Thomas Gummerer <t.gummerer@gmail.com> writes:
> 
> > +	stash_msg="$*"
> > +
> > +	if test -z stash_msg
> 
> A dollar-sign is missing here, I think.

Yes, thanks.

> > +	then
> > +		push_stash $push_options
> > +	else
> > +		push_stash $push_options -m "$stash_msg"
> > +	fi
> > +}

-- 
Thomas
