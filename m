From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Added guilt.reusebranch configuration option.
Date: Thu, 23 May 2013 12:14:27 -0700
Message-ID: <7vobc1ecfg.fsf@alter.siamese.dyndns.org>
References: <1369224677-16404-1-git-send-email-tytso@mit.edu>
	<x2ip2b6udr.fsf@bacon.lysator.liu.se>
	<20130522134212.GB13731@poseidon.cudanet.local>
	<20130522144531.GB2777@thunk.org>
	<7v8v36kiau.fsf@alter.siamese.dyndns.org>
	<20130522180403.GB20848@thunk.org>
	<7vvc6aj14r.fsf@alter.siamese.dyndns.org>
	<20130523021123.GA23155@thunk.org>
	<CALkWK0kyRno4eMYHXC3RkJFCVZ6DJWgFX=pR+WCu8=Gaf9q=Mw@mail.gmail.com>
	<20130523183759.GB1275@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Josef 'Jeff' Sipek <jeffpc@josefsipek.net>,
	Per Cederqvist <ceder@lysator.liu.se>, git@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Thu May 23 21:14:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfayB-0003eV-Be
	for gcvg-git-2@plane.gmane.org; Thu, 23 May 2013 21:14:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758393Ab3EWTOb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 May 2013 15:14:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50272 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758237Ab3EWTOa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 May 2013 15:14:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E941220D70;
	Thu, 23 May 2013 19:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pqau33dXBCVicuTnof6cPZOHBZA=; b=IohgEI
	lDcRoRUu/VULioTDKLvQjSKK9XhXyoiC41zyUg7/8ceQ4lOej0bltoEpN2kHNHIo
	C3pFEyg3mD5JK42Bk138DGJFo1mLhIn3RLMWe/ZLM37mvi78Gv2c11HotPZFh6M1
	mfX3VftB18ikDQ+N+fKte1kgh9UBUZ2Ui2hcA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=diQ5m9yqAZYjYGWhiealpSM1JwlaluBv
	Cdn45TSA/xYvv4zHG72swAshQF6l6ir6grNzBkyB1HuMO4wwbEFP8U05FKwmOnoT
	ylzZJGPVbm+BTSs7iar/HHIDg964mm593AQF0zD3g6Qtt6cnv4TtUsqoGr26ue2X
	z2n/o3LkBP0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DC86420D6F;
	Thu, 23 May 2013 19:14:29 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1FDC120D6C;
	Thu, 23 May 2013 19:14:29 +0000 (UTC)
In-Reply-To: <20130523183759.GB1275@thunk.org> (Theodore Ts'o's message of
	"Thu, 23 May 2013 14:37:59 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FDB7B092-C3DC-11E2-9F86-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225284>

Theodore Ts'o <tytso@mit.edu> writes:

> Spekaing of which, what I'd really appreciate is timestamps associated
> with the reflog.  That's because the most common time when I've
> screwed something up is after doing a "git rebase -i" and so the
> reflog has a *huge* number of entries on it, and figuring out which
> entry in the reflog is the right one is painful.  If could tell at a
> glance when each entry of the reflog was created, it would make it a
> lot easier to untangle a tree mangled by git rebase -i.

Do you mean you want to go back to one specific step in "rebase -i",
or you mean you want to go back to the state before "rebase -i"?

If the latter, one nice thing to know may be that "git log -g" is
like "git log -g HEAD@{0}" and inspects the reflog associated with
HEAD, and you can view individual steps of "rebase -i".  On the
other hand, "git log -g @{0}" (or "git log -g master@{0}" if you are
on 'master' branch) will inspect the reflog associated with the
current branch, and "rebase -i" appears as a single event (i.e. the
tip before rewinding and replaying all the changes is replaced with
the tip after that whole series of replaying).  So the latter is
what you want to use if you are interested in the state before the
whole "rebase -i" operation.

Also you can ask "git log -g HEAD@{now}" and "git log -g @{now}".  I
agree with you that "git log --oneline -g @{now}" is very handy, and
"git log --oneline --relative-date -g @{now}" is even better, as I
can clearly see where the flurry of recent activities ends and which
reflog entry is the one I was at 20 minutes ago before I started.

> This issue with reflogs not having timestamps isn't primarily about
> rewind safety,...

I think I may have answered this part with the above.

> So what I've done in the past is to create a whole bunch of feature
> branches, and then merge them into the pu branch, and then only
> publish the pu branch.  And I try to get the feature branches cleaned
> up as quickly as I have time, so they can appear on the maint or
> master/next branches sooner rather than later.

Sounds very similar to somebody else is doing ;-)

>> Just out of curiosity, do you ever have ref-renaming
>> requirements (like push = refs/heads/*:refs/heads/tt/*)?  We were
>> discussing that on another thread, but I haven't found an
>> implementation I'm happy with yet.
>
> In general, no, I don't do that, for the reasons stated above --- even
> publishing four branches gets to be confusing enough for people who
> are looking at my tree.
>
> I'm sure other people and other communities use git differently, so
> please insert the standard disclaimer that there's more than one way
> to skin a cat.

Agreed to both counts.  Thanks for comments.
