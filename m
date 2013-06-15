From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/6] status: do not depend on flaky reflog messages
Date: Sat, 15 Jun 2013 02:58:33 -0700
Message-ID: <7vobb7lmpi.fsf@alter.siamese.dyndns.org>
References: <1371130349-30651-1-git-send-email-artagnon@gmail.com>
	<1371130349-30651-6-git-send-email-artagnon@gmail.com>
	<7vvc5hubox.fsf@alter.siamese.dyndns.org>
	<CALkWK0kjxKFkrLArL1mLZYCMN1=sgnDSa3vaoJm6eSUp2E4Pyw@mail.gmail.com>
	<7vd2rpu3kf.fsf@alter.siamese.dyndns.org>
	<CALkWK0=NAiGDVWbwHXMmEffPF9wKXd23BdwOntfdvNCpVe8fiA@mail.gmail.com>
	<7vppvosstl.fsf@alter.siamese.dyndns.org>
	<CALkWK0k28u583Jci+Dvad1pbu7_dJdnmz1WBkP790a_t2QdPTg@mail.gmail.com>
	<7v38sksq14.fsf@alter.siamese.dyndns.org>
	<CALkWK0n_Jsb46qPojbGL3S+mPunNQWUOmypQOvdaBjcT5wgJBg@mail.gmail.com>
	<7vsj0kpsb0.fsf@alter.siamese.dyndns.org>
	<CALkWK0==Phbe-9QaOa3jkYMEvxb6F3kypRkk9RbzrLco-HkHKw@mail.gmail.com>
	<7v7ghwmi9x.fsf@alter.siamese.dyndns.org>
	<7v38skmgu8.fsf@alter.siamese.dyndns.org>
	<CALkWK0mCK_-bUapAvcrwtNgGnT1=x1d=+J9RO1GK6ssHWP2ztA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 15 11:58:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnnFp-00046k-3C
	for gcvg-git-2@plane.gmane.org; Sat, 15 Jun 2013 11:58:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753832Ab3FOJ6h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Jun 2013 05:58:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64057 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753548Ab3FOJ6g (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Jun 2013 05:58:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EDE9123449;
	Sat, 15 Jun 2013 09:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WPhT7wWlSqsywUYBSqJWA9lRYPA=; b=Pni1/L
	Ke4g7D3/Yd5BLJUP28JAytEQ3abSg+6itQ25rZxDrhjQQI7Yjdsoc4ACGbVtRy88
	fyC1MAaaXtKRa0jPl22Hs2pNLyx7zKhiIPMTt8P++RlTt9HTcPi0Au+8PEM1lv+w
	2ty0/q2qSR8/tjFGhdn8QETrGSbud+BXU5rXE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=biBLapnau++ymFG/akDkvwME/W4w81kg
	Y3rKkaQY4jlHP3AEbuwmusSK3dJo8t4siGE9zzhc83kdTkw5/cjQSoDtWijxMH6Q
	+sioHiUWS27nC0DNTpdUqApU44tO1k32Jrh2SE2s0mxkbXPx2EQDyQnnjaWlXqP3
	E+GHp/tU75Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E29AE23446;
	Sat, 15 Jun 2013 09:58:35 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 516CD23445;
	Sat, 15 Jun 2013 09:58:35 +0000 (UTC)
In-Reply-To: <CALkWK0mCK_-bUapAvcrwtNgGnT1=x1d=+J9RO1GK6ssHWP2ztA@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Sat, 15 Jun 2013 13:32:51 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 24CDFE1C-D5A2-11E2-BFC9-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227939>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> 2. The following no longer updates status:
>
>   # in the middle of a rebase
>   $ git reset @~2
>
> The constant "HEAD detached at $onto" message is misleading and Bad.
> Besides, wasn't this the primary usecase you wanted?

See the other message.  The first line from status in the middle of
a rebase is secondary.  End-user initiated "checkout" to detach is
the primary thing.

> You previously wrote:
>> *1* One thing I could think of is to start sightseeing or (more
>>     realistically) manually bisecting at a given release point,
>>     reset the detached HEAD around several times, and then want to
>>     be reminded where the session started from.  I do not think it
>>     is particularly a very good example, though.
>
> Whether the HEAD is detached by bisect or rebase is irrelevant.

You read and reacted to "bisect" too literally and missed
"manually".  The scenario I had in mind does _not_ use "git bisect"
command, which may _internally_ run "git checkout" to detach, but
for exactly the same reason why you want to touch "git rebase" in
this series, its use of "checkout" should not count for the next
"checkout -".

The sequence of "manually bisecting" is like

	$ git checkout v1.8.3
        ... test
        $ git status
        $ git log --oneline --first-parent v1.8.2..$detached_from
        ... pick a likely point
        $ git reset --hard $that_point
        ... go back to test further

which I actually do fairly often, as I tend to know more about the
likely place something may have been broken than a mechanical "split
the history into about the same number of commits" bisection.

> 3. The problem is not unique to rebase at all; yet you have
> special-cased it.  If this isn't a band-aid, what is?

It is an illustration for approach (2) in the other message.

In the longer term, you would want richer status output for various
detached state, and that "how about this" patch shows where new code
to support other cases should be added.
