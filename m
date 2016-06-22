Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 128BA1FF40
	for <e@80x24.org>; Wed, 22 Jun 2016 01:13:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751710AbcFVBNN (ORCPT <rfc822;e@80x24.org>);
	Tue, 21 Jun 2016 21:13:13 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:33625 "EHLO
	mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751485AbcFVBNM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Jun 2016 21:13:12 -0400
Received: by mail-it0-f68.google.com with SMTP id y93so3815294ita.0
        for <git@vger.kernel.org>; Tue, 21 Jun 2016 18:13:11 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=hhzkCYHELeXyku+psl1/0Zk1Zo+dBcBLiqhu6QIGuX0=;
        b=c9qJ4/32EfwO8hz0npPh8LTRZDiP+NBR5rtaPoDwc//d7V+NKwQb6Wx5t7OIPOVf+2
         pUohZy/VIvzYE/HqgKc0B/2MXEMORQmis6dR4mc5mJT1PC36hadSPjALXRFPvpAwCCvx
         AYQ7Ulb4Ipu1NbYDaGg02K9BnMwAnJjOjwVtNc9msM32b/J+H72dpp625kQiqMyBxTxz
         WdhyvLVC+ByZfCi+uGQEjld6jxjoJ9iT7k0GL2hPnAkDCXrCFTDWoOGhyJQUrRgHPr10
         qktPJUskdPiGcARK1hSdxqRc9h4QeYDXWojCEcL0XtdhxzSdflMpokgT3U9Iz1IIu2Vi
         ksGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=hhzkCYHELeXyku+psl1/0Zk1Zo+dBcBLiqhu6QIGuX0=;
        b=ZxQZwTTL8oeEuP0rQGjNUgoLKC6D1lxKb95UC11YZjtTL434JDBAPdm3lPNnYVGHJA
         W7XjPj2faguEzwltJnPQMDToS/zSQhYanUz0hFBdg/pETV7KVlt0GEcoBGtYVIwXlGRh
         6QFrHHPVFqQVpANeKfrEhwWHSZU5X56+McoL642uVUOOUo99TFvTkfFjH+U5VUBgPXlK
         u8rLbWoOv6oWGjw+3aM8zYhuZksouh+emz6Y/eMYu4zObGFJm/a1i1gRvFbv34emozaS
         Rb49XecqY5/wzMWnlsV+qsaIBa4HWlycg8DStmRrPlb+GTkt9QQM7Z6NZbskoaiBDYT6
         WeOw==
X-Gm-Message-State: ALyK8tLvcB+35tOlolblKjulHe/G3Rm8VpKU2NjaK0aGXWnsm4ql/Zr0mYzHe0tnTM6KhzMltY4c6wHDBOxeoQ==
X-Received: by 10.36.55.138 with SMTP id r132mr10563337itr.73.1466557990869;
 Tue, 21 Jun 2016 18:13:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.0.30 with HTTP; Tue, 21 Jun 2016 18:13:10 -0700 (PDT)
In-Reply-To: <20160621211412.28752-2-charles@hashpling.org>
References: <20160621211412.28752-1-charles@hashpling.org> <20160621211412.28752-2-charles@hashpling.org>
From:	Eric Sunshine <sunshine@sunshineco.com>
Date:	Tue, 21 Jun 2016 21:13:10 -0400
X-Google-Sender-Auth: OHjnVNnRRs9HE5kh0BTtMM6-uvA
Message-ID: <CAPig+cQ4CxRo460dcTJJtV_dPH8i5HC76_gpTv8attEZ8sdMZw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] grep: fix grepping for "intent to add" files
To:	Charles Bailey <charles@hashpling.org>
Cc:	Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Jun 21, 2016 at 5:14 PM, Charles Bailey <charles@hashpling.org> wrote:
> From: Charles Bailey <cbailey32@bloomberg.net>
>
> This reverts commit 4d552005323034c1d6311796ac1074e9a4b4b57e and adds an
> alternative fix to maintain the -L --cached behavior.

It is common to provide some context along with the (shortened) commit
ID. For instance:

    This reverts 4d55200 (grep: make it clear i-t-a entries are
    ignored, 2015-12-27) and adds ...

> 4d5520053 caused 'git grep' to no longer find matches in new files in
> the working tree where the corresponding index entry had the "intent to
> add" bit set, despite the fact that these files are tracked.
> [...]
> Helped-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> Signed-off-by: Charles Bailey <cbailey32@bloomberg.net>
> ---
>
> Is "Helped-by" an appropriate attribution in this case?

Very much so.

> diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
> @@ -1364,4 +1364,42 @@ test_expect_success 'grep --color -e A --and -e B -p with context' '
> +test_expect_success 'grep can find things only in the work tree' '
> +       touch work-tree-only &&

Avoid 'touch' if the timestamp of the file has no significance. Use '>' instead:

    >work-tree-only &&

> +       git add work-tree-only &&
> +       echo "find in work tree" >work-tree-only &&
> +       git grep --quiet "find in work tree" &&
> +       test_must_fail git grep --quiet --cached "find in work tree" &&
> +       test_must_fail git grep --quiet "find in work tree" HEAD &&
> +       git rm -f work-tree-only

If any statement before this cleanup code fails, then the cleanup will
never take place (due to the &&-chain). To ensure cleanup regardless
of test outcome, instead use test_when_finished() at the beginning of
the test:

    test_when_finished "git rm -f work-tree-only" &&

Same applies to other added tests.

> +'
> +
> +test_expect_success 'grep can find things only in the work tree (i-t-a)' '
> +       echo "intend to add this" >intend-to-add &&
> +       git add -N intend-to-add &&
> +       git grep --quiet "intend to add this" &&
> +       test_must_fail git grep --quiet --cached "intend to add this" &&
> +       test_must_fail git grep --quiet "intend to add this" HEAD &&
> +       git rm -f intend-to-add
> +'
> +
> +test_expect_success 'grep can find things only in the index' '
> +       echo "only in the index" >cache-this &&
> +       git add cache-this &&
> +       rm cache-this &&
> +       test_must_fail git grep --quiet "only in the index" &&
> +       git grep --quiet --cached "only in the index" &&
> +       test_must_fail git grep --quiet "only in the index" HEAD &&
> +       git rm --cached cache-this
> +'
> +
> +test_expect_success 'grep does not report i-t-a with -L --cached' '
> +       echo "intend to add this" >intend-to-add &&
> +       git add -N intend-to-add &&
> +       git ls-files | grep -v "^intend-to-add\$" >expected &&
> +       git grep -L --cached "nonexistent_string" >actual &&
> +       test_cmp expected actual &&
> +       git rm -f intend-to-add
> +'
> +
>  test_done
