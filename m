Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 56E301FAFB
	for <e@80x24.org>; Wed,  5 Apr 2017 09:36:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932376AbdDEJe2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Apr 2017 05:34:28 -0400
Received: from hapkido.dreamhost.com ([66.33.216.122]:34511 "EHLO
        hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932277AbdDEJdm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Apr 2017 05:33:42 -0400
Received: from homiemail-a95.g.dreamhost.com (sub4.mail.dreamhost.com [69.163.253.135])
        by hapkido.dreamhost.com (Postfix) with ESMTP id 41C4D8D232
        for <git@vger.kernel.org>; Wed,  5 Apr 2017 02:33:41 -0700 (PDT)
Received: from homiemail-a95.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a95.g.dreamhost.com (Postfix) with ESMTP id D25B66000503;
        Wed,  5 Apr 2017 02:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jupiterrise.com; h=subject
        :to:references:cc:from:message-id:date:mime-version:in-reply-to
        :content-type:content-transfer-encoding; s=jupiterrise.com; bh=y
        aNJL5MUdz5uoGUhy3ESqPIgh/o=; b=ERtbR2VZgkVnxxci3Kmee/N6ps1JXEcN8
        TPISpe4Bv+bp4Q0BjOEUYG3D+/sBh8uwbCqrB2ZZbMCjAh/pb9v46HcplJuIkOhm
        nHoLjOlr5wtV+rDCPGpv0rBEhBKbHtBEtCUQaFrsN/ynpDauRhdf0l0F78zONFQv
        Q/4B/c2iLs=
Received: from merlin.tgcnet.jupiterrise.com (2-106-159-182-static.dk.customer.tdc.net [2.106.159.182])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: tgc99@jupiterrise.com)
        by homiemail-a95.g.dreamhost.com (Postfix) with ESMTPSA id 93E156000501;
        Wed,  5 Apr 2017 02:33:40 -0700 (PDT)
Received: from [172.18.98.35] (nat.statsbiblioteket.dk [130.225.26.33])
        by merlin.tgcnet.jupiterrise.com (Postfix) with ESMTPSA id 1D004612D5;
        Wed,  5 Apr 2017 11:33:38 +0200 (CEST)
Subject: Re: [RFC] dropping support for ancient versions of curl
To:     Jeff King <peff@peff.net>, git@vger.kernel.org
References: <20170404025438.bgxz5sfmrawqswcj@sigill.intra.peff.net>
Cc:     Jonathan Nieder <jrnieder@gmail.com>
From:   "Tom G. Christensen" <tgc@jupiterrise.com>
Message-ID: <d6ba17f0-3da9-8699-8d5c-5ebf1eaef00e@jupiterrise.com>
Date:   Wed, 5 Apr 2017 11:33:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170404025438.bgxz5sfmrawqswcj@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/04/17 04:54, Jeff King wrote:
> A nearby thread raised the question of whether we can rely on a version
> of libcurl that contains a particular feature. The version in question
> is curl 7.11.1, which came out in March 2004.
>
> My feeling is that this is old enough to stop caring about. Which means
> we can drop some of the #ifdefs that clutter the HTTP code (and there's
> a patch at the end of this mail dropping support for everything older
> than 7.11.1). But that made wonder: how old is too old? I think it's
> nice that we don't force people to upgrade to the latest version of
> curl. But at some point, if you are running a 13-year-old version of
> libcurl, how likely are you to run a brand new version of Git? :)
>

FWIW I maintain freely available updated git packages for RHEL 3, 4, 5, 
6 and 7.

They can be found here:
https://jupiterrise.com/blog/jrpms/

And direct access here:
https://jupiterrise.com/jrpms/ (for el3,el4,el5)
https://jupiterrise.com/jrpmsplus/ (for el6, el7)

They are built against system versions of curl though a few patches are 
required for 7.10.6 (el3) and 7.12.1 (el4) support.
Patches can be found in the src.rpm, though I can also post them here as 
patch series, they cover more than just curl.

I don't use the el3 and el4 versions much any more and el5 use will also 
drop of now as I'm busy converting machines from el5 to el7.

-tgc
