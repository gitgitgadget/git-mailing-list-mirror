From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/6] stash: introduce 'git stash store'
Date: Mon, 13 May 2013 12:16:45 -0700
Message-ID: <7v61ymn10i.fsf@alter.siamese.dyndns.org>
References: <1368449154-21882-1-git-send-email-artagnon@gmail.com>
	<1368449154-21882-5-git-send-email-artagnon@gmail.com>
	<7vbo8fosd9.fsf@alter.siamese.dyndns.org>
	<CALkWK0kMj6q1rppzfxGWrthub4K_+C+jnvF=K4m2Fhk0pAnt7A@mail.gmail.com>
	<7v61ymop61.fsf@alter.siamese.dyndns.org>
	<CALkWK0mQhzrndaEp28nOpLs5STq136PY8hntCpX5RUZKrdJVAA@mail.gmail.com>
	<7vppwun5zk.fsf@alter.siamese.dyndns.org>
	<CALkWK0nmDopEVArofKt42u5JHRBXmGiHP051jhMxtaihWLu95A@mail.gmail.com>
	<7vli7in2wq.fsf@alter.siamese.dyndns.org>
	<CALkWK0nygD7dpwZkXYMuXHhVZpRzb968wAYq-xZrj=y7duL1ZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 13 21:16:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbyEv-0006K2-Rm
	for gcvg-git-2@plane.gmane.org; Mon, 13 May 2013 21:16:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754751Ab3EMTQt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 May 2013 15:16:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56674 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754334Ab3EMTQs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 May 2013 15:16:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8474C1EE18;
	Mon, 13 May 2013 19:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=w4IsfE6Lg9XOGWg/kCX/ZHF/NYo=; b=AhTxGU
	YMbRev6nn/AeyU9zIPuQf9n3Ue1FFr6yHaa1ivNCAisZRRagcBKVDyriVinKwxdO
	LqJp3MMsXgMng5+db7xisR44/VfHGKNqkFzsYd8vl1oAy46dnxK9+xM7dtHML+mV
	+8QAbrmAwHItRSCmr/82Iv5QZz5OqncdVCB9Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eQxRwmMWie8IMZCEfX4T+WT1Oo6jQZ3N
	YlUignPUmFSe5kTXWWa9MM0IUqfD/gZLt1xu00wXc0j3U6AOBLaV2aiO64PE8al/
	OMGwSkU6EARTk2PLQFEJjdQUAoZrNhp1f6Aul8WJimac4+THbG9hI+WFXemKLstp
	T8mWFWN6XjY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7AD0F1EE17;
	Mon, 13 May 2013 19:16:47 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E01881EE14;
	Mon, 13 May 2013 19:16:46 +0000 (UTC)
In-Reply-To: <CALkWK0nygD7dpwZkXYMuXHhVZpRzb968wAYq-xZrj=y7duL1ZQ@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Tue, 14 May 2013 00:15:45 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A7B641C8-BC01-11E2-8627-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224193>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Junio C Hamano wrote:
>> That is not a valid question.
>
> I was just asking to see if you could think of something.  I just did:
> named stashes (each one has a different ref/ reflog) for internal use.
>
> Sure, we'll go with the -m -e approach.

The whole point of my response is that it is not a valid approach to
decide to add (or not to add) a reasonable enhancement mechanism
built in from the beginning by asking "what future enhancement do
you foresee today?".  It is unclear if you got that point.

As long as the end result is to have something that does not paint
us into a corner from which it will be painful to escape, I'll be
happy anyway.
