From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Project idea: strbuf allocation modes
Date: Fri, 18 Apr 2014 17:55:19 -0700
Message-ID: <xmqq38hab0js.fsf@gitster.dls.corp.google.com>
References: <vpqr457omgs.fsf@anie.imag.fr> <53512DB6.1070600@alum.mit.edu>
	<xmqq8ur2d04g.fsf@gitster.dls.corp.google.com>
	<5351854E.1080602@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sat Apr 19 02:55:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WbJZR-00011Z-AM
	for gcvg-git-2@plane.gmane.org; Sat, 19 Apr 2014 02:55:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754661AbaDSAzY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Apr 2014 20:55:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46322 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753922AbaDSAzX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Apr 2014 20:55:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BB1097D748;
	Fri, 18 Apr 2014 20:55:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yUhojPrYgVsr/hoNGD9BVAL/0EY=; b=a3ALkp
	Bi7gHcnkQyJaChF0qOURfseC9a+gzPH0onI7rmt1rrsCvncVB5x119/vyGlfRCbv
	7GWa8+WlNqfkDVRdMkPN+XdSQaL2dLepyMMI1MdXeVO13a1fD+E6Bn3rBBqwnHl6
	bHjJjfZddH40QeJTcR94p1+i5uV6LJJh8++rE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=P4vqmQrr7PReFvD9UcelLZx0TkQsZYyW
	1eKmiDBm/FGRhHugzoY10bIvnTb3Dt8ZbsM45DLjmODl0eWaOQpDiO5rgibrvWS2
	XFrWuHX3IUoXEoDSR0kX4FgR3YA2u4O48Dhtgkl0Rma5yhxBH+zU8w7uINElIIEr
	cGgQLv8swAk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9FD787D747;
	Fri, 18 Apr 2014 20:55:22 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 18C397D746;
	Fri, 18 Apr 2014 20:55:21 -0400 (EDT)
In-Reply-To: <5351854E.1080602@alum.mit.edu> (Michael Haggerty's message of
	"Fri, 18 Apr 2014 22:04:30 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 4860EEE0-C75D-11E3-ADCC-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246494>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> On 04/18/2014 07:21 PM, Junio C Hamano wrote:
>> Michael Haggerty <mhagger@alum.mit.edu> writes:
>> 
>>> The Idea
>>> ========
>>>
>>> I would like to see strbuf enhanced to allow it to use memory that it
>>> doesn't own (for example, stack-allocated memory), while (optionally)
>>> allowing it to switch over to using allocated memory if the string grows
>>> past the size of the pre-allocated buffer.
>> 
>> I'd like to see these characteristics, but I would want to see that
>> this is done entirely internally inside the strbuf implementation
>> without any API impact, other than the initialisation.  I do not
>> ...
>
> I think that's exactly what I described.  The only thing that would have
> to change in the strbuf behavior (aside from initialization) is that a
> buffer-growing operation might die if the string would grow outside of
> the bounds of the existing buffer when STRBUF_FIXED_MEMORY is set.

Yup, we are in agreement ;-)

More seriously, sorry for sounding as if I was objecting. I should
have edited s/but/and/ before sending my response out.

Thanks.
