Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BCDDA20188
	for <e@80x24.org>; Wed, 10 May 2017 23:33:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753822AbdEJXdP (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 May 2017 19:33:15 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:32974 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751096AbdEJXdP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2017 19:33:15 -0400
Received: by mail-pf0-f173.google.com with SMTP id e193so4829476pfh.0
        for <git@vger.kernel.org>; Wed, 10 May 2017 16:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=zpxGJ9SbjBDFSu/hZknlLwqOlu3uiu75CioNg4X3Vrc=;
        b=P+Gp50D1N9dFOM/CbuShsbRdbKC40ic6d7Kr+5L7xWGOJcG9fA4tGmyTgcysEbgRU1
         aavTJ6cz2JOAjsrRYunf5r1kCXaOCRnClyR9ipGF66ehJ+kEuYfs3ZhkVVJyhu11Xak0
         +b7q100r9T/4hijsA25bxFPIuuF/UfQ5akqOzwZKVr2kmJChW18rRU4joHk7JfPoNO81
         JE6GCG0jfD4k+VM/FPba8NMpdCJP9TBbKtw4E18xd+U+3sQSmhgboVBZl/IKaJq9xGSU
         6BWwt/E25yNcyzNHrWD7vI9k4jTX9u09JjNfcM2r/4GtuY+X81ARBjb7Dep9ZnAxhlES
         HHiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=zpxGJ9SbjBDFSu/hZknlLwqOlu3uiu75CioNg4X3Vrc=;
        b=KoeQUnKPW/+O2901EK2QWuwyEZKciIocC85+ZtgzrMnjx0Ex5RhP9FwHm0h1JL6iDG
         77W0WtfgT6bnxdTZ7HoDuyfG5Ep0NFGfb2GzQ8hOtft0017ZSWejO2Xx2JjayoDaevdl
         DwT/ZBxOOOTXJAWOukHty1/sIoucooMqCcAG+10TrErfdZzKpsWGHw1oaU6rA7u0tPot
         9fgD1o0unMv2AJR8515E+TdmBNhWi96yaPbBiEDja/HPls8ebijxr6NaUZWz7BKke1Lg
         TeMMlSm9tLpJX3z2nQNqNCaKHBiYWzFfQ6w24smkdWvamO/bDo9znZ1kivGEZPY49jbu
         NGVA==
X-Gm-Message-State: AODbwcDyshyxQy08oJfEozgwqyfIzvhRqCydgClTme5ScgNfIrkdje+r
        WSbjnCW6ut2ZE98Fz5M=
X-Received: by 10.98.193.129 with SMTP id i123mr8945527pfg.203.1494459194315;
        Wed, 10 May 2017 16:33:14 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:55dd:a079:3f06:9176])
        by smtp.gmail.com with ESMTPSA id s186sm11484pfb.98.2017.05.10.16.33.13
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 10 May 2017 16:33:13 -0700 (PDT)
Date:   Wed, 10 May 2017 16:33:11 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH v2 2/2] perf: add test showing exponential growth in path
 globbing
Message-ID: <20170510233311.GE28740@aiede.svl.corp.google.com>
References: <20170510225316.31680-1-avarab@gmail.com>
 <20170510225316.31680-3-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170510225316.31680-3-avarab@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Ævar Arnfjörð Bjarmason wrote:

> Add a test showing that ls-files times grow exponentially in the face
> of some pathological globs, whereas refglobs via for-each-ref don't in
> practice suffer from the same issue.

Cool.

[...]
> --- /dev/null
> +++ b/t/perf/p0100-globbing.sh
> @@ -0,0 +1,48 @@
> +#!/bin/sh
> +
> +test_description="Tests pathalogical globbing performance
> +
> +Shows how Git's globbing performance performs when given the sort of
> +pathalogical patterns described in at https://research.swtch.com/glob

s/pathalogical/pathological/

> +"
> +
> +. ./perf-lib.sh
> +
> +test_globs_big='10 25 50 75 100'
> +test_globs_small='1 2 3 4 5 6'
> +
> +test_perf_fresh_repo
> +
> +test_expect_success 'setup' '
> +	for i in $(test_seq 1 100)
> +	do
> +		printf "a" >>refname &&
> +		for j in $(test_seq 1 $i)
> +		do
> +			printf "a*" >>refglob.$i
> +		done &&
> +		echo b >>refglob.$i
> +	done &&
> +	test_commit $(cat refname) &&
> +	for i in $(test_seq 1 100)
> +	do
> +	echo	git tag $(cat refname)-$i

Leftover echo from debugging?

> +	done &&
> +	test_commit hello
> +'
> +
> +for i in $test_globs_big
> +do
> +	test_perf "refglob((a*)^nb) against tag a^100; n = $i" '
> +		git for-each-ref "refs/tags/$(cat refglob.'$i')b"
> +	'
> +done
> +
> +for i in $test_globs_small
> +do
> +	test_perf "fileglob((a*)^nb) against file (a^100).t; n = $i" '
> +		git ls-files "$(cat refglob.'$i')b"
> +	'
> +done

The rest looks sensible.

Thanks,
Jonathan
