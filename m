Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D083203E1
	for <e@80x24.org>; Sun, 24 Jul 2016 23:22:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752415AbcGXXWZ (ORCPT <rfc822;e@80x24.org>);
	Sun, 24 Jul 2016 19:22:25 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:35516 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752039AbcGXXWZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jul 2016 19:22:25 -0400
Received: by mail-wm0-f51.google.com with SMTP id f65so115629304wmi.0
        for <git@vger.kernel.org>; Sun, 24 Jul 2016 16:22:24 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:newsgroups:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=eUMiUjMWqtCIE17ST2Mc8KW5qVpvOsGhXswRoMaFosk=;
        b=GKjp+syJZMoAanZzys8pziipictgDvWVDpiBwGpb3dTAPuTr8X0S1thbi77TNCE+qn
         ZpDsIEwd1VDE5w8uu4lvx5Zok5ca/7QpU1JgysmPmCh4y8w0pPkp5QpoEVg6bcMWVK62
         aphFQ+0R8HfNYvhrdoRY2KpAc+YmmYY+FEkDwXdKwEHqcgLZACpbe5llt+l8PemCQHRp
         QdlLWQ5aKY5cAjsqMMkHvmfogFkZhkho/X0hD/QLcubXRnmujjPd9rNQA9tkFwgeAtwF
         LH9ZGhS33uCpPP6W6YvzS2SUzNAA85U9VuHKgnxQWoTq5Ab8ln31AR6MpMlcRKYVV5za
         iSNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:newsgroups:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding;
        bh=eUMiUjMWqtCIE17ST2Mc8KW5qVpvOsGhXswRoMaFosk=;
        b=iQ00cgFDnkRjOPXjk1Ms18Sf39wwOO4Y++SEl4UKL2bP160xjccP3V0/LEneqHy8D5
         FaJBahYVcxROBi7H81ue+qUgscQwdgLCTCEGTTaEk2aJkBt6s6Y7MnkPPWZ8ZzQo/5QS
         jHFJP1QXA4kKUVCdnptmuGgGcymfY6Kx9sw4ezOHSYL1Kk3NN4ATxjuAJUbuOB1GLacu
         kj4WuEwbI0VRhRNZJZLliK5L9YNUnHk7U4L1LQjK9vwNDc135itk1m0p9CAyP9T1cNuP
         EEz8KbxdtNUYDzWEb82qI2E1EBpxhiL30NCPFdEkhgZ4d4FY0xugSl8DFCcsCd3Tpn1t
         5LHw==
X-Gm-Message-State: AEkoouvLkDhgRLUBj5JZfvCmkfQRVbvrjEVBJjerVNNCrsNP1Rhr26y/3GzedgS39ERgUg==
X-Received: by 10.194.248.33 with SMTP id yj1mr4283980wjc.158.1469402543330;
        Sun, 24 Jul 2016 16:22:23 -0700 (PDT)
Received: from [192.168.1.26] (exa83.neoplus.adsl.tpnet.pl. [83.20.250.83])
        by smtp.googlemail.com with ESMTPSA id kc6sm12750701wjb.3.2016.07.24.16.22.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Jul 2016 16:22:22 -0700 (PDT)
Subject: Re: [PATCH v1 3/3] convert: add filter.<driver>.useProtocol option
To:	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Lars Schneider <larsxschneider@gmail.com>
References: <20160722154900.19477-1-larsxschneider@gmail.com>
 <20160722154900.19477-4-larsxschneider@gmail.com>
 <9f47cf44-7163-a7a7-c1f0-87ebdee65b37@ramsayjones.plus.com>
 <1A0C148F-C7C3-4FAF-BAEE-58B11A2324FF@gmail.com>
 <194ea810-76ff-f32c-0f8a-57e8e60b65f5@ramsayjones.plus.com>
Cc:	Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	=?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
	mlbright@gmail.com
Newsgroups: gmane.comp.version-control.git
From:	=?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <57954DA3.9090006@gmail.com>
Date:	Mon, 25 Jul 2016 01:22:11 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
MIME-Version: 1.0
In-Reply-To: <194ea810-76ff-f32c-0f8a-57e8e60b65f5@ramsayjones.plus.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

W dniu 2016-07-25 o 00:36, Ramsay Jones pisze:
> On 24/07/16 18:16, Lars Schneider wrote:
>> On 23 Jul 2016, at 01:19, Ramsay Jones <ramsay@ramsayjones.plus.com> wrote:
>>> On 22/07/16 16:49, larsxschneider@gmail.com wrote:
[...]
>>>> This patch adds the filter.<driver>.useProtocol option which, if enabled,
>>>> keeps the external filter process running and processes all blobs with
>>>> the following protocol over stdin/stdout.
>>>>
>>>> 1. Git starts the filter on first usage and expects a welcome message
>>>> with protocol version number:
>>>> 	Git <-- Filter: "git-filter-protocol\n"
>>>> 	Git <-- Filter: "version 1"
>>>
>>> Hmm, I was a bit surprised to see a 'filter' talk first (but so long as the
>>> interaction is fully defined, I guess it doesn't matter).
>>
>> It was a conscious decision to have the `filter` talk first. My reasoning was:
>>
>> (1) I want a reliable way to distinguish the existing filter protocol ("single-shot 
>> invocation") from the new one ("long running"). I don't think there would be a
>> situation where the existing protocol would talk first. Therefore the users would
>> not accidentally mix them with a possibly half working, undetermined, outcome.
> 
> If an 'single-shot' filter were incorrectly configured, instead of a new one, then
> the interaction could last a little while - since it would result in deadlock! ;-)
> 
> [If Git talks first instead, configuring a 'single-shot' filter _may_ still result
> in a deadlock - depending on pipe size, etc.]

Would it be possible to do an equivalent of sending empty file to the filter?
If it is misconfigured old-style script, it would exit after possibly empty
output; if not, we would start new-style interaction.
 
This should be, if we agree that detecting misconfigured filters is a good
thing, tested.

>>
>> (2) In the future we could extend the pipe protocol (see $gmane/297994, it's very
>> interesting). A filter could check Git's version and then pick the most appropriate
>> filter protocol on startup.

