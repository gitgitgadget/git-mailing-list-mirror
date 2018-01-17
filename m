Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 672B91F406
	for <e@80x24.org>; Wed, 17 Jan 2018 22:06:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753865AbeAQWGs (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Jan 2018 17:06:48 -0500
Received: from mail-wm0-f42.google.com ([74.125.82.42]:42729 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753808AbeAQWGr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jan 2018 17:06:47 -0500
Received: by mail-wm0-f42.google.com with SMTP id b141so18259862wme.1
        for <git@vger.kernel.org>; Wed, 17 Jan 2018 14:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=fpS7asDGOxYDKRERvKjf2FA4y254vfsYM3avAd/lGko=;
        b=sZcv4Ma9yJo8NaIcHPvouZJqoW79UpM2FiLZt2kmQAyuo/MdFizB59c+a7S3OkJ0En
         OtKdj7/eLgb4psZ5NK+nPXL8HoPPKeCwfekRg5/FbBItaH5+CBO0FdNN9sn3tX+VgLrz
         F4JWQY9cl7/e1U7MWwHtRdBJyKPp0XjV817n4cpYB3cd2KlCo1DVKVvWCgb/vBi6OI6z
         WNErPHaMKS5jsjfXnOk1t4UiSKI3r1S4tdIm05MCvTGPBCGpHOniTtlMVuR3RzjBeGx4
         oEtPgNITohUBuV+pCr1ZL1cR/GL2N0UQPisIqaQKNMUyMId86SuOPITL4b8ksoVQJhbf
         Ap4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=fpS7asDGOxYDKRERvKjf2FA4y254vfsYM3avAd/lGko=;
        b=UA/VTiV76N/NCjPjlpiMV+0ne75IEqjyZBDydacvQbWXSMRQSi5TeUT7wJvQuY11jr
         Khzduevxkq26zxwLCyooIG5Al0iD4QOST6T1LE/Ie7kl2PXMnBCfap5wpchNwCevmliu
         cv3YeDjHMvS1kl5NUJ64g4rwY8arHEwoOIrkzabtz1R8xJ9sb7mI4QFGIcLzytOj6O7e
         5Em4E7WevBD6fmliHBbVIfaGpDOtw3UPbL73maXOPm2k07nFdM1OLPNY6cPpmiOmg2Yj
         4s+ljyrXYVJ9aN+qUlmvJ0mRv10Wy9Ri+LmQxPc6nkO+rOrvE3gjQPj6HxFc0qGE9ARx
         zljw==
X-Gm-Message-State: AKwxytdE9NvQNpI9HhH5qFlQUdI1VvsctT5BWLOnQSCXUNOVw3TleebD
        LC8Go8UicjRn9mEItmGWkvo=
X-Google-Smtp-Source: ACJfBosxeikWv/XZJ5Vl/zWRGnKr2vHhW//XmGR0OuWXK/he/9s0TwOhBOg8OTBvFSQXdD4vYnPJ+w==
X-Received: by 10.80.190.9 with SMTP id a9mr4822201edi.258.1516226806151;
        Wed, 17 Jan 2018 14:06:46 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id g61sm3325021edd.48.2018.01.17.14.06.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Jan 2018 14:06:45 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Christian Ludwig <chrissicool@googlemail.com>
Cc:     git@vger.kernel.org, Christian Ludwig <chrissicool@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 2/2] send-email: Support separate Reply-To address
References: <20180117180801.31049-1-chrissicool@gmail.com> <20180117180801.31049-2-chrissicool@gmail.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.0-alpha3
In-reply-to: <20180117180801.31049-2-chrissicool@gmail.com>
Date:   Wed, 17 Jan 2018 23:06:44 +0100
Message-ID: <87fu74i1hn.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jan 17 2018, Christian Ludwig jotted:

> +if (defined $reply_to) {
> +	$reply_to =~ s/^\s+|\s+$//g;
> +	($reply_to) = expand_aliases($reply_to);
> +	$reply_to = sanitize_address($reply_to);
> +}

Just a note to other reviewers: I found it odd to call a function with
one argument and then enforce list context, but I see expand_aliases()
expects to be called that way, and this is copied from a previous
pattern earlier in the file.

(As an aside, that code looks a bit odd, but then I see 302e04ea4d
("send-email: detect cycles in alias expansion", 2009-07-23) )

Looks good to me.
