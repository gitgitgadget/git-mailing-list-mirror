Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EABF72023D
	for <e@80x24.org>; Mon, 22 May 2017 21:51:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936098AbdEVVvf (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 May 2017 17:51:35 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:35548 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934097AbdEVVve (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 May 2017 17:51:34 -0400
Received: by mail-pf0-f174.google.com with SMTP id n23so94203257pfb.2
        for <git@vger.kernel.org>; Mon, 22 May 2017 14:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=TrNTHaqVat3SBihI6G2BGRD8/BhIHbozQqTieiDVN0g=;
        b=RSuHBoNjd3mNKLlJvhG/72BGWhN1WuQQ8qjQ0DzCrsMk2pwnY3jX6aXmJyeYQoFCWB
         IjJEhYSvhw3UET2aHqIv59DW752i5+sGOGitEp1k/42Ek6L1AU++vpfc/xdbPPEzf4uM
         VKwjPVid2MSmqX7jmd3cQA31aMlpTnWoaUbx+C/1BxLp2/optJ1i0YwSdW9PdCEggUFG
         00wutyEjTb1DyAkqgn//KiOGpAVocjt9lS81w7D5ZqK3gi2oTw5ywJ4G9pXVEqHOD7mC
         ewdOMgvTcfIiiFdQpaL0994d3VI2eKACZJ6CJorJ3tFDL1b9XFKJ60BaxH6BFgT19rwM
         uAaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=TrNTHaqVat3SBihI6G2BGRD8/BhIHbozQqTieiDVN0g=;
        b=APcCH3nsLci8eKCqb+x196QlKG1znIm5TtD0hyOo5YYiDlHg2zrZtICYmMs6cABpw7
         fAGPWBkNJAK+aOO0knTwO5NNRRVeZrhwb85dkWUPM6VAuJJi8f9jaT31JAuUe65+/dQ8
         yI+mMOJR8zXccW7DzbPo3aOP5VQCXvUpcpUkYJyQZLF+37wpAwR1C64Dj4Psqg1kDX9h
         12eUoutgIYLde7i272mu0wjGLNP7YdhghgWeZsg/QsOP0aIP974xBTaOOTbWL2bbQZdh
         VG/m6sYX0rnpZVQgAsXPAHU7UhLD1bsjJcw1NItBjlG/vuosNnSIRaqk9PxhRRwMwDRT
         2qLg==
X-Gm-Message-State: AODbwcCHdVyDjaeoGGQSyk29H2FM9HlLnhl9HnDfc85wF7EkgZzTLUCU
        Z7GvyUnU0LYGQY88hGO1P8ZsrCTghiJ4
X-Received: by 10.99.188.9 with SMTP id q9mr27971977pge.178.1495489893822;
 Mon, 22 May 2017 14:51:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.170.200 with HTTP; Mon, 22 May 2017 14:51:33 -0700 (PDT)
In-Reply-To: <cover.1495460199.git.mhagger@alum.mit.edu>
References: <cover.1495460199.git.mhagger@alum.mit.edu>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 22 May 2017 14:51:33 -0700
Message-ID: <CAGZ79kYC-nn9iY+mw6fAdBXKH_WBhJ0dLxg66BnH2pfF3L+9-g@mail.gmail.com>
Subject: Re: [PATCH v2 00/25] Prepare to separate out a packed_ref_store
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>,
        Johannes Sixt <j6t@kdbg.org>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 22, 2017 at 7:17 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> This is the second iteration of a patch series that prepares the
> ground for separating out a `packed_ref_store` and then for changing
> `packed-refs` to be read using `mmap()`. Thanks to Peff, Junio,
> Stefan, Brandon, and Johannes for their feedback about v1 [1]. I think
> I have addressed all of your comments.
>
> Changes since v1:
>
> * Since v1, branch `bc/object-id` has been merged to `next`, and it
>   has lots of conflicts with these changes. So I rebased this branch
>   onto a merge of `master` and `bc/object-id`. (I hope this makes
>   Junio's job easier.) This unfortunately causes a bit of tbdiff noise
>   between v1 and v2.
>
> * Patch [01/25]: in t3600, register the `test_when_finished` command
>   before executing `chmod a-w`.
>
> * Patch [04/25] (new patch): convert a few `die("internal error: ...")`
>   to `die("BUG: ...")`.
>
> * Patch [05/25]: Use `strlen()` rather than `memchr()` to check the
>   trim length, and `die()` rather than skipping if it is longer than
>   the reference name.
>
> * Patch [08/25]: Name the log message arguments `msg` for consistency
>   with existing code.
>
> * Patch [10/25]: Rename the new member from `packlock` to
>   `packed_refs_lock`.
>
> * Patch [13/25] (new patch): Move the check for valid
>   `transaction->state` from `files_transaction_commit()` to
>   `ref_transaction_commit()`.
>
> * Patch [14/25]:
>
>   * Add more sanity checks of `transaction->state`.
>
>   * Don't add `ref_transaction_finish()` to the public API. Instead,
>     teach `ref_transaction_commit()` to do the right thing whether or
>     not `ref_transaction_prepare()` has been called.
>
>   * Add and improve docstrings.
>
>   * Allow `ref_transaction_abort()` to be called even before
>     `ref_transaction_prepare()` (in which case it just calls
>     `ref_transaction_free()`).
>
> * Lots of improvements to commit messages and comments, mostly to
>   clarify points that reviewers asked about.
>
> These changes (along with the merge commit that they are based on) are
> also available as branch `packed-ref-store-prep` in my GitHub fork
> [2]. If you'd like to see a preview of the rest of the changes (which
> works but is not yet polished), checkout the `mmap-packed-refs` branch
> from the same place.

I have read this version and quite like it. I did not have any nits to remark.

Thanks,
Stefan
