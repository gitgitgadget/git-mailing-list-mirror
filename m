Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C1B341F731
	for <e@80x24.org>; Wed, 31 Jul 2019 04:06:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbfGaEGh (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jul 2019 00:06:37 -0400
Received: from mout.web.de ([217.72.192.78]:37011 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726378AbfGaEGh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jul 2019 00:06:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1564545973;
        bh=F62GK4eJu2CvdYqnk4Kg1c6wzjY+7xCIl962bDJWWwc=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=LMzPl6gIj0kfwK8zNUSaUsSGhuEDHdhH0YnnZtVmK//fD9dPVRlTYxpoV6Dbv9M4A
         PXeIP8+rv7vvRj6k4ExgwDQcyzfyxtxtyuiwmiNzt12dAoAdqeIELH0hmMZJ9wmJcf
         eMNBKgraXAowMQT52sTn3iKsVUgCqv3LWql0GtD4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.23] ([79.203.24.71]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LgYSP-1ig3NI1I61-00o1A5; Wed, 31
 Jul 2019 06:06:13 +0200
Subject: Re: [ANNOUNCE] Git v2.23.0-rc0 - Initial test failures on NonStop
To:     Jeff King <peff@peff.net>, Todd Zullinger <tmz@pobox.com>
Cc:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        'Junio C Hamano' <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        git@vger.kernel.org, git-packagers@googlegroups.com
References: <049a01d546f9$70be7a30$523b6e90$@nexbridge.com>
 <20190730194938.GZ4545@pobox.com>
 <20190730200203.GA4882@sigill.intra.peff.net>
 <20190730205624.GR20404@szeder.dev>
 <20190731005933.GA9610@sigill.intra.peff.net>
 <20190731012336.GA13880@sigill.intra.peff.net>
 <20190731015917.GB4545@pobox.com>
 <20190731032735.GA14684@sigill.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <b32a178d-0255-6c82-a3fd-ced2ec828fc8@web.de>
Date:   Wed, 31 Jul 2019 06:06:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190731032735.GA14684@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XJvA9cm810AybSt0JNtfb6ceVqhEkonD0+pOj6Kk0dahDjq01ve
 OwkWKKXAnlrJ3G4YlVqX4VY3ReLER9x/45Cuq8tJQBX4DpPyDLrm0/3Tz+7uxuRL/umNN1n
 QJyE4pY0kZmfVhEBj+W+lilE852v6ilK1n8RWQ7ydae5r/CUuRaRthIlG1NoTf78f9YE/cv
 FMpgcvjQp2YucEoePuHFg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:OaYmu3LuNb4=:p9LazyAqZdesi5h927gCxh
 Vmj6FXzc5TQDmJjHUQTYGvAEprFWXcbfSwPdTK9wsYQP2ZTYZ3gH7Ur1xO10woNdJCf/qsp26
 pRvawhunkE2+zv+7sE6cWKXmZCJJfgiwJq84NqneY51NAVN5ncVN3NrAY28fHZEkwZCQW6tPb
 xjN8yyEZzX45upSLSE/1QZzzhxbp8WJkSAEyIybpv1mC1lZBxOcaM8vnYOA9XU4zuOiV6WHtV
 HzIbbF8aAGUv6Jxav/QEYKbH/MV+SNZuqdVkqyrYze4hJIjJ565uIpUZptFCQo/FzAeojOL0Q
 axsURU6Wk5bNOCw9pOWzfPV1Q4jXBP2W7n4UhfBMYrsToQ4obuO/+ADDn6ABIf+Iosc4qbJsV
 ErkXWNPq/oQsLpnG9F2eDaIEivnhfzs3dmlcudIBL0weXmumH/wJrp6KTN93jULc38fmNyDwq
 rP+05EEE8h4o0PSvDFIXJ4lN0KLpqePDjjutKqvMhw9sgfErbY0p0lLuG9gcUqbRIqS08BJ5F
 ETFMPkV22+nA6Z4Rj1a7FWNsEL2gnm+lA18dckVoHjnF/siB7s9cncBrk+jEPyKwqCL1eyz+T
 UxEs5HSl91kcMsW9LEpX70Wzoh66fhVdItlSl2MY9t6Rcwdje1ynKQt9r7C8FDtFyXSNiZdEE
 du8enD35nmxLDGltEKJSwySGt7leZbT1aD1IQsNT7ymdI4GArb8LuvRM2zKzLIvhE4Iw1h6jY
 Rk6qj4S2LK06mWzM6w3vssRz7TDw53gRUi58Kz6jBMDhBr/3xgaJ+wjymykXacb3uUlaQUs7H
 mES9ZXyEICIH1IE8zQ5rMCfRRUnR6yXFHGf3MXCmvInLAWRnNJqXAv/NlRn1Kj64r1vhxlBnb
 0y6QymfNrSct8X9iM5ZAcUZw08NBQ7vy7FYp7Mmnvh+wh3YKnUO0n4HfOYIlm9hEsC2kI/SEn
 3W8/Wzv1QUKgU23ee//5Zh5hk9rvlT2/4CO0lcLpoqxXT3RCCjnyEi66gVytTtaIt0l0V/nK1
 iOeYYDRZ91J5NCY8btFegJLqhQsgDIkH68+4BaTIY4UhXetZrc3/Xyb8QSNQBrhnS8UrmKljm
 L/6+XMeaLlqCJ0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 31.07.19 um 05:27 schrieb Jeff King:
> One thing that makes it all a bit funky is that the "put" lines also
> output the old value (which is what all those NULLs) are. And I think
> that solves my "value3" puzzlement from earlier. It is not part of the
> iteration at all, but rather the result of the duplicate "put".
>
> That would perhaps be clearer if the "hashmap" tool actually did the
> sorting itself (so we'd sort _just_ the iteration, not the whole
> output). Something like this, though I'm on the fence about whether it
> is worth it:

We already have a few other tests that sort and compare.  Perhaps it's
time for a test_cmp_ignore_order?

And perhaps something like this might even be worth implementing as a
diff option?  https://github.com/l0b0/diff-ignore-moved-lines has
post-processing script for that..

Ren=C3=A9
