From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] remote-helpers: fix the run of all tests
Date: Wed, 03 Apr 2013 07:57:04 -0700
Message-ID: <7v8v4z7jcv.fsf@alter.siamese.dyndns.org>
References: <1364850872-21135-1-git-send-email-felipe.contreras@gmail.com>
 <1364850872-21135-2-git-send-email-felipe.contreras@gmail.com>
 <CALWbr2wAqudzbfiSHmD1uAVQX3mtbf5vgr2JXbXEg7yzaKXJcw@mail.gmail.com>
 <20130401234016.GC30935@sigill.intra.peff.net> <515B0D08.4020405@web.de>
 <20130402173652.GC24698@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Antoine Pelisse <apelisse@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 03 16:57:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNP86-0000Vp-6T
	for gcvg-git-2@plane.gmane.org; Wed, 03 Apr 2013 16:57:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762549Ab3DCO5I convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Apr 2013 10:57:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60527 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760353Ab3DCO5H convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Apr 2013 10:57:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D447D12076;
	Wed,  3 Apr 2013 14:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=LcZiYRzXj3GW
	y6in2tmcN1rF5cc=; b=e3HGmtWcdgtH5OKYcVY4qpwFgzRBHidXTVYvUu8b5/xW
	vEIcwczXfbNAtEcMbEsfvytntPMd984PZQE61P6uX8XeJ5JuKdmr+ER/zF5lDT5R
	Sz0Ay3ETyMuL+a/xfqEAD42QTaxoqGbXemAMs4KxzO3owWIn4SvXUb9NOQAXN3Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=PPkmg6
	BrJintUEkFZFZcLSRjNa520iOsnTyatLJZ0A6JlDDXjdP/cvJhD9ZRzN8QkvcLsp
	W/DCDDAw2HHoNrD7KGUA0JYQVHsmxdisI6YX95vrhNg90aIVBvuqTNturoqCAjEy
	QG5hfCEKQucBw4eQhue1xib7hhJWvvY5hkIY8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C76DB12075;
	Wed,  3 Apr 2013 14:57:06 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 47C1012073; Wed,  3 Apr
 2013 14:57:06 +0000 (UTC)
In-Reply-To: <20130402173652.GC24698@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 2 Apr 2013 13:36:52 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C06A5DF6-9C6E-11E2-A924-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219941>

Jeff King <peff@peff.net> writes:

> On Tue, Apr 02, 2013 at 06:53:28PM +0200, Torsten B=C3=B6gershausen w=
rote:
>
>> > I think the check for duplicate-numbers is the only one that does =
not
>> > make sense.=20
>> []
>> Not sure about that, I send a suggestion of a patch in a minute.
>> Highlights:
>> 1) - rename the contrib test cases and assigns real TC numbers
>> 2) - Forward the numbers into the main "test Makefile"
>
> I'm not sure if this is a good idea or not.

If that's a polite way to say that this is not a good idea, I'd
agree for all the reasons you mentioned.

> It puts the
> contrib/remote-helpers into the same "number namespace" as the rest o=
f
> the test scripts, and enforces uniqueness with test-lint-duplicates,
> when "make test" is run from contrib/remote-helpers. But people worki=
ng
> on the main test scripts would not get any such check, and would happ=
ily
> break contrib/remote-helpers by adding duplicate test numbers.
>
> It makes sense to me to either:
>
>   1. Have the contrib/remote-helpers test live in their own test
>      namespace completely, with their own numbers and test-results, a=
nd
>      pull in relevant bits from the main test harness. We do this
>      already with contrib/subtree.  I suggested this when the tests
>      first appeared, but there was some argument, and I don't remembe=
r
>      the details.

This makes more sense than the alternative, given that contrib/
material is "optional" from the main tree's point of view, at least
to me.

Thanks.

>   2. Just integrate contrib test scripts into the main repository, bu=
t
>      leave them off by default. For example, add:
>
>        if test -z "$GIT_TEST_REMOTE_HELPERS"; then
>               skip_all=3D"Remote helper tests disabled (define GIT_TE=
ST_REMOTE_HELPERS)"
>               test_done
>        fi
>
>      to the top of the scripts, and then set GIT_TEST_REMOTE_HELPERS
>      in contrib/remote-helpers/Makefile before chaining to the test
>      Makefile.
