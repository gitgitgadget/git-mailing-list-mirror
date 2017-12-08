Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5FD3B1FC34
	for <e@80x24.org>; Fri,  8 Dec 2017 23:15:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753225AbdLHXPX (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Dec 2017 18:15:23 -0500
Received: from mail-wm0-f47.google.com ([74.125.82.47]:32915 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752730AbdLHXPW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Dec 2017 18:15:22 -0500
Received: by mail-wm0-f47.google.com with SMTP id g130so6182346wme.0
        for <git@vger.kernel.org>; Fri, 08 Dec 2017 15:15:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=EmLPBYT0/w/b+gSuiI18Wt1vuAOTSdJdvRKWd/HsxeM=;
        b=ZVA18jwfwqBfZTmf9oyOzhl0tQ1f3ntQZ0SQ8bb0ytliNpa456LLGYZTuDEnfHJkJf
         g5UPZx8RKmoJ8K5wjj7gngguqUts71D/2xKrWWR2hhc4P6X2RvhOyThikonrT7lyyFpJ
         a9EdgCwqrSGBNL1nfyk6bgJq4wvDsvcvDb2ifr41S8gFRmTmp6WFtMa/xAFwpIZSh22X
         GihVZGSl1fyCElFxZ4qXwlZIJChtvaPuv9y+UrM7RNW5noncst14QN8ittoz2OIVZbA9
         p3hJqYcmsIYOreOrc+E/ljUk6crVl1IsR1pUvwifHPrH1cS0LeJafy3eNQB/cqV0Ua3R
         LtJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=EmLPBYT0/w/b+gSuiI18Wt1vuAOTSdJdvRKWd/HsxeM=;
        b=gSNjowjM4qjS+Fnur1x3fTAqYnOdXm1QP19zt9q7phxGgkdbhJ5DXJrIg6lpWh4o0z
         KfV+C14z+tEH67HGcPVEGQjPryfwjM5LJGMLqtTz0X5MUv3teSyy5LUzHtSfRht8Yol3
         g71Tm5ZwmfxcymIaXS/zPQenNqOVe771T/UGd101lXgOXwXLT0VT7ZWu70eUxOt6Frz3
         vJhaTWdKWi+V0ldz1D9rIhp7RB/blqnwXlPDDDukrpkq0NhwlpV6MnHpMHhKgL5V/0Ia
         SSdyYEteIbKfQtrAgaZ++Dwbu0zp1XB2w+eznhkZ/vXUCr2nFfJNQjrDJR7oTiR/07qe
         hBrA==
X-Gm-Message-State: AKGB3mJRCtSC60+VKacx1wXqBtcqIUnJPWIfoyp4kFhvVwSvp21Ezj6M
        Xru5eG1Q3wdC8iQTYz/nTUM=
X-Google-Smtp-Source: ACJfBoteA4Sd6ZgPJ02+qmtGD2uXmyUroTAEWwQwz5f9fC2eSGB/O/VEUwvQzwYtnGsged7oADrXFQ==
X-Received: by 10.28.37.3 with SMTP id l3mr2257309wml.66.1512774921264;
        Fri, 08 Dec 2017 15:15:21 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id a5sm9538795wra.87.2017.12.08.15.15.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Dec 2017 15:15:18 -0800 (PST)
Received: from avar by evledraar with local (Exim 4.89)
        (envelope-from <avarab@gmail.com>)
        id 1eNRrP-0008Mm-Nw; Sat, 09 Dec 2017 00:15:15 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Takashi Iwai <tiwai@suse.de>,
        Jeff King <peff@peff.net>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v2 2/5] Makefile: under "make dist", include the sha1collisiondetection submodule
References: <20171208223001.556-1-avarab@gmail.com> <20171128213214.12477-1-avarab@gmail.com> <20171208223001.556-3-avarab@gmail.com> <xmqqvahg6dkc.fsf@gitster.mtv.corp.google.com>
User-agent: Debian GNU/Linux 9.2 (stretch); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <xmqqvahg6dkc.fsf@gitster.mtv.corp.google.com>
Date:   Sat, 09 Dec 2017 00:15:15 +0100
Message-ID: <87d13oerr0.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Dec 08 2017, Junio C. Hamano jotted:

> Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:
>
>> Include the sha1collisiondetection submodule when running "make
>> dist". Even though we've been shipping the sha1collisiondetection
>> submodule[1] and using it by default if it's checked out[2] anyone
>> downloading git as a tarball would just get an empty
>> sha1collisiondetection/ directory.
>
> While I can see that you are not including everything, but I do not
> see _why_ you chose to do so and hardcode the burden of maintaining
> the list of files we need to copy in the Makefile.

I started by trying to come up with something generic which would handle
future submodules, i.e.:

    git submodule foreach 'git ls-files'

However, unlike the C programs ./git-submodule will bark about missing
shell stuff when not installed, and the "dist" target already use
./git-*.

Between that and someone using git.git probably never running
sha1collisiondetection/ itself, it seemed fine just to hardcode the
couple of things we needed, which are very unlikely to change.

> This is much better than shipping a tarball that would not build at
> the endgame stage, of course ;-)
