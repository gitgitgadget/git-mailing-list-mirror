Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65ED21F954
	for <e@80x24.org>; Wed, 22 Aug 2018 15:39:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729065AbeHVTEy (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Aug 2018 15:04:54 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42748 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729024AbeHVTEy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Aug 2018 15:04:54 -0400
Received: by mail-wr1-f65.google.com with SMTP id v17-v6so1983145wrr.9
        for <git@vger.kernel.org>; Wed, 22 Aug 2018 08:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=XHcpcQbt0CV3WkA1aPrhTxFQ2eQlh1eVfJZw1GjWacY=;
        b=ustb40+DKDtUKyVm5HtG/ZYEoAmFCBv36vSpjEYHRiBxUZinjQsFvPX2YgW4k5lQ6+
         zJhEqIO0Dxt/317vV9NSFfdbjx0O/wPY4a7P7UR5usaVjXzwkHkvzMcxMz8Tb6Sg5Auq
         oW1Kz4hHJKHT9LBG9E3W+p6O8O2OeSHOUsNTg/IAiXT2OTrJ6vqwbOlgXTtBtbMInCDz
         8e8avRywd117PFHWWOp4vOC/eEiphQbMTmaQHF1inKnotcZG8uUNvd2O586gwv827Mqq
         EXtZcGrzKRZKsr7g61p1AQLDFhdekILgHw3R3a36qW7emZZ0cviehG1PQoNJI0nCw1Os
         aDmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=XHcpcQbt0CV3WkA1aPrhTxFQ2eQlh1eVfJZw1GjWacY=;
        b=O1JDVPcHXVo2OlVpLNbNqtr3P9pKJj0J3OjHPfGRpBb39967efkvNtmM/jpBDX2T5Q
         YmTVQZe5zpDCp0+J2CgO41Byg0vL5UZ88ZvGpyhmWa5zyLRhWqXPRmBLqDQc0anC0rfN
         maMk9XLxEaoFHbNkIOBQcmuwX8LLXj3jzXYY+Vyvuig7QQojYRqcx+bs5iSazeZhIHEZ
         WwChMUiu3oGaWyX5pkrfOgQ6bvdz1rKh8wsmLmSd+v0hbsVY3WcmLmaRGmuyF4gkBz5F
         xuTEynSITONpWLNQLc4Y1N7vhPzvujUTOk2nJ9gaGUkgg8vUR2lPKZI0G9pqI5NOtoOV
         n5HA==
X-Gm-Message-State: APzg51D64xRZhpU3zpgGEM5KnJ9q087OchSOkiN48wauSGSQiYf5rerg
        2/M9wXQKPESBHMg5nZvsUqE=
X-Google-Smtp-Source: ANB0VdZNBOCxrr0jRCKNUkkNU7J2IdR8MGEkFrabxsZUbdbNsanRQ3gxzuNeCL1M45svOq33Hp5+iA==
X-Received: by 2002:adf:f608:: with SMTP id t8-v6mr14265827wrp.186.1534952369968;
        Wed, 22 Aug 2018 08:39:29 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id z101-v6sm2943322wrb.55.2018.08.22.08.39.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 Aug 2018 08:39:29 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] t7501-commit: drop silly command substitution
References: <20180821232811.3610-1-szeder.dev@gmail.com>
Date:   Wed, 22 Aug 2018 08:39:28 -0700
In-Reply-To: <20180821232811.3610-1-szeder.dev@gmail.com> ("SZEDER
 =?utf-8?Q?G=C3=A1bor=22's?=
        message of "Wed, 22 Aug 2018 01:28:11 +0200")
Message-ID: <xmqq8t4y76mn.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor <szeder.dev@gmail.com> writes:

> The test '--dry-run with conflicts fixed from a merge' in
> 't7501-commit.sh', added in 8dc874b2ee (wt-status.c: set commitable
> bit if there is a meaningful merge., 2016-02-15), runs the following
> unnecessary and downright bogus command substitution:
>
>   ! $(git merge --no-commit commit-1) &&

I vaguely recall discussing (or noticing myself and then forgetting
to mention it?  I dunno) this exact one on another thread of your
test fixes and drawing the same conclusion as you have here.

Will apply.  Thanks for following it through.

>
> I.e. after 'git merge ...' is executed and expectedly fails, the test
> attempts to execute its output:
>
>   Merging:
>   80f2ea2 commit 2
>   virtual commit-1
>   found 1 common ancestor:
>   e60d113 Initial commit
>   Auto-merging test-file
>   CONFLICT (content): Merge conflict in test-file
>   Automatic merge failed; fix conflicts and then commit the result.
>
> as a command, which most likely fails, because there is no such
> command as "Merging:".  Then '!' negates the failed exit status, the
> test continues, and eventually succeeds.
>
> Remove this command substitution and use 'test_must_fail' to ensure
> that 'git merge' fails.
>
> Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
> ---
>  t/t7501-commit.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t7501-commit.sh b/t/t7501-commit.sh
> index 51646d8019..d766bf34c4 100755
> --- a/t/t7501-commit.sh
> +++ b/t/t7501-commit.sh
> @@ -677,7 +677,7 @@ test_expect_success '--dry-run with conflicts fixed from a merge' '
>  	git checkout -b branch-2 HEAD^1 &&
>  	echo "commit-2-state" >test-file &&
>  	git commit -m "commit 2" -i test-file &&
> -	! $(git merge --no-commit commit-1) &&
> +	test_must_fail git merge --no-commit commit-1 &&
>  	echo "commit-2-state" >test-file &&
>  	git add test-file &&
>  	git commit --dry-run &&
