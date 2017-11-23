Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD4DF2036D
	for <e@80x24.org>; Thu, 23 Nov 2017 09:11:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752198AbdKWJLu (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Nov 2017 04:11:50 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:42669 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751632AbdKWJLs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Nov 2017 04:11:48 -0500
Received: by mail-wm0-f65.google.com with SMTP id l188so13560732wma.1
        for <git@vger.kernel.org>; Thu, 23 Nov 2017 01:11:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=X/wopiZ0hluW+f9HRPJ5H7ho5XRinPo2ZEq1kE5GioM=;
        b=vFkYFaUtB0mf5HQxzz6bqxU53PSR4/Y6nPLc0nNsJ88NGy0JUsZg6tvwkS9usBPHP+
         VQKdlcK6OjdMIm3QJrkROP/NQw8zPo2NAaCVj9B+BRbOuWCHuRgglddZ+xN97VXXYEcz
         Uv4zZACVKwbs992zX16+X9LcazFfzuq/goNMDQjW5A6LesDLosRAFv8fqCIu5zaV7oda
         uBinkIR99NhXZXil80PelSxbZsaaG5LctB6G97YYmAaZS7T6NE1GpqQnPNXGTkxet8U6
         rFWwMfbsXBXQwFWTh1XSMXsiFSv681AvMTfXI4qQbK4sQWQ+bq+txzfXLcCYHpELEixA
         5SXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=X/wopiZ0hluW+f9HRPJ5H7ho5XRinPo2ZEq1kE5GioM=;
        b=eMncuw9Zx8GhEl5x4xYWwM1bD22VhvcPzwr2g0wTA/SBnNbenoSLzF7NugIF4QmBh4
         +b1aJ/SbupH0gsFryFzZdETLioPWVHt+0DBmnJx6Wq9m3hqaqgQX8ST7YF3IgSx3bhee
         yyTjfnmplR+Ysdqop+HA1SOULEzucU8dw0zfnMo6wJENv/r/+Qm7xdpz3DJKKEaD1grB
         qdOEh+cTx2VaG+VDrGzdp4Vx6ULIfPIv630glU6ynCGP1i56PopRWW1VBGhBPhgSHB6m
         IMr8f3kq/KKMVdMHP6a1SnAZ6vDQD44YsOgOta30LupFJhyvd83C2WpSt/Xziy+mzDcy
         MfMw==
X-Gm-Message-State: AJaThX7xPeTfSDdUxREWtO9DOPqJVWlyxDaDmhEXgA1IOHDhTk/2cO9k
        4kAla6UOSpIMgX9R6hsn5p16IBMT
X-Google-Smtp-Source: AGs4zMZ53Qw7H+tbK3XMj3CYWYIzLPLrbj92U274bU8kf01BgLEg1fkFMFz6lZ0+nc2YWZc7Dc+YnQ==
X-Received: by 10.80.180.246 with SMTP id x51mr1609822edd.230.1511428306888;
        Thu, 23 Nov 2017 01:11:46 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id g45sm12806567eda.88.2017.11.23.01.11.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 Nov 2017 01:11:45 -0800 (PST)
Received: from avar by evledraar with local (Exim 4.89)
        (envelope-from <avarab@gmail.com>)
        id 1eHnXt-0002BS-2Q; Thu, 23 Nov 2017 10:11:45 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] test-lib: add LIBPCRE1 & LIBPCRE2 prerequisites
References: <20171122133630.18931-1-avarab@gmail.com> <20171122202259.GC11671@aiede.mtv.corp.google.com>
User-agent: Debian GNU/Linux 9.2 (stretch); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <20171122202259.GC11671@aiede.mtv.corp.google.com>
Date:   Thu, 23 Nov 2017 10:11:45 +0100
Message-ID: <87d149we9a.fsf@evledraar.booking.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Nov 22 2017, Jonathan Nieder jotted:

> Hi,
>
> Ævar Arnfjörð Bjarmason wrote:
>
>> Add LIBPCRE1 and LIBPCRE2 prerequisites which are true when git is
>> compiled with USE_LIBPCRE1=YesPlease or USE_LIBPCRE2=YesPlease,
>> respectively.
>>
>> The syntax of PCRE1 and PCRE2 isn't the same in all cases (see
>> pcresyntax(3) and pcre2syntax(3)). If test are added that test for
>> those they'll need to be guarded by these new prerequisites.
>>
>> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>> ---
>>  t/README      | 12 ++++++++++++
>>  t/test-lib.sh |  2 ++
>>  2 files changed, 14 insertions(+)
>>
>> diff --git a/t/README b/t/README
>> index 4b079e4494..599cd9808c 100644
>> --- a/t/README
>> +++ b/t/README
>> @@ -808,6 +808,18 @@ use these, and "test_set_prereq" for how to define your own.
>>     Git was compiled with support for PCRE. Wrap any tests
>>     that use git-grep --perl-regexp or git-grep -P in these.
>>
>> + - LIBPCRE1
>> +
>> +   Git was compiled with PCRE v1 support via
>> +   USE_LIBPCRE1=YesPlease. Wrap any PCRE using tests that for some
>> +   reason need v1 of the PCRE library instead of v2 in these.
>
> Are there plans to use the LIBPCRE1 prereq?  It might be simpler to
> only have LIBPCRE2, and LIBPCRE1 can still be expressed as
>
> 	PCRE,!LIBPCRE2
>
> which I think is clearer about the intent.

I prefer to keep it as it is. It's more obvious to me to have a 1=1
mapping between the ${USE,NO}_* variables and the prerequisites, and
it's future-proof if there's ever a PCRE v3, since tests that use this
will mean v1 specifically, not just any non-v2 version (although now v1
is the only one).
