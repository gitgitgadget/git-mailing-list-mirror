Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EBB0C433DB
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 18:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F313961947
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 18:43:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbhCUSme (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Mar 2021 14:42:34 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52202 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbhCUSmN (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Mar 2021 14:42:13 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2DA8211AE99;
        Sun, 21 Mar 2021 14:42:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=z0B+3LwsnTyeTgoOwrdQujoUKk4=; b=LOV/Ew
        MlLUBer6I4kiGoDzW3mLa75gPYdJqUbq5b/cvr7yI3JwrNLS6pEDajYVHHgQ3qe/
        CczRm7SHlJwLgAJhO0b0lzNzWrB4g6vgvDufgWQtNHJeJvsjTxNaMHXWxuA4202M
        BCHezJe+La3MpaxZ1x+y/pBaSNKaBD0Zw8FjA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=eY63rBww6qPopHt7sg0exP7M6gX9JMs2
        qNskWl+HAi/hN90TxmZ7BdB3hPWTLcaU5Qxdex3b3qoag2GEzKdylaNslDWT+hBL
        SQbPSb9MCxZmimznq/5iZJTWE13dojqz0+zo2HLPPiPKtKu/iHqouVkT2qD9j52z
        UQPLIm8ZZqo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2607611AE98;
        Sun, 21 Mar 2021 14:42:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 652C011AE97;
        Sun, 21 Mar 2021 14:42:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Georgios Kontaxis via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Georgios Kontaxis <geko1702+commits@99rst.org>
Subject: Re: [PATCH v3] gitweb: redacted e-mail addresses feature.
References: <pull.910.v2.git.1616297564158.gitgitgadget@gmail.com>
        <pull.910.v3.git.1616347731514.gitgitgadget@gmail.com>
Date:   Sun, 21 Mar 2021 11:42:08 -0700
In-Reply-To: <pull.910.v3.git.1616347731514.gitgitgadget@gmail.com> (Georgios
        Kontaxis via GitGitGadget's message of "Sun, 21 Mar 2021 17:28:50
        +0000")
Message-ID: <xmqqzgyw9wn3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 252AEBF0-8A75-11EB-82BA-D609E328BF65-77302942!pb-smtp21.pobox.com
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
> This may result in unsolicited messages.
> This is a feature for redacting e-mail addresses
> from the generated HTML, etc. content.
>
> This feature does not prevent someone from downloading the
> unredacted commit log, e.g., by cloning the repository, and
> extracting information from it.
> It aims to hinder the low-effort bulk collection of e-mail
> addresses by web crawlers.

Lines from here ...

>
> Changes since v1:
> - Turned off the feature by default.
> - Removed duplicate code.
> - Added note about Gitweb consumers receiving redacted logs.
>
> Changes since v2:
> - The feature can be set on a per-project basis. ('override' => 1)

... to here are to help reviewers on the mailing list while
iterations of the same change is being reviewed and polished.

But it is useless noise for those who only read "git log".  They
simply do not have access to earlier iterations.

Such "changes between iterations" comments needs to be written after
the three-dash lines.

> Signed-off-by: Georgios Kontaxis <geko1702+commits@99rst.org>
> ---
>     gitweb: Redacted e-mail addresses feature.
>     
>     Gitweb extracts content from the Git log and makes it accessible over
>     HTTP. As a result, e-mail addresses found in commits are exposed to web
>     crawlers. This may result in unsolicited messages. This is a feature for
>     redacting e-mail addresses from the generated HTML content.
>     
>     This feature does not prevent someone from downloading the unredacted
>     commit log and extracting information from it. It aims to hinder the
>     low-effort bulk collection of e-mail addresses by web crawlers.
>     
>     Signed-off-by: Georgios Kontaxis geko1702+commits@99rst.org
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-910%2Fkontaxis%2Fkontaxis%2Femail_privacy-v3
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-910/kontaxis/kontaxis/email_privacy-v3
> Pull-Request: https://github.com/gitgitgadget/git/pull/910
>
> Range-diff vs v2:
>
>  1:  74af11ca8bf2 ! 1:  930cdefe7ee0 gitweb: redacted e-mail addresses feature.
>      @@ Commit message
>           - Removed duplicate code.
>           - Added note about Gitweb consumers receiving redacted logs.
>       
>      +    Changes since v2:
>      +    - The feature can be set on a per-project basis. ('override' => 1)
>      +
>           Signed-off-by: Georgios Kontaxis <geko1702+commits@99rst.org>
>       
>        ## Documentation/gitweb.conf.txt ##
>      @@ gitweb/gitweb.perl: sub evaluate_uri {
>       +	# $feature{'email_privacy'}{'default'} = [1];
>       +	'email_privacy' => {
>       +		'sub' => sub { feature_bool('email_privacy', @_) },
>      -+		'override' => 0,
>      ++		'override' => 1,
>       +		'default' => [0]},
>        );
>        
>
>
>  Documentation/gitweb.conf.txt | 16 +++++++++++++
>  gitweb/gitweb.perl            | 42 ++++++++++++++++++++++++++++++++---
>  2 files changed, 55 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/gitweb.conf.txt b/Documentation/gitweb.conf.txt
> index 7963a79ba98b..b7af3240177d 100644
> --- a/Documentation/gitweb.conf.txt
> +++ b/Documentation/gitweb.conf.txt
> @@ -896,6 +896,22 @@ same as of the snippet above:
>  It is an error to specify a ref that does not pass "git check-ref-format"
>  scrutiny. Duplicated values are filtered.
>  
> +email_privacy::
> +    Redact e-mail addresses from the generated HTML, etc. content.
> +    This hides e-mail addresses found in the commit log from web crawlers.
> +    Disabled by default.
> ++
> +It is highly recommended to enable this feature unless web crawlers are
> +hindered in some other way. Note that crawlers intent on harvesting e-mail
> +addresses may disregard robots.txt.

Up to this line is more-or-less OK, but with a few comments:

 - "This hides ... from web crawlers"?  Doesn't this hide it
   indiscriminately, whether the requester is an interactive
   end-user or a crawler?

 - The name of the configured feature, 'email_privacy'.  There is
   another existing feature with underscore in its name
   (remote_heads), but I think it is an odd-ball mistake we do not
   want to imitate.  Instead, I think the "extra branch refs" may be
   a good example to follow.  The feature name (written in Perl
   code) is "extra-branch-refs" (downcased words with inter-word
   dashes) and the corresponding configuration (I am not saying we
   should add one to support this feature, if we do not have one
   already) is "gitweb.extraBranchRefs" (camelCased words).

 - Do not exaggerate with words like "highly", but trust the
   intelligence of your readers to make the right decision when they
   understand the reason why this feature exists in the first place.

 - I do not think this entry should be added to the end of feature
   list.  How about listing it just after 'avatar', which is also
   about how author/committer identity is shown?

> +---------------------------------------------------------------------------
> +$feature{'email_privacy'}{'default'} = [1];
> +---------------------------------------------------------------------------

I do not think this should be here.  None of the boolean features
listed early in "Features in `%feature`" section like blame,
snapshot, grep, pickaxe, ... features tell readers how to enable a
specific feature like that.

Unless the syntax to configure a feature is one-off oddball that is
different from all other features, we shouldn't clutter the
description with an example like this.

At the beginning of the section "Configuring Gitweb Features" there
is a general description and that should be sufficient (and if it is
not sufficient, it is OK to add an example to that section).

> +Note that if Gitweb is not the final step in a workflow then subsequent
> +steps may misbehave because of the redacted information they receive.

In other words, this will break crawlers that expect email addresses
are there and want to use it for some good purpose.  But that is an
natural consequence of the "feature", and should be described as
such when we said "Redact e-mail addresses", not as a "by the way"
mention in a footnote.

	... after reading more, readers realize that the damage is
	far worse in the current incarnation of the patch, but let's
	read on ...

> @@ -3449,6 +3458,19 @@ sub parse_date {
>  	return %date;
>  }
>  
> +sub hide_mailaddr_if_private {
> +	my $line = shift;
> +	return $line unless (gitweb_check_feature('email_privacy') &&
> +						$line =~ m/^([^<]+) <([^>]*)>/);

I find that the second line is way too deeply indented.  Wouldn't

> +	return $line unless (gitweb_check_feature('email_privacy') &&
> +				$line =~ m/^([^<]+) <([^>]*)>/);

be enough?

> +	return hide_mailaddr($line)
> +}
> +
> +sub hide_mailaddr {
> +	my $mailaddr = shift;
> +	$mailaddr =~ s/<([^>]*)>/<private>/;

s/private/redacted/ perhaps?

> @@ -3568,9 +3602,10 @@ sub parse_commit_text {
>  	if (! defined $co{'title'} || $co{'title'} eq "") {
>  		$co{'title'} = $co{'title_short'} = '(no commit message)';
>  	}
> -	# remove added spaces
> +	# remove added spaces, redact e-mail addresses if applicable.
>  	foreach my $line (@commit_lines) {
>  		$line =~ s/^    //;
> +		$line = hide_mailaddr_if_private($line);

A commit log that ends with

	Thank you, A <a@example.com> and B <b@example.com>, for discovering
	this bug and quickly proposing a solution.

would recact only the first one but not the other, I suspect.

Much more problematic is that I see too many hits from:

    $ git log v2.30.0..v2.31.0 | grep ' <[^>@]*>'

That is, "find a line in the commit log message that has a SP, open <bra,
run of characters that are not ket> or at@sign, closed with ket>".  These
are clearly not e-mail addresses.

This "feature" butchers a commit title:

    mktag doc: say <hash> not <sha1>

to

    mktag doc: say <private> not <sha1>

doesn't it?

> @@ -8060,8 +8095,9 @@ sub git_commitdiff {
>  		close $fd
>  			or print "Reading git-diff-tree failed\n";
>  	} elsif ($format eq 'patch') {
> -		local $/ = undef;
> -		print <$fd>;
> +		while (my $line = <$fd>) {
> +			print hide_mailaddr_if_private($line);
> +		}

And this is even worse.

 $ git log -p --no-merges v2.30.0..v2.31.0 | grep ' <[^>@]*>' | wc -l

gives me ~4700 hits.  Because the patch text as well as the log
message is munged, the "feature" makes the output utterly unreliable
as an input to "git am" by munging too much.  Interesting examples
are like these:

        -	for (i = 0; i < pairs->nr; ++i) {
                'git <command> [<revision>...] -- [<file>...]'
        +	for (i = split; i < geometry->pack_nr; i++) {

Now, I am *NOT* saying that you should tighten the e-mail address
syntax detection and keep munging the patch text.  The lines that
begin with minus and SP in a patch must match the preimage text,
so munging out existing e-mail addresses from them will make the
patch fail to find the part that needs to be modified.  And
replacing an e-mail address on a line that begins with plus would
redact it from the source---if they wrote an address, they must have
meant it to be available to those who consume the source, so I doubt
the wisdom of munging the patch part at all.

I may be sympathetic to the cause of the patch, but, I do not agree
with its execution in this iteration of the patch.

Thanks.

