Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C5C41F597
	for <e@80x24.org>; Mon, 30 Jul 2018 18:14:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726919AbeG3TuQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jul 2018 15:50:16 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37476 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726844AbeG3TuQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jul 2018 15:50:16 -0400
Received: by mail-pg1-f193.google.com with SMTP id n7-v6so7684819pgq.4
        for <git@vger.kernel.org>; Mon, 30 Jul 2018 11:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+jiheJyM7+b9296A76SITV9ZxTXXA8+D+PLcEXqj3d0=;
        b=HhmWzFc1DbX1vfookdDjpKDmHWaY4cmM774OPNgNrCmghBLmVYYybghRLxEkXVi9i4
         fLKuMBKZIoqAjM5CNAW8lwWbw1jPQsLLaiJUvfgUwDNtlp5gYxVQMchk8p0yxzI58RBC
         PSJxz0YSpr+susnJSUTC/rdNBvVOSFiFe5s640Y0C2iHoErYFaQHl1uVOl4AU/X4F/02
         LFhwae64oohSCiXSAbl2g7KoFVLSd3eBPqNrUS2Jy6rtMBPtD8NciPEE2NyPOfpYZ8+E
         JgZxcpihtLPEpW80H1o8ky474muf1XEA12Rf8Jo5yMFjDu7yAdJswqXOvZGDytncWL+g
         nSsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+jiheJyM7+b9296A76SITV9ZxTXXA8+D+PLcEXqj3d0=;
        b=QmGxM+RvYzNGSEAn5jvdyDt7m3DkRlNCmnfzqHb8Ky/Gr8vgZC0T0bv80veIA+GEnK
         a3kjhP5HNGfEIkh5tidKwWn94FKzyDkf8nq1CsHTtmYopyS/Z+rayCZ40jE0+IF78pTd
         X05FCDDMIysjda9YgFzAzfj3kmLwcn6WmkDDBeML5djGNXrVHm7pFMi7DgbRNKvsDs4A
         jaQ+ew9dbjU+vj++p7o1Yj75a1/HNkLUsj749jOMt/0z7YS/syhoteEUoOIOrbYSqw44
         KUL+xojeJo9J0kg/RQt36jVLaOUWW9liWr4TW4xx+KAGrTEP9aDtv0PWQllvceKz7DXQ
         5zgw==
X-Gm-Message-State: AOUpUlHQz166q0TVwwQZoIhwSq/WgEq9vfQmfHCn7IZE6WaWZjNZKg/A
        oCZerY+TBZh50vgSOoJTDNI=
X-Google-Smtp-Source: AAOMgpd+d223rxGUrQiNVlqPW0Rdm2gIYZ51+nNQak3mD252hhBVFJR7fEz24m8K0q8RgFgrK6CswQ==
X-Received: by 2002:a63:555:: with SMTP id 82-v6mr17640685pgf.25.1532974443717;
        Mon, 30 Jul 2018 11:14:03 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id r19-v6sm25635579pgg.39.2018.07.30.11.14.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Jul 2018 11:14:03 -0700 (PDT)
Date:   Mon, 30 Jul 2018 11:13:56 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Luke Diamand <luke@diamand.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 01/10] t/test-lib: teach --chain-lint to detect broken
 &&-chains in subshells
Message-ID: <20180730181356.GA156463@aiede.svl.corp.google.com>
References: <20180626073001.6555-1-sunshine@sunshineco.com>
 <20180711064642.6933-1-sunshine@sunshineco.com>
 <20180711064642.6933-2-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180711064642.6933-2-sunshine@sunshineco.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Eric Sunshine wrote:

> The --chain-lint option detects broken &&-chains by forcing the test to
> exit early (as the very first step) with a sentinel value. If that
> sentinel is the test's overall exit code, then the &&-chain is intact;
> if not, then the chain is broken. Unfortunately, this detection does not
> extend to &&-chains within subshells even when the subshell itself is
> properly linked into the outer &&-chain.
>
> Address this shortcoming by feeding the body of the test to a
> lightweight "linter" which can peer inside subshells and identify broken
> &&-chains by pure textual inspection.

Interesting.

>                                        Although the linter does not
> actually parse shell scripts, it has enough knowledge of shell syntax to
> reliably deal with formatting style variations (as evolved over the
> years) and to avoid being fooled by non-shell content (such as inside
> here-docs and multi-line strings).

This is causing contrib/subtree tests to fail for me: running "make -C
contrib/subtree test" produces

[...]
	*** t7900-subtree.sh ***
	ok 1 - no merge from non-existent subtree
	ok 2 - no pull from non-existent subtree
	ok 3 - add subproj as subtree into sub dir/ with --prefix
	ok 4 - add subproj as subtree into sub dir/ with --prefix and --message
	ok 5 - add subproj as subtree into sub dir/ with --prefix as -P and --message as -m
	ok 6 - add subproj as subtree into sub dir/ with --squash and --prefix and --message
	ok 7 - merge new subproj history into sub dir/ with --prefix
	ok 8 - merge new subproj history into sub dir/ with --prefix and --message
	ok 9 - merge new subproj history into sub dir/ with --squash and --prefix and --message
	ok 10 - merge the added subproj again, should do nothing
	ok 11 - merge new subproj history into subdir/ with a slash appended to the argument of --prefix
	ok 12 - split requires option --prefix
	ok 13 - split requires path given by option --prefix must exist
	ok 14 - split sub dir/ with --rejoin
	ok 15 - split sub dir/ with --rejoin from scratch
	ok 16 - split sub dir/ with --rejoin and --message
	ok 17 - split "sub dir"/ with --branch
	ok 18 - check hash of split
	ok 19 - split "sub dir"/ with --branch for an existing branch
	ok 20 - split "sub dir"/ with --branch for an incompatible branch
	error: bug in the test script: broken &&-chain or run-away HERE-DOC: 
		subtree_test_create_repo "$subtree_test_count" &&
[...]
		)

	Makefile:44: recipe for target 't7900-subtree.sh' failed

The problematic test code looks like this:

	(
		cd "$subtree_test_count/sub proj" &&
		git fetch .. subproj-br &&
		git merge FETCH_HEAD &&

		chks="sub1
sub2
sub3
sub4" &&
		chks_sub=$(cat <<TXT | sed '\''s,^,sub dir/,'\''
$chks
TXT
) &&
		chkms="main-sub1
main-sub2
main-sub3
main-sub4" &&
		chkms_sub=$(cat <<TXT | sed '\''s,^,sub dir/,'\''
$chkms
TXT
) &&

		subfiles=$(git ls-files) &&
		check_equal "$subfiles" "$chkms
$chks"
	)

Ugly quoting, useless use of "cat", etc, aside, I don't think it's
missing any &&.  Hints?

Thanks,
Jonathan
