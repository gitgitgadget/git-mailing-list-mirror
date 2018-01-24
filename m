Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 798BC1F576
	for <e@80x24.org>; Wed, 24 Jan 2018 11:48:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933263AbeAXLsC (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 06:48:02 -0500
Received: from mail-wm0-f52.google.com ([74.125.82.52]:40075 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932891AbeAXLsB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jan 2018 06:48:01 -0500
Received: by mail-wm0-f52.google.com with SMTP id v123so8012750wmd.5
        for <git@vger.kernel.org>; Wed, 24 Jan 2018 03:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=cPqouQE2wIeqA0TxkHItmiRqHz9KkuhAzPyUxk64ONk=;
        b=jNWWBNOv0tiLUkA19WMeecM6clAY0RbhatWrme4W8oibrk5lyyKisCsjOURU2/INBS
         oEwENb04DfZHUNm2raeL/kuBiibozI8mZZOGLeR8D+FOnURAB2Orq6B+dDA3gn97VfrN
         v77pexj9G5nYqotj0FvG2H5nI1xRRPtV69PRxUigeg6jy+ev1qQ/K1jYvOZt75/3vH4y
         DJ+N5KcJ6dtihx3b8q7ab9BzVN0TAGH3llknEguUO5LXiZfyWR18YCxO2a3VhA/7TIZC
         PXccW6UZutYG+X5fBEGBPtWP/adKP7JMSVAFQu3vA47gw1S/ouOtxGxR+p1SyRF3KEAY
         9tZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=cPqouQE2wIeqA0TxkHItmiRqHz9KkuhAzPyUxk64ONk=;
        b=XS65mtFZvzXvt8eKn8u3fQeUuSqwjigmvAMOwgE6BPiH+F/rOI2oJlexpJi9CODg0c
         TTReCIi/W8aaPbe6JrVVBubDjHLoNxXtZ1lA364fs3reVxqyMb+ay6uaIxnXlJhO2fF1
         58i2/hbG8w9SFZCBHwA4MWDpHTwOKQDZcIme66WzyYpQExdjH3B25otyNX7tV5yOQlUJ
         EZjG4v0azgZkPcbNI1rxWYRU5uQjHJxIGH0AEpb6Y8Qc43vsRKKs5cdBBmL/tt/ImgQJ
         NANKA2aDbE2RDdWhK2kvm1G0RtmuwIr+mLU0XfJv7k7FBTiCPLi4m0UhtmyFT2kb6Eo/
         cbuw==
X-Gm-Message-State: AKwxytcLCYv8QCEDla+RkQz21iZFpMwCHjzKNgPME9GNo/ATU0tmQVh+
        OSTw6fG3R5wC6mPIxcvZNRc=
X-Google-Smtp-Source: AH8x225cjG57Irn81qO7QRB0PRznnH46eS3NKYhV40qoDUlXM++XU4Iymbwhemyq4dOLcuEHaq22jA==
X-Received: by 10.28.144.20 with SMTP id s20mr4744182wmd.149.1516794479827;
        Wed, 24 Jan 2018 03:47:59 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id o12sm2042223wrf.81.2018.01.24.03.47.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Jan 2018 03:47:58 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/5] nd/fix-untracked-cache-invalidation updates
References: <20180118095036.29422-1-pclouds@gmail.com> <20180124093023.9071-1-pclouds@gmail.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.0-alpha3
In-reply-to: <20180124093023.9071-1-pclouds@gmail.com>
Date:   Wed, 24 Jan 2018 12:47:57 +0100
Message-ID: <87d11zh40i.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jan 24 2018, Nguyễn Thái Ngọc Duy jotted:

> This is a small update where the last two patches on 'pu' are merged
> in one. The final content is exactly the same as on 'pu'.
>
> Nguyễn Thái Ngọc Duy (3):
>   dir.c: avoid stat() in valid_cached_dir()
>   dir.c: fix missing dir invalidation in untracked code
>   dir.c: stop ignoring opendir() error in open_cached_dir()
>
> Ævar Arnfjörð Bjarmason (2):
>   status: add a failing test showing a core.untrackedCache bug
>   update-index doc: note a fixed bug in the untracked cache

Looks good to me.
