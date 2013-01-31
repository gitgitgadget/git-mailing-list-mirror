From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/7] Undocument deprecated alias 'push.default=tracking'
Date: Thu, 31 Jan 2013 11:41:45 -0800
Message-ID: <7vip6dgmx2.fsf@alter.siamese.dyndns.org>
References: <1334933944-13446-1-git-send-email-Matthieu.Moy@imag.fr>
 <1335170284-30768-1-git-send-email-Matthieu.Moy@imag.fr>
 <1335170284-30768-3-git-send-email-Matthieu.Moy@imag.fr>
 <CACBZZX552fnD+u9Zp-BhqDyYWN+OiyvCyub-xjMZ-_GXCG-vQA@mail.gmail.com>
 <7vvcadgss0.fsf@alter.siamese.dyndns.org> <20130131190747.GE27340@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 31 20:42:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U101T-0000It-4P
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jan 2013 20:42:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754191Ab3AaTlu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2013 14:41:50 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64749 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752013Ab3AaTls (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2013 14:41:48 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 25DF3BC45;
	Thu, 31 Jan 2013 14:41:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IetOBqTBZJQrjPgbSbOdZdc5SCA=; b=dmWKrw
	UJfHKCkD72QgHi58tpt33Z8pU1aVZ6zbLB6JR/X6ScTVmfpFqodUtzIbD3GlhfUX
	SyNGu1YW8NUx4fAW0pdbn3Aj2LPh4Ik/9br6FnH3HTXsZMoy6Pin4r+MLdFjhjcH
	7lzr2varpk0xrr2X3wMWeZPIBp+8Ispl7zw2s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bfEYhOvBkd5diMaafpiF7tKwISkOXNh0
	NBOB4xHqxncmwFTgq5sMT6NNlkS7sR6zt5XTlIsMXjy4hq2sheY/9Mabinh1/Os2
	cMr1LjL75JIRaeujXs1DTFQqQFeZDhpO4EmJ3pvbU6nn+seyCq8ETJIamQTFonEz
	Pu4H6rHCTok=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 19850BC44;
	Thu, 31 Jan 2013 14:41:48 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 637ECBC41; Thu, 31 Jan 2013
 14:41:47 -0500 (EST)
In-Reply-To: <20130131190747.GE27340@google.com> (Jonathan Nieder's message
 of "Thu, 31 Jan 2013 11:07:47 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3FF4620E-6BDE-11E2-A755-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215156>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Junio C Hamano wrote:
>
>> Wow, that's a blast from the past.
>>
>> I tend to agree that deprecating and removing are quite different,
>> but a simple "revert" of the change would not be good, either.  We
>> still would want to _discourage_ its use.
>
> Hm, I was about to try adding a line in that vein, like
>
>  * `tracking` - deprecated synonym for `upstream`.
>  
> Imagine my surprise when I saw that that is what you just said
> would be no good:
>
> [...]
>>>>    `git pull`.
>>>> -* `tracking` - deprecated synonym for `upstream`.
>>>>  * `current` - push the current branch to a branch of the same name.
>
> I really do think that including `tracking` in the same list would be
> valuable.  When I look over a friend's .gitconfig file to help track
> down a problem she is running into, it is helpful if I can find the
> meaning of each item in a straightforward way.

While I agree we would need a way for you to easily find `tracking`
mentioned near that point, listing it as if it is a proper part of
the same list of possibilities is not the only way to do so.

The enumeration is used by two different audiences.  For those who
want to _learn_ what possibilities are available to them (i.e. they
are not going from `tracking` to what it means, but going in the
opposite direction), it should be unmistakingly clear that
`tracking` is not a part of the choices they should make.  I do not
think the following list created by a simple "revert" makes it clear.

    * `nothing` - do not push anything.
    * `matching` - push all branches having the same name in both ends.
    * `upstream` - push the current branch to ...
    * `simple` - like `upstream`, but refuses to ...
    * `tracking` - deprecated synonym for `upstream`.
    * `current` - push the current branch to a branch of the same name.

When scanning, most people will scan lines to see there are 6
choices without reading anything after '-' first, and then start
reading the item that sounds plausible for them without necessarily
reading the others.  That will imprint the word `tracking` in the
context of choosing how to push, especially when that is not what
they end up using.

That is why I tend to prefer how check-ref-format documentation
describes --print:

        --normalize::
                Normalize 'refname' by removing any leading slash (`/`)
                characters and collapsing runs of adjacent slashes between
                name components into a single slash.  Iff the normalized
                refname is valid then print it to standard output and exit
                with a status of 0.  (`--print` is a deprecated way to spell
                `--normalize`.)

When you are going from `tracking` to what it means, you have \C-s
(if you are viewing in Emacs) or '/' (if you are using less)
available.
