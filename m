Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 790CA203EB
	for <e@80x24.org>; Wed, 27 Jul 2016 17:33:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757095AbcG0Rds (ORCPT <rfc822;e@80x24.org>);
	Wed, 27 Jul 2016 13:33:48 -0400
Received: from mail-io0-f181.google.com ([209.85.223.181]:34189 "EHLO
	mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754303AbcG0Rdr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jul 2016 13:33:47 -0400
Received: by mail-io0-f181.google.com with SMTP id q83so77237543iod.1
        for <git@vger.kernel.org>; Wed, 27 Jul 2016 10:33:47 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=HvFqEnCS5gE/SyvGeSzzmRzYJIxvyiopPQuREfSWfXU=;
        b=GT5PGLEAIkJ0VUYwX5iPvOec68U2x09ih2cc7imCpRhtFLYhpX4pVerFJ3o+1LDmT7
         DGMQe2c0zCSrVzsb0U+D1OIIN1741zIkF7TJnLYn8RzFJ4zelZ5frXHT1qGLCGH9EdHY
         0aPcgHM/lweUEeMHp+mp8qtu5efg7jM6V/DuIGRflZGqWLs/E9Iv6FH4r/XJlMBitvc9
         N3M9JNIRwz1FtubOa7Ke5ZT99Z4QFhcTJ76hXoONEUBW9NrFEDYEGP/bXWscgkD60nQs
         s3TPGBvobF/+qiIhp6QqHTm2jPIRNO8Zsk1iyHfxH5gPzXssqVUFAAZ8MmBaZhvuyWzc
         tZTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=HvFqEnCS5gE/SyvGeSzzmRzYJIxvyiopPQuREfSWfXU=;
        b=YQKXQg1PWarmNG7DuxxpBBDQmLRVx37nBDmzfRE8AOAGD+lPM1O+vcNl3J4fArrc0O
         M/ZXFgmlHkhwf+MrrUjycmR0Vm+PDr8mwkYekJ5Jxb/QtXPTA3qiLf41j75qtNoyTJla
         NlwWukG5wglz1eWSXETkAFpHcrj7oP/XOXdCuODrV4kPPp0WlOnD15tzBw0+2smpWAr0
         8bDvIVenieBGDk0YU4gMPq0IPeA9AebXMQp4IvWUBE+YigWIcNpYofBg5nNBA5yph1gC
         uC0J/ouPFyUlZDPM5K1KscVIfTX49KDNpdFW3EP/9u/2wPdqcxDzAU+7GW0TMULVIr4e
         HLGA==
X-Gm-Message-State: AEkoouv70Ee8MOknAhxdhX5WPMs+kynAa6ryEpe/pcT8A5AA2gS7YG7171EzQHEXR+EM+P44y0GzVACuqPvQrQ==
X-Received: by 10.107.159.147 with SMTP id i141mr32554667ioe.29.1469640826919;
 Wed, 27 Jul 2016 10:33:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.225.235 with HTTP; Wed, 27 Jul 2016 10:33:17 -0700 (PDT)
In-Reply-To: <CACsJy8CRHsyT8YLPYoHZnxCuMvF1W=S5iayy2eoHZhbSe_qmDg@mail.gmail.com>
References: <20160718223038.GA66056@plume> <20160718225424.GA813@plume> <CACsJy8CRHsyT8YLPYoHZnxCuMvF1W=S5iayy2eoHZhbSe_qmDg@mail.gmail.com>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Wed, 27 Jul 2016 19:33:17 +0200
Message-ID: <CACsJy8D9Cy1bjzXddCTOOT7X3smBBB3xccEg7CHaOKAZruHVag@mail.gmail.com>
Subject: Re: t7063 failure on FreeBSD 10.3 i386/amd64
To:	Eric Wong <e@80x24.org>
Cc:	Git Mailing List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Stefan Beller <sbeller@google.com>,
	David Turner <novalis@novalis.org>,
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Jul 19, 2016 at 6:12 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Tue, Jul 19, 2016 at 12:54 AM, Eric Wong <e@80x24.org> wrote:
>> Oops, forgot to Cc some folks who worked on this :x
>>
>> Filesystem is ufs and it fails regardless of whether
>> soft-updates is enabled or not.
>
> Nothing stands out to my eyes, so I'm going to install freebsd this
> weekend. I hope ufs does not have any nasty surprise for me. Stay
> tuned.

The good news is it looks like a false alarm due to a racy test (and
it happens on ext2 too, zfs not tested), no big flaw or anything
(phew!). The bad news is, I still have no idea what's happening and
why is_racy_stat() returns true in this particular case. It'll take
some more time...
-- 
Duy
