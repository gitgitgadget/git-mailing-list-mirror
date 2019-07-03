Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49F561F461
	for <e@80x24.org>; Wed,  3 Jul 2019 16:50:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbfGCQul (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jul 2019 12:50:41 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45079 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726686AbfGCQuk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jul 2019 12:50:40 -0400
Received: by mail-wr1-f65.google.com with SMTP id f9so3587926wre.12
        for <git@vger.kernel.org>; Wed, 03 Jul 2019 09:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=xSAvoZO7ek+KTKeUkgaD+rJSaRGlCniZG3jIql6vHRU=;
        b=hoOq112owY1Ktcp5IQwrmB5nBW7RvDR2DZtAu4UCRqvYeUGBb1zjhDU8UnxiGY86t1
         o0Ca9HyqPqEJ2CcC2A8cvTITZ11svKBQFvMrPHZZKRZUPmwWgjAnG3Id905VENimkN0l
         PFuBazOodhA696xzx/ksAdu8EISVbyeHRfykYeOrw/AbisQFXO/AMezdUjdSqrTSlDev
         /Ndb1DH9rwAT+lHkv+AQfBGjcHl9qn2dP+hp3pir1ne8rknIsYRqTchyMAWZWcpvFAct
         pp0f8G/YsYYNe24FHrztpChP/0QqnIiWfi4fFVaWYoFxr5SY0RkoQxvRBa2iHwaCNWtQ
         zwRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=xSAvoZO7ek+KTKeUkgaD+rJSaRGlCniZG3jIql6vHRU=;
        b=R1BRLpSvgFnXkP5B2Tqvs/ve3YCzRUcN2eplZIkqJHgVqrsD8nRkoXiDXvQ0mVpjJ3
         6rT3ATHXNXZDrAaA7vW91irbEoueTXwx3ZOvHZje8TlKPuNT/9k+710rKFb5kPr0xF6F
         9RofStysz3ahTEaB6w0LahluZ/EVxzNX7EKkW3vpXWGzEo5+IFh0Nri8FysCJuGT0/Zx
         yFsCQgmmaChsBuiAuHbNStsjDadOdL9VZFuUz8HaUK8+vf5ZAMrhGiXGsqSFJRbMeTrF
         KPWKpRUAo08/RZky98Xs1Wlwh6AmCUbSmyq0OZ3Ai0G975VatjeP+aP3l+8gswF0M8i/
         /xhw==
X-Gm-Message-State: APjAAAVearlXA/4zfnN9eLmgczRnbPV0UMmT/rvUTvbFIJzYH3SCDE8+
        rqlNle46hW9sMhzLwy4GvU4=
X-Google-Smtp-Source: APXvYqyreADP3dGnMBd5Z1+8i/UxIrc6/fuC7V1A6iYTFVS13e17EvcWTTXUZ8hGArvvRSBzLqkRcA==
X-Received: by 2002:adf:ea8b:: with SMTP id s11mr22880881wrm.100.1562172638663;
        Wed, 03 Jul 2019 09:50:38 -0700 (PDT)
Received: from szeder.dev (x4db51bef.dyn.telefonica.de. [77.181.27.239])
        by smtp.gmail.com with ESMTPSA id f7sm2646275wrp.55.2019.07.03.09.50.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jul 2019 09:50:37 -0700 (PDT)
Date:   Wed, 3 Jul 2019 18:50:36 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 2/2] check_everything_connected: assume alternate ref
 tips are valid
Message-ID: <20190703165036.GS21574@szeder.dev>
References: <20190701131713.GA25349@sigill.intra.peff.net>
 <20190701131815.GB2584@sigill.intra.peff.net>
 <20190703091225.GQ21574@szeder.dev>
 <20190703164116.GA23260@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190703164116.GA23260@sigill.intra.peff.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 03, 2019 at 12:41:16PM -0400, Jeff King wrote:
> On Wed, Jul 03, 2019 at 11:12:25AM +0200, SZEDER Gábor wrote:
> 
> > On Mon, Jul 01, 2019 at 09:18:15AM -0400, Jeff King wrote:
> > > diff --git a/t/t5618-alternate-refs.sh b/t/t5618-alternate-refs.sh
> > > new file mode 100755
> > > index 0000000000..3353216f09
> > > --- /dev/null
> > > +++ b/t/t5618-alternate-refs.sh
> > > @@ -0,0 +1,60 @@
> > 
> > > +test_expect_success 'log --source shows .alternate marker' '
> > > +	git log --oneline --source --remotes=origin >expect.orig &&
> > > +	sed "s/origin.* /.alternate /" <expect.orig >expect &&
> > 
> > Unnecessary redirection, 'sed' can open that file on its own as well.
> 
> Sure, but is there a compelling reason not to feed it as stdin?

Not really, other than there is no compelling reason to do so :)

