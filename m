Return-Path: <SRS0=WOg5=AS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3281AC433E0
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 19:50:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06F9A206DF
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 19:50:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="kPGd7yKh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbgGGTuk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jul 2020 15:50:40 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51857 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726951AbgGGTuj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jul 2020 15:50:39 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E4878DF615;
        Tue,  7 Jul 2020 15:50:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hcjItgElAYHB0o2KTE/27SYAep8=; b=kPGd7y
        KhKZ8CzXv8V7uOkpzlL49FNxt2CoN+aG0lWb0hAtG8zqvLJOJeknJ1nMq9HRcRFd
        GYTy+YL1G0XVrzYpegWtIAax4sMBiNms/vbRKanlj3JQ6d1iwPdrfrM/T7oMSQPH
        Wq2yLqqL9gaa1j5Pwm0Xkm4U9lbqUpPwzWH6A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ox0KYgjCq2NbkwQmX6EoyFlMEIDgQ+Rw
        ugO8OCsOnIT2w2ggei07rvG4gdWsIXwjcF2cKpdXiyODmNqAq+uLVM/4I8fvFgK7
        l8Lno+9nj/Ejfu2Oo94niNneuRjE53jBAU3tQjMnokNUEwT6igiFfXNUi6/bIHpS
        66xntjSCwZI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DA673DF614;
        Tue,  7 Jul 2020 15:50:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2F59EDF612;
        Tue,  7 Jul 2020 15:50:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH] Make some commit hashes in tests reproducible
References: <pull.816.git.git.1594149804313.gitgitgadget@gmail.com>
Date:   Tue, 07 Jul 2020 12:50:33 -0700
In-Reply-To: <pull.816.git.git.1594149804313.gitgitgadget@gmail.com> (Han-Wen
        Nienhuys via GitGitGadget's message of "Tue, 07 Jul 2020 19:23:24
        +0000")
Message-ID: <xmqqfta33y0m.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1FA4BCCE-C08B-11EA-A9EE-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Han-Wen Nienhuys <hanwen@google.com>
>
> Adds test_tick to t5801-remote-helpers.sh and t3203-branch-output.sh

That can be read from the patch.  Also the subject tells us a half
of what you want to achieve with this change (by the way, your
subject is malformatted and lacks the <area>: prefix; perhaps
"[PATCH] tests: make commit object names reproducible" or something),
but the readers are left hanging without knowing what motivated the
change.  Do any test pieces in these scripts change their behaviour
based on what exact object names are assigned to them, making them
flaky and hard to test, and if so which one and in what way?

Thanks.

> Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
> ---
>     Make commit hashes in test t3203-branch-output.sh reproducible
>     
>     Signed-off-by: Han-Wen Nienhuys hanwen@google.com [hanwen@google.com]
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-816%2Fhanwen%2Frepro-hash-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-816/hanwen/repro-hash-v1
> Pull-Request: https://github.com/git/git/pull/816
>
>  t/t3203-branch-output.sh  | 2 ++
>  t/t5801-remote-helpers.sh | 2 ++
>  2 files changed, 4 insertions(+)
>
> diff --git a/t/t3203-branch-output.sh b/t/t3203-branch-output.sh
> index 71818b90f0..6b614739af 100755
> --- a/t/t3203-branch-output.sh
> +++ b/t/t3203-branch-output.sh
> @@ -4,6 +4,8 @@ test_description='git branch display tests'
>  . ./test-lib.sh
>  . "$TEST_DIRECTORY"/lib-terminal.sh
>  
> +test_tick
> +
>  test_expect_success 'make commits' '
>  	echo content >file &&
>  	git add file &&
> diff --git a/t/t5801-remote-helpers.sh b/t/t5801-remote-helpers.sh
> index 0f04b6cddb..de51584173 100755
> --- a/t/t5801-remote-helpers.sh
> +++ b/t/t5801-remote-helpers.sh
> @@ -22,6 +22,8 @@ compare_refs() {
>  	eval $fail test_cmp expect actual
>  }
>  
> +test_tick
> +
>  test_expect_success 'setup repository' '
>  	git init server &&
>  	(cd server &&
>
> base-commit: a08a83db2bf27f015bec9a435f6d73e223c21c5e
