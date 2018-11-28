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
	by dcvr.yhbt.net (Postfix) with ESMTP id 391B11F609
	for <e@80x24.org>; Wed, 28 Nov 2018 13:31:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728504AbeK2Ac7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Nov 2018 19:32:59 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50976 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728092AbeK2Ac6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Nov 2018 19:32:58 -0500
Received: by mail-wm1-f66.google.com with SMTP id 125so2653112wmh.0
        for <git@vger.kernel.org>; Wed, 28 Nov 2018 05:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+5MUossZN9I6rT24ZOBY2lxYy6TYbjzinfcpeMgtPqc=;
        b=saZZgh+bmMYpOYB+UdI2qUNqtCzASystDRXx/Z7GlcopnzJRvI0kuKMQfSFXypHRew
         8FwXQeDT7tPIO6D08fRgdN+NQTaGXrGu2m7L+IRL7mdjXYnnf0rvh9azZBYJBAYee5vk
         FjWoc+xuM8U/3zcyThuDLBokL9ldDpkmi73fH/md3fRb0Y8UNvrY3x62c91nOVI0KgW2
         nbEiAi6JNSNKHpn3XliNvBrQBrGfQobOWDyHv1PelLdLWwNj28qcEXWJeQwJqGP5Wfi3
         /Eti7g1G3XuFO6xkg19OMeUQjaJlGh9eTtu5lFp4uwZFHmSaN/LWsE4QkxQ7OSvNtbJx
         xj3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+5MUossZN9I6rT24ZOBY2lxYy6TYbjzinfcpeMgtPqc=;
        b=GvoPhWGZ7PCjoOxgREIQU2eKjSp7i+XTh99jWJpZvW/33xZ9pkc4FQeu3L8FaHW0Pl
         /H+OIbYIkPzIqP8KfNscpyQLUWG6IFHFmFaXDPLXRqtb5XzNLKpzWhZ1RAfQr2aZsUQU
         frhvQqJ3UBiregQE22wpkJn3+KzLtAkKxm9zod9LRQLn1zNNdocsFTtl5rRYKZkavH3F
         LAefbFBpZ0u4qdPldggb1sAszGltsHoG9Kh0nDNb+b9UsnKqSt5MqrZuAKeKcSggL+V0
         v4TfcoxYO9UWXlQrNeN6H9/CF+V7O7+MBcamT0SUBGds5q5HXnEnMohUE+3qTi2Y9qSc
         jBww==
X-Gm-Message-State: AA+aEWajXsuda21rlrbU9lO0xzit9ZkHVZk+pBKHZXNIFVQpdjK4GSu9
        HUufqfvtLXq3qH8u9deNnxE=
X-Google-Smtp-Source: AFSGD/XxdKnDdcGJLQbdwlRGeIJbxQMpaGKLxd/PtN2Fn4ATvxeU/QilSgxOxfnYhP04VjCPa279ug==
X-Received: by 2002:a1c:b189:: with SMTP id a131mr2917529wmf.38.1543411876880;
        Wed, 28 Nov 2018 05:31:16 -0800 (PST)
Received: from szeder.dev (x4db2728b.dyn.telefonica.de. [77.178.114.139])
        by smtp.gmail.com with ESMTPSA id g198sm3068510wmd.23.2018.11.28.05.31.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Nov 2018 05:31:16 -0800 (PST)
Date:   Wed, 28 Nov 2018 14:31:14 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Ben Peart <peartben@gmail.com>
Cc:     git@vger.kernel.org, benpeart@microsoft.com, pclouds@gmail.com,
        sandals@crustytoothpaste.net, avarab@gmail.com,
        Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v1] teach git to support a virtual (partially populated)
 work directory
Message-ID: <20181128133114.GF30222@szeder.dev>
References: <20181030191608.18716-1-peartben@gmail.com>
 <20181127195057.19724-1-peartben@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181127195057.19724-1-peartben@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 27, 2018 at 02:50:57PM -0500, Ben Peart wrote:

> diff --git a/t/t1092-virtualworkdir.sh b/t/t1092-virtualworkdir.sh
> new file mode 100755
> index 0000000000..0cdfe9b362
> --- /dev/null
> +++ b/t/t1092-virtualworkdir.sh
> @@ -0,0 +1,393 @@
> +#!/bin/sh
> +
> +test_description='virtual work directory tests'
> +
> +. ./test-lib.sh
> +
> +# We need total control of the virtual work directory hook
> +sane_unset GIT_TEST_VIRTUALWORKDIR
> +
> +clean_repo () {
> +	rm .git/index &&
> +	git -c core.virtualworkdir=false reset --hard HEAD &&
> +	git -c core.virtualworkdir=false clean -fd &&
> +	touch untracked.txt &&

We would usually run '>untracked.txt' instead, sparing the external
process.

A further nit is that a function called 'clean_repo' creates new
untracked files...

> +	touch dir1/untracked.txt &&
> +	touch dir2/untracked.txt
> +}
> +
> +test_expect_success 'setup' '
> +	mkdir -p .git/hooks/ &&
> +	cat > .gitignore <<-\EOF &&

CodingGuidelines suggest no space between redirection operator and
filename.

> +		.gitignore
> +		expect*
> +		actual*
> +	EOF
> +	touch file1.txt &&
> +	touch file2.txt &&
> +	mkdir -p dir1 &&
> +	touch dir1/file1.txt &&
> +	touch dir1/file2.txt &&
> +	mkdir -p dir2 &&
> +	touch dir2/file1.txt &&
> +	touch dir2/file2.txt &&
> +	git add . &&
> +	git commit -m "initial" &&
> +	git config --local core.virtualworkdir true
> +'


> +test_expect_success 'verify files not listed are ignored by git clean -f -x' '
> +	clean_repo &&

I find it odd to clean the repo right after setting it up; but then
again, 'clean_repo' not only cleans, but also creates new files.
Perhaps rename it to 'reset_repo'?  Dunno.

> +	write_script .git/hooks/virtual-work-dir <<-\EOF &&
> +		printf "untracked.txt\0"
> +		printf "dir1/\0"
> +	EOF
> +	mkdir -p dir3 &&
> +	touch dir3/untracked.txt &&
> +	git clean -f -x &&
> +	test -f file1.txt &&

Please use the 'test_path_is_file', ...

> +	test -f file2.txt &&
> +	test ! -f untracked.txt &&

... 'test_path_is_missing', and ...

> +	test -d dir1 &&

... 'test_path_is_dir' helpers, respectively, because they print
informative error messages on failure.

> +	test -f dir1/file1.txt &&
> +	test -f dir1/file2.txt &&
> +	test ! -f dir1/untracked.txt &&
> +	test -f dir2/file1.txt &&
> +	test -f dir2/file2.txt &&
> +	test -f dir2/untracked.txt &&
> +	test -d dir3 &&
> +	test -f dir3/untracked.txt
> +'
