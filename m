Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C73F1F85D
	for <e@80x24.org>; Wed, 11 Jul 2018 09:21:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbeGKJY4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jul 2018 05:24:56 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:37746 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbeGKJYz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jul 2018 05:24:55 -0400
Received: by mail-io0-f194.google.com with SMTP id z19-v6so22979275ioh.4
        for <git@vger.kernel.org>; Wed, 11 Jul 2018 02:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=860KoRU1xa26390FV1yCaJV6T+TwYJH4NPVyM1NwhPw=;
        b=aaUuxPpr/MmxArspTE6w0KMju1edkrY1m/bBnmO2+/YcFslq4lR8Yiv1/dY6mkoTBC
         PLubtljeiPU6vevbzUFIb7oAPpg170A+4KPGBLxgwB2FIU5+eGJo7twOjYRyjnbQLL2E
         jYJ0DGF2BVZ5yfoZPCb+Pw5C/+PKvesxHl0tHnGTTGrM9FsH1FCtLx0W6xmYhv4fM/T/
         5uVyDgi9cEGttf5lXkbEc2LRp5FMml5Og3IZCf5JH5+xy5ALXvo3FOhJVJyN7FGbYFgd
         qE3i9iTqIgGizNF2JeqMwd9jWx8KbfHO11MRuutoPsGFWjdKLSlgUXA17NliS+qPOKP9
         c/Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=860KoRU1xa26390FV1yCaJV6T+TwYJH4NPVyM1NwhPw=;
        b=HRkGBnefMNlj0h1n0J/An2zCH4g2eLty1dD2H+7TxGLr3KSMwJv/v777Hj/3Kgk80T
         VKKBvUKV2WM4wUfbwJmuwDsvkPD3OzK7B49/FIs+sLH+Y4aqkGh5tAMWiG1niekgGyLG
         /scvDgnusDq7cPHeJmG9Mv8madOFZu89mDMZ0HkI6zvmSNsZg9ytT+U0AbnsbKx5rVom
         ldlRE6ORUe956RHeC6Du1xX3j5FqMlxAXrIwUMwRvaeVBe+k16vitvqkeE4Wz+15Iaix
         /ZoaC1W1QzsXWLCOpGiNI3PZec0/6LB9FPdon07L0FZnztCMnnZzpilzj0E2nKxJzeWB
         HWjw==
X-Gm-Message-State: AOUpUlGgZYRX9GmfTDj0LNDA+4LTHlq4JhOoQxUWuaVm0OZRCDmKNmDn
        uk0BSWMZ4mUmC/F96pbhjLE=
X-Google-Smtp-Source: AAOMgpeDBnFqEe3qNaEBANzKoBa60hCFIOPvVBou87Q7TaqRvskaEIuEy2fpHxOomi90tPeFb9iMBA==
X-Received: by 2002:a6b:1491:: with SMTP id 139-v6mr24738799iou.103.1531300893276;
        Wed, 11 Jul 2018 02:21:33 -0700 (PDT)
Received: from flurp.local (user-12l2cs3.cable.mindspring.com. [69.81.51.131])
        by smtp.gmail.com with ESMTPSA id z14-v6sm6625215iob.68.2018.07.11.02.21.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jul 2018 02:21:32 -0700 (PDT)
Date:   Wed, 11 Jul 2018 05:21:26 -0400
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH 1/2] t1015: demonstrate directory/file conflict recovery
 failures
Message-ID: <20180711092126.GA17315@flurp.local>
References: <20180711051834.28181-1-newren@gmail.com>
 <20180711051834.28181-2-newren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180711051834.28181-2-newren@gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 10, 2018 at 10:18:33PM -0700, Elijah Newren wrote:
> Several "recovery" commands outright fail or do not fully recover
> when directory-file conflicts are present.  This includes:
>   * git read-tree --reset HEAD
>   * git am --skip
>   * git am --abort
>   * git merge --abort
>   * git reset --hard
> 
> Add testcases documenting these shortcomings.
> 
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
> diff --git a/t/t1015-read-index-unmerged.sh b/t/t1015-read-index-unmerged.sh
> @@ -0,0 +1,123 @@
> +test_expect_success 'setup modify/delete + directory/file conflict' '
> +	test_create_repo df_plus_modify_delete &&
> +	(
> +		cd df_plus_modify_delete &&
> +
> +		printf "a\nb\nc\nd\ne\nf\ng\nh\n" >letters &&

test_write_lines a b c d e f g h >letters &&

> +		git add letters &&
> +		git commit -m initial &&
> +
> +		git checkout -b modify &&
> +		# Throw in letters.txt for sorting order fun
> +		# ("letters.txt" sorts between "letters" and "letters/file")
> +		echo i >>letters &&
> +		echo "version 2" >letters.txt &&
> +		git add letters letters.txt &&
> +		git commit -m modified &&
> +
> +		git checkout -b delete HEAD^ &&
> +		git rm letters &&
> +		mkdir letters &&
> +		>letters/file &&
> +		echo "version 1" >letters.txt &&
> +		git add letters letters.txt &&
> +		git commit -m deleted
> +	)
> +'
> +
> +test_expect_failure 'read-tree --reset cleans unmerged entries' '
> +	test_when_finished "git -C df_plus_modify_delete clean -f" &&
> +	test_when_finished "git -C df_plus_modify_delete reset --hard" &&
> +	(
> +		cd df_plus_modify_delete &&
> +		...
> +	)
> +'

I wonder how much value these distinct repositories add over not using
them:

--- >8 ---
#!/bin/sh

test_description='Test various callers of read_index_unmerged'
. ./test-lib.sh

test_expect_success 'setup modify/delete + directory/file conflict' '
	test_write_lines a b c d e f g h >letters &&
	git add letters &&
	git commit -m initial &&

	git checkout -b modify &&
	# Throw in letters.txt for sorting order fun
	# ("letters.txt" sorts between "letters" and "letters/file")
	echo i >>letters &&
	echo "version 2" >letters.txt &&
	git add letters letters.txt &&
	git commit -m modified &&

	git checkout -b delete HEAD^ &&
	git rm letters &&
	mkdir letters &&
	>letters/file &&
	echo "version 1" >letters.txt &&
	git add letters letters.txt &&
	git commit -m deleted
'

test_expect_failure 'read-tree --reset cleans unmerged entries' '
	test_when_finished "git clean -f" &&
	test_when_finished "git reset --hard" &&

	git checkout delete^0 &&
	test_must_fail git merge modify &&

	git read-tree --reset HEAD &&
	git ls-files -u >conflicts &&
	test_must_be_empty conflicts
'

test_expect_failure 'One reset --hard cleans unmerged entries' '
	test_when_finished "git clean -f" &&
	test_when_finished "git reset --hard" &&

	git checkout delete^0 &&
	test_must_fail git merge modify &&

	git reset --hard &&
	test_path_is_missing .git/MERGE_HEAD &&
	git ls-files -u >conflicts &&
	test_must_be_empty conflicts
'

test_expect_success 'setup directory/file conflict + simple edit/edit' '
	test_seq 1 10 >numbers &&
	git add numbers &&
	git commit -m initial &&

	git checkout -b d-edit &&
	mkdir foo &&
	echo content >foo/bar &&
	git add foo &&
	echo 11 >>numbers &&
	git add numbers &&
	git commit -m "directory and edit" &&

	git checkout -b f-edit d-edit^1 &&
	echo content >foo &&
	git add foo &&
	echo eleven >>numbers &&
	git add numbers &&
	git commit -m "file and edit"
'

test_expect_failure 'git merge --abort succeeds despite D/F conflict' '
	test_when_finished "git clean -f" &&
	test_when_finished "git reset --hard" &&

	git checkout f-edit^0 &&
	test_must_fail git merge d-edit^0 &&

	git merge --abort &&
	test_path_is_missing .git/MERGE_HEAD &&
	git ls-files -u >conflicts &&
	test_must_be_empty conflicts
'

test_expect_failure 'git am --skip succeeds despite D/F conflict' '
	test_when_finished "git clean -f" &&
	test_when_finished "git reset --hard" &&

	git checkout f-edit^0 &&
	git format-patch -1 d-edit &&
	test_must_fail git am -3 0001*.patch &&

	git am --skip &&
	test_path_is_missing .git/rebase-apply &&
	git ls-files -u >conflicts &&
	test_must_be_empty conflicts
'

test_done
--- >8 ---
