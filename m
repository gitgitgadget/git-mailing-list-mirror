Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0AC0C433DB
	for <git@archiver.kernel.org>; Sat, 20 Mar 2021 19:56:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 646CA61931
	for <git@archiver.kernel.org>; Sat, 20 Mar 2021 19:56:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbhCTTzd (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Mar 2021 15:55:33 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60602 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbhCTTzJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Mar 2021 15:55:09 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 853C211FC66;
        Sat, 20 Mar 2021 15:55:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tHC65gOoDle2LRkRzKYm2m6Wjy8=; b=malnf+
        NHmEQ4qyavDcNAbXA8E4Sm1MI92j0PpQ6ZFI8UTzLYz6jBF4KeR9BWZUKR9OcGvw
        uiK9j5odQ4hkFyirwgpwILPaSwdpAEKF+SlpTVLJQMTCxPWH+8zAwkK4D4/lSeEN
        ZkxFxfkSlkt4mFbnvp7MqGwLYyTkRoX6lKyrY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=My3Ls1YSJrfjsY+txHYyiodtD6SRgzLR
        Lo8bJOPN2Av8w9trczmkguNa2Zu0TiTMvIqdutrtHDPmifynqIdbcBwuruAV/+fr
        asyisJ4m+bkCwLHhr2kaTE/Ji4iyS6kYBmHqLKIjTYthVsuJrB2Q1wfUVQOh/irU
        RQ8o7RsMsWM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7CB5411FC65;
        Sat, 20 Mar 2021 15:55:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C3A6A11FC64;
        Sat, 20 Mar 2021 15:55:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH v8] format-patch: allow a non-integral version numbers
References: <pull.885.v7.git.1616152884317.gitgitgadget@gmail.com>
        <pull.885.v8.git.1616252178414.gitgitgadget@gmail.com>
Date:   Sat, 20 Mar 2021 12:55:04 -0700
In-Reply-To: <pull.885.v8.git.1616252178414.gitgitgadget@gmail.com> (ZheNing
        Hu via GitGitGadget's message of "Sat, 20 Mar 2021 14:56:17 +0000")
Message-ID: <xmqqv99lk3c7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2B49432A-89B6-11EB-8F1C-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:

As the patch text itself (assuming that the vague "compared with the
previous iteration" is acceptable) is getting solid, let's nitpick
the proposed log message so that we can start considering a merge to
'next'.

I won't review the t/ part of the patch as I know others on CC are
better at reviewing the tests than I am ;-)


> From: ZheNing Hu <adlternative@gmail.com>
>
> Usually we can only use `format-patch -v<n>` to generate integral
> version numbers patches,

The "only" sounds as if you are saying that "there is no tool other
than 'format-patch -v' we can use", which might be technically true,
but is not what you want to stress to your readers here.  You are
sayig that usually people only use integral version numbers.

> but sometimes a small fixup should be
> labeled as a non-integral version like `v1.1`, so teach `format-patch`
> to allow a non-integral version which may be helpful to send those
> patches.

Also, I do not think we want to encourage such use of fractional
iteration numbers.  We can merely enable, without saying it is a
good idea or a bad idea, leaving judgment to each project that may
or may not accept a patch versioned in such a way.  So avoid "should
be".

That makes the first part of the log message to be something like:

    The `-v<n>` option of `format-patch` can give nothing but an
    integral iteration number to patches in a series.  Some people,
    however, prefer to mark a new iteration with only a small fixup
    with a non integral iteration number (e.g. an "oops, that was
    wrong" fix-up patch for v4 iteration may be labeled as "v4.1").

    Allow `format-patch` to take such a non-integral iteration
    number.

> `<n>` can be any string, such as '3.1' or '4rev2'. In the case
> where it is a non-integral value, the "Range-diff" and "Interdiff"
> headers will not include the previous version.

This part is well written and can stay as-is.

> Signed-off-by: ZheNing Hu <adlternative@gmail.com>
> ---
>     [GSOC] format-patch: allow a non-integral version numbers
>     
>     There is a small question: in the case of --reroll-count=<n>, "n" is an
>     integer, we output "n-1" in the patch instead of "m" specified by
>     --previous-count=<m>,Should we switch the priority of these two: let "m"
>     output?

Didn't I answer this question already?

> diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
> index 3e49bf221087..e2c29a856451 100644
> --- a/Documentation/git-format-patch.txt
> +++ b/Documentation/git-format-patch.txt
> @@ -221,6 +221,11 @@ populated with placeholder text.
>  	`--subject-prefix` option) has ` v<n>` appended to it.  E.g.
>  	`--reroll-count=4` may produce `v4-0001-add-makefile.patch`
>  	file that has "Subject: [PATCH v4 1/20] Add makefile" in it.
> +	 `<n>` may be a non-integer number.  E.g. `--reroll-count=4.4`

Is it on purpose that `<n>` here has an extra SP before it?

> +	may produce `v4.4-0001-add-makefile.patch` file that has
> +	"Subject: [PATCH v4.4 1/20] Add makefile" in it.
> +	`--reroll-count=4rev2` may produce `v4rev2-0001-add-makefile.patch`
> +	file that has "Subject: [PATCH v4rev2 1/20] Add makefile" in it.

I am not sure it is worth repeating the whole explanation already
given to "v4" for two other.  By just mentioning that the "v4" could
be "v4.4" or "v4vis", the readers are intelligent enough to infer
what you mean, I would think.  Also be honest to readers by telling
them what they lose if they use a non-integral reroll count.

	`<n>` does not have to be an integer (e.g. "--reroll-count=4.4",
	or "--reroll-count=4rev2" are allowed), but the downside of
	using such a reroll-count is that the range-diff/interdiff
	with the previous version does not state exactly which
	version the new interation is compared against.

or something like that, perhaps?

Thanks.
