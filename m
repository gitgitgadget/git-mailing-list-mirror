Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 959A620281
	for <e@80x24.org>; Tue,  3 Oct 2017 03:37:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751075AbdJCDhb (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 23:37:31 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:54430 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750846AbdJCDha (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 23:37:30 -0400
Received: by mail-pf0-f176.google.com with SMTP id d187so3915753pfg.11
        for <git@vger.kernel.org>; Mon, 02 Oct 2017 20:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jQeKXO/hK+E/mc0TwY0P6/uoar7YE60TpzcS1E2PErA=;
        b=iAX5bs+n6yaTfGrXTRNYR7pkdsBTKyX7s+/9NQ+Lo/750jAk1kV49dryajK3CONkoO
         ZwYZhr5l8Db3BXIjv1qDXWXq9FHVccoueYnYx+fCv/xu0NyWQIHcDpqjSe0kR4IeRW9f
         1gdD7ShIWMrE9FkXmCJr4btjzjBYTT3ycKHdW15bdszegPFV2qdh1ys5tjfHQexNCHlU
         IxREiTuw2DH9YK6ahuyb8PE3/d5cRFBH0+I87QF7/87vhKLkhyZydM+2Q3/2HFGqN14d
         0Fdq6clwbW6Vze2ynKMvjVdjZUzx/7vvu/1gYw6HOd/k+LRxYFu2B+ppcOkc6S/OFmPb
         u8zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jQeKXO/hK+E/mc0TwY0P6/uoar7YE60TpzcS1E2PErA=;
        b=a0jRHmVk1pDPgwsse6SHk+MgVtBHjfGtsW9qpk9ND5Yz32+9LMXB8cISGqerlSolQU
         S+ZojrZF5dq9v2Y91YBrNh3Oi6wN+W+WQ0sARF7deZP0PU6n8mtBmC4f6xt3WknQug5/
         rKNKQTvEQWVudzDmgg5+w+nxnWpSC3L3iPzNFy7U1CG0YqMh2sQW5AWnJarjsf7cYCIq
         KxWB2itN/ceNPtTrosmBddRW2Sxc07Fy4NQkCIVPTVaZQqGlI7TRwLOgR/H7eOgwl9Jo
         vayswkPKypopTcQtjPuGr7HwUifC6P+sbDGAaNB82DXgOi5mb9HaDUVzko/qgR9HQYu5
         IGlw==
X-Gm-Message-State: AMCzsaVjUthFi1q0T36nGbylgGaKaOdGoqVugtMOremF/gIhnA6QZOl3
        NmdswWifeHbz7Uwp6ooTvGksTg==
X-Google-Smtp-Source: AOwi7QDaZgneQ0/iPadeDL0IyfqjVLhHWJhiVU80G2knXd66oiOxFnZ6Otdc4xuHE1Z/0gOiGEZ+sg==
X-Received: by 10.159.242.196 with SMTP id x4mr4290458plw.68.1507001849824;
        Mon, 02 Oct 2017 20:37:29 -0700 (PDT)
Received: from localhost ([205.175.97.239])
        by smtp.gmail.com with ESMTPSA id 138sm5372419pfa.66.2017.10.02.20.37.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Oct 2017 20:37:28 -0700 (PDT)
Date:   Mon, 2 Oct 2017 20:37:26 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        peff@peff.net
Subject: Re: [PATCH v2] ref-filter.c: pass empty-string as NULL to atom
 parsers
Message-ID: <20171003033726.GA84817@D-10-157-251-166.dhcp4.washington.edu>
References: <20171002055052.GB10729@D-10-157-251-166.dhcp4.washington.edu>
 <20171002161034.44867-1-me@ttaylorr.com>
 <20171002224052.GR19555@aiede.mtv.corp.google.com>
 <xmqqmv59m7fu.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqmv59m7fu.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 03, 2017 at 08:55:01AM +0900, Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:
>
> > The above does a nice job of explaining
> >
> >  - what this change is going to do
> >  - how it's good for the internal code structure / maintainability
> >
> > What it doesn't tell me about is why the user-facing effect won't
> > cause problems.  Is there no atom where %(atom:) was previously
> > accepted and did something meaningful that this may break?
>
> That is, was there any situation where %(atom) and %(atom:) did two
> differnt things and their differences made sense?
>
> > Looking at the manpage and code, I don't see any, so for what it's
> > worth, this is
> >
> > Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
> >
> > but for next time, please remember to discuss regression risk in
> > the commit message, too.
>
> Yes, I agree that it is necessary to make sure somebody looked at
> the issue _and_ record the fact that it happened.  Thanks for doing
> that already ;-)
>
> I also took a look at the code and currently we seem to abort,
> either with "unrecognised arg" (e.g. "refname:") or "does not take
> args" (e.g. "body"), so we should be OK, I'd think.

Thank you both for the helpful pointers. I will make sure to include a
more thorough review of potential breakage in existing code given a
particular change.

With respect to this particular patch, I agree with Jonathan and Junio
that there are no places in ref-filter.c that would be affected by this
change, and that it should be able to be applied cleanly without
breakage.

--
- Taylor
