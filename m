Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCADD1F404
	for <e@80x24.org>; Fri,  7 Sep 2018 07:20:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbeIGL7u (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Sep 2018 07:59:50 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:50311 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbeIGL7u (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Sep 2018 07:59:50 -0400
Received: by mail-wm0-f67.google.com with SMTP id s12-v6so13694176wmc.0
        for <git@vger.kernel.org>; Fri, 07 Sep 2018 00:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=XGDMrTC4hjwyNwcHpd5qBTALvQ/DrXursoW7Yn3ehO4=;
        b=SdmLBw1+Ya6AffLDdr1Dv2k58eG1dZ1UWg/ouGcCTk1YWOIywawgrbYrfV6MzS259m
         qwhs4pjL9jf0tETSgFawkpqFCYQeecAhLM5w1/TO9cYPNiJtgff7bUlN9y8jDdIwTsag
         nRpXD/1c+lPCO/Gpp1gHgvK+fPrt7QnucwYqsdWsx3ivDW7rIADcyHYypCTYAlMGdxCf
         j+BUuia20BVWS1TsSpUDVKcibo+HvtgepXC6Z9Y0J9pYoddiafVed5z0SCWNGh6kX//o
         MthlU+Col5hI8QPVp5D99KICsoy0DgrWJv8Jeeo2iLeYfUNgsRrGMpImDb3tQKmbgGFl
         FqTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=XGDMrTC4hjwyNwcHpd5qBTALvQ/DrXursoW7Yn3ehO4=;
        b=eGMCBGMIiZ2zf8RhBjF3l6PPdJ3NQuB35UorKeAEM1OUcRDCF/rt827TEX9YD1rh0W
         XoCRg7YszApvSL7BBIO96Kw0pfjZ6xKd67OwPKCSSt7NncSV3sx+BFW9FSdaO/tWEQGI
         XRFiGAIVt/jGPHt7vMaGKv1JlBbRq9yOFeM1jgkbwFXZe71odYtot9uCUbO6KI2ovCBD
         m6czgI7NE/zsEimDpUEmFYtMyAc9iJ8TtpqI+pIcLJu38J1lGI0Pt/memSBJYEwMgL4w
         IX6jya7LQQzqj65XNqbwlO2K+q+yIgGjaZ3yzyuWIQa82315cMvl5anCvtFBe1Q5IL0n
         rmuw==
X-Gm-Message-State: APzg51DKT2xI6tFkNEtRx0OvT1I7u0qqy1cQa05XZstlC7tNXMfMXbLv
        Q9Kc18VtUaK6ZoFLJsxq879bMIzS
X-Google-Smtp-Source: ANB0VdaQAD2cJFwNKYLBrp7AugJf9+B3zLcVFoLbIgwso+MbBhBw/weplwvDK+9SXcyBWriy5Wh1FQ==
X-Received: by 2002:a1c:8406:: with SMTP id g6-v6mr4181295wmd.18.1536304815601;
        Fri, 07 Sep 2018 00:20:15 -0700 (PDT)
Received: from evledraar (g74155.upc-g.chello.nl. [80.57.74.155])
        by smtp.gmail.com with ESMTPSA id v46-v6sm7466713wrc.63.2018.09.07.00.20.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Sep 2018 00:20:14 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Tim Schumacher <timschumi@gmx.de>, gitster@pobox.com,
        pclouds@gmail.com
Subject: Re: ordered string-list considered harmful, was Re: [PATCH v3] Allow aliases that include other aliases
References: <20180906191203.GA26184@sigill.intra.peff.net>
        <20180906192021.GB26575@sigill.intra.peff.net>
        <20180906235033.GA100309@aiede.svl.corp.google.com>
        <20180907032401.GB31728@sigill.intra.peff.net>
        <20180907063241.GA172953@aiede.svl.corp.google.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180907063241.GA172953@aiede.svl.corp.google.com>
Date:   Fri, 07 Sep 2018 09:20:13 +0200
Message-ID: <87in3hrcya.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Sep 07 2018, Jonathan Nieder wrote:

> Jeff King wrote:
>
>> I don't see any point in generating a sorted list and _then_ making an
>> auxiliary hashmap. My idea was that if you're using a sorted string-list
>> for lookup, then you can replace the whole thing with a hash (inserting
>> as you go, rather than sorting at the end).
>
> What if I'm sorting a string list in preparation for emitting a sorted
> list, and I *also* want to perform lookups in that same list?  In
> other words:

If this turns out to be a common use-case perhaps the easiest way to
support that would be to make the hashmap (optionally?) ordered, as Ruby
1.9 did with their hash implementation:
https://www.igvita.com/2009/02/04/ruby-19-internals-ordered-hash/
