Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A806208B8
	for <e@80x24.org>; Tue, 15 Aug 2017 14:29:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752048AbdHOO3Z (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Aug 2017 10:29:25 -0400
Received: from mout.web.de ([212.227.15.14]:55414 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751765AbdHOO3Z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2017 10:29:25 -0400
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MKwFs-1dhcqR0iYK-0005V7; Tue, 15
 Aug 2017 16:29:23 +0200
Date:   Tue, 15 Aug 2017 16:29:22 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/5] convert: initialize attr_action in convert_attrs
Message-ID: <20170815142922.GB4916@tor.lan>
References: <cover.1502780343.git.martin.agren@gmail.com>
 <0fd7f3184d285df8867ea44dd1adf418ebfc5ef3.1502780344.git.martin.agren@gmail.com>
 <20170815141734.GA4916@tor.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170815141734.GA4916@tor.lan>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K0:iLHIwQW7bzFY8b1D6CwzNoT50XKrxcSzI09jUpQbfXiareSvTl6
 5ommtjMRwUGTrBcHZOxonLss7pyDkVXZ8OdecA24chAmlcAkZkwcsK/HCx4ISllt2BEMLyN
 C88aeuKKXWUrsI0jtbRM2ZryX9LRjT0dmrlerP6TQokMKJ6Tbkm60kPKI+lqF3mG0LvpGAc
 2W+yORNLOnF+g+PII0VEw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ZrWF4Rz4Ze0=:Os/BAyzExTJDE8dnh1YWBT
 D2M7GcMgo3VyWAZz4zcmOVP8ZT33t7v5+/k+SyPzpT3EmFyB88eET/p1FqRiVxprfC/rj6kMc
 ILSzq7jbt9aXZ5TbC6aSRvob8ozrvAzDwku8Zt8WOerycnCDtab4kGHqyMeCMBCnkeX4goPtY
 0UijdhXCv2XWSXkvPa5zAEn6Fk4qmz3EHTe89xmCWnFNMIaxvcdHeZtONg7VO5cr2WyRzRSg9
 sHI4UW4vLiQzeXrLlNDdyi0A/49D2IStjCBpw+HYvL1q9BYvZv73/801ovhx9lY9lToQ0+etS
 mtlVeyca47bfemJ71ZCNL8jQZhTX5TsfpWc2bQrSesarIBrUaz1YprqjIn0H7qELx8ykN42Ym
 OkckFXhTQm+ROyfxp7D0ELP3LPGfxsmsaIDjXQRukKOS8GA/8XlWYPM1NhqK6I5tXGmn9zYJw
 EKaRKwiDUCrDLfFjQhCZuWVTJYR+Bq7rErNNXtR7AmoC6rDK+4L6t4sG5d50qOtWCd4ekHLZU
 3wwkrHtnY6kpibFI0Ez7/gnk6qWMmcPxCfRvAqeU4jsldGCrLgL8otb4JG1RER/7GHWdp+tKQ
 fc4HQqWwlVKdv4ycMcu5gy8l7s4N2dWU+O1ZMvqjQPZVv92cIMydtD0tGI6qlHcLu3t9QOy+2
 HzAn3KmILpPhu2fLXIL9pJRmAmq7Q0M1Yn7qFmhuXdx5bGonopvFMSSLGzhPz+2RSmYlJpkhI
 kxMzrhwcP1xriOhhG3uNzKmvxkDvZYvc96rqeg/sDarwIv/avq2RMCLCs5E3yv/4I2BDnQxHs
 v+NYtpQfVbE74v6NZFKoLlC1Gj1dA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> > diff --git a/convert.c b/convert.c
> > index 1012462e3..943d957b4 100644
> > --- a/convert.c
> > +++ b/convert.c
> > @@ -1040,7 +1040,6 @@ static void convert_attrs(struct conv_attrs *ca, const char *path)
> >  		ca->crlf_action = git_path_check_crlf(ccheck + 4);
> >  		if (ca->crlf_action == CRLF_UNDEFINED)
> >  			ca->crlf_action = git_path_check_crlf(ccheck + 0);
> > -		ca->attr_action = ca->crlf_action;
> 
> I don't think the removal of that line is correct.

Sorry, that went wrong, should have been:
 I think that the line can be removed here.

