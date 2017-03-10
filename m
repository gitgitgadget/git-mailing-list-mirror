Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81F7D1FC43
	for <e@80x24.org>; Fri, 10 Mar 2017 22:58:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933100AbdCJW6f (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Mar 2017 17:58:35 -0500
Received: from mail-io0-f169.google.com ([209.85.223.169]:35199 "EHLO
        mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932705AbdCJW6e (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Mar 2017 17:58:34 -0500
Received: by mail-io0-f169.google.com with SMTP id z13so57776091iof.2
        for <git@vger.kernel.org>; Fri, 10 Mar 2017 14:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=AE5RW5iL9J4km10xwTb+x/4zr6nOLGb8zOLnOfiGEuY=;
        b=MrATeShvNK7xMUa/tCykN3nQHzhCVbC5+33SbBsYK1WHllbcBrlMrv6Cm5rFYu98vh
         cGYHhFe3uhpOAfRPjs3bVOAsXhOhTZI8OHnbD7qHpu8+AApY68ZbvTjH2fFQyFHvz1od
         ulLrv7EUYNGYxN5Gav6ShoEGfizifTriSP2kzLtTUHVjuY3aKyc4ddCYisXh/ZaBIuvC
         uzerHzpmyXZOS9BXbh8Swpw4sChDx+H5NjAgAG3vNM4wMXAc1ZjpfMPXzGpMxwXyiDC0
         GcADpL+vxG5ZmXM7F6Ktvn0we2cMGlZFlk5cQUJCKzeOuQSgWLKAz2jG8Uil9umIVME+
         J6lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=AE5RW5iL9J4km10xwTb+x/4zr6nOLGb8zOLnOfiGEuY=;
        b=kpu5LiO63YTh9VvIdKcr6jqFVoNlezJARlemn+rVZInwpgDIvSa9ZIH3SAe4RAHJpV
         tq72pvSvu1Rjm/nVuiYxU8wS6/plYEU09HXTXCUVMTMbqgVw8YhOft/qW9JtIosnn+gG
         sAy4FPrpOlQzXpHYGA9IkSNWmykSnHbY+o4t8TSfZo+Rw6FRBGZ7ArIJsEjCAwUmxZVs
         3X3HglxfW15GLP2Eik+/ChWvMXjv3LRK1wBtk/110x+if+W1ZdbJEWBomMrdn5sYqwt9
         NUY6ClP+lxLgMiSzZ8PfpuIuLhulzN00jP6XYZzhmGBVybB8/kD+UQmzfE/l5zRp8cI5
         mVGQ==
X-Gm-Message-State: AMke39m3pYIMGPmxJ2QurE4WPuFkMX88083An5SoS/b5tmQesDcbalumKFRbY5PsjdrE5MquHmrB/FATIBnvag==
X-Received: by 10.107.200.139 with SMTP id y133mr20381167iof.147.1489186713588;
 Fri, 10 Mar 2017 14:58:33 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.130.208 with HTTP; Fri, 10 Mar 2017 14:58:13 -0800 (PST)
In-Reply-To: <20170310190641.i7geazhrlmzzfna6@sigill.intra.peff.net>
References: <20170310151556.18490-1-vegard.nossum@oracle.com> <20170310190641.i7geazhrlmzzfna6@sigill.intra.peff.net>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Fri, 10 Mar 2017 23:58:13 +0100
Message-ID: <CACBZZX5fGU9C-z94KbMAs_AegOSGtq8nbrkRe-NxBCHYsDswkA@mail.gmail.com>
Subject: Re: [RFC][PATCH] index-pack: add testcases found using AFL
To:     Jeff King <peff@peff.net>
Cc:     Vegard Nossum <vegard.nossum@oracle.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 10, 2017 at 8:06 PM, Jeff King <peff@peff.net> wrote:
> [Note: your original email didn't make it to the list because it's over
> 100K; I'll quote liberally].
>
> On Fri, Mar 10, 2017 at 04:15:56PM +0100, Vegard Nossum wrote:
>
>> I've used AFL to generate a corpus of pack files that maximises the edge
>> coverage for 'git index-pack'.
>>
>> This is a supplement to (and not a replacement for) the regular test cases
>> where we know exactly what each test is checking for. These testcases are
>> more useful for avoiding regressions in edge cases or as a starting point
>> for future fuzzing efforts.
>>
>> To see the output of running 'git index-pack' on each file, you can do
>> something like this:
>>
>>   make -C t GIT_TEST_OPTS="--run=34 --verbose" t5300-pack-object.sh
>>
>> I observe the following coverage changes (for t5300 only):
>>
>>   path                  old%  new%    pp
>>   ----------------------------------------
>>   builtin/index-pack.c  74.3  76.6   2.3
>>   pack-write.c          79.8  80.4    .6
>>   patch-delta.c         67.4  81.4  14.0
>>   usage.c               26.6  35.5   8.9
>>   wrapper.c             42.0  46.1   4.1
>>   zlib.c                58.7  64.1   5.4
>
> I'm not sure how I feel about this. More coverage is good, I guess, but
> we don't have any idea what these packfiles are doing, or whether
> index-pack is behaving sanely in the new lines. The most we can say is
> that we tested more lines of code and that nothing segfaulted or
> triggered something like ASAN.

Isn't the main value with these sorts of tests that they make up the
difference in the current manually maintained coverage & some
randomized coverage. So when you change the code in the future and the
randomized coverage changes, we don't know if that's a good or a bad
thing, but at least we're more likely to know that it changed, and at
that point someone's likely to actually investigate the root cause,
which'll turn some AFL blob testcase into an isolated testcase?
