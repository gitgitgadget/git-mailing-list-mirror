Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B8F95202BB
	for <e@80x24.org>; Wed, 13 Mar 2019 04:34:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726043AbfCMEef (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Mar 2019 00:34:35 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53392 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbfCMEef (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Mar 2019 00:34:35 -0400
Received: by mail-wm1-f65.google.com with SMTP id e74so409623wmg.3
        for <git@vger.kernel.org>; Tue, 12 Mar 2019 21:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=GSSGg1aw/3kuRa49iMl/mVTQjfaCV29z/h9ZUVvyR1A=;
        b=JGEfHIyu+VqDLI8hrgnPogWNGMakGKm7y5+KhzCZ/suCBmHVn/hC1h9OmWybGIPkov
         SwauSY/nOO67rbjaa739HmxduTOviFUJvXmKkxgejQ6o4lDh/atbjrREjifOqcleabac
         bCF1v4sDCXjBaZCcqlFZ9hmVB9oueoLjYACFt/DXsw/zUVyc7t8Yb6u/y0e5ZayVIrd/
         auSfMamuDQFa/P7HCYcPperhehEbV9RgsuBTKNpplgLCtgqb+Y979uBWvBTO9eyGpnx6
         B+3LhT+Kb+X8pyNIS/DPrNYFz/mCzDzswSiT6vvmoaLo1wiohstxiOSZeNjrUuEZpBEJ
         D7og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=GSSGg1aw/3kuRa49iMl/mVTQjfaCV29z/h9ZUVvyR1A=;
        b=hS5ZyjOspkVoqeL30ufIM6YtYqzlx2EqGeHC7e3AnoERldn8WQyK2mzOJXjOVPAAsy
         I02s/xorZbydCXmEo+/l5HyZYFT+Nonx0ZaBsNU2/Y0tCJBqdZqInLYODoV7YiQ7vk/C
         KirSraETMytG5jYo48p0Pgcr0nPd5tPiiekKSAFA4lPPfovM/pz3Ktxki1oJLy62w8XE
         OK/k0YhDRN9hwbXay6U0TKCs+e4W2Q4kEADVCyIjo6ndbPvsW/YLpbWzI63/QCleQFlF
         0AJNYcKEEfkoRvnRQEwlXWBv4K1lhhpC43UQpJBy52/vlS3cUsNfUSTaANQDGwzTa14M
         tRgA==
X-Gm-Message-State: APjAAAVVGeQhuS3ysNB+Wwuc20AHZPN/pBvxr2G1zOTBlpeLCkAyX8hP
        LZSNFBLuD5p5CdYjJsiCzHU=
X-Google-Smtp-Source: APXvYqy4RVNmhUpIy061Smpv/GGI4mxttzqYVz2Mz7bUs8mIFr8nsxvSEEMZckWQxat36bhA8Z9/Lg==
X-Received: by 2002:a1c:2283:: with SMTP id i125mr676567wmi.24.1552451673301;
        Tue, 12 Mar 2019 21:34:33 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id u17sm34264371wrg.71.2019.03.12.21.34.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 21:34:32 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Beat Bolli <dev+git@drbeat.li>
Subject: Re: [PATCH v3 02/11] Add initial support for many promisor remotes
References: <20190312132959.11764-1-chriscool@tuxfamily.org>
        <20190312132959.11764-3-chriscool@tuxfamily.org>
        <xmqqtvg7e7pn.fsf@gitster-ct.c.googlers.com>
Date:   Wed, 13 Mar 2019 13:34:32 +0900
In-Reply-To: <xmqqtvg7e7pn.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 13 Mar 2019 13:09:24 +0900")
Message-ID: <xmqqbm2fe6jr.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> What is the rule for these promisor names?

Disregard this part (and only this part).  The values are not names,
but just "is this thing a promisor" boolean.
