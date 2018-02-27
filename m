Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC3FE1F404
	for <e@80x24.org>; Tue, 27 Feb 2018 18:34:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751786AbeB0SeL (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 13:34:11 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:44060 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751748AbeB0SeK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 13:34:10 -0500
Received: by mail-pf0-f196.google.com with SMTP id 17so8301028pfw.11
        for <git@vger.kernel.org>; Tue, 27 Feb 2018 10:34:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=T9TnGCb+K7HpUD77zbqqDe8MPOMCat3ExB+3BZoTv/8=;
        b=JumGedhKorbGt49nTnknLQWinPOQ/v5DfvtCovkT4pSjcSmO1xGFa3x+KPNRc8Pqkt
         6o1sWVWeeqYI8iWVc+WGg7phx0K9IECtS7XOz9CPSfY986Jaj3ReSSERGdjLUgQ6pZMj
         kbtHsZa+vbw7ddF8GenwyvJ9qiblgBlJ7L6w+OyEJEYBiw8ZepYX6HKoXG7ua/WVw9mF
         4mOACoQhQWtf4Nw9RW+RQdQrFQODQyh+BYfdE4iFPis6aV+x6/jXAffg/zl+eleC7nVi
         aUfFW4z5lAMQKVFXUelYzvli3ImLrSfMMfw/hwe67HAKy/R468CNkZ5tlVXI2bOEClO/
         wJ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=T9TnGCb+K7HpUD77zbqqDe8MPOMCat3ExB+3BZoTv/8=;
        b=AUSuibn3sj+XnwmgUnm6GFXNF56vV66uqebkU0wVKMB5tGKgFBB1lKPsb+WvLigdt6
         pXsZPHE/t7/wnelc67+jCT59VLx2p/J+3DLDsHw8grz3SvrRFGRVBzGIG7TicTGN6Au0
         KLzNga+0+OdmfaAbdjDCLe4ea2OQkrKCrNxmgpqbjhXA8MdsWpVIOwty32y2/QHVR3p3
         9u5Q8uGjgmaX6vtTP1RrizWJCyJzVkmYJC4Ck1JQA2/Dnne3x9K5FbYCh8cbqAPxAMn/
         93lnGAp6WtGpzIMkD5r7QZQWXRpGHNG+q8rVb8DHxZs6QpktPYqwTaruxTqTYCda0UoL
         MuvQ==
X-Gm-Message-State: APf1xPBzWLj9A8xsd9X5ql3gxkayvulB+VWx8GIgsofJHxaSYtYxQQx1
        F2UUMEX7/5vqic/ujE0dIkGR8Z05Z8I=
X-Google-Smtp-Source: AH8x227OYqsb9CPBwnj1ZpUMpYlAoMO6KTk0YSqpMUdXdWrOEVDBf/cn9hYdw0WZWPCQKKhWygo90A==
X-Received: by 10.101.74.10 with SMTP id s10mr12334895pgq.219.1519756449458;
        Tue, 27 Feb 2018 10:34:09 -0800 (PST)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id w3sm26761358pfw.30.2018.02.27.10.34.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Feb 2018 10:34:08 -0800 (PST)
Date:   Tue, 27 Feb 2018 10:34:07 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, peff@peff.net,
        gitster@pobox.com, jrnieder@gmail.com, stolee@gmail.com,
        git@jeffhostetler.com, pclouds@gmail.com
Subject: Re: [PATCH v3 12/35] serve: introduce git-serve
Message-ID: <20180227183407.GD209668@google.com>
References: <20180125235838.138135-1-bmwill@google.com>
 <20180207011312.189834-1-bmwill@google.com>
 <20180207011312.189834-13-bmwill@google.com>
 <20180221144515.d180a26627a33168b19e0a4f@google.com>
 <20180223213315.GE234838@google.com>
 <20180227100555.91f2a5e196bff3968871a16e@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180227100555.91f2a5e196bff3968871a16e@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/27, Jonathan Tan wrote:
> On Fri, 23 Feb 2018 13:33:15 -0800
> Brandon Williams <bmwill@google.com> wrote:
> 
> > On 02/21, Jonathan Tan wrote:
> > > As someone who is implementing the server side of protocol V2 in JGit, I
> > > now have a bit more insight into this :-)
> > > 
> > > First of all, I used to not have a strong opinion on the existence of a
> > > new endpoint, but now I think that it's better to *not* have git-serve.
> > > As it is, as far as I can tell, upload-pack also needs to support (and
> > > does support, as of the end of this patch set) protocol v2 anyway, so it
> > > might be better to merely upgrade upload-pack.
> > 
> > Having it allows for easier testing and the easy ability to make it a
> > true endpoint when we want to.  As of right now, git-serve isn't an
> > endpoint as you can't issue requests there via http-backend or
> > git-daemon.
> 
> Is git-serve planned to be a new endpoint?
> 
> If yes, I now don't think it's a good idea - it's an extra burden to
> reimplementors without much benefit (to have a new endpoint that does
> the same things as upload-pack).

I'm still going to include it, with the potential for it to become an
endpoint if we so choose (it isn't now), because when we start to
introduce more things to v2 (push or other commands we haven't dreamed
up yet) it just makes more sense to contact an endpoint that doesn't
explicitly say what it does.

> 
> If not, I don't think that easier testing makes it worth having an extra
> binary. Couldn't the same tests be done by running upload-pack directly?

its builtin and not a new binary, and yes it makes testing much easier
because its assumes v2 from the start instead of v0.

-- 
Brandon Williams
