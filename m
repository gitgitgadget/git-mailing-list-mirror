Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BBA351FE90
	for <e@80x24.org>; Wed, 19 Apr 2017 14:03:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1763974AbdDSODh (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Apr 2017 10:03:37 -0400
Received: from mout.web.de ([212.227.17.11]:53770 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1763881AbdDSODg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Apr 2017 10:03:36 -0400
Received: from [192.168.178.36] ([79.213.114.92]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MYf78-1cVPB81vpy-00VNtP; Wed, 19
 Apr 2017 16:03:24 +0200
Subject: Re: [PATCH v3 1/2] use HOST_NAME_MAX to size buffers for
 gethostname(2)
To:     Jonathan Nieder <jrnieder@gmail.com>,
        David Turner <dturner@twosigma.com>
Cc:     git@vger.kernel.org
References: <20170418215743.18406-1-dturner@twosigma.com>
 <20170418215743.18406-2-dturner@twosigma.com>
 <20170419012824.GA28740@aiede.svl.corp.google.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <269cbe1c-d10a-7022-1977-2128d59aebb3@web.de>
Date:   Wed, 19 Apr 2017 16:03:19 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.0.1
MIME-Version: 1.0
In-Reply-To: <20170419012824.GA28740@aiede.svl.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:uYSSe51MKjIFyLSE0RWomC+hbIrjs9ky310Omfggfgw8Pjf3dT2
 LEgeONHFQQNWpmj4cJSfML8rlYyLJtB2QjCTutw0C3PruJmAZSqNM4OWdOz0T+MfTPGRmnE
 T/RslfAVOV+wl5l6WCMKd6IrUg0MPtBrQx5McT6BfnwmFqVcpru5w/pmifQtm/kCtFF2wO8
 XuVQrBkXGewMrSI7fv9yw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Px9l6FjsSn8=:3Rl3LYIbYqm7WftAgyiVDi
 pEHWf1dAG01Rzyj2di07l4wVMpzQFHlwHeoPJ76z22JBaZw1DWeWYY4+sGSfFG6QDfebstjye
 BHN49yhAr3GdeQwIbak4kv80YUpT4Ig55N9BAviVEcVN61uY9xYKWxPK6+e9BaAAWG+DamWMq
 oDVYaddExncx/ARcamkWKwSWzJeS+LBoPh+G2c3c4lQwl79wiqS3Rc+eeA+UVtmQHybe4qLwE
 E/Uy8McwaJUX02GQheC6BsuNtasz8mvlEfQ02E1G7B6f1/5r1RtA6sdv4Qyfvm3x7iizq2QXe
 PnYuu6qLU+hyVCbTnzovYi1bl+DQtgMphhqOfTZv3P19N4vJs9pk35n1/POPzgrbc67VpjBHf
 n4RYWiIzaQ8PLSaElgWEmuJ0Qt2BeqPw+eiIh0YHSgEXAmXTP1uqXqReen81GnDnziP6AsBEj
 WMSzw1OYnXuQJqCWLpkaXRSDyDB3Y+jpCRBrYbetQFQvrY3Sl4xDdllK1/ingcvgX6QIPl/ZK
 LXBxZR/28ZZRsC5yJ90b1UE3n3iKR6T+AWEwZkyXonfxBM6x6N+xtwymlbErKJyIzFJ70hZqG
 yAEyO+Tq2+ZHNGzVJJwGodiOakjJX0z7oFzkHubW672lM9OvG/zTEF/3I0/za4IbU150hkUXR
 ChDzCEPq8Y/SlGqu8UHz1VWdBuBmK6eHq53Lz/uENRcZuCWzdX0l6nQeageheJEvaJWFqG/2l
 jVseOVYrCOEr9wk8G4q90c8N6tK4+YjuRVesrl8XDXxN7OFohi6bX+ZMaI68ThZqlZF7PwU2U
 zsn8mee
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 19.04.2017 um 03:28 schrieb Jonathan Nieder:
>> From: René Scharfe <l.s.r@web.de>
>>
>> POSIX limits the length of host names to HOST_NAME_MAX.  Export the
>> fallback definition from daemon.c and use this constant to make all
>> buffers used with gethostname(2) big enough for any possible result
>> and a terminating NUL.
> 
> Since some platforms do not define HOST_NAME_MAX and we provide a
> fallback, this is not actually big enough for any possible result.
> For example, the Hurd allows arbitrarily long hostnames.

Interesting.  No limits, eh?  They suggest to allocate memory
dynamically [1].  Perhaps we should import their xgethostname() (which
grows a buffer as needed), or implement a strbuf_add_hostname()?

René


https://www.gnu.org/software/hurd/hurd/porting/guidelines.html#MAXHOSTNAMELEN_tt_
