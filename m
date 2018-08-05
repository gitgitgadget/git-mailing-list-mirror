Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D34901F597
	for <e@80x24.org>; Sun,  5 Aug 2018 03:17:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726075AbeHEFUK (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Aug 2018 01:20:10 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:44210 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726058AbeHEFUK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Aug 2018 01:20:10 -0400
Received: by mail-pl0-f66.google.com with SMTP id ba4-v6so4189912plb.11
        for <git@vger.kernel.org>; Sat, 04 Aug 2018 20:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TrBfTl64C6d0/0uOfvy460N0T9BAzFqpDFNWLoRGyiE=;
        b=StD000cp42lRVtrEHFBSLXyTjJ8b0sLffoSy2aMXx9jm9TG+/BIQ/LacHcgv4vfeED
         L7dJiROp2Bo08LqtTW0WuKFN+S9OSZuLeS1mKuG7xmc4Yg5rNK55Pb9pmTLT9ce7NMy2
         k35poYHLw+X050pmB4osU2wfQngNiSbPE8P1EoKrSk7dlOH7+VxmhtZi8qQKfSmQOVv1
         8LSNZVnP59Z1QlPcLBUXHHrdCWTOIfRrRgarqzgkIMeVfPOVzDZKETGNjYiSd2UxVV5k
         /LDp3kcT/ZSoUbmnqDt0Y7ngA20lS/+/OW9Ees8M5c7q1mpi+OLBPH0ZgQDQZ1OFItpY
         0iJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TrBfTl64C6d0/0uOfvy460N0T9BAzFqpDFNWLoRGyiE=;
        b=rDFRygTP8fKJLRiraF7hfZKQpswA4RKMir5ShdA/DCeWCVDsa5dQM95Yb0WSHEvcqj
         N6AD+EdakYyUno/rQRTh55esB0yFCKjZd7go9kjZmG8d17cE+KnljyAoEVy6faZ+EoCw
         tvK4hcwKEQOnEUhX1W06XxIz46QOkZlNO3jo9V5CaqHuki8V/9huYpFsWqiZcqc9HhBS
         Qh9nj7eKw+kfT8nohQBfyuW5XSrSakc0meSTCYWJDHtwEnKPhI7FuVMpq6sUf5+Sjsp5
         zxsZpLijpwRl5wuL0jeyPs7QTARbYFNYFXcrpFhcsOgD4lObkQFoPoPANYjtLUqVch/4
         8XQA==
X-Gm-Message-State: AOUpUlGG1CGO2/mOtUNq3S/zDh6fTAt6l5id2S5Yqi96u1uiNsttqAdM
        EKQcnxxUj0TTnm70zC2miTo=
X-Google-Smtp-Source: AAOMgpe+VnNkO2OIzG8zQ80tzHVZYIdBms0nwxRx/IJklnQIiWc7EhdQRTiooT6q18ol6srctECwdw==
X-Received: by 2002:a17:902:6ac7:: with SMTP id i7-v6mr9365135plt.288.1533439031415;
        Sat, 04 Aug 2018 20:17:11 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id s184-v6sm12698538pfb.56.2018.08.04.20.17.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 04 Aug 2018 20:17:10 -0700 (PDT)
Date:   Sat, 4 Aug 2018 20:17:09 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Git List <git@vger.kernel.org>, git-packagers@googlegroups.com,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH] Makefile: enable DEVELOPER by default
Message-ID: <20180805031709.GF258270@aiede.svl.corp.google.com>
References: <20180804020009.224582-1-sbeller@google.com>
 <20180804020255.225573-1-sbeller@google.com>
 <20180804060928.GB55869@aiede.svl.corp.google.com>
 <CACsJy8DxSDLD7B8Z+GBFOuU7d7VQ4-M=BP=wptra5rBiZGspSQ@mail.gmail.com>
 <CAPig+cRA87UZsynme-by+s2ZmQW2Aus9KQscCU9mXmALCBKkKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPig+cRA87UZsynme-by+s2ZmQW2Aus9KQscCU9mXmALCBKkKQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine wrote:

> And, compilation warnings are not limited to old compilers. Even my
> fully up-to-date FreeBSD 11.2 installation is not warning-free[1].
>
> [1]: For instance:
> utf8.c:486:28: warning: passing 'iconv_ibp *' (aka 'const char **') to parameter
>       of type 'char **' discards qualifiers in nested pointer types
>       [-Wincompatible-pointer-types-discards-qualifiers]

Oh, good catch!  POSIX documents iconv has having signature

	size_t iconv(iconv_t cd, char **restrict inbuf,
	       size_t *restrict inbytesleft, char **restrict outbuf,
	       size_t *restrict outbytesleft);

The Makefile explains

	# Define OLD_ICONV if your library has an old iconv(), where the second
	# (input buffer pointer) parameter is declared with type (const char **).

which is implemented as

	#if defined(OLD_ICONV) || (defined(__sun__) && !defined(_XPG6))
		typedef const char * iconv_ibp;
	#else
		typedef char * iconv_ibp;
	#endif

config.mak.uname contains

	ifeq ($(uname_S),FreeBSD)
		NEEDS_LIBICONV = YesPlease
		OLD_ICONV = YesPlease

So it looks like FreeBSD has modernized and we need to make that
conditional in config.mak.uname on $(uname_R).  Do you know which
version of FreeBSD changed the signature?  Care to write a patch?

Thanks,
Jonathan
