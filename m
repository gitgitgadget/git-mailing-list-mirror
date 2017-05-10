Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5036E20188
	for <e@80x24.org>; Wed, 10 May 2017 18:55:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932110AbdEJSzb (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 May 2017 14:55:31 -0400
Received: from [195.159.176.226] ([195.159.176.226]:33196 "EHLO
        blaine.gmane.org" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S932089AbdEJSza (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2017 14:55:30 -0400
Received: from list by blaine.gmane.org with local (Exim 4.84_2)
        (envelope-from <gcvg-git-2@m.gmane.org>)
        id 1d8Wld-0005sh-0w
        for git@vger.kernel.org; Wed, 10 May 2017 20:55:21 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:     git@vger.kernel.org
From:   Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH] fetch-pack: always allow fetching of literal SHA1s
Date:   Wed, 10 May 2017 20:55:19 +0200
Message-ID: <86ede049-ac9e-0886-acde-42e53ef30243@gmail.com>
References: <20170509182042.28389-1-jonathantanmy@google.com>
 <20170509221629.3z35qcz36oiix3kh@sigill.intra.peff.net>
 <CAJo=hJvAg2WqpiuykpbHcB5vgQiHJ74CZ8Y4qudkYqZrmd30zg@mail.gmail.com>
 <20170510043343.mgb7heqzu2etcgvf@sigill.intra.peff.net>
 <20170510170044.GX28740@aiede.svl.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@blaine.gmane.org
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12)
 Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
Cc:     Shawn Pearce <spearce@spearce.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        git <git@vger.kernel.org>
In-Reply-To: <20170510170044.GX28740@aiede.svl.corp.google.com>
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2017-05-10 19:00, Jonathan Nieder wrote:

>> Right, makes sense.  I wondered if GitHub should be turning on
>> allowTipSHA1InWant, but it really doesn't make sense to. We _do_ hide
>> some internal refs[1], and they're things that users wouldn't want to
>> fetch. The problem for your case really is just on the client side, and
>> this patch fixes it.
> [...]
>> [1] The reachability checks from upload-pack don't actually do much on
>>      GitHub, because you can generally access the objects via the API or
>>      the web site anyway. So I'm not really opposed to turning on
>>      allowTipSHA1InWant if it would be useful for users, but after
>>      Jonathan's patch I don't see how it would be.
> 
> Given that, what would make me really happy is if github enables
> uploadpack.allowAnySHA1InWant.  That would be useful for me, at least.

Me too, BTW. If you're only interested in building / analyzing a 
specific SHA1 it's really a waste of network resources to fetch all of 
the history.

-- 
Sebastian Schuberth

