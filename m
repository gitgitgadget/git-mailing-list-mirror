From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] push: make upstream, simple work with pushdefault
Date: Thu, 13 Jun 2013 09:48:54 -0700
Message-ID: <7vehc6vtvt.fsf@alter.siamese.dyndns.org>
References: <1370798000-2358-1-git-send-email-artagnon@gmail.com>
	<1370798000-2358-3-git-send-email-artagnon@gmail.com>
	<7vip1moq3k.fsf@alter.siamese.dyndns.org>
	<CALkWK0mesZay8Cpi6yTvhUG=136=9JLyFUZXm8t_fMOrY0F62Q@mail.gmail.com>
	<7v4nd6l31d.fsf@alter.siamese.dyndns.org>
	<CALkWK0mY5=H6FoUZCOXTYykEV1f=3wrP21WPXj1v4VBCeOxocg@mail.gmail.com>
	<7vwqq2j7c9.fsf@alter.siamese.dyndns.org>
	<CALkWK0mfWs3LBocvn=QMcX0_ZCROx4Nw=+xjpCbKLQU0JzSdXg@mail.gmail.com>
	<7vobbdhjeg.fsf@alter.siamese.dyndns.org>
	<CALkWK0mDDKETE1O=g7X5s5MJvU7UA_NQiMNESor_8=phW0WR-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Leandro Lucarella <leandro.lucarella@sociomantic.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 13 18:49:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnAhu-0005Rq-W2
	for gcvg-git-2@plane.gmane.org; Thu, 13 Jun 2013 18:49:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757366Ab3FMQtB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Jun 2013 12:49:01 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65488 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756653Ab3FMQtA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jun 2013 12:49:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7C04326162;
	Thu, 13 Jun 2013 16:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=P4yckFGZcmwHbUO3+8fibcjTUcQ=; b=Py+Ytg
	Mv1SbTktD5RqH0rkLem486SbF8oiTDjyOGC+3SLQYnKz+hucpn572xDVbQPKOV3y
	7eGMR+pNDvZTxWGS50lJVGn+qeDDjGugkCxRHmCERmfwUCWVPoRnQm1FE4heQF8T
	kRjqksctrOvE863ra7KfSjK/IdRldsmNZ1ecs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xDsmVBY2vAFgPtrhXYwn8VvrAcnvt42L
	EPMHeuOfMv/ezoJJa4e0ctZrXvKF8YlGot7/+dIcP+raAboY91ZbZ0rYUoB1EQk5
	ZeNoBSa5cpDpckfnqU4EjYj7SCZ8r3XgKeGZbIJenoUZMwJWVgeWsAABncZuj0LP
	N4g+kN4nUKc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 719F32615F;
	Thu, 13 Jun 2013 16:48:57 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 94FB12615A;
	Thu, 13 Jun 2013 16:48:56 +0000 (UTC)
In-Reply-To: <CALkWK0mDDKETE1O=g7X5s5MJvU7UA_NQiMNESor_8=phW0WR-A@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Thu, 13 Jun 2013 14:40:44 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 23672134-D449-11E2-8DCF-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227746>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Junio C Hamano wrote:
>
>> [...]
>
> Okay, so what you're saying makes sense.

That is not a very useful style of quoting; what did you just agree to?

I think we should step back and clarify the "to which repository the
push goes" and "what branch(es) in that chosen repository is
updated".  The former is determined by your original "triangular"
topic in the recent world order.

The push.default specifies the logic/algorithm to decide the latter,
when there is no stronger configuration is given (e.g. the push
refspecs in remote.*.push, and branch.*.push).

> - current: push "$(HEAD)".  No restrictions on destination.

This updates the branch with the same name the current branch on the
pushing side.

> - matching: push ":" to the destination specified by the current
> branch.

This updates the branches in the destination repository, for which
branches with the same name exists on the pushing side.

> - upstream: In the special case when fetch source is equal to push
> destination, push "$(HEAD):$(branch.$(HEAD).merge)".  Otherwise,
> fallback to current.  Useful in central workflows.

That looks to me as an inconsistent description.  If you are not
pushing to where you fetched from, that is not even central.

This is mean to update the branch that is fetched from and is
integrated with the current branch with the tip of the current
branch, so the branch at the destination repository that gets
updated is branch.$current.merge.  It further means that the
repository being pushed to must be the same as the repository we
fetch from; otherwise it is an error.

> - simple: [still haven't thought about what to do with this; I'm
> generally not in favor of artificially crippling functionality by
> erroring out]

In a central workflow (i.e. repository we fetch from to update the
current branch is the same as the repository we push the tip of this
branch to), this works the same as upstream, but the configured
branch.$current.merge has to be the same as the name of the current
branch in the local repository; otherwise it is an error.

In a triangular workflow TBD, but I think doing the same as current
may be a good starting point.

> Just like upstream respects branch.<name>.merge, current respects
> branch.<name>.push, making branch-level ref mapping in triangular
> workflows possible.

I do not know we want to make branch.*.push linked to current.  If
it is set, shouldn't that apply when push.default is "matching" and
other values?  That is why I threw it in the same category as the
traditional push refspecs in remote.*.push in the early part of this
message.
