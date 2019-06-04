Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09FA21F609
	for <e@80x24.org>; Tue,  4 Jun 2019 13:14:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbfFDNOH (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Jun 2019 09:14:07 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46215 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727129AbfFDNOG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jun 2019 09:14:06 -0400
Received: by mail-wr1-f65.google.com with SMTP id n4so10521199wrw.13
        for <git@vger.kernel.org>; Tue, 04 Jun 2019 06:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=igKRtn4Ron95zokFfaZ/5xyWyW1GhJllsTEECooYs+8=;
        b=gDOfgEJX8R5HjfP+gIRWq3l/3fghxEx7ymNWgGSCQoDhzFqxyeTF3jijauNAKcb47B
         BJj9gDxtj4KPsuMZfx3e5aMNOaeuDcJJQ5/qgu8XBa2tUliYvvy9sFxIMgIkMTJdtxQE
         M6SfIIiAXy7OFM4+gOAD6fPCDcbfWvluL9JDMgRKaMA6RKY3QKAIIe7JkokmbaRgXB+S
         g4RKgOXAMCyfJMMAk4mhGYyWp9vlrMzZ/Pi8TFj8/Zai7/YY+pDEo9ypf4CPefAtHoEc
         9FUf/rCYsA/dNGB7DL5eOVRSxj0JWKQY4/w6s8l9j2Yau1p60gBZO2ukSJaRIJ3cxlS3
         UTFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=igKRtn4Ron95zokFfaZ/5xyWyW1GhJllsTEECooYs+8=;
        b=K70bBcD30H8OsKRSr5CYKqMctwZIgE2R/ODciTHOFam3SmxJCV0ZR7nRWUYt7lbE6f
         EQaTRx9aPiyvJSTYn2924VBUXk/G6ilbugInEuusW9slXCTVEB6NeAdgMQZTR0c5zRnl
         TXwbfZKi/YtvNokaE9lqboYyEGF9pD2Q1yk5HIhVZq0CLb6X35bUjj9hApIlbYHNtVCZ
         dP75ARLeOXoXsJif8MNpfWOrwgn0EvIsj4q0lX+TRbTm+3y5UTKa1iZDujyCYaH9aTTc
         xfxa5iqanwLmNmJqqHqBy1Ij0aGJFj2OYM8F1J9vieSFZxhr423hWQocN3aCeVCu3r1W
         eKjg==
X-Gm-Message-State: APjAAAUBLU9fzsKeZKJ+YAlt5lF7T6ve2SCelMzyAaxCi8NNsR0wl4i9
        AV+V/fldeiQrZl8daZbJzps=
X-Google-Smtp-Source: APXvYqwxMJ2EdiBtLpBxK1JS91neVLK+Ad/9ox2mvFvmWZ5G84M2CLsFgUounrE36F6UnstE5NQPJw==
X-Received: by 2002:adf:f046:: with SMTP id t6mr7333481wro.307.1559654043342;
        Tue, 04 Jun 2019 06:14:03 -0700 (PDT)
Received: from szeder.dev (x4dbe169e.dyn.telefonica.de. [77.190.22.158])
        by smtp.gmail.com with ESMTPSA id u205sm21208923wmu.47.2019.06.04.06.14.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jun 2019 06:14:02 -0700 (PDT)
Date:   Tue, 4 Jun 2019 15:14:00 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        ben.humphreys@atlassian.com,
        Ben Humphreys <behumphreys@atlassian.com>
Subject: Re: [PATCH] merge-recursive: restore accidentally dropped setting of
 path
Message-ID: <20190604131400.GS951@szeder.dev>
References: <20190604023039.GR951@szeder.dev>
 <20190604072614.26885-1-newren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190604072614.26885-1-newren@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 04, 2019 at 12:26:14AM -0700, Elijah Newren wrote:
> Of course, this wasn't the only bug; it also showed we had a glaring
> whole in our test coverage -- there's a dearth of tests for rename/add
> conflicts, and in particular none involving content merges for the
> rename side.  So, I created a patch which adds some tests for that
> (which triggered the assertion error).  I pulled SZEDER's fix into the
> same patch and added a commit message explaining the issue, using a
> Based-on-patch-by tag for the fix.  SZEDER: if you'd like to see this
> in a different format (maybe I add tests which show the error and then
> in a separate patch authored by you we introduce your fix?), just let
> me know.

Nah, I'm fine with it.

> Since we're at -rc3 already, even if it is a trivial patch, I'm going to
> try to re-analyze it all tomorrow to make sure I didn't miss anything and
> see if I can find more tests to throw at it.
> 
> Ben: Could you rerun all your special testcases to make sure things
> are good with this patch too?  It'd be much appreciated.
> 
> Thanks Ben for reporting and SZEDER for jumping on and analyzing and
> cc'ing me.
> 
> Sorry for the headache folks,

Thanks for the tests!



> Subject: [PATCH] merge-recursive: restore accidentally dropped setting of path
> 
> In commit 8daec1df03de ("merge-recursive: switch from (oid,mode) pairs
> to a diff_filespec", 2019-04-05), we actually switched from
> (oid,mode,path) triplets to a diff_filespec -- but most callsites in the
> patch only needed to worry about oid and mode so the commit message
> focused on that.  The oversight in the commit message apparently spilled
> over to the code as will; one of the dozen or so callsites accidentally

s/will/well/

> dropped the setting of the path in the conversion.  Restore the path
> setting in that location.
> 
> Also, this pointed out that our testsuite was lacking a good rename/add
> test, at least one that involved the need for merge content with the
> rename.  Add such a test, and since rename/add vs. add/rename could
> possibly be important, redo the merge the opposite direction to make
> sure we don't have issues with the direction of the merge.  These
> testcases failed before restoring the setting of path, but with the
> paths appropriately set the testcases both pass.
> 
> Reported-by: Ben Humphreys <behumphreys@atlassian.com>
> Based-on-patch-by: SZEDER Gábor <szeder.dev@gmail.com>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  merge-recursive.c                    |   1 +
>  t/t6042-merge-rename-corner-cases.sh | 118 +++++++++++++++++++++++++++
>  2 files changed, 119 insertions(+)
> 
> diff --git a/merge-recursive.c b/merge-recursive.c
> index a7bcfcbeb4..d2e380b7ed 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -1660,6 +1660,7 @@ static int handle_rename_add(struct merge_options *opt,
>  	       c->path, add_branch);
>  
>  	prev_path_desc = xstrfmt("version of %s from %s", path, a->path);
> +	ci->ren1->src_entry->stages[other_stage].path = a->path;
>  	if (merge_mode_and_contents(opt, a, c,
>  				    &ci->ren1->src_entry->stages[other_stage],
>  				    prev_path_desc,
> diff --git a/t/t6042-merge-rename-corner-cases.sh b/t/t6042-merge-rename-corner-cases.sh
> index 09dfa8bd92..0793f64099 100755
> --- a/t/t6042-merge-rename-corner-cases.sh
> +++ b/t/t6042-merge-rename-corner-cases.sh
> @@ -411,6 +411,124 @@ test_expect_success 'disappearing dir in rename/directory conflict handled' '
>  	)
>  '
>  
> +# Test for basic rename/add-dest conflict, with rename needing content merge:
> +#   Commit O: a
> +#   Commit A: rename a->b, modifying b too
> +#   Commit B: modify a, add different b
> +
> +test_expect_success 'setup rename-with-content-merge vs. add' '
> +	test_create_repo rename-with-content-merge-and-add &&
> +	(
> +		cd rename-with-content-merge-and-add &&
> +
> +		test_seq 1 5 >a &&
> +		git add a &&
> +		git commit -m O &&
> +		git tag O &&
> +
> +		git checkout -b A O &&
> +		git mv a b &&
> +		test_seq 0 5 >b &&
> +		git add b &&
> +		git commit -m A &&
> +
> +		git checkout -b B O &&
> +		echo 6 >>a &&
> +		echo hello world >b &&
> +		git add a b &&
> +		git commit -m B
> +	)
> +'
> +
> +test_expect_success 'handle rename-with-content-merge vs. add' '
> +	(
> +		cd rename-with-content-merge-and-add &&
> +
> +		git checkout A^0 &&
> +
> +		test_must_fail git merge -s recursive B^0 >out &&
> +		test_i18ngrep "CONFLICT (rename/add)" out &&
> +
> +		git ls-files -s >out &&
> +		test_line_count = 2 out &&
> +		git ls-files -u >out &&
> +		test_line_count = 2 out &&
> +		git ls-files -u b >out &&

Are these two 'git ls-files -u' executions as intended, i.e. first
without a file and then with 'b'?

Or is this a bit of a "Huh?!"-inducing way (for me; for you it might
be an idiom :) to check that 'b' has two unmerged entries and no other
file has unmerged entries?

> +		test_line_count = 2 out &&
> +		git ls-files -o >out &&
> +		test_line_count = 1 out &&
> +
> +		test_path_is_missing a &&
> +		test_path_is_file b &&
> +
> +		test_seq 0 6 >tmp &&
> +		git hash-object tmp >expect &&
> +		git rev-parse B:b >>expect &&
> +		git rev-parse >actual  \
> +			:2:b    :3:b   &&
> +		test_cmp expect actual &&
> +
> +		# Test that the two-way merge in b is as expected
> +		git cat-file -p :2:b >>ours &&
> +		git cat-file -p :3:b >>theirs &&
> +		>empty &&
> +		test_must_fail git merge-file \
> +			-L "HEAD" \
> +			-L "" \
> +			-L "B^0" \
> +			ours empty theirs &&
> +		git hash-object b >actual &&
> +		git hash-object ours >expect &&
> +		test_cmp expect actual

So these last three lines compute the object ids of two files and then
compare those two oids to make sure they match...  But wouldn't a
'test_cmp ours b' do the trick just as well?

> +	)
> +'
> +
> +test_expect_success 'handle rename-with-content-merge vs. add, merge other way' '
> +	(
> +		cd rename-with-content-merge-and-add &&
> +
> +		git reset --hard &&
> +		git clean -fdx &&
> +
> +		git checkout B^0 &&
> +
> +		test_must_fail git merge -s recursive A^0 >out &&
> +		test_i18ngrep "CONFLICT (rename/add)" out &&
> +
> +		git ls-files -s >out &&
> +		test_line_count = 2 out &&
> +		git ls-files -u >out &&
> +		test_line_count = 2 out &&
> +		git ls-files -u b >out &&
> +		test_line_count = 2 out &&
> +		git ls-files -o >out &&
> +		test_line_count = 1 out &&
> +
> +		test_path_is_missing a &&
> +		test_path_is_file b &&
> +
> +		test_seq 0 6 >tmp &&
> +		git rev-parse B:b >expect &&
> +		git hash-object tmp >>expect &&
> +		git rev-parse >actual  \
> +			:2:b    :3:b   &&
> +		test_cmp expect actual &&
> +
> +		# Test that the two-way merge in b is as expected
> +		git cat-file -p :2:b >>ours &&
> +		git cat-file -p :3:b >>theirs &&
> +		>empty &&
> +		test_must_fail git merge-file \
> +			-L "HEAD" \
> +			-L "" \
> +			-L "A^0" \
> +			ours empty theirs &&
> +		git hash-object b >actual &&
> +		git hash-object ours >expect &&
> +		test_cmp expect actual
> +	)
> +'
> +
>  # Test for all kinds of things that can go wrong with rename/rename (2to1):
>  #   Commit A: new files: a & b
>  #   Commit B: rename a->c, modify b
> -- 
> 2.22.0.rc3.1.g617c1f72bf
> 
