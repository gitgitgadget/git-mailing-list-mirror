Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E3BF01F462
	for <e@80x24.org>; Tue, 18 Jun 2019 20:22:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730575AbfFRUW5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jun 2019 16:22:57 -0400
Received: from resqmta-po-11v.sys.comcast.net ([96.114.154.170]:40456 "EHLO
        resqmta-po-11v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729961AbfFRUW4 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 18 Jun 2019 16:22:56 -0400
Received: from resomta-po-20v.sys.comcast.net ([96.114.154.244])
        by resqmta-po-11v.sys.comcast.net with ESMTP
        id dJ27hA4yzEDICdKd5h9QE0; Tue, 18 Jun 2019 20:22:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=20190202a; t=1560889376;
        bh=ZInKe2Dk4y9LeXwfcWSbU+H9wGL3NWE+E0br/D+elSk=;
        h=Received:Received:Date:From:To:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=41M/YJ/p9Y7ZBpoapIJS4RVgpYIxamwp2W1UPsK2YVwFVKSuizlGcv++rAdx+ARi8
         SvwkiK1asXOBn6u73beR4tqIBHhQFbfBv4BaNLsMZmeloimPgg/5VqE9zQYoF1XzHb
         F6wo6ulsGmsKTccuIcf3dZ/V0yto9oZT2IDrmH1LqyoiDeMtOKbg8tDCQAmDTfmb/R
         P9JaAfmscknPvBfAabBfzxlKdxf1BssRlo9EmlcguWeVtkYJTngZzcBijqEkyvmUX7
         aEQ4jO/aKqhK2roxwwfHFcaHzSP/4pwIk4IV6+Nf2uAxPbmsK1aBMmyKeOBquzqGb2
         Z/Uej70BbaTFw==
Received: from comcast.net ([IPv6:2620:15c:2ce:200:7408:b2da:b734:693d])
        by resomta-po-20v.sys.comcast.net with ESMTPSA
        id dKcSh8cacSHF0dKcahFGxF; Tue, 18 Jun 2019 20:22:53 +0000
X-Xfinity-VMeta: sc=-100;st=legit
Date:   Tue, 18 Jun 2019 13:22:16 -0700
From:   Matthew DeVore <matvore@comcast.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Matthew DeVore <matvore@google.com>, git@vger.kernel.org,
        jonathantanmy@google.com, jrn@google.com, dstolee@microsoft.com,
        jeffhost@microsoft.com, jrnieder@gmail.com, pclouds@gmail.com,
        peff@peff.net, emilyshaffer@google.com,
        Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 04/10] list-objects-filter: implement composite filters
Message-ID: <20190618202216.GA35347@comcast.net>
References: <20190601003603.90794-1-matvore@google.com>
 <cover.1560558910.git.matvore@google.com>
 <47a2680875e6f68fbf1f2e5a5a2630d263cdf426.1560558910.git.matvore@google.com>
 <nycvar.QRO.7.76.6.1906181040490.44@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1906181040490.44@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 18, 2019 at 10:42:10AM +0200, Johannes Schindelin wrote:
> > +	if (!subspecs[0]) {
> > +		strbuf_addf(errbuf,
> > +			    _("expected something after combine:"));
> 
> Please squash this in, to pacify Coccinelle:
> 
> -- snipsnap --
> diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
> index 5e5e30bc6a17..483ab512e24c 100644
> --- a/list-objects-filter-options.c
> +++ b/list-objects-filter-options.c
> @@ -150,7 +150,7 @@ static int parse_combine_filter(
>  	int result = 0;
> 
>  	if (!subspecs[0]) {
> -		strbuf_addf(errbuf,
> +		strbuf_addstr(errbuf,

Thank you - fixed locally for the next re-roll.
