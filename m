From: Junio C Hamano <gitster@pobox.com>
Subject: Re: ghost refs
Date: Thu, 08 Apr 2010 13:42:01 -0700
Message-ID: <7vbpdt65ie.fsf@alter.siamese.dyndns.org>
References: <89030B4A18ECCD45978A3A6B639D1F24032A074E1C@FL01EXMB01.trad.tradestation.com>
 <r2h32541b131004070958pa66bb7a3g6a1ecfaea0419965@mail.gmail.com>
 <20100407210010.GB27012@coredump.intra.peff.net>
 <89030B4A18ECCD45978A3A6B639D1F24032A0750BE@FL01EXMB01.trad.tradestation.com>
 <k2p32541b131004071503g4ce66e5bjac8270b10790a2af@mail.gmail.com>
 <89030B4A18ECCD45978A3A6B639D1F24032A0750CC@FL01EXMB01.trad.tradestation.com>
 <k2x32541b131004071511i9bbe883az504547d6133aef@mail.gmail.com>
 <20100408043059.GA28768@coredump.intra.peff.net>
 <89030B4A18ECCD45978A3A6B639D1F24032A075390@FL01EXMB01.trad.tradestation.com>
 <7vwrwh6fz8.fsf@alter.siamese.dyndns.org>
 <20100408194908.GB4222@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Dlugosz <JDlugosz@TradeStation.com>, git@vger.kernel.org,
	Avery Pennarun <apenwarr@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 08 22:42:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzyYO-0000M7-AE
	for gcvg-git-2@lo.gmane.org; Thu, 08 Apr 2010 22:42:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933268Ab0DHUmP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Apr 2010 16:42:15 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:44885 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933242Ab0DHUmN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Apr 2010 16:42:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 53E64A8E60;
	Thu,  8 Apr 2010 16:42:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8DNN8GI/l/jJgo5k4a95FNIJ90U=; b=jHgG+b
	AnWnFwo0UTXXIfOKnc+3Z9HNPLoNoRsVnU2SQaC5GmKchzRcDCKqAV1EJeWL5gm+
	c33ntcnvPu/uYH9mSdIxdSGnEaUlZJKaiLKugAUlMjAFEZX7DzqqQClTvLUePLET
	5AnimEXuzV+/UtT4SuGhk6POYxx+jS8IBkU1s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vh8DYZ6cpzvyo2eotnWb5yty+8esg1uv
	XAcSCW2KuEXSZ/W1dZTEd1HZsVoYrz5CvXov0y8h5enSjZYe43e3eYC+U8/7KxP/
	eSNc4RYy6gEntuOmsdqT+7Qr1dH0SdRLtdcnTSXUL52Ul63+Uou402OoRcmxfBha
	RRTWI3zTieQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B41BBA8E59;
	Thu,  8 Apr 2010 16:42:07 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6A315A8E56; Thu,  8 Apr
 2010 16:42:02 -0400 (EDT)
In-Reply-To: <20100408194908.GB4222@sigill.intra.peff.net> (Jeff King's
 message of "Thu\, 8 Apr 2010 15\:49\:08 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 32B26754-434F-11DF-A579-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144381>

Jeff King <peff@peff.net> writes:

> Maybe:
>
> -- >8 --
> Subject: [PATCH] docs: clarify "branch -l"
>
> This option is mostly useless these days because we turn on
> reflogs by default in non-bare repos.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  Documentation/git-branch.txt |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
> index 903a690..d78f4c7 100644
> --- a/Documentation/git-branch.txt
> +++ b/Documentation/git-branch.txt
> @@ -72,6 +72,8 @@ OPTIONS
>  	Create the branch's reflog.  This activates recording of
>  	all changes made to the branch ref, enabling use of date
>  	based sha1 expressions such as "<branchname>@\{yesterday}".
> +	Note that in non-bare repositories, reflogs are usually
> +	enabled by default by the `core.logallrefupdates` config option.
>  
>  -f::
>  --force::

That certainly is an improvement, but I've been wondering if it makes
sense to also have a section in each commands the configuration variables
that affects the behaviour of the command.  core.logallrefupdates surely
is not the only variable that affects how "git branch" behaves.

We might want to have a general concensus on what we want to have in the
documentation.  As you noted, some have too sparse SYNOPSIS, while others
have full list of options.  Some mention configuration variables, while
others don't.  Some have extensive examples, while others lack any.
Once we know the general direction in which we are going, we can hand off
the actual documentation updates to the crowd ;-)

I'll list my preference off the top of my head as a firestarter.

NAME::

The name followed by what it is used for

SYNOPSIS::

I prefer to have (almost) complete set of options in SYNOPSIS, rather than
"command [<options>] <args>..." which is next to useless.  This is
especially true for commands whose one set of options is incompatible with
other set of options and arguments (e.g. there is no place for "-b" to
"checkout" that checks out paths out of the index or a tree-ish).

I also prefer not to list "purely for backward compatibility" options in
SYNOPSIS section.

DESCRIPTION::

The description section should first state what the command is used for,
iow, in which situation the user might want to use that command.

OPTIONS::

List of full options.  Some existing pages list them alphabetically, while
others list them in functional groups.  I prefer the latter which tends to
make the page more concise, and is more suited for people who got used to
the system (and remember, nobody stays to be a newbie forever, and people
who stay to be newbies forever are not our primary audience).

Detailed discussion of concepts::

Some manual pages need to have discussion of basic concepts that would not
be a good fit for the DESCRIPTION section (e.g. "Detached HEAD" section in
"checkout" manual).  I am not sure if this kind of material is better
given in OPTIONS section close to the functional group (e.g. "History
Siimplification" heading in "log" manual).


EXAMPLES::

I prefer to make it mandatory for Porcelain command manual pages to have a
list of often used patterns that a reasonably intelligent person can guess
how to tweak to match the particular situation s/he is in.


AUTHOR/DOCUMENTAITON::

These sections in most pages are not kept up to date, and I prefer to
remove them altogether.  They do not help end users who never clone
git.git, and those who clone git.git will have shortlog to give them more
accurate information.
