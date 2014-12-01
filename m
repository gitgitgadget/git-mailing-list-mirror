From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git add -i: allow list (un)selection by regexp
Date: Mon, 01 Dec 2014 08:28:08 -0800
Message-ID: <xmqqiohvqqqv.fsf@gitster.dls.corp.google.com>
References: <DB3PR04MB25020F247555E521936E676EB7D0@DB3PR04MB250.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>,
	"akx\@iki.fi" <akx@iki.fi>
To: Aarni Koskela <aarni.koskela@andersinnovations.com>
X-From: git-owner@vger.kernel.org Mon Dec 01 17:28:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XvTpk-0002zn-Po
	for gcvg-git-2@plane.gmane.org; Mon, 01 Dec 2014 17:28:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753693AbaLAQ2P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2014 11:28:15 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:57641 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752842AbaLAQ2L (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2014 11:28:11 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B855122EC5;
	Mon,  1 Dec 2014 11:28:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rU7B78k0OhuN89/5S8xjgIH1TE4=; b=RGoH6H
	nzal+YhoyQGScHKSxK35tOMwWuEBtJLLsxb03Sf5jrMk2m66QbX7M+CPzbz3b/sy
	96AbwZ9uxeC8i0+iegwo0p/5/rcleWYw6UZ3c/BRdcoqfo3LCHkTxQu98g+F5Q6C
	fT96CL7FEOQBYAgHSyyJwN0WmFSFPaok2vHTo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=N8nSILYQ5QXwIFZvjtveV03EQ9aVHWl0
	izL+9Q/GtNQBruEmOyvFCrRlnKR3ZdK+DOZZqG9EBli2JZULo+giZvXLlxVLtUyK
	nHzunyzcFFGBRlmJZuJVe+q94GnhMDj2v4+BbiHTO+BuWi/qXK9vMQzwj+6/8KKo
	RFrdcKeHIs4=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AF4A122EC4;
	Mon,  1 Dec 2014 11:28:10 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 292AC22EC3;
	Mon,  1 Dec 2014 11:28:10 -0500 (EST)
In-Reply-To: <DB3PR04MB25020F247555E521936E676EB7D0@DB3PR04MB250.eurprd04.prod.outlook.com>
	(Aarni Koskela's message of "Mon, 1 Dec 2014 09:31:22 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 09E12302-7977-11E4-A686-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260489>

Aarni Koskela <aarni.koskela@andersinnovations.com> writes:

> Hello!
>
> This patch makes it possible to select or unselect files in `git add -i`
> by regular expression instead of unique prefix only.
>
> The command syntax is `/foo` for selection and `-/foo` for unselection.
> I don't think the syntax will conflict with any existing use cases, but feel
> free to prove me wrong.

Usually the responsibility to ensure correctness lies on the person
who proposes a change, not those who relies on the continued correct
operation of the existing code.

> I'm not a Perl programmer, but I've tried to follow the style of the
> existing code as much as possible. :)
>
> Note I'm currently not on the mailing list, so please cc.
>
> Best regards,
>
> Aarni Koskela

All of the above do not belong to the commit log message.  Please
have these commentaries after the three-dash line you have under
your Signed-off-by line.

>
> From 53c12d9c9928dc93a57595e92d785ecc0b245390 Mon Sep 17 00:00:00 2001
> From: Aarni Koskela <akx@iki.fi>
> Date: Mon, 1 Dec 2014 11:06:10 +0200
> Subject: [PATCH] git-add--interactive: allow list (un)selection by regular
>  expression

Remove these four lines when sending out a patch in the e-mail.

> Teach `list_and_choose` to allow `/regexp` and `-/regexp` syntax to
> select items based on regular expression match.
>
> For instance, `/jpg$` will select all options whose display name ends with
> `jpg`.

It has been a long time since I wrote this code, but is this about
the selection that happens after showing you a list of filenames to
choose from?  "all options" together with "jpg" made me go "Huh?
Does any of our command have jpeg related options?  We are not in
the image processing business".

Perhaps s/all options/all files/ or something.

> Signed-off-by: Aarni Koskela <akx@iki.fi>
> ---
>  git-add--interactive.perl | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>
> diff --git a/git-add--interactive.perl b/git-add--interactive.perl
> index 1fadd69..34cc603 100755
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
> @@ -585,6 +587,28 @@ sub list_and_choose {
>  			    prompt_help_cmd();
>  			next TOPLOOP;
>  		}
> +		if ($line =~ /^(-)*\/(.+)$/) {

You want zero or one '-', not zero or arbitrary large number of '-',
as a sign to unchoose.  (-)? instead of (-)*, perhaps?

> +			my $choose = !($1 && $1 eq '-');

The first $1 is an attempt to catch non-negative case where it is
"undef"; it might be more explicit this way?

			my $choose = !(defined $1);

> +			my $re = $2;

Mental note.  $re is an end-user supplied random string that may or
may not be a valid regular expression.

> +			my $found = 0;
> +			for ($i = 0; $i < @stuff; $i++) {
> +				my $val = $stuff[$i];
> +				my $ref = ref $val;
> +				if ($ref eq 'ARRAY') {
> +					$val = $val->[0];
> +				}
> +				elsif ($ref eq 'HASH') {
> +					$val = $val->{VALUE};
> +				}
> +				if ($val =~ /$re/) {

... which makes me wonder what happens when $re is a bogus regular
expression here.  Does the program die?  Does the user get an error
message about bad regexp and the condition to this if expression is
false?  Something else?

Perhaps validating and catching regexp errors early like this might
be sufficient:

        		my $re = eval { qr/$2/ };
                        if (!$re) {
				print STDERR "$@\n";
                                next TOPLOOP;
			}


Thanks.
