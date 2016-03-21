From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH][Outreachy] branch -D: allow - as abbreviation of @{-1}
Date: Mon, 21 Mar 2016 10:47:49 -0700
Message-ID: <xmqqtwjzn2nu.fsf@gitster.mtv.corp.google.com>
References: <1458573317-15532-1-git-send-email-elena.petrashen@gmail.com>
	<vpqfuvju4km.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Elena Petrashen <elena.petrashen@gmail.com>, git@vger.kernel.org,
	sunshine@sunshineco.com
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Mar 21 18:47:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ai3vp-0004H5-He
	for gcvg-git-2@plane.gmane.org; Mon, 21 Mar 2016 18:47:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757367AbcCURrx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2016 13:47:53 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:56874 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757127AbcCURrw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2016 13:47:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 59D274E059;
	Mon, 21 Mar 2016 13:47:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+H1eN9JvOvY4fhT3rOz1okXiJ9I=; b=M0Ce6u
	p2JEVqOuY6se2BZJdyx011GI4kO4WQG/TD88UwBRp7vmjOsprFjjkI/cl1CwOzMJ
	HDJeeYNFHE+1HPiJzenAZIFMT/I4ddXdE/dqEeWb8SegEbXBOwE6Ra8n8STudOEf
	CMr0jZVlhSZTTrn0CDaml1Hwz9ZnTn6GVBDxY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cQ4GhXfq+2PWRLQmervRZ+BtG854+r6/
	lznWfx6jxdq+H9WbfXhhIEkgCOIxrAaJ/EzZny/Px34gwXyXfh67lDwZAiEJN33n
	sGdYJ1g+3XJTUc+U14bARk74opM8T47I0Nlt14Jeov2tsQMxRBY27uAxM00hFtCQ
	TaTZDjcZ9oU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 525904E058;
	Mon, 21 Mar 2016 13:47:51 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B5F8F4E055;
	Mon, 21 Mar 2016 13:47:50 -0400 (EDT)
In-Reply-To: <vpqfuvju4km.fsf@anie.imag.fr> (Matthieu Moy's message of "Mon,
	21 Mar 2016 18:24:41 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 07FF864A-EF8D-11E5-AF05-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289428>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> But I'm not sure how often people want to delete (force-delete according
> to your message) the branch they just come from.

One that I heard was this sequence:

    $ git checkout -b work master
    $ work work work ...
    $ git checkout master
    $ git merge work
    $ git branch -d work

where their argument was that they are done with the work branch,
and it no longer is needed.

As you may be able to guess, I don't personally subscribe to that
workflow (I'd keep the topic a lot longer, until the result of the
merge is proven to be good in the field), but probably these people
are more perfect developers than I am ;-)

> It might be less
> dangerous to give incentive to the user to spell the branch name
> completely to avoid mistake. As analogy, my shell knows "cd -" but I
> can't "rm -fr -" and I'm happy about it.

That is indeed an interesting analogy.
