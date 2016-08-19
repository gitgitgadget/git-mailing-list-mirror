Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B3CD1F859
	for <e@80x24.org>; Fri, 19 Aug 2016 15:14:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754689AbcHSPOy (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Aug 2016 11:14:54 -0400
Received: from mail-pa0-f68.google.com ([209.85.220.68]:33812 "EHLO
        mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754014AbcHSPOx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2016 11:14:53 -0400
Received: by mail-pa0-f68.google.com with SMTP id hh10so3586268pac.1
        for <git@vger.kernel.org>; Fri, 19 Aug 2016 08:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ty3Byb/s/v0S/l7DFBB7Y1ESsEtRmohLQG81AsSDLjY=;
        b=EbPkT502SPwsrx9MAn/0m0bVUNjnzhOAmgJ1BaomZKHAsK2BRgiUGmNFOGLOxirQYX
         gSup5Dwms4q+YBGW3tUuyGkGovMfijF+Sx6DEn2CxjaELKnMq049jo2IS56Hff+QSzuS
         vb+3i3uNBPPgtLPlqHNULLYyaR7Hf01Ib0bJewjSeEJ8ta0qX3oMGvQlOuX/Y5UqNGG3
         Vt2ZsZI4ra7xDDLNAv3zr0wMdo0t+v+bEvdq7/xs8vJvv/5P4UPcMC71LcFOIDE3nxoy
         Ds4iZhr/JMthf/41SDkq8b9hEOHAtcEfAQOjtnXPt7+PyYU+3si5rI86JjMBHDnBHtI1
         L8WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ty3Byb/s/v0S/l7DFBB7Y1ESsEtRmohLQG81AsSDLjY=;
        b=S7LgA5nP2eEcai7kqk+vzdzGgF1XXaz+A8gXdUnwG4XH4Wwe55nSF3ntk0w02ydKfe
         suI+VocnKSEV6I6WVVELGo2WyZiGJ6w5UFwgT5yK9OzAYSmH1JtyMiGEsGKeAjrDXFyu
         BrnHDWDhQLC8zVnLPO/oKgcVyTwfcBhAZwY66tOTfH9ah9tzV8VOKUw73yaInDEswcyJ
         TcyeL1Lo30qhbpEaigDdolnNswQkqSL+2U0X81cTrHG5Q+AshH9JfW4owmzwKliYWPEh
         ewXRMkUINf9fGrjBBY8QhAEtK3qWPd/KaYyeoL/gyJr+KfaXJxgsOcNAueoKhAp0I6ix
         x5+w==
X-Gm-Message-State: AEkoouvFRseQaWOTxKRTJn6ocbqZywAGIyb1Ecac21GBQ5wHlrCvEyBO/nYBNW7bknEEqw==
X-Received: by 10.66.182.232 with SMTP id eh8mr14766191pac.146.1471619615079;
        Fri, 19 Aug 2016 08:13:35 -0700 (PDT)
Received: from tci.corp.yp.com ([216.2.203.2])
        by smtp.gmail.com with ESMTPSA id ro14sm12369091pab.32.2016.08.19.08.13.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Aug 2016 08:13:34 -0700 (PDT)
From:   Brian Henderson <henderson.bj@gmail.com>
X-Google-Original-From: Brian Henderson <bhenderson@yp.com>
Date:   Fri, 19 Aug 2016 08:13:32 -0700
To:     Jeff King <peff@peff.net>
Cc:     Brian Henderson <henderson.bj@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        e@80x24.org
Subject: Re: [PATCH v2 1/3] diff-highlight: add some tests.
Message-ID: <20160819151332.GB29458@tci.corp.yp.com>
References: <20160817153124.7770-1-henderson.bj@gmail.com>
 <20160810085635.GA1672@starla>
 <20160817153124.7770-2-henderson.bj@gmail.com>
 <xmqqziob8b6i.fsf@gitster.mtv.corp.google.com>
 <20160819144235.GA29458@tci.corp.yp.com>
 <20160819145123.73hf7ffysy53l3kz@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160819145123.73hf7ffysy53l3kz@sigill.intra.peff.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 19, 2016 at 10:51:23AM -0400, Jeff King wrote:
> On Fri, Aug 19, 2016 at 07:42:35AM -0700, Brian Henderson wrote:
> 
> > > > +# PERL is required, but assumed to be present, although not necessarily modern
> > > > +# some tests require 5.8
> > > > +test_expect_success PERL 'name' 'true'
> > > 
> > > If the platform lacks PERL prerequisite, this will simply be
> > > skipped, and if the platform has it, it will always succeed.
> > > 
> > > I am not sure what you are trying to achieve by having this line
> > > here.
> > 
> > I originally didn't have this line, and my comment was referring to the
> > t/README which says
> > 
> >    Even without the PERL prerequisite, tests can assume there is a
> >    usable perl interpreter at $PERL_PATH, though it need not be
> >    particularly modern.
> > 
> > There is current functionality in diff-highlight which requires at least
> > perl 5.8 (the utf8 functions). I was going to add a test for this as
> > well, but I'm not super comfy with multibyte chars.
> 
> Yeah, I'd agree this test would want the PERL prereq. It is not just
> using perl for one-liners in support of the script; it is testing major
> perl functionality that should be skipped if we do not have a modern
> perl available.
> 
> > Eric recommended adding this line, what do you think?
> > 
> > would `test_set_prereq PERL` be better?
> 
> test_set_prereq is for telling the test scripts that we _have_ perl, but
> what I think this script wants to do is test "do we have perl?" and
> abort otherwise. The way to do that is:
> 
>   if ! test_have_prereq PERL
>   then
> 	skip_all='skipping diff-highlight tests; perl not available'
> 	test_done
>   fi
> 
> > > > +test_expect_success 'diff-highlight does not highlight whole line' '
> > > > +	dh_test \
> > > > +		"aaa\nbbb\nccc\n" \
> > > > +		"aaa\n000\nccc\n"
> > > > +'
> > 
> > This (at least to me) is desired. See comment for `sub
> > is_pair_interesting`
> 
> Yeah, that is an intentional behavior, and makes sense to test.
> 
> > > > +test_expect_success 'diff-highlight does not highlight mismatched hunk size' '
> > > > +	dh_test \
> > > > +		"aaa\nbbb\n" \
> > > > +		"aaa\nb0b\nccc\n"
> > > > +'
> > 
> > This is undesired behavior, but currently implemented for simplicity,
> > see `sub show_hunk`
> > 
> > Do they need comments or something?
> 
> Undesired behavior should generally not be tested for. It just makes
> life harder for somebody when they make a change that violates it, and
> they have to figure out "oh, but it's _good_ that I changed that, the
> tests were wrong" (or more likely "I didn't fix it, but it's just broken
> in a different way, and neither is preferable").
> 
> If you want to document known shortcomings, the best thing to do is show
> what you'd _like_ to have happen, and mark it as test_expect_failure;
> the test scripts show this as a known-breakage, and somebody later who
> fixes it can flip the "failure" to "success".
> 
> -Peff

all very helpful, thanks!
