From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git grep: search whole tree by default?
Date: Wed, 23 Oct 2013 11:52:06 -0700
Message-ID: <xmqqob6fq0q1.fsf@gitster.dls.corp.google.com>
References: <CAA01CsqgNKdDAc9OL9zdk=3tnK9GAG=6w+wP_XSoiefBOgfzRQ@mail.gmail.com>
	<vpqbo2guff7.fsf@anie.imag.fr>
	<xmqqmwlzrjdh.fsf@gitster.dls.corp.google.com>
	<87hac7hmrb.fsf@mcs.anl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Piotr Krukowiecki <piotr.krukowiecki@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jed Brown <jed@59A2.org>
X-From: git-owner@vger.kernel.org Wed Oct 23 20:52:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZ3XT-0002zb-7d
	for gcvg-git-2@plane.gmane.org; Wed, 23 Oct 2013 20:52:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751719Ab3JWSwK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Oct 2013 14:52:10 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47658 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751480Ab3JWSwJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Oct 2013 14:52:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 240C24D520;
	Wed, 23 Oct 2013 18:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RVBR8rU8IChAwb49DYfroPXDQSw=; b=ABZv3H
	fVgfNoqxRZPx2AcDqiUh7rSru7IUT1rriN3f/T2cvv9tM3Tq0X061Q8SmkzEMOQo
	OwbhXiPLJE/AKueVT/CcC+6cwB91roMJXeuqWPtwTJHmd+OoWET2HkP/SxEBIlCJ
	SLqSAcGZNi/rU1MCp1o+iQeYVQQ2+NXSjuB+g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LqYEPlMfWt7bFKhbi25iRP3TmHwyyt5R
	hbpdqK8LrjH7/Fe5QyAaElBAJ3589/P8GMAq9ptsNfEGyo8Brsqxrg2cYNjUQxIN
	FkT+pSsgTDtBQh9Ea6E2uhR6K7Dy1T0zIIviyw43w1d580DswLJuH/DyqnPnUBLG
	U8GmvQ2gh8I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 13D1F4D51F;
	Wed, 23 Oct 2013 18:52:09 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7115B4D51C;
	Wed, 23 Oct 2013 18:52:08 +0000 (UTC)
In-Reply-To: <87hac7hmrb.fsf@mcs.anl.gov> (Jed Brown's message of "Wed, 23 Oct
	2013 13:20:56 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 37D19504-3C14-11E3-BD1C-8F264F2CC097-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236548>

Jed Brown <jed@59A2.org> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>> I suspect that it would be too late for 2.0 we want to do sometime
>> early next year, though.
>
> How would you manage transition from the current behavior?  Warning
> people to explicitly use "." or ":/" during some interim period sounds
> worse than just switching the default behavior.

"How would I"?

You're asking that question only because you omitted too much from
the quote ;-)

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> wrote:

> In summary: changing is painful. The case of "git add" was really bad,
> since the same command had different behavior depending on the options
> given, so it was clearly worth the pain. In the case of "git grep", the
> current behavior is not _that_ bad, so nobody bothered to do the change.
>
> (by "do the change", I mean propose a migration plan, convince people
> that it is good, ...)

I agree that it is up to those who really want to switch the
default.
