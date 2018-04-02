Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C3201F404
	for <e@80x24.org>; Mon,  2 Apr 2018 21:16:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754407AbeDBVQt (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Apr 2018 17:16:49 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:52407 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753322AbeDBVQs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Apr 2018 17:16:48 -0400
Received: by mail-wm0-f47.google.com with SMTP id g8so4698887wmd.2
        for <git@vger.kernel.org>; Mon, 02 Apr 2018 14:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=G9GuMVbHUlwhf4vWIjV2q7U6yF3P8IIZtdDbT8cPrCE=;
        b=JCKkyFghXB0Qfa4IluLKTVaTUGOgoYm6qAFDc7jSsqvpXqky+h5xnHK2W2Ih44ORUZ
         zSUPpEZvDJLnNgGVrttlbSEFIfrpBNHksj6lgne3+WlGhIk9XkBndVlQmRxk8RpQkaOe
         /8NeWpbeJ9xmLEE+bNx9O+5aPYgbTBcTvulJeJDlgB0bFmNiniuceA6ByQbK0AbetuWh
         kJSEHVHX4b6SmYIiAr7t6/x5uX1xfWw5gTz72Achqf68OG0H0t8k14HX5RKDkHIzrMEQ
         Abb24Rt3V7kWWY0xZMuT+8jFuj1vOFF99MNmKE/bbzF9v2ynu0J3j5ZGny4qP+ZfWDSO
         iEOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=G9GuMVbHUlwhf4vWIjV2q7U6yF3P8IIZtdDbT8cPrCE=;
        b=Dwk0GRpwVUYMGbS9su2JBGGylEzWG6xxSSKCfPnb24sxM5/87D/pIUFRv5LQm2NxXy
         HzZs8s0uryLPNBibyETCteW4jtuchfhnwJXNZEpUUqZGJcU4tMl2U8VxD7SIAnYH0i5R
         ixei7lB5TwdP23fvVSVokP3qK+qWwlKxsver+CHI7N///uKlzRm9To6aZnxI4xxHkDgZ
         pND8JtmHSARuQ7HOBwQ4YvD/nTefgsOAyU0GXlpFhEEyhEVkHZC9lm47M0eijyJ4kJJ3
         5UD9Nt43IfARXR0gVmCL/uDqv9EW9dbTh69v3Qe5bvxbM5eRjWYS4Y5cHvziv70HL81L
         vRbQ==
X-Gm-Message-State: ALQs6tDSNt3uhgD9hfPWX5Guzk9hXlL260SxE+G8X/7KHkb/kOS6/pIo
        PeJbp2NOWCPNbLuGE+Rs2Do=
X-Google-Smtp-Source: AIpwx4/e/gOvyShYNotDulM5w9p0Vtoio1HdPRYcC5C9I4NfR3p2CUerba1thDBfRCVuXLjVWYboNw==
X-Received: by 10.28.26.73 with SMTP id a70mr1797758wma.30.1522703807461;
        Mon, 02 Apr 2018 14:16:47 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id 90sm1444285wrl.10.2018.04.02.14.16.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Apr 2018 14:16:46 -0700 (PDT)
Date:   Mon, 2 Apr 2018 23:20:16 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH v6 2/6] reset: introduce show-new-head-line option
Message-ID: <20180402222016.GI2629@hank>
References: <20180325134947.25828-1-t.gummerer@gmail.com>
 <20180331151804.30380-1-t.gummerer@gmail.com>
 <20180331151804.30380-3-t.gummerer@gmail.com>
 <xmqqwoxpxsfv.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqwoxpxsfv.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/02, Junio C Hamano wrote:
> This is completely offtopic tangent, but I wonder how hidden-bool or
> hidden options[] element in general interacts with the recent
> addition of helping command line completion.  Are we already doing
> the right thing?

I had a quick look at this, and it looks like we're doing the right
thing here.  The following snipped from the 'show_gitcomp' function in
parse-options.c:


>	for (; opts->type != OPTION_END; opts++) {
>		const char *suffix = "";
>
>		if (!opts->long_name)
>			continue;
>		if (opts->flags & (PARSE_OPT_HIDDEN | PARSE_OPT_NOCOMPLETE))
>			continue;

So if the PARSE_OPT_HIDDEN flag is given, we skip printing the option,
which seems like the right thing to do.
