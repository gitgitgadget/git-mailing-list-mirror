Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 13E34203E1
	for <e@80x24.org>; Wed, 27 Jul 2016 17:11:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757216AbcG0RLY (ORCPT <rfc822;e@80x24.org>);
	Wed, 27 Jul 2016 13:11:24 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65389 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754303AbcG0RLY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jul 2016 13:11:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 88EF92EB4C;
	Wed, 27 Jul 2016 13:11:22 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=V7PI5xpX6RmLjZu7U/2PxTf6FOc=; b=AlBND1
	10U9CwA2+i6sJ7PI8YTNvlhLSqHI/lUDGDz9yZxFHYMFuu921UfAw6w74MZLfCbJ
	bnkwdl34yEyQET4nc6fw7+LUpkNjtv6ZAVsRnlh74GZVgAlqVLz8Xu7bkjkSsPM3
	BJu7cp196ZpB+ue8scys+VxLwSfj3xPZEMuQI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SNqnX3QiWHG7W/HaDXpPbeYV8JJr+dui
	IspBrgUVZ4VYGWpWhjJEKPJw8DtGTeVwdeNuh9noIVmxO4Qp4bOdaFDVOcwdpVwO
	IPuR8zCrBQHkLiYAb6wqXM5Fv930gQtQ1tjnS3QxfpUfL1AY3LXK1BNHmlIiuotw
	nRX7ahcZW8M=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 7E3652EB4B;
	Wed, 27 Jul 2016 13:11:22 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EA19A2EB4A;
	Wed, 27 Jul 2016 13:11:21 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	David Aguilar <davvid@gmail.com>
Cc:	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Brett Cundal <brett.cundal@iugome.com>,
	"David A . Greene" <greened@obbligato.org>,
	Charles Bailey <cbailey32@bloomberg.net>,
	Techlive Zheng <techlivezheng@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 3/3] subtree: adjust style to match CodingGuidelines
References: <20160727005638.9972-1-davvid@gmail.com>
Date:	Wed, 27 Jul 2016 10:11:19 -0700
In-Reply-To: <20160727005638.9972-1-davvid@gmail.com> (David Aguilar's message
	of "Tue, 26 Jul 2016 17:56:38 -0700")
Message-ID: <xmqq1t2fxayw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 243FEBDE-541D-11E6-8537-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

David Aguilar <davvid@gmail.com> writes:

> Prefer "test" over "[ ... ]", use double-quotes around variables, break
> long lines, and properly indent "case" statements.
>
> Helped-by: Johannes Sixt <j6t@kdbg.org>
> Signed-off-by: David Aguilar <davvid@gmail.com>
> ---
> This is a replacement patch that addresses the notes from Hannes' review.

Thanks.

>  case "$command" in
> -	add) [ -e "$prefix" ] && 
> -		die "prefix '$prefix' already exists." ;;
> -	*)   [ -e "$prefix" ] || 
> -		die "'$prefix' does not exist; use 'git subtree add'" ;;
> +add)
> +	test -e "$prefix" && die "prefix '$prefix' already exists."
> +	;;
> +*)
> +	test -e "$prefix" ||
> +	die "'$prefix' does not exist; use 'git subtree add'"
> +	;;
>  esac

Comparing the above with the below

> @@ -145,16 +204,21 @@ debug
>  cache_setup()
>  {
>  	cachedir="$GIT_DIR/subtree-cache/$$"
> -	rm -rf "$cachedir" || die "Can't delete old cachedir: $cachedir"
> -	mkdir -p "$cachedir" || die "Can't create new cachedir: $cachedir"
> -	mkdir -p "$cachedir/notree" || die "Can't create new cachedir: $cachedir/notree"
> +	rm -rf "$cachedir" ||
> +		die "Can't delete old cachedir: $cachedir"
> +	mkdir -p "$cachedir" ||
> +		die "Can't create new cachedir: $cachedir"
> +	mkdir -p "$cachedir/notree" ||
> +		die "Can't create new cachedir: $cachedir/notree"
>  	debug "Using cachedir: $cachedir" >&2
>  }

makes me think the former would look more readble if consistently
formatted line this (note: I untabified to keep the alignment, so
please do not cut and paste from here):

        case "$command" in
        add)
                test -e "$prefix" &&
                        die "prefix '$prefix' already exists."
                ;;
        *)
                test -e "$prefix" ||
                        die "'$prefix' does not exist; use 'git subtree add'"
                ;;
        esac

>  cache_get()
>  {

I noticed this in the CodingGuidelines:

 - We prefer a space between the function name and the parentheses,
   and no space inside the parentheses. The opening "{" should also
   be on the same line.

perhaps do it as well while we are at it?

> -	for oldrev in $*; do
> -		if [ -r "$cachedir/$oldrev" ]; then
> +	for oldrev in "$@"
> +	do

This looked fishy, but all the callers of cache_get are doing the
right thing.  They either throw a single token ("latest_new",
"latest_old") at it, or give "$rev" (dquoted) or $parents (not
dquoted) that is taken by reading the "rev-list --parents" output
with "read rev parents" one line at a time.

>  cache_miss()
>  {
> -	for oldrev in $*; do
> -		if [ ! -r "$cachedir/$oldrev" ]; then
> +	for oldrev in "$@"
> +	do

Ditto.

> @@ -172,9 +238,11 @@ cache_miss()
>  
>  check_parents()
>  {
> -	missed=$(cache_miss $*)
> -	for miss in $missed; do
> -		if [ ! -r "$cachedir/notree/$miss" ]; then
> +	missed=$(cache_miss "$@")
> +	for miss in $missed

Ditto.

There is an obvious "optimization potential" here in that $missed is
otherwise never used, but it is outside the scope of the stylefix
patch.

> +	if test -n "$old"
> +	then
> +		squash_msg "$dir" "$oldsub" "$newsub" |
>  			git commit-tree "$tree" -p "$old" || exit $?

The change to the third line is to remove the trailing SP, which is
welcome.  While we are touching it up, "git commit-tree" should be
dedented to align with "squash_msg" (the same in the else clause)
to be consistent with the remainder of the script (and the system),
I would think.
