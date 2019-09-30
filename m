Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A8061F463
	for <e@80x24.org>; Mon, 30 Sep 2019 01:34:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729091AbfI3BeU (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Sep 2019 21:34:20 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56632 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726390AbfI3BeU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Sep 2019 21:34:20 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E7F73212D4;
        Sun, 29 Sep 2019 21:34:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DHgP0nKY7eBs9QIaohz9et8Jkps=; b=Y84QD3
        ffaDiHBOEh0eMoNTQ6IfCsEj6jl9Nx9Eytu9TCJ21R7dClMPpKJEj85+9Y7NySHy
        u8lckDAZh0wB6OKLsulePXiXO2LZvse5K+/Nr8r+f16+Rp+TWxGiBElt9YYUGFTJ
        idq37VSZnCjXiSCby/xlkoygjEjw2Xt64zbj0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=igqrMnlP36AS9YcY7AcDI0lLv/LM87SD
        sz8MZpKbbz+xaIdWo7wUDub2JLvXjrKCsA49ZtMr3EhIEoBfIvV8fTwS9NSkExYc
        4Y2Jrj+lU8oanAM/91mEuhnp8Kw5KRCS6rOCi96RUsbdDtfQgpZfVYBvYOFwbKs8
        NZr+nMsv5kc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DFED5212D3;
        Sun, 29 Sep 2019 21:34:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4C2FE212D2;
        Sun, 29 Sep 2019 21:34:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Kunal Tyagi via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Kunal Tyagi <tyagi.kunal@live.com>
Subject: Re: [PATCH v2 1/1] git-add--interactive.perl: Add progress counter in the prompt
References: <pull.349.git.gitgitgadget@gmail.com>
        <pull.349.v2.git.gitgitgadget@gmail.com>
        <a9c590689931ebc49e91c56d8a095f66193801c2.1569720616.git.gitgitgadget@gmail.com>
Date:   Mon, 30 Sep 2019 10:34:13 +0900
In-Reply-To: <a9c590689931ebc49e91c56d8a095f66193801c2.1569720616.git.gitgitgadget@gmail.com>
        (Kunal Tyagi via GitGitGadget's message of "Sat, 28 Sep 2019 18:30:19
        -0700 (PDT)")
Message-ID: <xmqqeezyin3e.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 691B48B0-E322-11E9-BDA3-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Kunal Tyagi via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Kunal Tyagi <tyagi.kunal@live.com>
> Subject: Re: [PATCH v2 1/1] git-add--interactive.perl: Add progress counter in the prompt

Either of these two, perhaps (I'd use the former if I were writing
this patch):

	add -i: show progress counter in the prompt
	add -i: add progress counter to the prompt

Give an order to the codebase to "become like so".  E.g.

	Report how many hunks have been processed and the total
	number of hunks in the current file in the prompt, and
	adjust the expected output in some tests.

	Signed-off-by: ...

> Adds a feedback regarding how many hunks from the current file have been
> processed and total number of hunks
> Also included: changes to the test script due to change in expected
> output string
>
> Change in UI: displays '(${current-hunk-id} + 1/${total-hunks-in-file})' before
> displaying the current prompt during user interaction
>
> Signed-off-by: Kunal Tyagi <tyagi.kunal@live.com>
> ---
>  git-add--interactive.perl  | 2 +-
>  t/t3701-add-interactive.sh | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/git-add--interactive.perl b/git-add--interactive.perl
> index c20ae9e210..51c30e08cb 100755
> --- a/git-add--interactive.perl
> +++ b/git-add--interactive.perl
> @@ -1541,7 +1541,7 @@ sub patch_update_file {
>  		for (@{$hunk[$ix]{DISPLAY}}) {
>  			print;
>  		}
> -		print colored $prompt_color,
> +		print colored $prompt_color,"(". ($ix+1) ."/$num) ",

Don't omit space after comma. or around the "." operators---if you
want to use "." here, that is.  I am not convinced it makes the code
better to use ".", though.

	print colored $prompt_color, "(", ($ix+1), "/$num) ",

is probably how I would write this, as I expect those writing Perl
would know that elements of a comma separated list fed to 'print'
are shown without any extra space in between.

>  			sprintf(__($patch_update_prompt_modes{$patch_mode}{$hunk[$ix]{TYPE}}), $other);
>  
>  		my $line = prompt_single_character;
> diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
> index 69991a3168..3a2d9fb607 100755
> --- a/t/t3701-add-interactive.sh
> +++ b/t/t3701-add-interactive.sh
> @@ -314,7 +314,7 @@ test_expect_success C_LOCALE_OUTPUT 'add first line works' '
>  	git commit -am "clear local changes" &&
>  	git apply patch &&
>  	printf "%s\n" s y y | git add -p file 2>error |
> -		sed -n -e "s/^Stage this hunk[^@]*\(@@ .*\)/\1/" \
> +		sed -n -e "s/^(.*) Stage this hunk[^@]*\(@@ .*\)/\1/" \

Shouldn't this pattern be a bit tighter than "(.*)" (i.e. anything
can come between paren)?

>  		       -e "/^[-+@ \\\\]"/p  >output &&
>  	test_must_be_empty error &&
>  	git diff --cached >diff &&
