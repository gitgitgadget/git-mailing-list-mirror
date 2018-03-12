Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2809E1F404
	for <e@80x24.org>; Mon, 12 Mar 2018 22:44:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932225AbeCLWoA (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Mar 2018 18:44:00 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34890 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751282AbeCLWn7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Mar 2018 18:43:59 -0400
Received: by mail-pf0-f196.google.com with SMTP id y186so5017735pfb.2
        for <git@vger.kernel.org>; Mon, 12 Mar 2018 15:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MbNdzdztvcCSP+lPoFBGL2I/LsNl4W6zNQ1k80DG6ro=;
        b=CjZcY0AvdA4oZhS3Lhwx+3usOyIBTc4eeAsN8dccq/BoiJRfWBikGurVcsYHCZMFB8
         S6SZ5TQppeDnq+hms+xWQp5VmOGwTb76PBh31POIKCSEEDfuoU9N9uxc5yhSFWzuoLYT
         2IjIH+u3a/YNB11Od9b82p+L7hiqPkuZqMNpvISRkZVHdvI8CE4TvvoNy8ALtzCyurBu
         aJuiH0NtZ8M316lq2yiIrrWC94U/vJ54fxwMcT+V5vtsXyu+pT3RgYyUmdBNGTJnfaoi
         /N/tNDOqIOQLUeqQZso3zvmCVFDiUrX3ttOi3/+5mr/zwDKcH2p0IYHFYpaFoVikkXqI
         hOjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MbNdzdztvcCSP+lPoFBGL2I/LsNl4W6zNQ1k80DG6ro=;
        b=bMNmGpPWBOzykl5JijhOnOcWYKutEGtksABQzwhWLmx0uzrAsqQOuco8LqdcMZhLFk
         IEAEHXJrVC+dqru0EIJ2eYh9vduxMULF7dcQtuLuko8OFu/eYX6RLjpYpcSfHhe90RwL
         Voen8mtpmUP6g3MiDkZZmRIzZUJla1vVYeL+c9VQwlrEbg7YAQFD1c4k80S0stjDXWHj
         xhAfw8xyJDnV/1mqdQuIFis6lXH4xzssqZSZAfqhkPZGGNPM7HId5faFtRMklSmSSZMw
         A53tNylVL/oXwslZ2NH1bX0EPvv6JaetlC48ss7DabGSbqbl40SEZQ/NJLu9Ks9SxyYi
         6XjQ==
X-Gm-Message-State: AElRT7HGGyG41TjyJMcaM/DgGoZGGXbTYelKqrXCMdsls+XuTmA4VZ2G
        sCsHAkVcLgE3VKf0KMMqgQ0=
X-Google-Smtp-Source: AG47ELsCZHAIF0VkMy8G9aadNdJleGWoN7KrM+tWm4aIup0G30Klr5jUAPCxQYZvk4dpE6/xaZn46A==
X-Received: by 10.98.18.143 with SMTP id 15mr9624087pfs.104.1520894638276;
        Mon, 12 Mar 2018 15:43:58 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id k23sm16775992pfi.79.2018.03.12.15.43.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Mar 2018 15:43:57 -0700 (PDT)
Date:   Mon, 12 Mar 2018 15:43:55 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Brandon Williams <bmwill@google.com>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        sbeller@google.com, gitster@pobox.com, stolee@gmail.com,
        git@jeffhostetler.com, pclouds@gmail.com
Subject: Re: [PATCH v3 04/35] upload-pack: convert to a builtin
Message-ID: <20180312224355.GC58506@aiede.svl.corp.google.com>
References: <20180207011312.189834-5-bmwill@google.com>
 <20180221134422.2386e1aca39fe673235590e7@google.com>
 <20180222095833.GC12442@sigill.intra.peff.net>
 <20180222180715.GB185096@google.com>
 <20180222181400.GA19035@sigill.intra.peff.net>
 <20180222193814.GA256918@aiede.svl.corp.google.com>
 <20180222201940.GB23561@sigill.intra.peff.net>
 <20180222202150.GA23985@sigill.intra.peff.net>
 <20180222212634.GC256918@aiede.svl.corp.google.com>
 <20180222214457.GB30638@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180222214457.GB30638@sigill.intra.peff.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Jeff King wrote:
> On Thu, Feb 22, 2018 at 01:26:34PM -0800, Jonathan Nieder wrote:

>> Keep in mind that git upload-archive (a read-only command, just like
>> git upload-pack) also already has the same issues.
>
> Yuck. I don't think we've ever made a historical promise about that. But
> then, I don't think the promise about upload-pack has ever really been
> documented, except in mailing list discussions.

Sorry to revive this old side-thread.  Good news: for a dashed command
like git-upload-archive, the pager selection code only runs for
commands with RUN_SETUP or RUN_SETUP_GENTLY:

	if (use_pager == -1 && p->option & (RUN_SETUP | RUN_SETUP_GENTLY) &&
	    !(p->option & DELAY_PAGER_CONFIG))
		use_pager = check_pager_config(p->cmd);

None of upload-pack, receive-pack,git-serve, or upload-archive set
those flags, so we (narrowly) escape trouble here.

Later today I should be able to send a cleanup to make the behavior
more obvious.

Thanks again,
Jonathan
