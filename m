Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B096C433DB
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 20:08:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 006646194C
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 20:08:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbhCUUH5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Mar 2021 16:07:57 -0400
Received: from mx.99rst.org ([52.22.122.190]:38956 "EHLO mx.99rst.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230497AbhCUUHZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Mar 2021 16:07:25 -0400
Received: from mail.kodaksys.org (localhost [127.0.0.1])
        by mx.99rst.org (Postfix) with ESMTP id 3C57A42327;
        Sun, 21 Mar 2021 20:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=99rst.org;
        s=20161001; t=1616357242;
        bh=rx7Y9uKOwSw44eOMyuEI33Fiu028icIhTttc9zNVkBE=;
        h=In-Reply-To:References:Date:Subject:From:To:Cc:From;
        b=GhbaTn0GYxUyE8ltlfQESTvek3nbFrSFb71BhUkySSdySGT9BngeNr2UgoflXg/p1
         Vc1RurO5cr5WUtPlIESeRh3ZBHpYSfXcZRDgMmPue4vIXnhXuNTwVjJ3OgeMUDoO8r
         TdhaIvLpFOIIHoeOKP5PTHTR6xulx756s97eQF4cTf7AzoM24GtdFz/kA31yhTCAVD
         m05kj8RIpesyfq5hqYNxi+Va32ozX8k054Dj1xQzSxmMH/jqrKAE7vQTuxn+oc45P/
         AAQeg0CNi6sRflsUezKj07gOIF6Io+niVSTZpN06PM83mubZIAuKDvosfRl9Ijfei9
         vfoRa2Jh2kRRQ==
Received: by mail.kodaksys.org with HTTP;
        Sun, 21 Mar 2021 20:07:22 -0000
Message-ID: <dfb1fe6cdf78788250009abe8e1489c8.squirrel@mail.kodaksys.org>
In-Reply-To: <xmqqzgyw9wn3.fsf@gitster.g>
References: <pull.910.v2.git.1616297564158.gitgitgadget@gmail.com>
    <pull.910.v3.git.1616347731514.gitgitgadget@gmail.com>
    <xmqqzgyw9wn3.fsf@gitster.g>
Date:   Sun, 21 Mar 2021 20:07:22 -0000
Subject: Re: [PATCH v3] gitweb: redacted e-mail addresses feature.
From:   "Georgios Kontaxis" <geko1702+commits@99rst.org>
To:     "Junio C Hamano" <gitster@pobox.com>
Cc:     "Georgios Kontaxis via GitGitGadget" <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7AgQmphcm1hc29uIg==?= 
        <avarab@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
User-Agent: SquirrelMail
MIME-Version: 1.0
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
Importance: Normal
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> "Georgios Kontaxis via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
>> From: Georgios Kontaxis <geko1702+commits@99rst.org>
>>
>> Gitweb extracts content from the Git log and makes it accessible
>> over HTTP. As a result, e-mail addresses found in commits are
>> exposed to web crawlers and they may not respect robots.txt.
>> This may result in unsolicited messages.
>> This is a feature for redacting e-mail addresses
>> from the generated HTML, etc. content.
>>
>> This feature does not prevent someone from downloading the
>> unredacted commit log, e.g., by cloning the repository, and
>> extracting information from it.
>> It aims to hinder the low-effort bulk collection of e-mail
>> addresses by web crawlers.
>
> Lines from here ...
>
>>
>> Changes since v1:
>> - Turned off the feature by default.
>> - Removed duplicate code.
>> - Added note about Gitweb consumers receiving redacted logs.
>>
>> Changes since v2:
>> - The feature can be set on a per-project basis. ('override' => 1)
>
> ... to here are to help reviewers on the mailing list while
> iterations of the same change is being reviewed and polished.
>
> But it is useless noise for those who only read "git log".  They
> simply do not have access to earlier iterations.
>
> Such "changes between iterations" comments needs to be written after
> the three-dash lines.
>
>> Signed-off-by: Georgios Kontaxis <geko1702+commits@99rst.org>
>> ---
>>     gitweb: Redacted e-mail addresses feature.
>>
>>     Gitweb extracts content from the Git log and makes it accessible
>> over
>>     HTTP. As a result, e-mail addresses found in commits are exposed to
>> web
>>     crawlers. This may result in unsolicited messages. This is a feature
>> for
>>     redacting e-mail addresses from the generated HTML content.
>>
>>     This feature does not prevent someone from downloading the
>> unredacted
>>     commit log and extracting information from it. It aims to hinder the
>>     low-effort bulk collection of e-mail addresses by web crawlers.
>>
>>     Signed-off-by: Georgios Kontaxis geko1702+commits@99rst.org
>>
>> Published-As:
>> https://github.com/gitgitgadget/git/releases/tag/pr-910%2Fkontaxis%2Fkontaxis%2Femail_privacy-v3
>> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git
>> pr-910/kontaxis/kontaxis/email_privacy-v3
>> Pull-Request: https://github.com/gitgitgadget/git/pull/910
>>
>> Range-diff vs v2:
>>
>>  1:  74af11ca8bf2 ! 1:  930cdefe7ee0 gitweb: redacted e-mail addresses
>> feature.
>>      @@ Commit message
>>           - Removed duplicate code.
>>           - Added note about Gitweb consumers receiving redacted logs.
>>
>>      +    Changes since v2:
>>      +    - The feature can be set on a per-project basis. ('override'
>> => 1)
>>      +
>>           Signed-off-by: Georgios Kontaxis <geko1702+commits@99rst.org>
>>
>>        ## Documentation/gitweb.conf.txt ##
>>      @@ gitweb/gitweb.perl: sub evaluate_uri {
>>       +	# $feature{'email_privacy'}{'default'} = [1];
>>       +	'email_privacy' => {
>>       +		'sub' => sub { feature_bool('email_privacy', @_) },
>>      -+		'override' => 0,
>>      ++		'override' => 1,
>>       +		'default' => [0]},
>>        );
>>
>>
>>
>>  Documentation/gitweb.conf.txt | 16 +++++++++++++
>>  gitweb/gitweb.perl            | 42 ++++++++++++++++++++++++++++++++---
>>  2 files changed, 55 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/gitweb.conf.txt
>> b/Documentation/gitweb.conf.txt
>> index 7963a79ba98b..b7af3240177d 100644
>> --- a/Documentation/gitweb.conf.txt
>> +++ b/Documentation/gitweb.conf.txt
>> @@ -896,6 +896,22 @@ same as of the snippet above:
>>  It is an error to specify a ref that does not pass "git
>> check-ref-format"
>>  scrutiny. Duplicated values are filtered.
>>
>> +email_privacy::
>> +    Redact e-mail addresses from the generated HTML, etc. content.
>> +    This hides e-mail addresses found in the commit log from web
>> crawlers.
>> +    Disabled by default.
>> ++
>> +It is highly recommended to enable this feature unless web crawlers are
>> +hindered in some other way. Note that crawlers intent on harvesting
>> e-mail
>> +addresses may disregard robots.txt.
>
> Up to this line is more-or-less OK, but with a few comments:
>
>  - "This hides ... from web crawlers"?  Doesn't this hide it
>    indiscriminately, whether the requester is an interactive
>    end-user or a crawler?
>
Correct. It doesn't say "it only hides from".
I can see how it may be confusing. I'll rephrase.

>  - The name of the configured feature, 'email_privacy'.  There is
>    another existing feature with underscore in its name
>    (remote_heads), but I think it is an odd-ball mistake we do not
>    want to imitate.  Instead, I think the "extra branch refs" may be
>    a good example to follow.  The feature name (written in Perl
>    code) is "extra-branch-refs" (downcased words with inter-word
>    dashes) and the corresponding configuration (I am not saying we
>    should add one to support this feature, if we do not have one
>    already) is "gitweb.extraBranchRefs" (camelCased words).
>
I'll rename the feature.

>  - Do not exaggerate with words like "highly", but trust the
>    intelligence of your readers to make the right decision when they
>    understand the reason why this feature exists in the first place.
>
Will remove.

>  - I do not think this entry should be added to the end of feature
>    list.  How about listing it just after 'avatar', which is also
>    about how author/committer identity is shown?
>
Will do.

>> +---------------------------------------------------------------------------
>> +$feature{'email_privacy'}{'default'} = [1];
>> +---------------------------------------------------------------------------
>
> I do not think this should be here.  None of the boolean features
> listed early in "Features in `%feature`" section like blame,
> snapshot, grep, pickaxe, ... features tell readers how to enable a
> specific feature like that.
>
> Unless the syntax to configure a feature is one-off oddball that is
> different from all other features, we shouldn't clutter the
> description with an example like this.
>
> At the beginning of the section "Configuring Gitweb Features" there
> is a general description and that should be sufficient (and if it is
> not sufficient, it is OK to add an example to that section).
>
Will remove.

>> +Note that if Gitweb is not the final step in a workflow then subsequent
>> +steps may misbehave because of the redacted information they receive.
>
> In other words, this will break crawlers that expect email addresses
> are there and want to use it for some good purpose.  But that is an
> natural consequence of the "feature", and should be described as
> such when we said "Redact e-mail addresses", not as a "by the way"
> mention in a footnote.
>
> 	... after reading more, readers realize that the damage is
> 	far worse in the current incarnation of the patch, but let's
> 	read on ...
>
Will move this out of the footnote.

>> @@ -3449,6 +3458,19 @@ sub parse_date {
>>  	return %date;
>>  }
>>
>> +sub hide_mailaddr_if_private {
>> +	my $line = shift;
>> +	return $line unless (gitweb_check_feature('email_privacy') &&
>> +						$line =~ m/^([^<]+) <([^>]*)>/);
>
> I find that the second line is way too deeply indented.  Wouldn't
>
>> +	return $line unless (gitweb_check_feature('email_privacy') &&
>> +				$line =~ m/^([^<]+) <([^>]*)>/);
>
> be enough?
>
Will adjust.

>> +	return hide_mailaddr($line)
>> +}
>> +
>> +sub hide_mailaddr {
>> +	my $mailaddr = shift;
>> +	$mailaddr =~ s/<([^>]*)>/<private>/;
>
> s/private/redacted/ perhaps?
>
Will adjust.

>> @@ -3568,9 +3602,10 @@ sub parse_commit_text {
>>  	if (! defined $co{'title'} || $co{'title'} eq "") {
>>  		$co{'title'} = $co{'title_short'} = '(no commit message)';
>>  	}
>> -	# remove added spaces
>> +	# remove added spaces, redact e-mail addresses if applicable.
>>  	foreach my $line (@commit_lines) {
>>  		$line =~ s/^    //;
>> +		$line = hide_mailaddr_if_private($line);
>
> A commit log that ends with
>
> 	Thank you, A <a@example.com> and B <b@example.com>, for discovering
> 	this bug and quickly proposing a solution.
>
> would recact only the first one but not the other, I suspect.
>
> Much more problematic is that I see too many hits from:
>
>     $ git log v2.30.0..v2.31.0 | grep ' <[^>@]*>'
>
> That is, "find a line in the commit log message that has a SP, open <bra,
> run of characters that are not ket> or at@sign, closed with ket>".  These
> are clearly not e-mail addresses.
>
> This "feature" butchers a commit title:
>
>     mktag doc: say <hash> not <sha1>
>
> to
>
>     mktag doc: say <private> not <sha1>
>
> doesn't it?
>
True. Thanks for pointing these out.
Sounds like the pattern we're looking for needs to be more specific.

>> @@ -8060,8 +8095,9 @@ sub git_commitdiff {
>>  		close $fd
>>  			or print "Reading git-diff-tree failed\n";
>>  	} elsif ($format eq 'patch') {
>> -		local $/ = undef;
>> -		print <$fd>;
>> +		while (my $line = <$fd>) {
>> +			print hide_mailaddr_if_private($line);
>> +		}
>
> And this is even worse.
>
>  $ git log -p --no-merges v2.30.0..v2.31.0 | grep ' <[^>@]*>' | wc -l
>
> gives me ~4700 hits.  Because the patch text as well as the log
> message is munged, the "feature" makes the output utterly unreliable
> as an input to "git am" by munging too much.  Interesting examples
> are like these:
>
>         -	for (i = 0; i < pairs->nr; ++i) {
>                 'git <command> [<revision>...] -- [<file>...]'
>         +	for (i = split; i < geometry->pack_nr; i++) {
>
> Now, I am *NOT* saying that you should tighten the e-mail address
> syntax detection and keep munging the patch text.  The lines that
> begin with minus and SP in a patch must match the preimage text,
> so munging out existing e-mail addresses from them will make the
> patch fail to find the part that needs to be modified.  And
> replacing an e-mail address on a line that begins with plus would
> redact it from the source---if they wrote an address, they must have
> meant it to be available to those who consume the source, so I doubt
> the wisdom of munging the patch part at all.
>
> I may be sympathetic to the cause of the patch, but, I do not agree
> with its execution in this iteration of the patch.
>
I see your point.

It seems hiding e-mail addresses should be limited to the commit message,
i.e., stop at the "---" line.

> Thanks.
>
>


