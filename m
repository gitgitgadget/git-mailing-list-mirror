Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3788920248
	for <e@80x24.org>; Tue, 19 Mar 2019 09:28:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbfCSJ22 (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Mar 2019 05:28:28 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46584 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbfCSJ21 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Mar 2019 05:28:27 -0400
Received: by mail-ed1-f67.google.com with SMTP id d1so404079edd.13
        for <git@vger.kernel.org>; Tue, 19 Mar 2019 02:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=hN3rAIa9gx96EIdgoOfhHnSXwg96PrNUbsEVElZ64DQ=;
        b=aex4BCz7EETZZ2XoKzylbu2Sde/BJ5Yvgc+sm/C7GIqWjmwR0sKIJzo5OE803Sq7JS
         9ht2dk3wdiclYE+ckmj4f1TDuO5k0BMn9ZxqRshnyJXfdzkWrye4awsWrkzUNvLHmfbe
         Bx8WGDeK0gPAlmLWyGyZrIsdXL4wWlOIHCCULvrvLQ6SJgy5NmEXeJeHGn+9bB5SLu+h
         kVhLHcKi2Itn8H0nUwNiBNtOvrym0an6TlpZq7DpC/n8EgdX4uP28RaFoMDYE8t7VcMO
         F3fx+5D/o8VM41lr9Hz2UiwFpsYt2ocExh1iaEeHTTyLtEofze/DJgiI7+qWpyCw/7qs
         WktQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=hN3rAIa9gx96EIdgoOfhHnSXwg96PrNUbsEVElZ64DQ=;
        b=MeiCl3Y+d8OShCon922Q1cUKKy4Vgr6JIxHOdy7j+G3cu1l/BBWvjBFGe14Rhxk1s4
         abIxTS1ecjpTkw8QqNVWKC2TN/xZmAWVACeoBEJkWSK14Zol7Cn1vHRs2xPkU3TeDkwS
         Fc6mwJucIJQzRAbZfa3qBG7iDZXb6urXCfwEUm0+Oa9PPDNEzmj3YttfZLbb/wS2FYKQ
         30+I4VbWlaM2t4Adxe/44oOBF2Daoao1HuQdYvV/8RpCWN7/HCWOVEo3W8m5EbqUa0xR
         MTobsGPvOL6pj43RJA5JRGM8P2/CW7viJuCukUCFUR7kgE8A4A0he0I8Qgp1YOEcZzrJ
         l8WA==
X-Gm-Message-State: APjAAAVNw8dSpnEDgjA+4gFbSUTp/dm2LuTcG4/2yqV8HOHiBbxkI8Q0
        H7KAlDSRaUQ0ftKKv0SUUDKVKjtxvCY=
X-Google-Smtp-Source: APXvYqzH8ZmII1MS2cpNLolzfAmRvw/YNHjkHKW/WS4fXNoY13AH6cKUvsPqo3W8d66wXNQClXzwHA==
X-Received: by 2002:a17:906:fd5:: with SMTP id c21mr13684565ejk.86.1552987705944;
        Tue, 19 Mar 2019 02:28:25 -0700 (PDT)
Received: from evledraar ([5.57.21.49])
        by smtp.gmail.com with ESMTPSA id q12sm4311509edd.12.2019.03.19.02.28.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Mar 2019 02:28:25 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Matt McCutchen <matt@mattmccutchen.net>
Subject: Re: [PATCH 4/4] gc docs: downplay the usefulness of --aggressive
References: <20190318161502.7979-1-avarab@gmail.com> <20190318161502.7979-5-avarab@gmail.com> <5cf21eee-a46f-2657-7bf3-e4963cf1c56b@kdbg.org>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <5cf21eee-a46f-2657-7bf3-e4963cf1c56b@kdbg.org>
Date:   Tue, 19 Mar 2019 10:28:24 +0100
Message-ID: <87bm27dxhj.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Mar 19 2019, Johannes Sixt wrote:

> Am 18.03.19 um 17:15 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>> +Using this option may optimize for disk space at the expense of
>> +runtime performance. See the `--depth` and `--window` documentation in
>> +linkgit:git-repack[1]. It is not recommended that this option be used
>> +to improve performance for a given repository without running tailored
>> +performance benchmarks on it. It may make things better, or worse. Not
>> +using this at all is the right trade-off for most users and their
>> +repositories.
>> ++
>> +The effects of this option are persistent to the extent that
>> +`gc.autoPackLimit` and friends don't cause a consolidation of existing
>> +pack(s) generated with this option.
>
> The first paragraph talks about potential downsides. And I think that
> the second paragraph attempts to tell me how I can back out if I'm hit
> by those downsides. But I have not the slightest idea how to read this
> sentence and know what I have to do.

That's an existing issue, but I'm fine with improving the docs even
more, will add that :)

You need to repack non-aggressively with the -f option. Right now
there's nothing that exposes that from "gc", except setting the
"aggressive" settings to the same as the default window/depth.
