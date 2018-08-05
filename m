Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E828B1F597
	for <e@80x24.org>; Sun,  5 Aug 2018 07:57:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726085AbeHEKBU (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Aug 2018 06:01:20 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:35756 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbeHEKBU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Aug 2018 06:01:20 -0400
Received: by mail-pl0-f66.google.com with SMTP id w3-v6so4341839plq.2
        for <git@vger.kernel.org>; Sun, 05 Aug 2018 00:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lxr6yOm4RFcnmJhuukkwNHY+aXuuNv72KTSnpSOVfIQ=;
        b=YQY8pJ+kRyIwUl900SAEhj/iB9Kn4D4Z/ZDwR5JS8G1SCX8sWSMclJ0EMvCGNBGro/
         y77MUQhiYRXrfOuFmYb0vo4UeoRT6GQ3ovlWJHkz273bDbAYdcEeuEbvwXhSM04fH8qu
         C/gri5rnjYeuHlwgst2Dqpt/o/iKCgcBXqI6/+nh+cag9gNJWd6sqcY4PnGtK4/ayD8b
         HAMscxCR8xn9n00NUBNncs/xHInjQPz6wAaGNGuRLYOHXq817j02b0q5ZQ6EUJuFzWys
         hRRpEPE9Y4h+YI4fziiPWGR1rgU5DcV8RrnZSb9nJIdQJ38AGHXA9ET8X/0VyBTPnu7s
         8/FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lxr6yOm4RFcnmJhuukkwNHY+aXuuNv72KTSnpSOVfIQ=;
        b=aJYfMb2tRMmP2Rcclg48onJ5IEpRBhdP8z5hwh9hP9FgOaqwW3xu3AGliJIpajqGnk
         WYvso4PkpOIPqwMX96wIQbEamOgKI1mqUm34UwzsulCCZfLl0aUzFKhxj8UGTYWpcTth
         sdmOPs5TaEuWA32+4n3yndueaD7aYSNKPNVOxhUh1Jck8tH/+zKhMMkDKaifmuqMYGuU
         aJ166vonfw9E/iza4S8nB6qILyv72BQjE8/2zCZG/yPJ93IIqEVCJEXIQzN3vLmdl/oj
         1d03fbQ6/qtGbakQjrOX01MAn9n5QgG4VpifZavzWRU1JmAgunmMq6suPLl+pau0S4D5
         9Fkg==
X-Gm-Message-State: AOUpUlGzReU4ZDpK6XGyWeixYZOAnjBQCM/mOrPHk5gEjiiatx9XONrt
        z66e4Pd3T0HcKzZtO8tOZ9Q=
X-Google-Smtp-Source: AAOMgpf6iQwTDnTyss/w0fiZpuWLETsVcMj0YYSmYQtViw7L8V1Qus94k1zBBTf9LbUGTx0cvsYBnQ==
X-Received: by 2002:a17:902:4503:: with SMTP id m3-v6mr9785488pld.168.1533455859115;
        Sun, 05 Aug 2018 00:57:39 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id i3-v6sm8442966pgq.35.2018.08.05.00.57.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 05 Aug 2018 00:57:38 -0700 (PDT)
Date:   Sun, 5 Aug 2018 00:57:36 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Git List <git@vger.kernel.org>, git-packagers@googlegroups.com,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH] Makefile: enable DEVELOPER by default
Message-ID: <20180805075736.GF44140@aiede.svl.corp.google.com>
References: <20180804020009.224582-1-sbeller@google.com>
 <20180804020255.225573-1-sbeller@google.com>
 <20180804060928.GB55869@aiede.svl.corp.google.com>
 <CACsJy8DxSDLD7B8Z+GBFOuU7d7VQ4-M=BP=wptra5rBiZGspSQ@mail.gmail.com>
 <CAPig+cRA87UZsynme-by+s2ZmQW2Aus9KQscCU9mXmALCBKkKQ@mail.gmail.com>
 <20180805031709.GF258270@aiede.svl.corp.google.com>
 <CAPig+cRjxLgGZbROZAuH-VF3xLVUxQTRj7gKPFurypbwz2zzjg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPig+cRjxLgGZbROZAuH-VF3xLVUxQTRj7gKPFurypbwz2zzjg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Eric Sunshine wrote:
> On Sat, Aug 4, 2018 at 11:17 PM Jonathan Nieder <jrnieder@gmail.com> wrote:

>>> utf8.c:486:28: warning: passing 'iconv_ibp *' (aka 'const char **') to parameter
>>>       of type 'char **' discards qualifiers in nested pointer types
>>>       [-Wincompatible-pointer-types-discards-qualifiers]
>>
>> Oh, good catch!  POSIX documents iconv has having signature
>>
>>         size_t iconv(iconv_t cd, char **restrict inbuf,
>>                size_t *restrict inbytesleft, char **restrict outbuf,
>>                size_t *restrict outbytesleft);
>>
>> config.mak.uname contains
>>
>>         ifeq ($(uname_S),FreeBSD)
>>                 NEEDS_LIBICONV = YesPlease
>>                 OLD_ICONV = YesPlease
>>
>> So it looks like FreeBSD has modernized and we need to make that
>> conditional in config.mak.uname on $(uname_R).  Do you know which
>> version of FreeBSD changed the signature?  Care to write a patch?
>
> Unfortunately, I don't know in which version of FreeBSD that changed.

"git blame" tells me it's from r281550[1] (Remove the const qualifier
from iconv(3) to comply with POSIX, 2015-04-15), which was part of
FreeBSD 11.  r282275[2] (2015-04-30) backported the same change to
FreeBSD 10 and is part of 10.2.

FreeBSD 9 has

	#define iconv(cd, in, insize, out, outsize)    libiconv(cd, __DECONST(char **, in), insize, out, outsize)

from r219019[3] (2011-02-25).  I don't know what to make of it.  The
underlying libiconv function it calls takes char ** (the modern thing)
but the macro does the __DECONST thing for compatibility with GNU
libiconv.

Older versions, going back at least as far as FreeBSD 3, behave the
same way as FreeBSD 9.  So that must be what was tested with
OLD_ICONV=YesPlease.

FreeBSD 10.1.0 and 10.0.0 have

	size_t  iconv(iconv_t, const char ** __restrict,
		      size_t * __restrict, char ** __restrict,
		      size_t * __restrict);

which also needs OLD_ICONV.  If I assume everyone on 10.x is using
10.2 or newer, then the patch could be something like this (completely
untested):

diff --git i/config.mak.uname w/config.mak.uname
index 684fc5bf026..8078c099313 100644
--- i/config.mak.uname
+++ w/config.mak.uname
@@ -192,7 +192,9 @@ ifeq ($(uname_O),Cygwin)
 endif
 ifeq ($(uname_S),FreeBSD)
 	NEEDS_LIBICONV = YesPlease
-	OLD_ICONV = YesPlease
+	ifeq ($(shell expr "$(uname_R)" : '[1-9]\.'),2)
+		OLD_ICONV = YesPlease
+	endif
 	NO_MEMMEM = YesPlease
 	BASIC_CFLAGS += -I/usr/local/include
 	BASIC_LDFLAGS += -L/usr/local/lib

Deciding whether to fix the pattern matching to also include 10.0 and
10.1 (and doing so if warranted) is left as an exercise to the reader.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>

[1] https://github.com/freebsd/freebsd/commit/b0813ee288f64f677a2cebf7815754b027a8215b
[2] https://github.com/freebsd/freebsd/commit/b709ec868adb5170d09bc5a66b18d0e0d5987ab6
[3] https://github.com/freebsd/freebsd/commit/c91ab1769b1237e3663d59888cebe31ceee47570
