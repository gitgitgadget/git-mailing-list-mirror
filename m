Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BF3B1F461
	for <e@80x24.org>; Sat, 24 Aug 2019 07:26:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbfHXH0p (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Aug 2019 03:26:45 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41638 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbfHXH0p (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Aug 2019 03:26:45 -0400
Received: by mail-pg1-f193.google.com with SMTP id x15so7154894pgg.8
        for <git@vger.kernel.org>; Sat, 24 Aug 2019 00:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LdAiabMecnhXfKKNT/tVPkldUVlsVB4oMPMclrkUhlI=;
        b=nLlzpVX5IwulZkdNqS4EJVvQU1Kjj9jgBo6dEey9/rPCG84mRNR6BcSucxYk6cTlSB
         HP2jgnZoptoJqo2Y182Z/3TWCqELbXwHlDxFm6Ncd2nlpV8ijBKc0NwxVzVOE7AgZN8f
         bifDvSQiuUoOUoBDr1NhlPAN5R+Oxl/A8x6uxKS/wyHLCKKc2hDkUfiuxIjBYhkI3+XL
         Vqr+3HFsxNA7NTRonYUWAsHQgYEIJihlJZ7A3cknXmwFSjGYc3Bk4aVzTEEAxCwIN9w5
         UcoEmzzmuEDORPYxJkzHOjHdW9x3qH1TS60UCUEVO+Fm7WIVIa0jdJBJ2JQXv/xcFS76
         q2Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LdAiabMecnhXfKKNT/tVPkldUVlsVB4oMPMclrkUhlI=;
        b=lPx1Kmu1J9TVPfz/v7dWur353q6W5UYDutYpM82xGtrQYvDmzn+/4REc39EklxIpvE
         rFFmRSkmEMvC7iAXv7LN5Y68oiMxoUflnh/TyKSN1E9atvLBpEs2k9W86hdXHnyQf+F7
         Ih15mAYlQl/xZ4wD3PR1ihyJxT/1AJm+v7uAs6EJPZDQoMZyyW9sRvUP/9n7pTO97jEo
         POlAbSDJlUCVY4DCRvqNVmQ4zCjk3r/iZZICExagEdK5V7X1G1CU6q1mUf3uhkpPbyCX
         wDP2ioGuVVVpEOvzH37zjn/noSTYesD5tMELTlqozyaRMuJ5fE1iHt565cOtQDB3aCIs
         oxUw==
X-Gm-Message-State: APjAAAUwNn+gkM5km1pOtHt7GfzZBynCsfPJv9ridmbvcETUZjL4Q7nN
        7Uuigsxj7H0zxjqzAXqBI+I=
X-Google-Smtp-Source: APXvYqwPLhFqm35Lt7o3AGcwY2IJFosJEknyW8pK5TlN3LQ+XRnoe1seFm4qPi0sVt+aVRthTaZx/w==
X-Received: by 2002:a63:1e06:: with SMTP id e6mr7077852pge.185.1566631604528;
        Sat, 24 Aug 2019 00:26:44 -0700 (PDT)
Received: from gmail.com (50-1-201-252.dsl.static.fusionbroadband.com. [50.1.201.252])
        by smtp.gmail.com with ESMTPSA id ck8sm4096789pjb.25.2019.08.24.00.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Aug 2019 00:26:43 -0700 (PDT)
Date:   Sat, 24 Aug 2019 00:26:41 -0700
From:   David Aguilar <davvid@gmail.com>
To:     Bert Wesarg <bert.wesarg@googlemail.com>
Cc:     Pratyush Yadav <me@yadavpratyush.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 0/4] git-gui: Add ability to revert selected hunks and
 lines
Message-ID: <20190824072641.GA5363@gmail.com>
References: <20190819214110.26461-1-me@yadavpratyush.com>
 <20190822220107.4153-1-me@yadavpratyush.com>
 <20190823234339.GA17088@gmail.com>
 <CAKPyHN1gA4zPL7=WYQotKmQf=hZR+gr1wH3t5GuMw9thiMTsKg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKPyHN1gA4zPL7=WYQotKmQf=hZR+gr1wH3t5GuMw9thiMTsKg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 24, 2019 at 08:57:22AM +0200, Bert Wesarg wrote:
> On Sat, Aug 24, 2019 at 1:43 AM David Aguilar <davvid@gmail.com> wrote:
> > On the other hand, if I had to actually move my hand over to a mouse or
> > trackpad and actually "click" on something then I would be super
> > annoyed.  That would be simply horrible with RSI in mind.
> >
> 
> I take this as a point for *not* having a confirmation dialog when
> doing the action per mouse. Which matches exactly my original
> implementation.

+1

> > That's my $.02 from having used this feature in practice since 2013.
> 
> 2012

Nice! ;-)  I agree with everything you've written here.

cheers,
-- 
David
