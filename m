Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69076202DD
	for <e@80x24.org>; Mon,  2 Oct 2017 05:11:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750957AbdJBFLk (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 01:11:40 -0400
Received: from mail-pg0-f47.google.com ([74.125.83.47]:52120 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750903AbdJBFLj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 01:11:39 -0400
Received: by mail-pg0-f47.google.com with SMTP id k193so2433078pgc.8
        for <git@vger.kernel.org>; Sun, 01 Oct 2017 22:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=svYyGhTxfS0kILAAa8NxKuMAeiNpvkq1+Qo8nyVF1h4=;
        b=Fb+MPG3ClXbOTvl8OsQN4b6Yl2s59CdrgLTJmrCDkk2qDUrvwGc9WjnG7tmEKn4W08
         EkcenVOKE7F/DwHtZxTI66pnjrT1FK/SbIS/hwTPGjI1RUdDjqEA9h8NyxZVgojWoEtz
         glPUYcmCA2by8OYr+SioF8y75wqkdqsbwjrrfmp/zcEmJGeYqHI7VZaVk1w+bko7RaPV
         Z0oC5Wf+7ufelSrJEWT4XowDxo58iYJYmGZWM18mhx8561ecHxjl1JiD+CCchAHJAhpW
         LsdeL0uGBiynuBb+K+a83BSjR3KFOgve7YRTjRkOpR6jIbBQHBO6VS0xWqOCUT9Te8qM
         1W3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=svYyGhTxfS0kILAAa8NxKuMAeiNpvkq1+Qo8nyVF1h4=;
        b=cbUP4OUAZ2ahElsd+2WHmTd27hTopyf6F4vKEiJhcBAEywSWjz61wqMUmLVAwmcGJn
         l903RpoI5nnxpH5URXqZ8lXGvA389Ds9WcqtiTTYaTZdiERCk9kPMAXeJSs5k0jlvPhU
         WxI57xckLeiI+aF/1WFmxAJJlFDpEDdkIGd4MgEMFFc61RGwbtfxfBe5kGqkEBDaDbmq
         yH22B8g+4sP9jwC4kGaPIKtjD9/ZQ0Cf1rYM3veZaXVPsOGW5K0S+kKlFbNcgwq+ui+P
         yp1VNNq02s014/xJXZkxQzO7CI9qpjralY1IdMHlAUAySNnfUjj88xUMmQ7GWQTUqGQ7
         Mzjg==
X-Gm-Message-State: AMCzsaWxmTpzxjuk9STLEO0Tbv23QziE05f+vDF8V06GFvqmIAUdzD5b
        FdfUtoN+HC+SthoBPbXsDJWXOg==
X-Google-Smtp-Source: AOwi7QBi+E0A3moH10Ur+/mR2suYuwc/iYDFVP6y7JbNN5zdWXKGH5xmyOkS7obES+bkyybZ1uNNdw==
X-Received: by 10.99.123.78 with SMTP id k14mr1685979pgn.351.1506921098952;
        Sun, 01 Oct 2017 22:11:38 -0700 (PDT)
Received: from localhost ([205.175.97.239])
        by smtp.gmail.com with ESMTPSA id m67sm15264387pfc.38.2017.10.01.22.11.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 Oct 2017 22:11:37 -0700 (PDT)
Date:   Sun, 1 Oct 2017 22:11:37 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 4/5] ref-filter.c: use trailer_opts to format trailers
Message-ID: <20171002051137.GA5566@D-10-157-251-166.dhcp4.washington.edu>
References: <20170930062238.87077-1-me@ttaylorr.com>
 <20170930062238.87077-5-me@ttaylorr.com>
 <xmqqbmlrutsm.fsf@gitster.mtv.corp.google.com>
 <20171002050507.i27l2iulfbskmnpx@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171002050507.i27l2iulfbskmnpx@sigill.intra.peff.net>
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 02, 2017 at 01:05:07AM -0400, Jeff King wrote:
> On Sun, Oct 01, 2017 at 06:00:25PM +0900, Junio C Hamano wrote:
>
> > Taylor Blau <me@ttaylorr.com> writes:
> >
> > > diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
> > > index 2a9fcf713..2bd0c5da7 100755
> > > --- a/t/t6300-for-each-ref.sh
> > > +++ b/t/t6300-for-each-ref.sh
> > > @@ -597,6 +597,9 @@ Acked-by: A U Thor
> > >    <author@example.com>
> > >  EOF
> > >
> > > +unfold () {
> > > +	perl -0pe 's/\n\s+/ /'
> > > +}
> >
> > For the purpose of the current shape of the test, the above might be
> > sufficient, but the lack of "/g" at the end means that the script
> > will happily stop after unfolding just one line, which probably is
> > not what you intended.
>
> This is indirectly my fault, since this was copied from my t4205
> version. It might be worth fixing while we're thinking about it, as it's
> a potential trap for future changes.

I agree. I'll include a fix for this as an additional commit in v6.

--
- Taylor
