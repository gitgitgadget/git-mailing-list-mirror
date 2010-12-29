From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t9001: Fix test prerequisites
Date: Wed, 29 Dec 2010 13:38:54 -0800
Message-ID: <7vhbdws1ht.fsf@alter.siamese.dyndns.org>
References: <1293656551-5463-1-git-send-email-robbat2@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: "Robin H. Johnson" <robbat2@gentoo.org>
X-From: git-owner@vger.kernel.org Wed Dec 29 22:39:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PY3jl-0000zp-8c
	for gcvg-git-2@lo.gmane.org; Wed, 29 Dec 2010 22:39:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753431Ab0L2VjI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Dec 2010 16:39:08 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:34268 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752795Ab0L2VjG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Dec 2010 16:39:06 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id AB7403578;
	Wed, 29 Dec 2010 16:39:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=RiOA7FcwoVtr
	i+0Mezf1Hh9ruP4=; b=yVi2c3lDxCyBzOyM2SU/Q5HEa8D+93pD9SX7SC5Hl4zH
	Rs42au0QIzhbLehN925VBTYB2G6YTPXPy0olePg/UhV+fNqnkUinEhVxrTJwnDeY
	M6QdCmeU383ZzeuxzuucektnTL+mwGFdT8u/LnqevoUEeuWfNDoEmYnYVta/GEY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=qYGS6Y
	Nqrh2HMGE6sJz1AeJ5B6v37yBaGqK3+DxoKCVTTOXpzkWwROpk4p5Msy6IfkqZ+z
	8P7JXe9ScA7JN23uU8jJjCZ+8S6pi/4ZYe1XJ+VehD3pZJ8Os0N7QMVxAQM8rmo7
	YNkK5t9ihyvvtYu+RS3ii6LeU17iRw+PXqGiA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 77C6D3577;
	Wed, 29 Dec 2010 16:39:33 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 27D24356E; Wed, 29 Dec 2010
 16:39:28 -0500 (EST)
In-Reply-To: <1293656551-5463-1-git-send-email-robbat2@gentoo.org> (Robin H.
 Johnson's message of "Wed\, 29 Dec 2010 21\:02\:31 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 20061680-1394-11E0-9728-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164332>

"Robin H. Johnson" <robbat2@gentoo.org> writes:

> Add in missing Perl prerequisites for new tests of send-email.
>
> Signed-off-by: Robin H. Johnson <robbat2@gentoo.org>
> ---
>  t/t9001-send-email.sh |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)

Thanks.

> diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
> index 1dc4a92..3271426 100755
> --- a/t/t9001-send-email.sh
> +++ b/t/t9001-send-email.sh
> @@ -1135,7 +1135,7 @@ test_expect_success $PREREQ '--8bit-encoding al=
so treats subject' '
>  # Note that the patches in this test are deliberately out of order; =
we
>  # want to make sure it works even if the cover-letter is not in the
>  # first mail.
> -test_expect_success 'refusing to send cover letter template' '
> +test_expect_success $PREREQ 'refusing to send cover letter template'=
 '
>  	clean_fake_sendmail &&
>  	rm -fr outdir &&
>  	git format-patch --cover-letter -2 -o outdir &&
> @@ -1151,7 +1151,7 @@ test_expect_success 'refusing to send cover let=
ter template' '
>  	test -z "$(ls msgtxt*)"
>  '
> =20
> -test_expect_success '--force sends cover letter template anyway' '
> +test_expect_success $PREREQ '--force sends cover letter template any=
way' '
>  	clean_fake_sendmail &&
>  	rm -fr outdir &&
>  	git format-patch --cover-letter -2 -o outdir &&

This however makes me wonder (Robin, the following is primarily meant f=
or
=C3=86var to whom 57cd35e (t/t9001-send-email.sh: change from skip_all=3D=
* to
prereq skip, 2010-08-13) is credited, and not a complaint to your patch=
 at
all, but you are welcome to comment on it if you feel like).

Everything in this test seem to require $PREREQ now (test_expect_succes=
s
always takes the 3-parameter form).  Does it suggest that we might want=
 to
allow tests to define a "global prerequisite", e.g.

   GIT_TESTS_PREREQ=3D"PERL"
   export GIT_TESTS_PREREQ

and make the traditional 2-parameter test_expect_success without an
explicit prerequisite take notice?  Would it let us not have to worry
about this kind of breakages?  Or is 9001 a very tiny minority oddball
that must have $PREREQ everywhere and such a test framework feature wou=
ld
be an overkill?

More importantly, 9001 is all about send-email and we know upfront that=
 we
want to skip everything when PERL prerequisite is not met.  Why not a
simple=20

	if ! test_have_prereq PERL
        then
        	test_done
	fi

insufficient?

Who cares "skipped statistics"?  When one does not care about testing
send-email at all, why should one care how many tests on that program a=
re
skipped?  I personally do not think this is worth the trouble, and am v=
ery
close (showing two fingers almost touching) to suggest reverting 57cd35=
e.

Please convince me otherwise.
