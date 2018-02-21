Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C91A91F404
	for <e@80x24.org>; Wed, 21 Feb 2018 18:47:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752944AbeBUSrX (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Feb 2018 13:47:23 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:40198 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752761AbeBUSrW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Feb 2018 13:47:22 -0500
Received: by mail-wr0-f193.google.com with SMTP id o76so7335359wrb.7
        for <git@vger.kernel.org>; Wed, 21 Feb 2018 10:47:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=6L9Y/2szdNmQkaCcc0tINMF0FoQaoDCuXuNmMJWeFdA=;
        b=klI9LNxDWgjbFaD99iZzIUUPJFtw1YclABxJPH5dEtlqJVzvi83WKnCWZIgLwIuwiy
         4Hwru+LoT8MgzbOC/YCC5tXQee+dOLeWFWDf7N2C9tYeZhZvq/RwO8W4LTGKyzwJweDx
         TJV6m9ue+aDGJvL+SK2wUAiyL/9VCurnv2XHgmlrP6oqw/Kgck0n9gQAyRvxdT2DnK3C
         UkF/9Q8hUPrS53gZos0QCFiKHuIM4jt56vpGrbqHAUVX5xwi28PL6bQQM/ydIgjXZL3F
         P56PIzxWg1uECItEoB892O8M+ZfOp8Jvy+Wzt8h7xnN1GFKCOBXiRW5MLdxpIi4e4qzM
         NVWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=6L9Y/2szdNmQkaCcc0tINMF0FoQaoDCuXuNmMJWeFdA=;
        b=IRQMY+lfjPyCYwBivKZJBWQH2j8D7PkLjbBQ/sdwyZ+IkUA8OP97hyJTwdOxSzqXiQ
         r0jjxMfKzoNG/QtEPX2NBfxAMsI4DpkDhpbxUUlEUTg6xezJbOWBFyDqlVUI3QXfEFtB
         PHfIujMkoftc7u749b4VAaGMNR1ajxp/EGtVmu5vp0koEORjleXOsPC9QT6Axh/Hv30I
         uRG72dHK8fsxtScRdhPng58i/TWJuMpme1Lwn9Ds0g+8Aq287nnOTbW0TyS76Nl/ILPG
         sTfmzbT4Kbd28CCCbYxHmg3YnDmCw2eCTci5cTlJovURbOzbM7JnyOnJPM7wBZsQTeRa
         jrJw==
X-Gm-Message-State: APf1xPDKqorTUUrF9ZWNDzGKMbvuwTkcAo4YL9N/pd9dGFhILev8zjuf
        a9n7b+jdeOqZbUJHYEiAZaw=
X-Google-Smtp-Source: AH8x226NnDij/q6UREftpLFChRBUHMSx2BvrANt/DA0MEC/Z2OmNOSSoxgrxKD7NqDDBG3BGpzPSmw==
X-Received: by 10.223.183.39 with SMTP id l39mr4170724wre.214.1519238840691;
        Wed, 21 Feb 2018 10:47:20 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id o16sm14806470wro.55.2018.02.21.10.47.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Feb 2018 10:47:20 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Patryk Obara <patryk.obara@gmail.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 00/36] object_id part 12
References: <20180219225927.386065-1-sandals@crustytoothpaste.net>
Date:   Wed, 21 Feb 2018 10:47:19 -0800
In-Reply-To: <20180219225927.386065-1-sandals@crustytoothpaste.net> (brian
        m. carlson's message of "Mon, 19 Feb 2018 22:58:51 +0000")
Message-ID: <xmqqh8qayybs.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> This is the twelfth in a series of patches to convert from unsigned char
> [20] to struct object_id.  This series is based on next.
>
> Included in this series are conversions for find_unique_abbrev and
> lookup_replace_object, as well as parts of the sha1_file code.
>
> Conflicts with pu are average in number but minor, mostly because of the
> type_name conversion.  None of them are tricky, except that the
> introduction of get_tree_entry_if_blob requires a conversion of that
> function.

And the reason why this is based on 'next' is...?  Which topic(s) do
we have to wait for until we can queue this series, in other words?

Thanks for working on this, though.
