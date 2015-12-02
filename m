From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH V3] git-send-email: Add auto-cc to all body signatures
Date: Wed, 02 Dec 2015 09:58:41 -0800
Message-ID: <xmqq8u5c68by.fsf@gitster.mtv.corp.google.com>
References: <b2937bc06d1bff456b84e51d6edee0bb1afc5f31.1311902983.git.joe@perches.com>
	<1311903782.20837.42.camel@jtkirshe-mobl>
	<1323313119.1762.58.camel@joe2Laptop>
	<7v8vmmj1ng.fsf@alter.siamese.dyndns.org>
	<1323377486.1762.71.camel@joe2Laptop>
	<87mvtti2ul.fsf@rasmusvillemoes.dk>
	<1449075602.3716.27.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Rasmus Villemoes <rv@rasmusvillemoes.dk>, git@vger.kernel.org,
	jeffrey.t.kirsher@intel.com
To: Joe Perches <joe@perches.com>
X-From: git-owner@vger.kernel.org Wed Dec 02 18:59:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a4Bg8-0006XR-16
	for gcvg-git-2@plane.gmane.org; Wed, 02 Dec 2015 18:58:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964801AbbLBR6q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2015 12:58:46 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:52344 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933054AbbLBR6o (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2015 12:58:44 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6F728303A5;
	Wed,  2 Dec 2015 12:58:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GIVo0d3HMlwMe/tyzI4seR+eoFo=; b=RnSxdg
	P/BIiOwTI+AmhogmAP2CLd7nupiBA6dRZD0HL97EgyMgGrwU0Esu2G2sfvsWf7gz
	ZVAJA968pSoDcv1W0Z5NIr0tYapirJwTySrZGb2BlCSflHC9lFgLGefBsPb/R3hP
	itCRWqp73KiSp/nPqWkhE/SCiyORB93q3HxaM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=m7pbPtfUiGoAZQkwKQX5Pltux9u5FW3C
	A40fH6TrYXqHUqo8toeP4uZzWhfS4m/Ci1M8Cp/E7JMlXzvbxHb36Bxm8T8/9HYx
	XAu/5KhSdJof6q/xBkQ2C5jwJB0KWjwvzOJmN5bTY2uw2RNnMJjGDJF8STJpEKpR
	Zknc9OAErFQ=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 676A1303A4;
	Wed,  2 Dec 2015 12:58:43 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id D6AAE303A2;
	Wed,  2 Dec 2015 12:58:42 -0500 (EST)
In-Reply-To: <1449075602.3716.27.camel@perches.com> (Joe Perches's message of
	"Wed, 02 Dec 2015 09:00:02 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5338173C-991E-11E5-83C4-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281896>

Joe Perches <joe@perches.com> writes:

> Many types of signatures are used by various projects.
>
> The most common type is formatted:
> 	"[some_signature_type]-by: First Last <email <at> domain.tld>"
> e.g:
> 	"Reported-by: First Last <email <at> domain.tld>" (no quotes are used)
>
> Make git-send-email use these signatures as "CC:" entries.
>
> Add command line option --suppress-cc=signatures to avoid
> adding these entries to the cc.
>
> Signed-off-by: Joe Perches <joe <at> perches.com>
> Acked-by: Jeff Kirsher <jeffrey.t.kirsher <at> intel.com>

I wonder what send-email with this patch does to the above two lines
with "<at>" not "@" ;-)  How was this patch sent?

In any case, did you mean "Helped-by:" not "Acked-by:"?  "git
shortlog git-send-email.perl" does not show that name as one of the
major stakeholders who would be capable of giving an Ack on it.

> ---
>> It's been four years, but I recently ran into this. I mistakenly thought
>> that git would actually pick up cc addresses also from Reported-by, so
>> the reporter ended up not being cc'ed. Is there any chance this could be
>> revisited,
>
> Here's a refresh if desired.  I still think it's sensible.

What the patch tries to achieve may make a lot of sense.  I however
do not necessarily think this particular implementation does,
unfortunately.

These "Random-by:", especially the ones that the author adds on his
own initiative like "Reported-by:", are often followed by just a
name but not an addresses.  A "Signed-off-by:" and "Cc:" that is not
followed by a valid e-mail address may deserve to get an error (or
perhaps an end-user interaction "This is not a valid address. What
do you want to do about it?") so "/^(Signed-off-by|Cc): (.*)$/i"
does not need its own sanity check on $2, because a later call to
extract-valid-address or extract-valid-address-or-die will take care
of it.

It would however be wrong to cause the program to error out or even
bother the user upon seeing such random trailer lines that the
author did not mean to have an e-mail address on it in the first
place.  If you have a trailer line

    Random-by: Joe Perches

without an address, I suspect you will end up adding "Joe" and
"Perches" as two addresses on the Cc: line, which is most likely not
what the user intended [*1*].

As to the lingo, these are still not signatures, but during the past
years, it seems that we settled on using the term "trailers" for
these e-mail header-like things at the end of the log message.
"Trailers" are not limited to "*-by:" so this patch is not about
adding auto-cc to all trailers--a retitle would be

    send-email: add auto-cc to addresses that appear on *-by: trailers

or something (and the option and variable names may need to be
updated to match).


[Footnote]

*1* I further suspect that the existing code shares a similar issue.
Don't Cc: and Signed-off-by: expect a single address on each line in
the usual fashion?  Perhaps a two-patch series whose first part does

-		if (/^(Signed-off-by|Cc): (.*)$/i) {
+		if (/^(Signed-off-by|Cc): (.*<[^>]*>)\s*$/i) {

to tighten it (so that "Cc: Joe Perches" would not result in two
pieces of mail sent to Joe and Perches), with your patch as a follow
up, may be a good way forward.

I dunno.
