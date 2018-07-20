Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,PYZOR_CHECK,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E62111F597
	for <e@80x24.org>; Fri, 20 Jul 2018 15:42:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732141AbeGTQaz (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jul 2018 12:30:55 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36561 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731583AbeGTQaz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jul 2018 12:30:55 -0400
Received: by mail-wm0-f67.google.com with SMTP id s14-v6so10305931wmc.1
        for <git@vger.kernel.org>; Fri, 20 Jul 2018 08:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=B7d8ySsjr4QTi1Xl0oTp13tAc0DvFi67hqDNlHpCELI=;
        b=B27ecpRAUOo1f7B0PoTdoN8YT2lssUkGGdMbK0zx2TwMILMLv7hrSwCRL7kcQE993r
         IheGOv1uGFaKoEIYvupNnz3uYIv2DBKh8g/6sfuaA8GqAHC78QWD4KuzHzO8oJrN/BcA
         azeh7s5ZwlOaX39m51GJJw2SslwR9MN1gIlNcW11zH6oomoK7sbHvx0MBrhhRDKhFRQL
         TGguWRC9H7JNTpIhP3RlTs6FKhgzlnjcCGJFiDu8Uv9C1sx/69pOzxgt/c077Vhtwgzb
         hvwVUHxfmJfDTb7EFOn0Mj9pkMTyESkUYedf6tJzgmcJAAAfNb9zNZjPRKnICjSIS/Ea
         HO3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=B7d8ySsjr4QTi1Xl0oTp13tAc0DvFi67hqDNlHpCELI=;
        b=oU/jHQ4lRR9qJF3nWFUACa5p4N+DkYI0wxydyw2clBjx8jZe3RtSUGOlkoW1Tb3eec
         kTKBs3ckf/KIbKpMXz8QkOCiWS1VlTWQ8lMBm5u+lFWEHGKqv3PhiCibGpasvJlyY6SP
         86lR5mGrOaSPU/s9D22kf+l7/XHAPPoRVk0K7qlyFM/4XHbFXPWCpUavqoEsFATuXVsV
         B5u7Lw2w35HJNlK7mUpZtTl7UA8gzUqgp+NuBmq3/Ug8lQspgbOZXnxXh3Yw4DVsFHMb
         8gEzW6YD4UcGDScoFkJ1LEVBf4TSkYzF6qLgyuD7a/1OeUnrtNtoJKyEzhxYSTQTe+tI
         3G4Q==
X-Gm-Message-State: AOUpUlG32USuCupe5guuMh2ALnWNDKeIAR4K92bAbbCj57Odri55s+NG
        zKyQBguzkQDchn2T7lXqetK+O+Qs
X-Google-Smtp-Source: AAOMgpf55ks43stQ5nAfrzfTeRBKro4sbGw+Va0baXFODLQs6KgUv0VCbq97+EjVMaL6PYx3RysXqQ==
X-Received: by 2002:a1c:8e08:: with SMTP id q8-v6mr2008938wmd.137.1532101322594;
        Fri, 20 Jul 2018 08:42:02 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id s10-v6sm2829703wmb.12.2018.07.20.08.42.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Jul 2018 08:42:01 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Henning Schild <henning.schild@siemens.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Ben Toews <mastahyeti@gmail.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v6 7/7] gpg-interface t: extend the existing GPG tests with GPGSM
References: <20180718093112.29783-1-henning.schild@siemens.com>
        <20180720082807.2917-1-henning.schild@siemens.com>
Date:   Fri, 20 Jul 2018 08:42:01 -0700
In-Reply-To: <20180720082807.2917-1-henning.schild@siemens.com> (Henning
        Schild's message of "Fri, 20 Jul 2018 10:28:07 +0200")
Message-ID: <xmqq6019did2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks.
