Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA5B31F454
	for <e@80x24.org>; Mon,  5 Nov 2018 01:08:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbeKEKZk (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Nov 2018 05:25:40 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39840 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbeKEKZk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Nov 2018 05:25:40 -0500
Received: by mail-wm1-f67.google.com with SMTP id u13-v6so6420479wmc.4
        for <git@vger.kernel.org>; Sun, 04 Nov 2018 17:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version:content-transfer-encoding;
        bh=93MLO4WwChbHEupj2j6+0rLQ/RM4wH0DAzhpPnN6MGk=;
        b=qFVs2nb3WQkEQKcT0R2NhWiCnfH1vEZkXeBJOgCRREppdpRhB9tWdDjLxpTD5BTg+8
         gl8nUtrkdHDFvESuDWq6fMS9ytfNbQt0pe0n+/bcpyg22RGBBm77GejptvYa/xyYRPjn
         TGvMQKNuLSksn2PWiU6Act42vcPqycYqn00h5aYjsVgmwshZkdFi6LVekckCe8YQYK/v
         no/SLh0nLSu+rqe4oXGEyd/MOvSf5cOhvyXhyf/7sHVBVhYK8rGV57lp6fdUQnlfcMZn
         IaLPCD1KmnG+I3DprvVIdYClqIE4TZzLGUueGrbYwHVpV+Ocpbwj24n/XUfLP0tt5SRG
         HwcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :user-agent:date:message-id:mime-version:content-transfer-encoding;
        bh=93MLO4WwChbHEupj2j6+0rLQ/RM4wH0DAzhpPnN6MGk=;
        b=JAyeFVs72WKoBh2SyguzgjOC4KDTEjLxk9h/0UQ6DK2rW5jP5lpskGK6HmpRzOcWKM
         icJ4G6V3p8STsbyexg895kYB0gORLFrL1Cj1mopl/S8tb2Vb/y2Hfqr5TLK8WVAxvApr
         GN621zhWyxOOFnZS0IqEV2FaL3E7KqlrB8EkKmslT2aVsSEMjUtTJ3Kq0fu2+EH5Z7Mu
         WVeeETffJ+9khXZex+6V4EWFKUcUKo1JE6eYNuw9lHLo3c3G/6X5O59PyUbi+T12BpMz
         E3xJzehshD4iIoCHPa781Cz0ptpcsJ+EM1/762jEsiPhX/T58piz8wbZpQyUzQ6IFxC3
         /IrQ==
X-Gm-Message-State: AGRZ1gIjvbDnfdoaMQcxeDktCrccRGUEyvvo6tzi2crzT95qHxN22glz
        xl5lVXCzTP3cvYhLdJUA9vg=
X-Google-Smtp-Source: AJdET5e/VX8hASJFz03+HjEeJR+PTloeQsX6E6KUp8LBswlfNtLGs4EJh8l+boM9/qXtOnsYzs2WVQ==
X-Received: by 2002:a1c:95:: with SMTP id 143-v6mr149512wma.4.1541380115762;
        Sun, 04 Nov 2018 17:08:35 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id c21-v6sm28848472wmh.26.2018.11.04.17.08.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 04 Nov 2018 17:08:34 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?TWljaGHFgiBHw7Nybnk=?= <mgorny@gentoo.org>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 2/2] t/t7510-signed-commit.sh: add signing subkey to Eris Discordia key
In-Reply-To: <1541347654.22217.4.camel@gentoo.org> (=?utf-8?Q?=22Micha?=
 =?utf-8?Q?=C5=82_G=C3=B3rny=22's?= message
        of "Sun, 04 Nov 2018 17:07:34 +0100")
References: <20181104094710.27859-1-mgorny@gentoo.org>
        <20181104094710.27859-2-mgorny@gentoo.org>
        <20181104151013.GH731755@genre.crustytoothpaste.net>
        <1541347654.22217.4.camel@gentoo.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
Date:   Mon, 05 Nov 2018 10:08:33 +0900
Message-ID: <xmqqo9b4l4a6.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michał Górny <mgorny@gentoo.org> writes:

>> It's my understanding that GnuPG will use the most recent subkey
>> suitable for a particular purpose, and I think the test relies on that
>> behavior.  However, I'm not sure that's documented.  Do we want to rely
>> on that behavior or be more explicit?  (This is a question, not an
>> opinion.)
>
> To be honest, I don't recall which suitable subkey is used.  However, it
> definitely will prefer a subkey with signing capabilities over
> the primary key if one is present, and this is well-known and expected
> behavior.
>
> In fact, if you have a key with two signing subkeys A and B and it
> considers A better, then even if you explicitly pass keyid of B, it will
> use A.  To force another subkey you have to append '!' to keyid.
>
> Therefore, I think this is a behavior we can rely on.

I didn't check how the signing key configuration is done in the test
sript (which is outside the patch context), but do you mean that we
create these signed objects by specifying which key to use with a
keyid with "!"  appended?  If so I agree that would make sense,
because we would then know which subkey should be used for signing
and checking with %GF/%GP would be a good way to do so.

Thanks.
