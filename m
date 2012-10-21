From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git fetch documentation problem or bug
Date: Sun, 21 Oct 2012 12:30:38 -0700
Message-ID: <7vk3ujfwrl.fsf@alter.siamese.dyndns.org>
References: <CAB9Jk9Ac06sfFMGizRq6Ztqd2tKS7BBqGOC891=z4615J3f4hA@mail.gmail.com>
 <7vfw5olqp9.fsf@alter.siamese.dyndns.org>
 <7vbogclqm6.fsf@alter.siamese.dyndns.org>
 <7vpq4silou.fsf@alter.siamese.dyndns.org>
 <CAM9Z-nnKTq0C9wPA=JKZ3qzTmL3NVisfy=rbjjq1yKEVrN53FQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Angelo Borsotti <angelo.borsotti@gmail.com>,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
To: Drew Northup <n1xim.email@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 21 21:30:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQ1Eb-0006Q7-Eq
	for gcvg-git-2@plane.gmane.org; Sun, 21 Oct 2012 21:30:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754334Ab2JUTam (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Oct 2012 15:30:42 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45733 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754228Ab2JUTal (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Oct 2012 15:30:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B32409AEA;
	Sun, 21 Oct 2012 15:30:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WZPZqdH+6e+WB8i96GSjP2D22do=; b=iLHvn+
	2DRL1F7XAazc2qWlG/UGiA7BhqvyEd67UXaPBhRyga7WJpa5Bhmh+mkfpFfxftUS
	fgXa7fS+F9zYTjbMO8Dhy4FCsO1wLq1h6WtXVJ4LU8B2ret5wxmr4q1ldjCsZ9oa
	q/20djwikabTpTgwD4fAbc+inkpPJrekrTtcU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jMz3Gci96oL+aIL6GBbA4vIyHqbcAdAs
	qq3TCgQLYIcVYn2vplhclWHUWZCnW8mqL1k/3PtEUdPXLuwT7x0NFhntvL69kS3h
	XgA9oGAcs0x+GSpe66hBxowXN+dnQLvyokDPHGRA7d+Y3Rik/So0ZzuPjLHjeqHg
	ljGm11HMEOU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A03439AE9;
	Sun, 21 Oct 2012 15:30:40 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9CFEA9AE7; Sun, 21 Oct 2012
 15:30:39 -0400 (EDT)
In-Reply-To: <CAM9Z-nnKTq0C9wPA=JKZ3qzTmL3NVisfy=rbjjq1yKEVrN53FQ@mail.gmail.com> (Drew
 Northup's message of "Sun, 21 Oct 2012 08:15:41 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CBC91514-1BB5-11E2-95DE-9A8C2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208140>

Drew Northup <n1xim.email@gmail.com> writes:

> On Mon, Oct 8, 2012 at 7:33 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>> I personally do not think the downside of breaking backward
>> compatibility is too bad.  If we do this only when we already are
>> configured to keep remote tracking branch for branch $branch from
>> remote $from (it has to be given as a nickname, not URL that happens
>> to have an entry in the configuration), then a promiscuous fetch
>> that grabs from a URL (or a nickname that is configured not to keep
>> tracking branches) will not change any behaviour, and when you want
>> to keep your remote tracking branch intact while doing one-shot
>> fetch for whatever reason, you can say "git fetch $from $branch:" to
>> explicitly decline copying.
>
> How are we supposed to remember those are different?
>
> "git fetch $from $branch..."
> VS
> "git fetch $from $branch:"

I do not know what you meant by the three dots, but you are supposed
to know what you meant by $branch... whatever it is.  It is what you
wrote, not I did ;-)

Let me clarify what is in the message you are responding to.

	git fetch $from $branch

(no colon in $branch part anywhere) traditionally meant a short-hand
of saying

	git fetch $from $branch:

I.e. "fetch $branch and store in FETCH_HEAD but not anywhere else".

The hypothesized change is to make it a short-hand of saying

	git fetch $from $branch:refs/remotes/$from/$branch

when "git fetch $from" is already configured to store the result
there. 

Without [remote "$from"] fetch = refs/heads/*:refs/remotes/$from/*
configured, it will still mean "git fetch $from $branch:".

And for the record, I am *not* enthused about such a change.  I am
only saying that, seeing that many new people seem to wish the
command behaved that way, such a change would not hurt existing
users too much.  Switching the meaning of shorthand (i.e. a piece of
refspec that does not have any colon) from "just fetch but do not
store" from "fetch and store in the remote tracking ref if it is
configured to do so without command override" is still a backward
incompatible change.

> I strongly prefer EXPLICITLY setting tracking than expecting some
> extreme syntactic nuance to quietly do it for me now and confuse the
> heck out of me later.

This is not about your preference.  This is about what happens when
you say something on the command line to override your explicit
setting you have in $GIT_DIR/config

	[remote "$from"] fetch = ...
