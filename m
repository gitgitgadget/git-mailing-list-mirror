From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Use 'fast-forward' all over the place
Date: Sat, 24 Oct 2009 12:44:36 -0700
Message-ID: <7v3a5860gr.fsf@alter.siamese.dyndns.org>
References: <1256373092-15126-1-git-send-email-felipe.contreras@gmail.com>
 <1256373092-15126-2-git-send-email-felipe.contreras@gmail.com>
 <7v3a587kc2.fsf@alter.siamese.dyndns.org>
 <94a0d4530910241212s5d644eb6u66c6f96feafcaf10@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 24 21:44:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N1mXo-0000zD-0O
	for gcvg-git-2@lo.gmane.org; Sat, 24 Oct 2009 21:44:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752079AbZJXTon convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 24 Oct 2009 15:44:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752053AbZJXTon
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Oct 2009 15:44:43 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:53541 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752023AbZJXTom convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Oct 2009 15:44:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 45E9984270;
	Sat, 24 Oct 2009 15:44:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=oWDhcmI6p1vP
	dUUc6oJInWZs7KM=; b=Ca3TJo1lSWStxtefzd4NhZDFlHfwGuaUreG1W1MGdi+G
	KoOMhGYmXx9xTd/11ezv/QXAVF2awSJzBQld5ncnp0kgQ5tC6pJUbrG1IMYxmYe6
	CDUgffx21X/WpBM/qk59ENeOkb1/wQY3G9j8aLTa8bHoXGsgslPPm/0TFvTVt68=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=uySOb8
	GPHVkk3YIskhPp4MSx/aQMaGDjLMcg6GQrA2zYJfSYVAfE+KxANgbJrxMnqZzpTa
	SiHeRgvOnWM5QZVmv0+cVS/MW+JdQGYoYUjUkzSwI+fc602L2TmpqPqcb66P1H8x
	HpfEEQszeG6wbnt3xT9H1km+0b/5kby0d3gJM=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1BF608426F;
	Sat, 24 Oct 2009 15:44:43 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 973218426E; Sat, 24 Oct 2009
 15:44:38 -0400 (EDT)
In-Reply-To: <94a0d4530910241212s5d644eb6u66c6f96feafcaf10@mail.gmail.com>
 (Felipe Contreras's message of "Sat\, 24 Oct 2009 22\:12\:36 +0300")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: AD000964-C0D5-11DE-BB62-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131176>

=46elipe Contreras <felipe.contreras@gmail.com> writes:

>> I suspect the patch would have been much easier to the reviewers it =
it
>> stated somewhere in the log message:
>>
>> =C2=A0(1) how the mechanical change was produced;
>
> There wasn't such.

That is actually a bad news; it is even worse than mechanical spotting
followed by manual inspection.  It would force us feel _more_ worried, =
as
we would then need to grep for leftovers that your manual conversion ma=
y
not have caught.  Sigh...

>> =C2=A0(2) what criteria was used to choose between leaving the mecha=
nical
>> =C2=A0 =C2=A0 change as-is and rewording them manually; and
>
> If it wasn't straight forward. I considered the following straightfor=
ward:
> fast forward -> fast-forward
> fast forwarded -> fast-forwarded
> fast forwarding -> fast-forwarding
> fast forwardable -> fast-forwardable
> non-fast forward -> non-fast-forward
> Fast forward -> Fast-forward
> Fast forwarding -> Fast-forwarding

All of these are what "s/([fF])ast forward/$1ast-forward/g" does, aren'=
t
they?

> I couldn't parse that. From what I can see "Fast forward" was
> emphasized because the author thought the words didn't make much sens=
e
> separated. Now that the word is fast-forward, there's no need to
> emphasize.

Even after your patch, hunk beginning on line 1384 of the
user-manual says

    ... then git just performs a "fast-forward"; the head of the ...

and I think you did the right thing by keeping these dq here.  This is =
the
first occurrence of the word followed by its explanation and for that
reason, the word deserves to be emphasized---IOW, the context calls for=
 an
emphasis.

In the "Important note!" part, we talk about the pull operation that
normally creates a merge commit, and _in contrast_, under a particular
condition (namely, "no local changes"), it does something different
(namely, a "fast-forward").  We should keep the emphasis on "fast-forwa=
rd"
here for exactly the same reason---the context calls for an emphasis.

I was about to read the rest of the patch (the non-doc part) but instea=
d I
ended up spending another 20 minutes writing this message, so the revie=
w
by me on the remainder has to wait til sometime later.
