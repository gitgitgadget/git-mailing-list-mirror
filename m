Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6E4A1F453
	for <e@80x24.org>; Fri, 28 Sep 2018 02:37:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbeI1I6x (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Sep 2018 04:58:53 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41619 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbeI1I6x (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Sep 2018 04:58:53 -0400
Received: by mail-pg1-f196.google.com with SMTP id z3-v6so3298744pgv.8
        for <git@vger.kernel.org>; Thu, 27 Sep 2018 19:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=deoDM7K6ywjUHOo/M8TVEAhxHxkhZTKrvX5XXJASheU=;
        b=y1olnAD8KD2pwfRSd6JlIRvW532V0pt9eLp8gxREg/4qT4P9rgWMo0EHvJYfIE3PHj
         uJ46tGCcboIZhjsFS7KWLFuz/ixa9weiSRBrAWlf3drtGwBb7KfQvzkdDKOW/ZAlRRFi
         Enoh0vbexepe8uo1rWICJElefHV+NXd4RgOFINxScVDRWZwXC5b3aFHh87kJvoAUdyIZ
         zawD3d840m/eqG9rYT3VFCniRwd3llhniua2otIYdBspmQIuEpcyVK7f+6JvzHswvZVR
         sblQnDseVdT9REOBuXYlmyv+FKT0s8QEIx7Poiwzg59+y46+rk0VoPFGUEBu7uYXpiPH
         RW7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=deoDM7K6ywjUHOo/M8TVEAhxHxkhZTKrvX5XXJASheU=;
        b=j9o+OzVblCUWoj3WkrdyR5pVCZEQWNE05QaCnK37eaNu8/pOWle57f5/OU6YnJQNPf
         tmbiK8a2vTWaiT5b2gTIOOLyQPiB40BodJYtP33xYRz07NvNdZihFqdT9Teq5B++yBSJ
         YVNxtsIKMewzYUdLi2ZiTYPz0W8rzZmJAWa3o1aIvQ3uZZ/ixllcqJaLXV88CnGO/Qml
         88dlBV03VZ1TyVopmXnx1G6EZZe7BiuXHiC8z7sN1qPorqzbMN1V36nDVVxGHxldnwSp
         uWAuMhoWE5dtAh/41KpI5Dclct4o37FX4qPp/pZ+6ETWiQ9heTW+YqHils3ffA1MqCdi
         FRBA==
X-Gm-Message-State: ABuFfogjQ2LXCZq+IPnD7b6dcosg1p77MwbMibH+JfIqTwKOAhuxxtXh
        t2bsDhQo8r3+iXa7kt39ZK4eC0oaRsY=
X-Google-Smtp-Source: ACcGV61WQ+vqyea9Bc3XmOyTnzSWsP5TQUEQkJnfxfjiR/Ihz/nXS5rVx5SXwHJ0Qgq10eRMR3gm6A==
X-Received: by 2002:a17:902:9302:: with SMTP id bc2-v6mr14091065plb.280.1538102247096;
        Thu, 27 Sep 2018 19:37:27 -0700 (PDT)
Received: from localhost ([2601:602:9200:32b0:1924:afac:8279:2210])
        by smtp.gmail.com with ESMTPSA id h69-v6sm8223031pfh.13.2018.09.27.19.37.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 19:37:25 -0700 (PDT)
From:   Taylor Blau <me@ttaylorr.com>
X-Google-Original-From: Taylor Blau <ttaylorr@github.com>
Date:   Thu, 27 Sep 2018 19:37:24 -0700
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Duy Nguyen <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] git help: promote 'git help -av'
Message-ID: <20180928023724.GA89283@syl>
References: <20180922174707.16498-1-pclouds@gmail.com>
 <20180924181927.GB25341@sigill.intra.peff.net>
 <xmqq4leesjdc.fsf@gitster-ct.c.googlers.com>
 <CACsJy8D1EMCqvBdxbta4oocMF33jwDf1=opXwZ0aRN7LYu=JXg@mail.gmail.com>
 <20180925174451.GA29454@duynguyen.home>
 <xmqq8t3omam8.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq8t3omam8.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 26, 2018 at 10:28:31AM -0700, Junio C Hamano wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
>
> > Here's the patch that adds that external commands and aliases
> > sections. I feel that external commands section is definitely good to
> > have even if we don't replace "help -a". Aliases are more
> > subjective...
>
> I didn't apply this (so I didn't try running it), but a quick
> eyeballing tells me that the listing of external commands in -av
> output done in this patch seems reasonable.
>
> I do not think removing "-v" and making the current "help -a" output
> unavailable is a wise idea, though.

I think that your point about having to react in a split-second in order
to ^C before we open the manual page for a command is a good one. So, I
agree with this.

Thanks,
Taylor
