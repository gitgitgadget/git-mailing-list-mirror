Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AADD9211B3
	for <e@80x24.org>; Wed,  5 Dec 2018 14:39:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727762AbeLEOjZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Dec 2018 09:39:25 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52617 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727103AbeLEOjZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Dec 2018 09:39:25 -0500
Received: by mail-wm1-f65.google.com with SMTP id r11-v6so13457341wmb.2
        for <git@vger.kernel.org>; Wed, 05 Dec 2018 06:39:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=XQw3tFe8BWIEOQEQwuZLdc0pfYpuaSXx7yF1iLZhX2E=;
        b=unXcidBZqRq/mLRyOOH+MXHFu/WR8xKbx9FyP+7IVD7zhksNbiipELfOG6mza0CzJ6
         FjVdYC8czNpbfkhvXTjJf3i3SwFB20Tn3rcIm/Cs/x0PosFhd1CYcpu/6am0avAD9KtS
         5l8Kkq2UALgacQc9d+Q0p62dTgPagDRQmJGRGfj6e9dPkrTYqHq8LpVjH6dFfmxIiG7j
         6/ot8Fcfdk2QTX6NnDypiiJh8aCQHSCYd/5MUk57HPb0mri7G+EX0tuBCk3DYZXMIEkD
         xE/1TYiqRnIwtS8oC4yVGy2zSQ0PBS1ZJN8TsgX+C3SbURQleiX9CLZlWyhMoSEJ77kh
         VFgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=XQw3tFe8BWIEOQEQwuZLdc0pfYpuaSXx7yF1iLZhX2E=;
        b=jrk8jAx9tIh+dBYG0YdkjYVqiKRwV6F2QkS4dGOYKQQSpt/1oDPunNzkUleiISYrt5
         JCWXHg/Bw4Wh0gmfMxYYV+5GR2OYKUG+HmWoXGv2IbwE1ce7tXb1lRtIWAYIH0LUvDqN
         H+9XwQ+noyuaJ2i4VHLSkDyFAnCISz8m68dsBYcofJVesY2CaRjaHgb8EYtbqtr8FllV
         UHtPGzoxGDOt1XeLH8ni6YaCJLVOYziLIj4thdjml/9IjJNR3QquyJzRTH6LGZU9GaoB
         4xulnxRORaRyCvkM5wNpBuwIEuzUK5oqumLlKoYaG0eGlRq347VQ8arHUdyuw5+b2GJn
         jacQ==
X-Gm-Message-State: AA+aEWb3Mvg1jC1JgilmGLNXHw1HNzE+WID9xooDfuqURbpmcqEzUjAz
        bBYTH6O2WmP1xxsvJjHtVZ4=
X-Google-Smtp-Source: AFSGD/VTReXPlQYwLSbvcgYK1ivtaFK2f1JdKnfb6ybRQSfQChLREFi48YWERnce9oADmVGaHFSeIg==
X-Received: by 2002:a1c:c483:: with SMTP id u125mr15916609wmf.14.1544020762282;
        Wed, 05 Dec 2018 06:39:22 -0800 (PST)
Received: from szeder.dev (x4dbd715c.dyn.telefonica.de. [77.189.113.92])
        by smtp.gmail.com with ESMTPSA id t4sm27526435wrm.6.2018.12.05.06.39.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 06:39:21 -0800 (PST)
Date:   Wed, 5 Dec 2018 15:39:19 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [RFC PATCH 3/3] test-lib: add the '--stress' option to run a
 test repeatedly under load
Message-ID: <20181205143919.GN30222@szeder.dev>
References: <20181204163457.15717-1-szeder.dev@gmail.com>
 <20181204163457.15717-4-szeder.dev@gmail.com>
 <87muplyxfn.fsf@evledraar.gmail.com>
 <20181205120725.GK30222@szeder.dev>
 <87wooof4xm.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87wooof4xm.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 05, 2018 at 03:01:41PM +0100, Ævar Arnfjörð Bjarmason wrote:
> >> decide to stress test in advance, since we'd either flock() the trash
> >> dir, or just mktemp(1)-it.
> >
> > While 'mktemp' seems to be more portable than 'flock', it doesn't seem
> > to be portable enough; at least it's not in POSIX.>
> 
> We are already relying on stuff like mktemp() being reliable for
> e.g. the split index.

That's the mktemp() function from libc; I meant the 'mktemp' command
that we would use this early in 'test-lib.sh', where PATH has not been
set up for testing yet.

