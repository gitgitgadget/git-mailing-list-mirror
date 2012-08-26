From: Junio C Hamano <gitster@pobox.com>
Subject: Re: misleading diff-hunk header
Date: Sun, 26 Aug 2012 11:53:27 -0700
Message-ID: <7vzk5htrh4.fsf@alter.siamese.dyndns.org>
References: <503385D0.5070605@tim.thechases.com>
 <87a9xoi82i.fsf@thomas.inf.ethz.ch> <5033AC55.8080405@tim.thechases.com>
 <7vfw7gdtfg.fsf@alter.siamese.dyndns.org>
 <20120824142908.GA15162@sigill.intra.peff.net>
 <20120824164415.GA23262@sigill.intra.peff.net>
 <50381F52.9030007@tim.thechases.com>
 <7va9xjy4or.fsf@alter.siamese.dyndns.org>
 <5038CB66.1040006@tim.thechases.com> <5039FDD7.2090800@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tim Chase <git@tim.thechases.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Stefano Lattarini <stefano.lattarini@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 26 20:53:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T5hxy-0004Y2-Qn
	for gcvg-git-2@plane.gmane.org; Sun, 26 Aug 2012 20:53:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753678Ab2HZSxc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Aug 2012 14:53:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60884 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754785Ab2HZSxa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Aug 2012 14:53:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EB91D918D;
	Sun, 26 Aug 2012 14:53:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=13iSwaslOIy8luS3paXIueJm3a0=; b=QQHbte
	Hep4Lss54kqSarEkCbkdTus7+TI3OPw4TdL3gxwsoPc9OjRpCXF9IuXQiOdRWk9s
	nXYBR3CsBWGuDK6osImW+4T4yeAhT3DQE79gFvef4E12lH/ORdaytnycQAri4Fky
	JP7EtomL8gZp9Zr2q2CXKvinq8ZK2af4fuKNk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fINSd0WkpXsacf1O3iOLn2PX7aTCY1Ep
	m+3fyJSxSvOxM9Y+AMj6C0fyixfvQRwJ6e24e0c0SY4zQANzqo2DWyn0oEn7QhKH
	G9IKCDsqEotjxYKd4FvlFnhnHMYVyVtzrzPl3KYeioAU6m4XFfuG3wR5QfGdz10I
	6622rc1rcKI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D9431918C;
	Sun, 26 Aug 2012 14:53:29 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 240B6918A; Sun, 26 Aug 2012
 14:53:29 -0400 (EDT)
In-Reply-To: <5039FDD7.2090800@gmail.com> (Stefano Lattarini's message of
 "Sun, 26 Aug 2012 12:43:35 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 532C52A6-EFAF-11E1-AF16-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204310>

Stefano Lattarini <stefano.lattarini@gmail.com> writes:

> On 08/25/2012 02:56 PM, Tim Chase wrote:
>> On 08/24/12 23:29, Junio C Hamano wrote:
>>> Tim Chase <git@tim.thechases.com> writes:
>>>> If the documented purpose of "diff -p" (and by proxy
>>>> diff.{type}.xfuncname) is to show the name of the *function*
>>>> containing the changed lines,....
>>>
>>> Yeah, the documentation is misleading, but I do not offhand think of
>>> a better phrasing. Perhaps you could send in a patch to improve it.
>>>
>>> How does GNU manual explain the option?
>> 
>> Tersely. :-)
>> 
>>        -p  --show-c-function
>>               Show which C function each change is in.
>>
> That's in the manpage, which is basically just a copy of the output from
> "diff --help".  In the texinfo manual (which is the real documentation),
> there are additional explanations, saying, among other things:
>
>     To show in which functions differences occur for C and similar languages,
>     you can use the --show-c-function (-p) option. This option automatically
>     defaults to the context output format (see Context Format), with the
>     default number of lines of context. You can override that number with
>     -C lines elsewhere in the command line. You can override both the format
>     and the number with -U lines elsewhere in the command line.
>     The -p option is equivalent to -F '^[[:alpha:]$_]' if the unified format
>     is specified, otherwise -c -F '^[[:alpha:]$_]' (see Specified Headings).
>     GNU diff provides this option for the sake of convenience.
>     ...
>     The --show-function-line (-F) option finds the nearest unchanged line
>     that precedes each hunk of differences and matches the given regular
>     expression.

So in short, if we say "Show which function each change is in" in
the documentation, that is consistent with what GNU does and that is
described consistently with what GNU says, modulo that we obviously
do more than "C" via the diff.<driver>.xfuncname mechanism.

We already document diff.<driver>.xfuncname as determining "the hunk
header", and the documentation that is referred to (i.e. gitattributes)
shows the shape of a hunk in the "diff" output:

            @@ -k,l +n,m @@ TEXT

    This is called a 'hunk header'.  The "TEXT" portion is by default a line
    that begins with an alphabet, an underscore or a dollar sign; this
    matches what GNU 'diff -p' output uses.

and then later says:

    Then, you would define a "diff.tex.xfuncname" configuration to
    specify a regular expression that matches a line that you would
    want to appear as the hunk header "TEXT".

Honestly, I do not offhand see an obvious and possible room for vast
improvement over what we already have, so my RFH to Tim that appears
at the beginning of what you quoted from my previous message still
stands ;-).

Thanks.
