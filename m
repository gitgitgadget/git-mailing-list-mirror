Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 108901F406
	for <e@80x24.org>; Tue,  9 Jan 2018 22:28:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754889AbeAIW2a (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Jan 2018 17:28:30 -0500
Received: from mail-pf0-f172.google.com ([209.85.192.172]:43066 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754000AbeAIW23 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jan 2018 17:28:29 -0500
Received: by mail-pf0-f172.google.com with SMTP id e3so9595090pfi.10
        for <git@vger.kernel.org>; Tue, 09 Jan 2018 14:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PWh1HcTK7YwLl4PPrpKLQFZc/RHQX+D6XM02nhqqcxY=;
        b=ua9UhDc67MT5zEj3aRRqsE1wv51Amv5hXjW9E7JHm1hUs471bKI40tzBKd1FyhLtEC
         VqFbFRYvpMX7O95G0p95y8Pn4t/inS+oGYZuZcIdIFo4UBF0WaGs/7/67wrSm75FeHhU
         VBl+nhtCx8DcpV51TEK9EZ/Ziw1X2btv1kHIaUr1S48dkg4P0BmE70K9FjFOvVI8PSC5
         nkw2g9M4f+kR4SsV0CkCbN4vyTdcnnwVIXiJQtsTcOg76KZIFz0KM6i12OjK1+KjaBnu
         8xUfa5ZVvfBZxTOLgl7G1yT5VPrV220tOpwhs0+yfuRrRGpT3RkQBL9DqOqqBDeRHpcp
         Oadg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PWh1HcTK7YwLl4PPrpKLQFZc/RHQX+D6XM02nhqqcxY=;
        b=Td5vAoO4IXzeJge2PSddHYbbidrsRncX2wdw4Z0IBg1khylZahM/+QkpQ2HFO63SoY
         Z+szsIHp+CHklsP5OdwXTnToHhT4NQm1WQabkEDvzWiEHg0hB22FOsckUodsgNC9+z8n
         CwtDmG++eS7RS25GFOHSi/tNjGhOpUn+f0es5Tt0/Zy1rd/dZNBPmzgwVqq1omYW1hzZ
         2KnF0zJ63EQ4Cpc6a8SGYggCm68/8MaR5Vgj01RY5nlbsdsQO3n1WweMnq6UmE5eJHOw
         +2whBaKxolBEqwoI1/5EeH6n/OdjYacmB3h1DWy0dkO/eFg7MMTcFTQseRg+JFYsIXlO
         Cehg==
X-Gm-Message-State: AKGB3mICqFUGyqlb8OpqYyRE+gi1UiGfuWg/LWtL0mhYhlSbW6xpcuUO
        5AlaUMRU8i/oOtIFXV36ARcpVJeiqDI=
X-Google-Smtp-Source: ACJfBosdgsQtQPtBDUcrpkO/0tOOtO46gZYvGc+GQqcef7ePUN8SjjIt8GVPxTq65v1pJLI8maBJwg==
X-Received: by 10.159.208.7 with SMTP id a7mr17628654plp.104.1515536909036;
        Tue, 09 Jan 2018 14:28:29 -0800 (PST)
Received: from twelve3.mtv.corp.google.com ([2620:0:100e:422:592e:240e:24e2:56aa])
        by smtp.gmail.com with ESMTPSA id f10sm28305688pgr.62.2018.01.09.14.28.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jan 2018 14:28:28 -0800 (PST)
Date:   Tue, 9 Jan 2018 14:28:27 -0800
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, gitster@pobox.com,
        peff@peff.net, philipoakley@iee.org, stolee@gmail.com,
        jrnieder@gmail.com
Subject: Re: [PATCH 11/26] serve: introduce git-serve
Message-Id: <20180109142827.a2fe13a69e5240b6a12729e1@google.com>
In-Reply-To: <20180109221642.GF151395@google.com>
References: <20180103001828.205012-1-bmwill@google.com>
        <20180103001828.205012-12-bmwill@google.com>
        <20180109122455.5845c4f12ccdd4cada1528f2@google.com>
        <20180109221642.GF151395@google.com>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 9 Jan 2018 14:16:42 -0800
Brandon Williams <bmwill@google.com> wrote:

> All good documentation changes.

Thanks!

> > > +	/*
> > > +	 * Function called when a client requests the capability as a command.
> > > +	 * The command request will be provided to the function via 'keys', the
> > > +	 * capabilities requested, and 'args', the command specific parameters.
> > > +	 *
> > > +	 * This field should be NULL for capabilities which are not commands.
> > > +	 */
> > > +	int (*command)(struct repository *r,
> > > +		       struct argv_array *keys,
> > > +		       struct argv_array *args);
> > 
> > Looking at the code below, I see that the command is not executed unless
> > advertise returns true - this means that a command cannot be both
> > supported and unadvertised. Would this be too restrictive? For example,
> > this would disallow a gradual across-multiple-servers rollout in which
> > we allow but not advertise a capability, and then after some time,
> > advertise the capability.
> 
> One way to change this would be to just add another function to the
> struct which is called to check if the command is allowed, instead of
> relying on the same function to do that for both advertise and
> allow...though I don't see a big win for allowing a command but not
> advertising it.

My rationale for allowing a command but not advertising it is in the
paragraph above (that you quoted), but if that is insufficient
rationale, then I agree that we don't need to do this.

> > If we change this, then the value parameter of advertise can be
> > mandatory instead of optional.
> 
> I don't see how this fixes the issue you bring up.

This is a consequence, not a fix - if we were to do as I suggested, then
we no longer need to invoke advertise to check whether something is
advertised except when we are advertising them, in which case "value"
never needs to be NULL.
