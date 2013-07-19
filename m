From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Delete current branch
Date: Fri, 19 Jul 2013 09:48:06 -0700
Message-ID: <7vppuewl6h.fsf@alter.siamese.dyndns.org>
References: <CALkWK0=8q4J2yi2to_+41kJSA5E59CBwkG69Hj7MmTPgUnSh5Q@mail.gmail.com>
	<7vr4euy4c6.fsf@alter.siamese.dyndns.org>
	<CALkWK0m-q=Aoof62zhXnUYsJ7PQZwTLbQ50BUEmufVO4gtWNUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 19 18:48:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V0Dqo-0001H8-MC
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jul 2013 18:48:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760148Ab3GSQsK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jul 2013 12:48:10 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54532 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750989Ab3GSQsJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jul 2013 12:48:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A69912F8B6;
	Fri, 19 Jul 2013 16:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=z5Yn/tym469ko7xRrHM9NO4HPPI=; b=MOHXPg
	NAZMjxmkcESgN//AaRPh8RpM+GnDeNrEWcEOkrNTrvBWdwmlB+6kmcUOLFrC98GF
	Dh/yB+sVdEgtebyCkiPdPVC+gBH1/6s+O4nOdnct9gAhsrq/sJjdGn+LxiGVM4Mz
	qqhpGJf4GKPjasBLjM2oSif7I8eVoIBq3i0TM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AAHPERdAvewgf3X4rTxIlxBmEKYFCpkt
	NVzIcVIursQ6kyOBn7S15tbQo31gxHIfZEI+YahuEaOIJwOwNREOenmxI7E7dyyw
	4jeBloi3O8oKXLo8c37FYOQz3Tmm1gljOprK5dhXqUiaGdT0yS6q1jwDWOO/EDWN
	5Hap+WSUeVs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 93B162F8B3;
	Fri, 19 Jul 2013 16:48:08 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F20172F8B2;
	Fri, 19 Jul 2013 16:48:07 +0000 (UTC)
In-Reply-To: <CALkWK0m-q=Aoof62zhXnUYsJ7PQZwTLbQ50BUEmufVO4gtWNUA@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Fri, 19 Jul 2013 21:12:02 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FD4B9212-F092-11E2-BC5C-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230828>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Junio C Hamano wrote:
>> Did you know that the general way to spell the branch previously you
>> were on is "@{-1}" and "checkout -" is an ugly special case that is
>> possible only because "checkout" does not happen to take a "-" as a
>> valid argument that means something else (like the more usual "read
>> from standard input")?
>
> I disagree that it is ugly: it's a very commonly used shortcut that I
> like.

It does not matter if you like it or not ;-).

I do agree that "checkout -" is 100% more pleasing to the eye than
"checkout @{-1}" from visual "prettyness" point of view.

But there is a very commonly accepted long tradition for "-" to mean
"read from the standard input", so we cannot reuse it to mean "the
branch I was previously on" for every command without first making
sure the command will never want to use "-" for the other common
purpose.

That limits the context we could use "-" and we cannot consistently
use it everywhere. I find _that_ ugly from the "design cleanliness"
point of view.
