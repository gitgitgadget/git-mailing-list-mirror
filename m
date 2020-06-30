Return-Path: <SRS0=HTZL=AL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 300CEC433E0
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 00:06:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1B2A20781
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 00:06:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="i18uAw7I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbgF3AGX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Jun 2020 20:06:23 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:65446 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726994AbgF3AGX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jun 2020 20:06:23 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2C122DD042;
        Mon, 29 Jun 2020 20:06:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3EckGwJ+1xpqFxASv+GHJh5Ilkk=; b=i18uAw
        7ImUaWpk+h+p7V3T2Gi+kyh3rrscbkpJHDEyd4mvGXUIG13unNNMh2CNOJQrnYCo
        6uBWcqUIG2ei+q+dKniApTOopvx5CAbhKi3MwewjV1eP4KNGWZ+VtDfT0idOCldY
        SQvGKpvPG/sFtnmaHnFrj/lFUfu+4xR+wbL+k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=FL+RUzlaKOo51pyugOwE4RkfWlQmNBvB
        gJL1VaoxAOAxVaI0Zz3jHn2vfvj3sTqhTuCvqUZHl88rzadjUYPBe9qFXTwXp3TL
        ht14fVCzDdvmaBuZyZJUzUvwKjdoegR6jzX5svvHsh5L+cit2yyzCEy0FXHDWS0j
        SC32IV/dXyw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 23E99DD041;
        Mon, 29 Jun 2020 20:06:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 689DCDD040;
        Mon, 29 Jun 2020 20:06:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "sunlin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, sunlin <sunlin7@yahoo.com>,
        "lin.sun" <lin.sun@zoom.us>
Subject: Re: [PATCH v3] Enable auto-merge for meld to follow the vim-diff beharior
References: <pull.781.v2.git.git.1591672753363.gitgitgadget@gmail.com>
        <pull.781.v3.git.git.1593414441313.gitgitgadget@gmail.com>
Date:   Mon, 29 Jun 2020 17:06:13 -0700
In-Reply-To: <pull.781.v3.git.git.1593414441313.gitgitgadget@gmail.com>
        (sunlin via GitGitGadget's message of "Mon, 29 Jun 2020 07:07:21
        +0000")
Message-ID: <xmqqeepxfmdm.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 83D4691E-BA65-11EA-931E-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"sunlin via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: "lin.sun" <lin.sun@zoom.us>

The way this "name <addr>" is spelled must match the name used on
the Signed-off-by: line below.

> The mergetool "meld" does NOT merge the no-conflict changes, while the
> mergetool "vimdiff" will merge the no-conflict parts and highlight the
> conflict parts.

OK.

Have a blank line between paragraphs here.

> This patch will make the mergetool "meld" similar to "vimdiff",
> auto-merge the no-conflict parts, highlight conflict parts.

Give an order to the codebase to be like so, e.g.:

    Make the mergetool used with "meld" backend behave similarly to
    how "vimdiff" beheaves by telling it to auto-merge parts without
    conflicts and highlight the parts with conflicts.

or somethin glike that.

> Signed-off-by: Lin Sun <lin.sun@zoom.us>
> ---
>     Enable auto-merge for meld to follow the vimdiff beharior
>     
>     Hi, the mergetool "meld" does NOT merge the no-conflict changes, while
>     the mergetool "vimdiff" will merge the no-conflict changes and highlight
>     the conflict parts. This patch will make the mergetool "meld" similar to
>     "vimdiff", auto-merge the no-conflict changes, highlight conflict parts.

That repeats the log message and does not add much useful info.

>  mergetools/meld | 32 ++++++++++++++++++++++++++++++--
>  1 file changed, 30 insertions(+), 2 deletions(-)
>
> diff --git a/mergetools/meld b/mergetools/meld
> index 7a08470f88..91b65ff22c 100644
> --- a/mergetools/meld
> +++ b/mergetools/meld
> @@ -7,13 +7,23 @@ merge_cmd () {
>  	then
>  		check_meld_for_output_version
>  	fi
> +	if test -z "${meld_has_auto_merge_option:+set}"
> +	then
> +		check_meld_for_auto_merge_version
> +	fi

The detection part looks clumsy and inefficient.  More about it later.

> +	option_auto_merge=
> +	if test "$meld_has_auto_merge_option" = true
> +	then
> +		option_auto_merge="--auto-merge"
> +	fi
>  
>  	if test "$meld_has_output_option" = true
>  	then
> -		"$merge_tool_path" --output="$MERGED" \
> +		"$merge_tool_path" $option_auto_merge --output="$MERGED" \
>  			"$LOCAL" "$BASE" "$REMOTE"
>  	else
> -		"$merge_tool_path" "$LOCAL" "$MERGED" "$REMOTE"
> +		"$merge_tool_path" $option_auto_merge "$LOCAL" "$MERGED" "$REMOTE"
>  	fi
>  }

The part that chooses whether to pass --auto-merge or not and
adjusts the command line options does look sensible.

I wonder if the same "hasAutoMerge" option can be used by those who
do *not* want the new --auto-merge behaviour to opt out of this
change.  Is there a reason why "meld" offers the --auto-merge as an
optional behaviour (which tells, at least to me, that the default
behaviour is not to auto-merge and makes me assume that the default
must be chosen by some sound reasoning, hence some users would prefer
not to use this new behaviour with good reasons)?

I guess what I am trying to get at is, if --auto-merge is an optional
and non-default behaviour for "meld" users, perhaps it is not a good
idea to change the behaviour on them only because the version of meld
they run happens to support the --auto-merge as an optional behaviour.

IOW, wouldn't it make more sense, and certainly make it safer
without surprises to existing users, if we made the logic to

    * If mergetool.meld.useAutoMerge is not set, do not pass
      --auto-merge whether "meld" supports the option or not.

    * If mergetool.meld.useAutoMerge is 'true', always pass it
      without checking.

    * If mergetool.meld.useAutoMerge is 'when-able' (or come up with
      a better name if you want, perhaps 'auto'), check if "meld"
      accepts "--auto-merge" and decide whether to pass it or not.

perhaps?

> +# Check whether we should use 'meld --auto-merge ...'
> +check_meld_for_auto_merge_version () {
> +	meld_path="$(git config mergetool.meld.path)"
> +	meld_path="${meld_path:-meld}"
> +
> +	if meld_has_auto_merge_option=$(git config --bool mergetool.meld.hasAutoMerge)
> +	then
> +		: use configured value
> +	elif "$meld_path" --help 2>&1 |
> +		grep -e '--auto-merge' -e '\[OPTION\.\.\.\]' >/dev/null
> +	then
> +		: old ones mention --auto-merge and new ones just say OPTION...
> +		meld_has_auto_merge_option=true
> +	else
> +		meld_has_auto_merge_option=false
> +	fi
> +}

When not configured, we end up running "meld --help" twice for two
options, which is not great, don't you think?  I actually think the
part that runs "meld --help" and parses its output should be split
out of the helper function "check_meld_for_output_version" and
called "check_meld_supported_options" or something, so that the
logic to see if the --output and --auto-merge options should be
passed can be made with at most one invocation of "meld --help".
Which may involve *NOT* having two separate helper functions
check_meld_for_*_version for the tested features.

Oh, also, check_meld_for_*_version is nonsensical as a name for
these helper functions (it is not the fault of this patch---it is
mimicking the existing practice, but that does not make the function
name not nonsensical).  The helpers do not actually want to check a
"version", they only want to see if a feature is supported.  So
having "feature" in the name would be good, but "version" is not.



