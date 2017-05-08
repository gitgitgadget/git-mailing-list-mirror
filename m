Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 956C720188
	for <e@80x24.org>; Mon,  8 May 2017 04:34:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751759AbdEHEeH (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 May 2017 00:34:07 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33885 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751378AbdEHEeG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2017 00:34:06 -0400
Received: by mail-pg0-f67.google.com with SMTP id u187so8843090pgb.1
        for <git@vger.kernel.org>; Sun, 07 May 2017 21:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=4roubhocDCMjs0NEnXagYXPsg2zICgrvEfM72jg/EP8=;
        b=jGd/rmN1asnigBFz72zr6U3GHV+NlM/oexpmstnOPVOP2gY5d7CvHoSJGJ9UGzCf9U
         bseDvzL9/9jVW97xt41ololSPfoS9L4e0pYIFozcxsuX1Z6wn6VawOzHJ5myojGFrM5y
         dutH3o+2qoIMDJCAGDx6QZLfuHR5Pk8FIAlEZMkmsyflEVptGOUhdEp4oZZW3BWY75OO
         24By94hs156V4grwQ7CUQrPvxGPUs2dg9HltYgKgsrSqaaD5ST0cvTrfTIdgTWg28HDd
         Y7CNrPfvagHohmG4Sy6i/sk88L++sLzLE4Y97wbN0KbvUq18ZerD7t224LwGXPtQAbNv
         oJzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=4roubhocDCMjs0NEnXagYXPsg2zICgrvEfM72jg/EP8=;
        b=SkiZIE6VZmHsTnvPER3tctPEv6b3nq36Ps7pOXnI9d0/trVMpUjLF/IcgQo6hGYQEP
         /n3wvKcdoFsljz6HvCvnU2eTxJG04eEn5NiHhDzFVBGGEZPmcYb6DXigAuHn2qtZWnyU
         7IRTpCYeoDE8aNzOkVcgt9w/PlE5MXtq/2a5qQkjfOOlkBp02M1IsAeXbiCrjKx/8giK
         K+muVmpaD0yKIdsFKscGvHR6FR+/mO7MBh48vkG12c4rxyxWWYi/I7kdisjk4QknwV1s
         SIQpZ3wMDk0t+Cw3+wiUDcwLLuSGCHrRt4NR6Z3yVpNtqDMi4bLqDQiV/eUOoR4cQmqf
         e4cw==
X-Gm-Message-State: AODbwcCHP3poRMn50nlC1uL2B6lt1EPc/wGEaeRtzQNLDoB3Nakzg7dc
        1PfQIdfMfMLXMQ==
X-Received: by 10.99.103.70 with SMTP id b67mr9192739pgc.96.1494218045555;
        Sun, 07 May 2017 21:34:05 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:3011:642f:81a0:efbd])
        by smtp.gmail.com with ESMTPSA id 15sm21320324pfl.110.2017.05.07.21.34.04
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 07 May 2017 21:34:04 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Samuel Lijin <sxlijin@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 2/9] t7061: expect failure where expected behavior will change
References: <20170505104611.17845-1-sxlijin@gmail.com>
        <20170503032932.16043-1-sxlijin@gmail.com>
        <20170505104611.17845-3-sxlijin@gmail.com>
Date:   Mon, 08 May 2017 13:34:04 +0900
In-Reply-To: <20170505104611.17845-3-sxlijin@gmail.com> (Samuel Lijin's
        message of "Fri, 5 May 2017 05:46:04 -0500")
Message-ID: <xmqqd1bk9dc3.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Samuel Lijin <sxlijin@gmail.com> writes:

> This changes tests for `status --ignored` from test_expect_success to
> test_expect_failure in preparation for a change in its expected behavior
> (namely, that ignored files in untracked dirs will be reported).
>
> Signed-off-by: Samuel Lijin <sxlijin@gmail.com>
> ---

This is an odd way to do this.  If we stop applying your patches at
this step, these tests will still see output from "status --ignored"
that is expected by them, so there is no expect_failure here.

If we decide that the current output from "status --ignored" is
WRONG, and your series to fix "clean -d" FIXES "status --ignored" as
a side effect, then having a step to describe a desired behaviour in
the new world order in the test like this patch does makes sense,
but if that is what is going on, then not just flipping "success" to
"failure", the patch would be changing the expected output as well,
i.e. by adding the ignored files in untracked directories in the
expected output.  Obviously the code at this point after applying
only patches 1 & 2 will not produce such an output, so marking the
test that expects output based on the new world order as "expect
failure" would make sense.  Then your future commit that FIXES
"status --ignored" output would flip _failure to _success.

It is unclear to me if the new behaviour of "status --ignored" is a
bugfix, or a new bug, though.


>  t/t7061-wtstatus-ignore.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/t/t7061-wtstatus-ignore.sh b/t/t7061-wtstatus-ignore.sh
> index cdc0747bf..dc3be92a2 100755
> --- a/t/t7061-wtstatus-ignore.sh
> +++ b/t/t7061-wtstatus-ignore.sh
> @@ -11,7 +11,7 @@ cat >expected <<\EOF
>  ?? untracked/
>  EOF
>  
> -test_expect_success 'status untracked directory with --ignored' '
> +test_expect_failure 'status untracked directory with --ignored' '
>  	echo "ignored" >.gitignore &&
>  	mkdir untracked &&
>  	: >untracked/ignored &&
> @@ -20,7 +20,7 @@ test_expect_success 'status untracked directory with --ignored' '
>  	test_cmp expected actual
>  '
>  
> -test_expect_success 'same with gitignore starting with BOM' '
> +test_expect_failure 'same with gitignore starting with BOM' '
>  	printf "\357\273\277ignored\n" >.gitignore &&
>  	mkdir -p untracked &&
>  	: >untracked/ignored &&
