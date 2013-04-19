From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Apr 2013, #05; Mon, 15)
Date: Fri, 19 Apr 2013 14:56:00 -0700
Message-ID: <7v61ziyykv.fsf@alter.siamese.dyndns.org>
References: <20130418172714.GA24690@sigill.intra.peff.net>
	<7vd2tr6833.fsf@alter.siamese.dyndns.org>
	<20130418180017.GA5714@sigill.intra.peff.net>
	<7v61zj66wu.fsf@alter.siamese.dyndns.org>
	<20130418203035.GB24690@sigill.intra.peff.net>
	<7vvc7j4j0u.fsf@alter.siamese.dyndns.org>
	<20130418214427.GA10119@sigill.intra.peff.net>
	<7vobdb4hii.fsf@alter.siamese.dyndns.org>
	<20130419043142.GA5055@elie.Belkin>
	<7vbo9a3011.fsf@alter.siamese.dyndns.org>
	<20130419213455.GB20873@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 19 23:56:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTJI8-0000q7-J7
	for gcvg-git-2@plane.gmane.org; Fri, 19 Apr 2013 23:56:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934574Ab3DSV4R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Apr 2013 17:56:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40336 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933977Ab3DSV4Q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Apr 2013 17:56:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3F9FF182B9;
	Fri, 19 Apr 2013 21:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3GPjmplM6Hvdc8lvyX7AVmNTCDw=; b=M4Xy2Z
	hywdXGMea9s4fcVQX9+IJSJv+P/4te/7Qeu2St4ZMGg0Uec17axbHMtBEHVRtwRV
	SdnA0T5HK/T1YVON1bohCGtZ86ZwPUrV0vW4s+DDJpLNvId9bb+2CZ5OnE/2RBBX
	4DSw/dDO/emc10TzkXaSQhhWySFGnK2UEwQDk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JP5nk/CwZth3tvQZ4tzB8cgNEn4OyWMm
	/g+s8+1J9OAzlYDAYsn7JbvcwYeto0A/+wtQdcN2D3nvZNNctcuDzPOFba6NS33y
	nhuVFeAylUwXM88xEdbiiWNwfopNAfvx9f8TatdVGzDrcNfIMo9DAj3IAramfcOG
	oI4WtCwGnRc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3286A182B8;
	Fri, 19 Apr 2013 21:56:12 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7EB8B182B1;
	Fri, 19 Apr 2013 21:56:11 +0000 (UTC)
In-Reply-To: <20130419213455.GB20873@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 19 Apr 2013 17:34:55 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F2BEA65C-A93B-11E2-BA7C-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221824>

Jeff King <peff@peff.net> writes:

> On Fri, Apr 19, 2013 at 10:25:46AM -0700, Junio C Hamano wrote:
>
>> Jonathan Nieder <jrnieder@gmail.com> writes:
>> 
>> > Junio C Hamano wrote:
>> >
>> >>     You ran 'git add' with neither '-A (--all)' or '--no-all', whose
>> >>     behaviour will change in Git 2.0 with respect to paths you
>> >>     removed from your working tree.
>> >>
>> >>     * 'git add --no-all <pathspec>', which is the current default,
>> >>       ignores paths you removed from your working tree.
>> >>
>> >>     * 'git add --all <pathspec>' will let you also record the
>> >>       removals.
>> >>
>> >>     The removed paths (e.g. '%s') are ignored with this version of Git.
>> >>     Run 'git status' to remind yourself what paths you have removed
>> >>     from your working tree.
>> >>
>> >> or something?
>> >
>> > That looks good. :)
>> 
>> I think the direction may be good but the above is too tall to be
>> the final version. of the message.  Somebody good at phrasing needs
>> to trim it down without losing the essense.
>
> Hmph. I actually like it as it is. It says:
>
>   1. Here's what triggered this warning (removed paths without -A).
>
>   2. Here is how you tell git what you want to do (--all/--no-all)
>
>   3. Here is how you get more information about what you wanted to do
>      (mention one such path, point to "git status").
>
> I would not want to cut out any of those three. You could perhaps cut
> out the bullet points in the middle, which reduces (2), but the user may
> be able to figure it out from the first sentence. However, I like the
> explicitness of those bullet points (and I prefer them to a wall of text
> which is more daunting to read).

I think we are saying the same thing.  I do agree with you that
these three points are "the essense" we do not want to lose.

Shrinking the first paragraph and the last paragraph to less than
three lines and each bullet point a single liner each was the kind
of change I had in mind.
