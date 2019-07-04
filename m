Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 292261F461
	for <e@80x24.org>; Thu,  4 Jul 2019 20:01:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbfGDUBi (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Jul 2019 16:01:38 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44699 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbfGDUBi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jul 2019 16:01:38 -0400
Received: by mail-wr1-f68.google.com with SMTP id b2so6463766wrx.11
        for <git@vger.kernel.org>; Thu, 04 Jul 2019 13:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=BGoox6il17b2YafN76O1hCMc55m2+dF/6jMZy//pU9o=;
        b=AlkROegOg9Q24eSM19uDB4qHNGyjjxFlnOeY0N8ivt0bCYPGc2kjK0st57r46kSokf
         n7j6sKBCQm/Vc+GjoYL752Ff9f/o42SiorNKQp5JeeGcMt2d0n6r0+6iCBPeKxwO0JbX
         qt1359TrT0GhiDRfvFJoenUHv4HTjPBDNxVjmlLwymH+RlOMMiG9XVJFWQM72z590dub
         OHxJsLV1u8E60Yxm7ovvz2ru68G2PRrkSASgEmbZZIvITkKs2X1t9trjxKhQ/EMbgHoF
         /s2GapuAdxnoiURkJe8qnSYlX5vcR4JeFs0B6bcZ0RkPjbCm4gwjKfIaA146JUrQ7s68
         wnqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=BGoox6il17b2YafN76O1hCMc55m2+dF/6jMZy//pU9o=;
        b=pUiBuKDOCVoKrKxuRRCjq7iTNWhfOthybJ7aldq+hbgrU4eZqrzpGb/20FnGAVQw/E
         yfKVKH38NFa8UmvCnK0Gaf+diDGYzUNdWsatCQGKj6QJrL0ObqUb8uQkZpLnURmrpIJ9
         uTyFY2B47CvBpwn2t/mcafAt6zhYS+c9zwGj4aaLUt/TCKcZNwyJHOqrVnC+dmlZWilx
         slyMv7febn4zZEMBaXy7ZwfQXOwccp0y4oD4HaAH5nn2+ZoLzu57bviNnO3o4CHBO+3n
         aDFcx3lmxXUMTdXEwrUG+AcEacsZ0cK17fjSjGiQggV34TyiG1B213W4UQL6Mf3WVqsK
         +1sQ==
X-Gm-Message-State: APjAAAWgSQuMdQPolEAZmH7Ae8vtJZYXttWX+zSnJYapH0HJjuc80EWp
        cdMUH0mYIBcXOg7JSgDnomc=
X-Google-Smtp-Source: APXvYqwLhaplLwDoOzTWijD+eoXRHPFZ7iihvEUsveVqjit6nLw73dT5DmijxBwzL2SR5nhqxaeScw==
X-Received: by 2002:a5d:55d2:: with SMTP id i18mr193479wrw.260.1562270496357;
        Thu, 04 Jul 2019 13:01:36 -0700 (PDT)
Received: from szeder.dev (x4db60912.dyn.telefonica.de. [77.182.9.18])
        by smtp.gmail.com with ESMTPSA id u6sm6185072wml.9.2019.07.04.13.01.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Jul 2019 13:01:35 -0700 (PDT)
Date:   Thu, 4 Jul 2019 22:01:33 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Derrick Stolee <stolee@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 05/10] split-index.c: dump "link" extension as json
Message-ID: <20190704200133.GD20404@szeder.dev>
References: <20190624130226.17293-1-pclouds@gmail.com>
 <20190624130226.17293-6-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190624130226.17293-6-pclouds@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 24, 2019 at 08:02:21PM +0700, Nguyễn Thái Ngọc Duy wrote:
> diff --git a/t/t3011-ls-files-json.sh b/t/t3011-ls-files-json.sh
> index 082fe8e966..dbb572ce9d 100755
> --- a/t/t3011-ls-files-json.sh
> +++ b/t/t3011-ls-files-json.sh
> @@ -44,4 +44,18 @@ test_expect_success 'ls-files --json, main entries, UNTR and TREE' '
>  	compare_json basic
>  '
>  
> +test_expect_success 'ls-files --json, split index' '
> +	git init split &&
> +	(
> +		cd split &&
> +		echo one >one &&
> +		git add one &&
> +		git update-index --split-index &&
> +		echo updated >>one &&
> +		test_must_fail git -c splitIndex.maxPercentChange=100 update-index --refresh &&
> +		cp ../filter.sed . &&
> +		compare_json split-index
> +	)
> +'
> +
>  test_done
> diff --git a/t/t3011/split-index b/t/t3011/split-index
> new file mode 100644
> index 0000000000..cdcc4ddded
> --- /dev/null
> +++ b/t/t3011/split-index
> @@ -0,0 +1,39 @@
> +{
> +  "version": 2,
> +  "oid": <string>,
> +  "mtime_sec": <number>,
> +  "mtime_nsec": <number>,
> +  "entries": [
> +    {
> +      "id": 0,
> +      "name": "",
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
> +    }
> +  ],
> +  "extensions": {
> +    "link": {
> +      "file_offset": <number>,
> +      "ext_size": <number>,
> +      "oid": <string>,
> +      "delete_bitmap": [
> +      ],
> +      "replace_bitmap": [
> +        0
> +      ]
> +    }
> +  }
> +}

This test is flaky, as reported in:

  https://public-inbox.org/git/xmqqftno2mku.fsf@gitster-ct.c.googlers.com/

This is because it relies on racy behaviour, namely that the following
three commands

    echo one >one &&
    git add one &&
    git update-index --split-index &&

are executed within the same second, leaving 'one' racily clean.  To
deal with the racily clean file, 5581a019ba (split-index: smudge and
add racily clean cache entries to split index, 2018-10-11) kicks in,
and 'one's smudged index entry is stored both in the shared index and
in the split index.  That's why this test expects the offset 0 in the
"replace_bitmap" array.

However, it's possible that a second boundary is crossed between
writing to 'one' and splitting the index, and then 'one' is not racily
clean, and its index entry is only stored in the shared index.
Consequently, there are no index entries in the split index, so the
"replace_bitmap" array ends up being empty, ultimately failing the
test.

A 'test-tool chmtime' invocation or two could make the test
deterministic (i.e it could make sure that 'one' is either always
racily clean or it never is, whichever is preferred).

What I still don't understand, however, is that when the test fails
this way, then the "entries" array ends up being empty as well.  It
looks as if the JSON dump included only index entries that were
actually stored in '.git/index', but omitted entries that were only
present in the shared index.  I think this is wrong, and it should
dump the unified view of the split and shared indexes.  Or include all
entries from the shared index as well.  Or perhaps I'm completely
missing something...


