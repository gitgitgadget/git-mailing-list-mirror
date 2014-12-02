From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git add -i: allow list (un)selection by regexp
Date: Tue, 02 Dec 2014 09:26:54 -0800
Message-ID: <xmqq8uiqm081.fsf@gitster.dls.corp.google.com>
References: <DB3PR04MB25020F247555E521936E676EB7D0@DB3PR04MB250.eurprd04.prod.outlook.com>
	<xmqqiohvqqqv.fsf@gitster.dls.corp.google.com>
	<DB3PR04MB2509E51F1DE708549483845EB7A0@DB3PR04MB250.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>,
	"akx\@iki.fi" <akx@iki.fi>
To: Aarni Koskela <aarni.koskela@andersinnovations.com>
X-From: git-owner@vger.kernel.org Tue Dec 02 18:27:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XvrE5-0007NU-Ah
	for gcvg-git-2@plane.gmane.org; Tue, 02 Dec 2014 18:27:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754187AbaLBR05 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2014 12:26:57 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:57822 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750780AbaLBR04 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2014 12:26:56 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 48EC123650;
	Tue,  2 Dec 2014 12:26:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0l5ZJHvtEUvsVC3M9ffvTKCFsLs=; b=U0l4Fd
	HucZqThNqR/NVW90+MKrlyVRGhotozmYN00gqTuIIDw0BeCnoFnMgoasXuwFwCTs
	77lZ0GW2wmusb+UuLbJf7OGCZ/8IG/Ks4+OZHc7js97NF0F6hBKoMVFi92YgO3CV
	SB2J17CwkYlr2LlUwV8/HYiLxu0Z/iqDS/yMA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WKTJ9uenduEoXLSa8j1cEq6Vfia/oITS
	HC0L+yIj5giBgFT50ee5JHT4rer4YPZcof4mA22c82JFb0OMg+L+21QHOvFA/w1z
	ulyhP+Wfdtr7I+tJvDkiVWJgXOMwz1rjdUgqENYsEANns1YFe4FizvSNLB6HHnin
	xgaMkRGjY4U=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4006B2364F;
	Tue,  2 Dec 2014 12:26:56 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7D6622364E;
	Tue,  2 Dec 2014 12:26:55 -0500 (EST)
In-Reply-To: <DB3PR04MB2509E51F1DE708549483845EB7A0@DB3PR04MB250.eurprd04.prod.outlook.com>
	(Aarni Koskela's message of "Tue, 2 Dec 2014 12:12:48 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 698FEAFA-7A48-11E4-99A7-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260582>

Aarni Koskela <aarni.koskela@andersinnovations.com> writes:

> From 9096652a71666920ae8d59dd4317d536ba974d5b Mon Sep 17 00:00:00 2001
> From: Aarni Koskela <akx@iki.fi>
> Date: Tue, 2 Dec 2014 13:56:15 +0200
> Subject: [PATCH] git-add--interactive: allow list (un)selection by regular
>  expression

Remove the three lines from the top, move the content on Subject: to
the subject of the e-mail.

Other than that, everything I see in this message is very well
done.

Thanks, will queue.

>
> Teach `list_and_choose` to allow `/regexp` and `-/regexp` syntax to
> select items based on regular expression match.
>
> This feature works in all list menus in `git-add--interactive`, and is not
> limited to file menus only.
>
> For instance, in file lists, `/\.c$` will select all files whose extension
> is `.c`.  In option menus, such as the main menu, `/pa` could be used to
> choose the `patch` option.
>
> Signed-off-by: Aarni Koskela <akx@iki.fi>
> ---
>
> Thank you for the insightful comments, Junio, and sorry for the confusion
> regarding email-patch formatting.  Hoping I get it right this time.
>
>> Usually the responsibility to ensure correctness lies on the person who
>> proposes a change, not those who relies on the continued correct operation
>> of the existing code.
>
> You're of course absolutely right.  My point was that I can't think of an use
> case where one would need to otherwise have "/" or "-/" as the first characters
> of input in a list_and_choose situation, but someone else might.
>
>> [...] but is this about the selection that happens after showing you a
>> list of filenames to choose from?
>
> I clarified this in the commit message.  Selection by regexp works in all
> list_and_choose situations, including the main menu of `git add -i`, hence "option".
>
> Regarding the unchoose quantifier -- yes, silly me.
>
> And regarding error checking for the regular expression, you're right -- the
> program promptly blew up when entering an invalid regexp.  I incorporated your
> suggestion for error checking, with the addition of using the `error_msg` sub
> for colorized error reporting.
>
> Best regards,
>
> Aarni Koskela
>
>  git-add--interactive.perl | 49 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
>
> diff --git a/git-add--interactive.perl b/git-add--interactive.perl
> index 1fadd69..28e4c2d 100755
> --- a/git-add--interactive.perl
> +++ b/git-add--interactive.perl
> @@ -483,6 +483,8 @@ sub is_valid_prefix {
>  	    !($prefix =~ /[\s,]/) && # separators
>  	    !($prefix =~ /^-/) &&    # deselection
>  	    !($prefix =~ /^\d+/) &&  # selection
> +	    !($prefix =~ /^\//) &&   # regexp selection
> +	    !($prefix =~ /^-\//) &&  # regexp unselection
>  	    ($prefix ne '*') &&      # "all" wildcard
>  	    ($prefix ne '?');        # prompt help
>  }
> @@ -585,6 +587,50 @@ sub list_and_choose {
>  			    prompt_help_cmd();
>  			next TOPLOOP;
>  		}
> +		if ($line =~ /^(-)?\/(.+)$/) {
> +			# The first capture group ("-") being missing means "choose" is
> +			# requested. If the first group exists at all, "unchoose" is
> +			# requested.
> +			my $choose = !(defined $1);
> +
> +			# Validate the regular expression and complain if compilation failed.
> +			my $re = eval { qr/$2/ };
> +			if (!$re) {
> +				error_msg "Invalid regular expression:\n  $@\n";
> +				next TOPLOOP;
> +			}
> +
> +			my $found = 0;
> +			for ($i = 0; $i < @stuff; $i++) {
> +				my $val = $stuff[$i];
> +
> +				# Figure out the display value for $val.
> +				# Some lists passed to list_and_choose contain
> +				# items other than strings; in order to match
> +				# regexps against them, we need to extract the
> +				# displayed string. The logic here is approximately
> +				# equivalent to the display logic above.
> +
> +				my $ref = ref $val;
> +				if ($ref eq 'ARRAY') {
> +					$val = $val->[0];
> +				}
> +				elsif ($ref eq 'HASH') {
> +					$val = $val->{VALUE};
> +				}
> +
> +				# Match the string value against the regexp,
> +				# then act accordingly.
> +
> +				if ($val =~ $re) {
> +					$chosen[$i] = $choose;
> +					$found = $found || $choose;
> +					last if $choose && $opts->{SINGLETON};
> +				}
> +			}
> +			last if $found && ($opts->{IMMEDIATE});
> +			next TOPLOOP;
> +		}
>  		for my $choice (split(/[\s,]+/, $line)) {
>  			my $choose = 1;
>  			my ($bottom, $top);
> @@ -635,6 +681,7 @@ sub singleton_prompt_help_cmd {
>  Prompt help:
>  1          - select a numbered item
>  foo        - select item based on unique prefix
> +/regexp    - select item based on regular expression
>             - (empty) select nothing
>  EOF
>  }
> @@ -648,6 +695,8 @@ Prompt help:
>  foo        - select item based on unique prefix
>  -...       - unselect specified items
>  *          - choose all items
> +/regexp    - select items based on regular expression
> +-/regexp   - unselect items based on regular expression
>             - (empty) finish selecting
>  EOF
>  }
