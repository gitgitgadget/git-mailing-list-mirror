Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,FREEMAIL_FROM,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D53C20401
	for <e@80x24.org>; Thu, 15 Jun 2017 16:12:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751909AbdFOQMv (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Jun 2017 12:12:51 -0400
Received: from mout.web.de ([212.227.17.12]:62506 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751883AbdFOQMu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jun 2017 12:12:50 -0400
Received: from [192.168.178.36] ([79.237.60.227]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M6E6g-1dj6sL0n4U-00y6Pz; Thu, 15
 Jun 2017 18:12:35 +0200
Subject: Re: [PATCH 2/2] date: use localtime() for "-local" time formats
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Ulrich Mueller <ulm@gentoo.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <20170615134958.mzmdmhonjsnconu2@sigill.intra.peff.net>
 <20170615135216.2jfsrjpicku6zxv3@sigill.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <b79d1c3d-e43e-a82b-2d33-2283cb0aa5ef@web.de>
Date:   Thu, 15 Jun 2017 18:12:31 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <20170615135216.2jfsrjpicku6zxv3@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:xVe5S8eAqlhIzBhAJvPvcBlo3W2auzH8KfM700sYvwT/LFSj2BO
 MhKCFWIbuED7d3ikGP9drz8XF9Ln9LcQc9tWEXZC2mqpTPp5vK7FxMJZGPBJ3SJx0Axc9m1
 ydYX+1JEa9nyutwfQFtM7JS1CZABEjyEo1ojLgWtIvn9RlHKjj3kymrnyjEmj0sjSND69ZH
 n0eweW7ZRF7g8LhS+kg8w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:6aZDXyWJtTs=:ZsndQWY5m6AntVdk6iGETL
 pv9gsTS4E6+yGypdYa2JumqITnpKWi1O8Qo7BHY8ImxSqDuJqyfIt2tjaFgKDiJRVfGd+ZZwX
 dT0M/iU8BPeLAGAKQorJJ3SHh8UnACVVVUq4uvCsyfLq/kImfID5WmTMi9oJ7cx5IhATW1fJF
 uTebAjNBz+dhlnNo85ECvu9XLy1rrQLj3iSGdrfEh9csl3mdWf4BEt3DGuYD+9c9W8fm6hw7n
 NByIbYJSUnJnZ7zifdOJbAMimxzF1vdVr9x9CV9LG6j2MSPuUs8KVI0pqShBzC+rkwWQaHTfE
 rP3SEXG+/KNHVZMYxq7tsrte8Y0BNAExLzuoVXeTovJy8plooRd1ZO6w1BbVgL6KPcN8AH5uF
 wPDj85hTU6lrFH2R9+h5Zb80VUS2Sm4tknccEtFHRdcWiq2gmQtrAE6i8SEH4+/P7LezE+rJ4
 RitfbbrUoGMeV8gSrKUJfmYhYDNcA6FupE6BJ2v8vvOXb+TqxyGBlNk7pDZ1HOzbTLhqTZGh8
 a/rhDPm/OqM4U5JsbHBD+2KM/IzWBVKFd/Eb5qhMnp+/Okc7QfjrOlq1tMtDUCDWpzKQNPJte
 Cnxo7RVlZ8qxiXAH/KhRfOls2OLmYrGlm+Z1T8hW4mzzEaPdOBQRU560vTIsiBkcvM2ag2coL
 1vFTncQmSCDQu1HCPUSYjA42A0mlS3mznaY9RqrZjahwNN5YBnhLKPjORkBIwWm5FUG916M88
 W3Urzkj5Fbzyl6BKn3FwxBkevh/4TpnIzPGZ8iEog94A3+57noPLdKoCG3twQ6H9QXNzGSO67
 BcIrmeF
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 15.06.2017 um 15:52 schrieb Jeff King:
> But for the special case of the "-local" formats, we can
> just skip the adjustment and use localtime() instead of
> gmtime(). This makes --date=format-local:%Z work correctly,
> showing the local timezone instead of an empty string.

Documentation/rev-list-options.txt should be updated to mention that %Z
is passed to strftime in the local case, no?

> The new test checks the result for "UTC", our default
> test-lib value for $TZ. Using something like EST5 might be
> more interesting, but the actual zone string is
> system-dependent (for instance, on my system it expands to
> just EST). Hopefully "UTC" is vanilla enough that every
> system treats it the same.
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> I don't have a Windows system to test this on, but from the output Dscho
> provided earlier, I believe this should pass.

The first patch applies with some fuzz on master of Git for Windows, the
second one applies cleanly.  A "typedef unsigned long timestamp_t;" is
required to compile it; such a fixup won't be needed for long, I guess.
t0006 succeeds.

René
