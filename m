From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Re: Teach mailinfo to ignore everything before -- >8 --
 mark
Date: Tue, 25 Aug 2009 18:51:46 -0700
Message-ID: <7vvdkbl4ul.fsf@alter.siamese.dyndns.org>
References: <7v3a7g501e.fsf@alter.siamese.dyndns.org>
 <fc2ecb5cf28cabb7d183e2835ce46aa9afb2a322.1251215299.git.nicolas.s.dev@gmx.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nanako Shiraishi <nanako3@lavabit.com>,
	Thell Fowler <git@tbfowler.name>, git@vger.kernel.org,
	Johannes.Schindelin@gmx.de
To: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
X-From: git-owner@vger.kernel.org Wed Aug 26 03:52:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mg7gU-0002KM-PF
	for gcvg-git-2@lo.gmane.org; Wed, 26 Aug 2009 03:52:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932769AbZHZBv7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Aug 2009 21:51:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932727AbZHZBv7
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Aug 2009 21:51:59 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:42400 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932631AbZHZBv6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Aug 2009 21:51:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 90C6318E84;
	Tue, 25 Aug 2009 21:51:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iBJw9mW1KgLnEr3CEO952wLURhU=; b=sLdm6Z
	79Gz+NSdRzcZpaVC4Hla7IPkuJbFRzF92jr7L9li6EwQVDct75fHmkG6tlqmKIQN
	FEJC37rONR1KELN95ai7gOrv49yFGLoNLzXdIhAJhtMk2RrTeryHjmuTtaXT+zUW
	i3z3NqvvOvp7gUU9qYTIZIWcANaWjPWy7P0bo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VfPG2tSF5g8IEX+z4D2Eq2L4quiZOqBJ
	AGgh7+9qusUTSdXBbXeUjeNA2u1IRtE+MybmyJjcjgfirH/XamuayjmFeznurgwt
	bFhy5kkC/S2dFWLMGiD0LbQ8qwD6WpeQUWz28dtm+dUZVKpKzPc0ktjQHang3ycp
	m8DE6fEfJ5g=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0CD5B18E82;
	Tue, 25 Aug 2009 21:51:54 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E462918E81; Tue, 25 Aug
 2009 21:51:47 -0400 (EDT)
In-Reply-To: <fc2ecb5cf28cabb7d183e2835ce46aa9afb2a322.1251215299.git.nicolas.s.dev@gmx.fr> (Nicolas Sebrecht's message of "Tue\, 25 Aug 2009 18\:18\:30 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 07AFC54C-91E3-11DE-B3BE-CA0F1FFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127057>

Nicolas Sebrecht <nicolas.s.dev@gmx.fr> writes:

>> I think we have bikeshedded long enough, so I won't be touching this code
>> any further only to change the definition of what a scissors mark looks
>> like,
>
> I'm not sure I understand. Are you still open to a patch touching this code
> /too/?

What I meant was that I would not want to spend any more of _my_ time on
the definition of the scissors for now.  That means spending or wasting
time on improving the 'pu' patch myself, or looking at others patch to
find flaws in them.

Of course, as the maintainer, I would need to look at proposals to improve
or fix bugs in the code before the series hits the master, but I would
give zero priority to the patches that change the definition at least for
now to give myself time to work on more useful things.

I think --ignore-scissors is a good thing to add, regardless of what the
definition of scissors should be.  So your patch should definitely be
separated into two parts.

> diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
> index 7e09b51..92319f6 100644
> --- a/builtin-mailinfo.c
> +++ b/builtin-mailinfo.c
> @@ -6,6 +6,7 @@
>  #include "builtin.h"
>  #include "utf8.h"
>  #include "strbuf.h"
> +#include "git-compat-util.h"

Inclusion of builtin.h is designed to be enough.  What do you need this
for?

>  static FILE *cmitmsg, *patchfile, *fin, *fout;
>  
> @@ -25,6 +26,7 @@ static enum  {
>  static struct strbuf charset = STRBUF_INIT;
>  static int patch_lines;
>  static struct strbuf **p_hdr_data, **s_hdr_data;
> +static int ignore_scissors = 0;

Don't initialize a static to 0.

> @@ -715,51 +717,63 @@ static inline int patchbreak(const struct strbuf *line)
>  		if (isspace(buf[i])) {
> +			if (scissors_dashes_seen)
> +				mark_end = i;

I think you do not want this part, and then you won't have to trim
trailing whitespaces from mark_end later.


> +			/*
> +			 * The mark is 8 charaters long and contains at least one dash and
> +			 * either a ">8" or "<8". Check if the last mark in the line
> +			 * matches the first mark found without worrying about what could
> +			 * be between them. Only one mark in the whole line is permitted.
> +			 */

This definition makes "-            8<" a scissors.  

Even though

    "-- 8< -- please cut here -- -- 8< --" 

is allowed, so is

    "-- 8< -- -- please cut here -- 8< -- --"

it does not allow

    "-- 8< -- please cut here -- 8< -- --"

nor

    "-- 8< -- -- please cut here -- -- 8< --"

nor

    "-- 8< -- -- please cut here -- -- >8 --"

Oh, did I say I won't waste my time on the definition?  I should have just
discarded this hunk ;-)

> @@ -782,22 +796,25 @@ static int handle_commit_msg(struct strbuf *line)
>  	if (metainfo_charset)
>  		convert_to_utf8(line, charset.buf);
>  
> -	if (is_scissors_line(line)) {
> -		int i;
> -		rewind(cmitmsg);
> -		ftruncate(fileno(cmitmsg), 0);
> -		still_looking = 1;
> +	if (!ignore_scissors) {
> +		if (is_scissors_line(line)) {
> +			warning("scissors line found, will skip text above");
> ...
> +			return 0;

Don't re-indent like this.  Just do:

	if (!ignore_scissors && is_scissors_line(line)) {
        	...
	}

> -	# -s, -u, -k, --whitespace, -3, -C, -q and -p flags are kept
> +	# Following flags are kept

We seem to have lost the description of what the "Following" are.
