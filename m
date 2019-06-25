Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6FC521F461
	for <e@80x24.org>; Tue, 25 Jun 2019 09:06:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729235AbfFYJF7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jun 2019 05:05:59 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:32869 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728365AbfFYJF7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jun 2019 05:05:59 -0400
Received: by mail-wr1-f67.google.com with SMTP id n9so16982916wru.0
        for <git@vger.kernel.org>; Tue, 25 Jun 2019 02:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Or5ajJewnjr5tDmBqH4/I+l2hML1IC3O+umX9erXpbM=;
        b=DVe3o+OvDcEIwHRJvxMWwn8BkxMYH7z0nNepP3B9Wc3O2P7q/BgxGG+/WFZoIXmeYL
         vu+YJweVF2khVHCOJO/BHUnMgYIC26IKcdAM3dreA5HN51f1TTF0kKTHYWexEOlUfWBI
         nQNep5J238NN9PhWsxOUL7IM8kP5GNNX2f13Yn1b7/Xt+8vZoXQ/5j7Ppv4PKKBzsHF/
         rK34NT5HZivwPVoYrECoY1Valjcbbvw9ic/Jbdu8BsVKEu+JQCtKsShiL1yqQLB6Usw4
         aYohu1fbrcs5yAwLUhOSDukDJ4MFD0W6qEv6puPtY0kTRi0H0eMLJt288z8rLwSEz+rZ
         bZiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Or5ajJewnjr5tDmBqH4/I+l2hML1IC3O+umX9erXpbM=;
        b=MJKhE9K5lFUS5un7Ermi5fW/zZP/eTk1q0gDGh0pIe740XCoTRsQknlfY6n+BiOSYK
         GxaOE6k8klZaXgPsEXkVmeQWGElrWvP7EpW+xepoKflp9XyVmbB106/WUaDH+DxBuQj3
         zmmEbAfx1o/nKaSc7AP+JIBBPMgXK51DrnoLfEp1UkwkgcVKdkj6w7WgzI9n0wWvxtM0
         7ELvH7FJz9hXEjpwMs1YY/8OWCl0SR8JQhc4VabbIAENWBE6HLUeOJ/fSw7EkvUWlgdr
         mXNMRTlAv1fInK1jBNQSsee/O9C5N0ddPmeX/hVH3jx0hZJJLIiDtbQbgW7fa67HvVS2
         4rSA==
X-Gm-Message-State: APjAAAWBJtl2Kv15PPu2XxWJqofLCgkmMKhq7FTtIpTte/rVtnagBS6f
        wJDFP7QnT/ZadSDo4MFZSIg=
X-Google-Smtp-Source: APXvYqwAof92Se4e+gVHkWUXCXSotI6VaxHsjdxkSlPsNm3JATFZspHIlAX0ldDSzOeb7Or4GbbBwg==
X-Received: by 2002:adf:a345:: with SMTP id d5mr34925424wrb.234.1561453557391;
        Tue, 25 Jun 2019 02:05:57 -0700 (PDT)
Received: from localhost (adsl-24.176.58.195.tellas.gr. [176.58.195.24])
        by smtp.gmail.com with ESMTPSA id d7sm1043868wrx.37.2019.06.25.02.05.55
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 25 Jun 2019 02:05:56 -0700 (PDT)
Date:   Tue, 25 Jun 2019 10:05:54 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Derrick Stolee <stolee@gmail.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 01/10] ls-files: add --json to dump the index
Message-ID: <20190625090554.GA2423@hank.intra.tgummerer.com>
References: <20190624130226.17293-1-pclouds@gmail.com>
 <20190624130226.17293-2-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190624130226.17293-2-pclouds@gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/24, Nguyễn Thái Ngọc Duy wrote:
> So far we don't have a command to basically dump the index file out,
> with all its glory details. Checking some info, for example, stat
> time, usually involves either writing new code or firing up "xxd" and
> decoding values by yourself.
> 
> This --json is supposed to help that. It dumps the index in a human
> readable format but also easy to be processed with tools. And it will
> print almost enough info to reconstruct the index later.
> 
> In this patch we only dump the main part, not extensions. But at the
> end of the series, the entire index is dumped. The end result could be
> very verbose even on a small repository such as git.git.
> 
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  Documentation/git-ls-files.txt    |  5 +++
>  builtin/ls-files.c                | 38 +++++++++++++---
>  cache.h                           |  2 +
>  json-writer.c                     | 22 ++++++++++
>  json-writer.h                     | 23 ++++++++++
>  read-cache.c                      | 72 ++++++++++++++++++++++++++++++-
>  t/t3011-ls-files-json.sh (new +x) | 44 +++++++++++++++++++
>  t/t3011/basic (new)               | 67 ++++++++++++++++++++++++++++
>  8 files changed, 265 insertions(+), 8 deletions(-)
>
> [...]
>
> diff --git a/t/t3011-ls-files-json.sh b/t/t3011-ls-files-json.sh
> new file mode 100755
> index 0000000000..97bcd814be
> --- /dev/null
> +++ b/t/t3011-ls-files-json.sh
> @@ -0,0 +1,44 @@
> +#!/bin/sh
> +
> +test_description='ls-files dumping json'
> +
> +. ./test-lib.sh
> +
> +strip_number() {
> +	for name; do
> +		echo 's/\("'$name'":\) [0-9]\+/\1 <number>/' >>filter.sed
> +	done
> +}
> +
> +strip_string() {
> +	for name; do
> +		echo 's/\("'$name'":\) ".*"/\1 <string>/' >>filter.sed
> +	done
> +}
> +
> +compare_json() {
> +	git ls-files --debug-json >json &&
> +	sed -f filter.sed json >filtered &&
> +	test_cmp "$TEST_DIRECTORY"/t3011/"$1" filtered
> +}
> +
> +test_expect_success 'setup' '
> +	mkdir sub &&
> +	echo one >one &&
> +	git add one &&
> +	echo 2 >sub/two &&
> +	git add sub/two &&
> +
> +	echo intent-to-add >ita &&
> +	git add -N ita &&
> +
> +	strip_number ctime_sec ctime_nsec mtime_sec mtime_nsec &&
> +	strip_number device inode uid gid file_offset ext_size &&
> +	strip_string oid ident
> +'
> +
> +test_expect_success 'ls-files --json, main entries' '
> +	compare_json basic
> +'
> +
> +test_done
> diff --git a/t/t3011/basic b/t/t3011/basic
> new file mode 100644
> index 0000000000..9436445d90
> --- /dev/null
> +++ b/t/t3011/basic
> @@ -0,0 +1,67 @@
> +{
> +  "version": 3,

This will break the test suite when 'GIT_TEST_INDEX_VERSION' is set to
4 for example.  I think this applies to a few other tests in later
patches as well.

> +  "oid": <string>,
> +  "mtime_sec": <number>,
> +  "mtime_nsec": <number>,
> +  "entries": [
> +    {
> +      "id": 0,
> +      "name": "ita",
> +      "mode": "100644",
> +      "flags": 536887296,
> +      "extended_flags": true,
> +      "intent_to_add": true,
> +      "oid": <string>,
> +      "stat": {
> +        "ctime_sec": <number>,
> +        "ctime_nsec": <number>,
> +        "mtime_sec": <number>,
> +        "mtime_nsec": <number>,
> +        "device": <number>,
> +        "inode": <number>,
> +        "uid": <number>,
> +        "gid": <number>,
> +        "size": 0
> +      },
> +      "file_offset": <number>
> +    },
> +    {
> +      "id": 1,
> +      "name": "one",
> +      "mode": "100644",
> +      "flags": 0,
> +      "oid": <string>,
> +      "stat": {
> +        "ctime_sec": <number>,
> +        "ctime_nsec": <number>,
> +        "mtime_sec": <number>,
> +        "mtime_nsec": <number>,
> +        "device": <number>,
> +        "inode": <number>,
> +        "uid": <number>,
> +        "gid": <number>,
> +        "size": 4
> +      },
> +      "file_offset": <number>
> +    },
> +    {
> +      "id": 2,
> +      "name": "sub/two",
> +      "mode": "100644",
> +      "flags": 0,
> +      "oid": <string>,
> +      "stat": {
> +        "ctime_sec": <number>,
> +        "ctime_nsec": <number>,
> +        "mtime_sec": <number>,
> +        "mtime_nsec": <number>,
> +        "device": <number>,
> +        "inode": <number>,
> +        "uid": <number>,
> +        "gid": <number>,
> +        "size": 2
> +      },
> +      "file_offset": <number>
> +    }
> +  ]
> +}
> -- 
> 2.22.0.rc0.322.g2b0371e29a
> 
