Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 229E8C433C1
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 20:01:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E818F6192F
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 20:01:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231725AbhC2UAm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Mar 2021 16:00:42 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52462 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231747AbhC2UAV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Mar 2021 16:00:21 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 39588B7F3C;
        Mon, 29 Mar 2021 16:00:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=kQR1vnAukThcNjf94G8ju9DCVbY=; b=nBH1T4
        txFz6r+NczgfgDHSAkjA9Oy90urC5MVEDBFyaFpOGJiih4ITE6bSyP7MWPUBHc3S
        /VPllOqQpZ+ROrDd0UjMmBHm0Etxvdfl7Xn/JUEz4z9Na/PyP4Jo2p+Yr2rDBDC8
        AVq/Ss/6aVWMglY7FTlnPjGKlVm/d2oCFbXrw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=aRwenJbk1X1RFsWKre09iJiwzRe/KlE7
        c+XcoQeJEAotA+kcDqLvcC89JOWIETSvXM+88zQ87OtoyN19sn//W+rKzCd48EiS
        mHhDHp+a+OhevQumRl+GpPOe8U9JL8Bz7QdRzzgDX8j/DxTNXUiduRPHByMBXPSJ
        NkAF8BRyBfo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2DFEFB7F3A;
        Mon, 29 Mar 2021 16:00:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 625BBB7F39;
        Mon, 29 Mar 2021 16:00:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Georgios Kontaxis via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Georgios Kontaxis <geko1702+commits@99rst.org>
Subject: Re: [PATCH v6] gitweb: redacted e-mail addresses feature.
References: <pull.910.v5.git.1616817387441.gitgitgadget@gmail.com>
        <pull.910.v6.git.1616973963862.gitgitgadget@gmail.com>
Date:   Mon, 29 Mar 2021 13:00:17 -0700
In-Reply-To: <pull.910.v6.git.1616973963862.gitgitgadget@gmail.com> (Georgios
        Kontaxis via GitGitGadget's message of "Sun, 28 Mar 2021 23:26:03
        +0000")
Message-ID: <xmqq5z19k9wu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 62BB967C-90C9-11EB-BA30-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Georgios Kontaxis via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Georgios Kontaxis <geko1702+commits@99rst.org>
>
> Gitweb extracts content from the Git log and makes it accessible
> over HTTP. As a result, e-mail addresses found in commits are
> exposed to web crawlers and they may not respect robots.txt.
> This can result in unsolicited messages.
>
> Introduce an 'email-privacy' feature which redacts e-mail addresses
> from the generated HTML content. Specifically, obscure addresses
> retrieved from the the author/committer and comment sections of the
> Git log. The feature is off by default.
>
> This feature does not prevent someone from downloading the
> unredacted commit log, e.g., by cloning the repository, and
> extracting information from it. It aims to hinder the low-
> effort, bulk collection of e-mail addresses by web crawlers.
>
> Signed-off-by: Georgios Kontaxis <geko1702+commits@99rst.org>
> ---

> @@ -751,6 +751,17 @@ default font sizes or lineheights are changed (e.g. via adding extra
>  CSS stylesheet in `@stylesheets`), it may be appropriate to change
>  these values.
>  
> +email-privacy::
> +	Redact e-mail addresses from the generated HTML, etc. content.
> +	This obscures e-mail addresses retrieved from the author/committer
> +	and comment sections of the Git log.
> +	It is meant to hinder web crawlers that harvest and abuse addresses.
> +	Such crawlers may not respect robots.txt.
> +	Note that users and user tools also see the addresses as redacted.
> +	If Gitweb is not the final step in a workflow then subsequent steps
> +	may misbehave because of the redacted information they receive.
> +	Disabled by default.

OK.  I still think everything after "Note that" is a bit redandant
(as any intelligent reader can read what the feature does and reach
its natural consequence themselves), but I do not strongly oppose
leaving it in.

> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 0959a782eccb..01c6faf88006 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -569,6 +569,15 @@ sub evaluate_uri {
>  		'sub' => \&feature_extra_branch_refs,
>  		'override' => 0,
>  		'default' => []},
> +
> +	# Redact e-mail addresses.
> +
> +	# To enable system wide have in $GITWEB_CONFIG
> +	# $feature{'email-privacy'}{'default'} = [1];
> +	'email-privacy' => {
> +		'sub' => sub { feature_bool('email-privacy', @_) },
> +		'override' => 1,
> +		'default' => [0]},
>  );

Sensible.

While reviewing this part, I noticed a few things

 - A few other features explain how to toggle it system wide and
   nothing else, like this one does.

 - Others explain, in addition, talk about how to toggle per
   repository (which may necessitate explaining how to toggle the
   override bit if the default is false).

It might be a good idea to standardise the explanation somehow.

This is just an observation (in other words, nothing needs to be
done in this patch).


> @@ -3449,6 +3458,13 @@ sub parse_date {
>  	return %date;
>  }
>  
> +sub hide_mailaddrs_if_private {
> +	my $line = shift;
> +	return $line unless gitweb_check_feature('email-privacy');
> +	$line =~ s/<[^@>]+@[^>]+>/<redacted>/ig;
> +	return $line;
> +}

OK.  The "this catches AUTHOR_EMAIL" pattern is a bit embarrassing
(my fault); "s/<[^@>]+@[-a-z0-9.]+>/<redacted>/ig" might be less
embarrassing but I do not care deeply enough either way.  The version
in this patch is probably closer to what ident.c uses anyway ;-)

> @@ -7489,7 +7506,8 @@ sub git_log_generic {
>  			         -accesskey => "n", -title => "Alt-n"}, "next");
>  	}
>  	my $patch_max = gitweb_get_feature('patches');
> -	if ($patch_max && !defined $file_name) {
> +	if ($patch_max && !defined $file_name &&
> +		!gitweb_check_feature('email-privacy')) {
>  		if ($patch_max < 0 || @commitlist <= $patch_max) {

An observation unrelated to this change.  I think checking for
negative patch_max is a bug in the original code.  Everywhere else,
the way to disable the 'patch' view is to set it to 0, not negative,
and this block is already protected with "if ($patch_max".

> @@ -7550,7 +7568,8 @@ sub git_commit {
>  			} @$parents ) .
>  			')';
>  	}
> -	if (gitweb_check_feature('patches') && @$parents <= 1) {
> +	if (gitweb_check_feature('patches') && @$parents <= 1 &&
> +		!gitweb_check_feature('email-privacy')) {
>  		$formats_nav .= " | " .
>  			$cgi->a({-href => href(action=>"patch", -replay=>1)},
>  				"patch");
> @@ -7863,7 +7882,8 @@ sub git_commitdiff {
>  		$formats_nav =
>  			$cgi->a({-href => href(action=>"commitdiff_plain", -replay=>1)},
>  			        "raw");
> -		if ($patch_max && @{$co{'parents'}} <= 1) {
> +		if ($patch_max && @{$co{'parents'}} <= 1 &&
> +			!gitweb_check_feature('email-privacy')) {
>  			$formats_nav .= " | " .
>  				$cgi->a({-href => href(action=>"patch", -replay=>1)},
>  					"patch");

I see your wish is "we do not show any link to a patch page, but
anybody who knows what a link to the patch page looks like can craft
and ask", but I am not sure if that is worth the above three hunks.
It still feels more robust to just disable the 'patches' feature
when the email-privacy feature is enabled, but that may be just me.

Will queue as-is.  Input from those who are more adept at Perl
and/or interested in helping polish gitweb are still welcome, but at
my level of interest on the topic, this version looks as good as it
gets ;-)

Thanks.
