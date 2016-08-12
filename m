Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C72A61F859
	for <e@80x24.org>; Fri, 12 Aug 2016 17:14:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752752AbcHLROE (ORCPT <rfc822;e@80x24.org>);
	Fri, 12 Aug 2016 13:14:04 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36061 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752461AbcHLROE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2016 13:14:04 -0400
Received: by mail-wm0-f66.google.com with SMTP id i138so3996954wmf.3
        for <git@vger.kernel.org>; Fri, 12 Aug 2016 10:14:03 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=2kpPLfbytAtYbdhxuR1bwuX6fxhlkGqetzPxNeaI334=;
        b=FZu+kyCnutkR9kBU3aaCNGewQWmJeYdI2se6jtt+ep4dr3wvidzI41dl2BC44kUNn/
         Q5l6ORD+MPZYGoC9NXC7KVVceOKFLuWPSm74l3WAJOjA7ePN7BesXBuPSbmBuy4FN5ib
         7FEY5StXxdTT7Uqtm/Y0BilQOIpznGeftEs78jHx2vIiN1LXEFlBIlI6j53hwesZF5Ng
         x5bhj6vEphJH57av4x1mfaOBwAOrrFU8592KN9UOuBl7kQi7r/s88+FmDrROArH/IBBi
         szYD68CH7kjHpRbpqZbMverlAQ0pXIxgIJK9IvJnqleKytG1N0q8EPCHKNKe2CN5X+BQ
         SHyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=2kpPLfbytAtYbdhxuR1bwuX6fxhlkGqetzPxNeaI334=;
        b=FEei3Ez0EANbBNkLB54z5F7HjNwuumeZnpDVlCarPoYtRdL2fSEwnUB+bZ0R9pf2RL
         cP3dI4RVP0ip0BIDTJWYA6kWtS8W2x0zIKUBEIPhajSHFTNdvYRBBH2g3nPQ5ULbOvZU
         uBKk300wBacUa/d9Mru8XrdopGDWDp14j3v1k8oznB83lvlhihh98QKc3Yz48pER+7BB
         C9movwSidI6Y+80JL4BB/hYRMRuqAkDdjuwiWbCdf9+udrpIFBnIxnZRe1UwV0x4zfK5
         ehX3nbn9NvqYMdCyBEWv5mm17ebfVVzdKOkj8EPnZITyjF3XntkQ28YZSCyApB9/1jOu
         Z+1Q==
X-Gm-Message-State: AEkoouvhl0Uyk5nRyH21qfwztewv6EtKLtb0K4wOp34rDRqJMVY4fvm2DDPrHVswBFSQfQ==
X-Received: by 10.194.238.170 with SMTP id vl10mr16891879wjc.18.1471022042516;
        Fri, 12 Aug 2016 10:14:02 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id r16sm3397959wme.16.2016.08.12.10.14.01
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 12 Aug 2016 10:14:01 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v5 14/15] convert: add filter.<driver>.process option
From:	Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <CAGZ79kYL5ajdyJK8Yimy2O3b=x=46D2VuNgm2aZ5nD703y1A3Q@mail.gmail.com>
Date:	Fri, 12 Aug 2016 19:14:00 +0200
Cc:	"git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
	Martin-Louis Bright <mlbright@gmail.com>,
	Eric Wong <e@80x24.org>, Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, ben@wijen.net
Content-Transfer-Encoding: 7bit
Message-Id: <3605A4A8-468D-4EBF-B834-07D27F841AB2@gmail.com>
References: <20160803164225.46355-1-larsxschneider@gmail.com/> <20160810130411.12419-1-larsxschneider@gmail.com> <20160810130411.12419-15-larsxschneider@gmail.com> <CAGZ79kboxgBRHSa2s7CKZ1Uo=13WT=rT8VHCNJNj_Q9jQzZAYw@mail.gmail.com> <509A907F-B1B5-4244-B1C7-F1190296208D@gmail.com> <CAGZ79kYL5ajdyJK8Yimy2O3b=x=46D2VuNgm2aZ5nD703y1A3Q@mail.gmail.com>
To:	Stefan Beller <sbeller@google.com>
X-Mailer: Apple Mail (2.3124)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


> On 12 Aug 2016, at 19:07, Stefan Beller <sbeller@google.com> wrote:
> 
> On Fri, Aug 12, 2016 at 9:59 AM, Lars Schneider
> <larsxschneider@gmail.com> wrote:
>> 
>> The welcome message is necessary to distinguish the long running
>> filter protocol (v2) from the current one-shot filter protocol (v1).
>> This is becomes important if a users tries to use a v1 clean/smudge
>> filter with the v2 git config settings.
> 
> Oh I see, that's why we're at v2 now.
> How do you distinguish between v1 and v2? Does the welcome message
> need to follow a certain pattern to be recognized to make it v2+ ?

v1 has no format at all. It works like this:

1. Git starts the filter process
2. Git writes the entire file via stdin to the filter process
3. Git reads the result via stdout from the filter process
3. Git stops the filter process


Any v2+ would need to deal with the following:

packet:          git> git-filter-client
packet:          git> version=2
packet:          git> version=2+
packet:          git> 0000
packet:          git< git-filter-server

Everything after could be different in v2+ compared to v2.

Thanks,
Lars
