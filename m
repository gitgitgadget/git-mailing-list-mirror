Return-Path: <SRS0=kUNO=A7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E5E2C433E0
	for <git@archiver.kernel.org>; Mon, 20 Jul 2020 18:52:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56BCA22482
	for <git@archiver.kernel.org>; Mon, 20 Jul 2020 18:52:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="SJpCMdej"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730692AbgGTSwY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jul 2020 14:52:24 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56265 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbgGTSwY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jul 2020 14:52:24 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A7170E8AF8;
        Mon, 20 Jul 2020 14:52:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=oeu+SKDo1GC7VStCyRUVHwfz1uk=; b=SJpCMd
        ejCkwqHeYxhOj/vU1x3OF/e9atpoC38ioQv7tAG8xCaU07eZvGIlAYh3gICoIiZ4
        aov7gvnEHEN+z+jAcuU59/rs95WK4uzQcPFRr/cLBvvVm5v4xMy7bBChcJKqL1Pv
        pgXFsMdYDyroJHWc000bDV4NbueKczdy2NBGo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=SW27WicoWayg1EyQRr8r656Hw/jR/6ik
        R1K2JPII+ulqxTqjBBPssZ2+CVyhKEnlUckzZ0NXJkWPACsnMIO2BPBkSNUUuLq9
        7LHYn9FPbSKDbwB7Glvhrd0aE7Tr4Lpc48oH2PRNVkQYin4ea0kiiFaW5ETRV3fz
        FD+ezR8f/eU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9EE18E8AF7;
        Mon, 20 Jul 2020 14:52:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E6B64E8AF6;
        Mon, 20 Jul 2020 14:52:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     pudinha <rogi@skylittlesystem.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 2/2] Support nvim as merge tool
References: <20200718192001.27434-1-rogi@skylittlesystem.org>
        <20200719042335.3913-3-rogi@skylittlesystem.org>
Date:   Mon, 20 Jul 2020 11:52:16 -0700
In-Reply-To: <20200719042335.3913-3-rogi@skylittlesystem.org> (pudinha's
        message of "Sun, 19 Jul 2020 05:23:38 +0100")
Message-ID: <xmqq8sfe9fz3.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 227D8FDC-CABA-11EA-9FD5-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

pudinha <rogi@skylittlesystem.org> writes:

> Subject: Re: [PATCH v2 2/2] Support nvim as merge tool

Perhaps "mergetools: add support for nvimdiff family" or something
along that line.

> ---

Missing sign-off.

Thanks.


>  contrib/completion/git-completion.bash |  4 ++--
>  git-mergetool--lib.sh                  |  7 +++++--
>  mergetools/nvimdiff                    |  1 +
>  mergetools/vimdiff                     | 15 +++++++++------
>  4 files changed, 17 insertions(+), 10 deletions(-)
>  create mode 100644 mergetools/nvimdiff
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index ee468ea3b0..aed08f8df5 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1712,8 +1712,8 @@ _git_diff ()
>  }
>  
>  __git_mergetools_common="diffuse diffmerge ecmerge emerge kdiff3 meld opendiff
> -			tkdiff vimdiff gvimdiff xxdiff araxis p4merge bc
> -			codecompare smerge
> +			tkdiff vimdiff nvimdiff gvimdiff xxdiff araxis p4merge
> +			bc codecompare smerge
>  "
>  
>  _git_difftool ()
> diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
> index 29fecc340f..2defef28cd 100644
> --- a/git-mergetool--lib.sh
> +++ b/git-mergetool--lib.sh
> @@ -304,11 +304,14 @@ list_merge_tool_candidates () {
>  		tools="$tools smerge"
>  	fi
>  	case "${VISUAL:-$EDITOR}" in
> +	*nvim*)
> +		tools="$tools nvimdiff vimdiff emerge"
> +		;;
>  	*vim*)
> -		tools="$tools vimdiff emerge"
> +		tools="$tools vimdiff nvimdiff emerge"
>  		;;
>  	*)
> -		tools="$tools emerge vimdiff"
> +		tools="$tools emerge vimdiff nvimdiff"
>  		;;
>  	esac
>  }
> diff --git a/mergetools/nvimdiff b/mergetools/nvimdiff
> new file mode 100644
> index 0000000000..04a5bb0ea8
> --- /dev/null
> +++ b/mergetools/nvimdiff
> @@ -0,0 +1 @@
> +. "$MERGE_TOOLS_DIR/vimdiff"
> diff --git a/mergetools/vimdiff b/mergetools/vimdiff
> index 3925e1fc3e..abc8ce4ec4 100644
> --- a/mergetools/vimdiff
> +++ b/mergetools/vimdiff
> @@ -5,7 +5,7 @@ diff_cmd () {
>  
>  merge_cmd () {
>  	case "$1" in
> -	gvimdiff|vimdiff)
> +	*vimdiff)
>  		if $base_present
>  		then
>  			"$merge_tool_path" -f -d -c '4wincmd w | wincmd J' \
> @@ -15,11 +15,11 @@ merge_cmd () {
>  				"$LOCAL" "$MERGED" "$REMOTE"
>  		fi
>  		;;
> -	gvimdiff2|vimdiff2)
> +	*vimdiff2)
>  		"$merge_tool_path" -f -d -c 'wincmd l' \
>  			"$LOCAL" "$MERGED" "$REMOTE"
>  		;;
> -	gvimdiff3|vimdiff3)
> +	*vimdiff3)
>  		if $base_present
>  		then
>  			"$merge_tool_path" -f -d -c 'hid | hid | hid' \
> @@ -34,10 +34,13 @@ merge_cmd () {
>  
>  translate_merge_tool_path() {
>  	case "$1" in
> -	gvimdiff|gvimdiff2|gvimdiff3)
> +	nvimdiff*)
> +		echo nvim
> +		;;
> +	gvimdiff*)
>  		echo gvim
>  		;;
> -	vimdiff|vimdiff2|vimdiff3)
> +	vimdiff*)
>  		echo vim
>  		;;
>  	esac
> @@ -48,7 +51,7 @@ exit_code_trustable () {
>  }
>  
>  list_tool_variants () {
> -	for prefix in '' g; do
> +	for prefix in '' g n; do
>  		for suffix in '' 2 3; do
>  			echo "${prefix}vimdiff${suffix}"
>  		done
