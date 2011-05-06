From: Junio C Hamano <gitster@pobox.com>
Subject: Re: RFC: a plugin architecture for git extensions?
Date: Thu, 05 May 2011 21:47:19 -0700
Message-ID: <7vbozg4eqw.fsf@alter.siamese.dyndns.org>
References: <4DB80747.8080401@op5.se>
 <BANLkTimUHrHqS-Ssj+mK=0T8QHKg34pkaw@mail.gmail.com>
 <4DB82D90.6060200@op5.se> <7vbozr8uo8.fsf@alter.siamese.dyndns.org>
 <7vpqo77dlr.fsf@alter.siamese.dyndns.org>
 <1303930175.25134.38.camel@drew-northup.unet.maine.edu>
 <20110427194233.GA16717@gnu.kitenet.net>
 <7vwrif5q93.fsf@alter.siamese.dyndns.org> <20110427220748.GA19578@elie>
 <7vsjt35l84.fsf@alter.siamese.dyndns.org> <20110427234224.GA26854@elie>
 <7viptz5j82.fsf@alter.siamese.dyndns.org>
 <BANLkTi=w0aKH6dxu84i4DjkL-vNCWQi8pw@mail.gmail.com>
 <alpine.DEB.2.00.1104271751300.940@asgard.lang.hm>
 <BANLkTimnkBMRH7Spj1ByQRa9YdV9w+bwtQ@mail.gmail.com>
 <BANLkTikbcpzF203rUVB05OYyYhLmu3+n6w@mail.gmail.com>
 <BANLkTinQny-M0rL+Vs9L_cQhtVLyv6rqMw@mail.gmail.com>
 <4DB9329E.7000703@op5.se> <88795B20-6994-46A5-9710-2ADC84E04695@gmail.com>
 <7vhb986chl.fsf@alter.siamese.dyndns.org>
 <BANLkTi=+emhzqfiGxGbnJ=bm3oL7SvjhBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Aguilar <davvid@gmail.com>, Andreas Ericsson <ae@op5.se>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Joey Hess <joey@kitenet.net>,
	Git Mailing List <git@vger.kernel.org>,
	"david\@lang.hm" <david@lang.hm>,
	Pau Garcia i Quiles <pgquiles@elpauer.org>
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 06 06:47:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QICxI-0004iq-G1
	for gcvg-git-2@lo.gmane.org; Fri, 06 May 2011 06:47:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751783Ab1EFErx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2011 00:47:53 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:53796 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751602Ab1EFErm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2011 00:47:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 90B2E5E64;
	Fri,  6 May 2011 00:49:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/I9vcL1612THkMypwAXg6K9P9EY=; b=ES7Uxs
	jjzmGMJ25K/b2dfjDFufjAsLNYZ7fEr3lfX0FUsEK3akrZdVkNvpzYJ4mugUrcuY
	5gDrvW2h0SJMgLCKXkeyXxSnMGVYdPhEChgO4plZuFz972xgP/OWAV2zQvAZ1Apz
	+bHC5VtqWxtKIVuwMExSl3eUA4p2fxbVPRPwA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LDGf4dOX5oMOTCog1WGPovbqhNh3aF8t
	d4QYCR/qYfLw4MrX0AM00jQ9dqHu1OWbrjvFXxE2cdj1SphYrsoObF0mgnAuZG8Z
	Z16eoQ+hqxxzVdiX1pP0hR0i56iQp79A9qyH6ENcxM8BW3pYAQkJgvf4KqvNzOda
	1nS0+sFqcrA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 12C965E63;
	Fri,  6 May 2011 00:49:35 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 8F68C5E62; Fri,  6 May 2011
 00:49:24 -0400 (EDT)
In-Reply-To: <BANLkTi=+emhzqfiGxGbnJ=bm3oL7SvjhBw@mail.gmail.com> (Jon
 Seymour's message of "Fri, 6 May 2011 09:51:17 +1000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3D683494-779C-11E0-A512-90BEB0B5FC3A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172937>

Jon Seymour <jon.seymour@gmail.com> writes:

> | Junio: apologies, reply missed list. Edited slightly.
>
> On Fri, May 6, 2011 at 7:53 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> David Aguilar <davvid@gmail.com> writes:
>>
>>> On Apr 28, 2011, at 3:56 AM, Jon Seymour <jon.seymour@gmail.com> wrote:
>>>
>>>> What is so hard about the concept of an application providing a
>>>> ...
>
> It would be good if something like:
>
>     unzip -d $(git --plugins-dir) foobar.zip
>
> installed scripts, info files and man pages into a place where git
> would find them and then have git foobar start working without any
> additional effort by the package author or user.

That should be doable without any elaborate "plugin management".  We only
need to enhance the git potty and help system to look for things in a set
of new directories, and have these unzip installation put their stuff
there.

>> [Footnote]
>>
>> *1* I admit that I didn't read all of them carefully, as I was repelled by
>> them as soon as I saw phrases like "for people who can grok this concept".
>
> Junio: at least quote me accurately. I actually wrote:
>
> "Contributors who grok the concept as I conceive it are welcome to
> submit pull requests."
>
> I am a little mystified why use of the word "grok" in this way, given the
> circumstances, caused you to be "repelled".

What repelled me was not any particular word (and that is exactly why I
did not even bother to "quote") but your general attitude in the
discussion.  Your tone throughout the discussion appeared at least to me
that you thought anybody who did not agree with you was incapable of
understanding something so obvious and clearly right, and only those who
could "grok" it deserved to join the discussion.  We occasionally have
seen such people on this list in the past, but luckily not very often.

I am not saying that your thinking should always start from "I could be
wrong".  However, I do not think "What is so hard about the concept ...?"
is the question you should be asking others before asking yourself "Is
there a better way I could have explained this idea I want others to agree
with?  The reason why they are still not on the same page as I am could
well be because all of them are morons, but it may be possible that it is
because the way I have explained my idea to them was not optimal.  Perhaps
I did not present the motivation and the background well enough to justify
that the problem I am trying to solve is worth solving, before throwing my
idea on how to solve it".

After all, different people have different needs and expectations.  The
discussion on a particular _solution_ can only start after you get people
on board and share the sense of _need_ to solve something common.
