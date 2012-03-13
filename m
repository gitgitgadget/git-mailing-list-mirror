From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fmt-merge-msg: show those involved in a merged series
Date: Mon, 12 Mar 2012 18:55:22 -0700
Message-ID: <7vipi9mfhx.fsf@alter.siamese.dyndns.org>
References: <7vvcmj68iz.fsf@alter.siamese.dyndns.org>
 <CA+55aFzQ3+EFBVyE9PWOyH0XEC_oW+kUaBTYfixmi2wgMmiZvw@mail.gmail.com>
 <7vipii27ka.fsf@alter.siamese.dyndns.org>
 <CA+55aFw-sS_p7JXNXbSbpiwh9_bZhSrTtC3is4NtLa_n9Hzk5A@mail.gmail.com>
 <7vmx7uzq8h.fsf_-_@alter.siamese.dyndns.org>
 <20120312071121.GA17269@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org, Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 13 02:55:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7GxX-0004uZ-1Z
	for gcvg-git-2@plane.gmane.org; Tue, 13 Mar 2012 02:55:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758494Ab2CMBz0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Mar 2012 21:55:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34437 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758433Ab2CMBzZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2012 21:55:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AAEF87473;
	Mon, 12 Mar 2012 21:55:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XqX4R1sXV932xYsGHHdvLZ+Apfg=; b=tSf2HY
	WJK+M4N94ZGC04SaI5UK4N0D1pqI21Rh+N2ryyqfkZrvXrEJM0jp4305gdiSs0A+
	ubHcSN7jjd8jE577ST4JG+tSjQ3glooPEl2w2h+vh4+MpN/jDVCgEDZ/o1RWxWTZ
	7l76fE5XFeyIUJSrRwP5NBHnmpUdT6srGj3u0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=U76+ywjPW4MeKnNGPCNeBM6EJCvtNG0D
	9MrjZLPYB7jaoxK0VH6m1hTVHznYgWWp/2PE022r7MGMHa23jajaEydbecvEk338
	lw+Mj1ih4mSJBq7QHFV33/zXqSDfkkpaQjH7H++ZTsMr2mHs1pyLme5r5jNMRqso
	WQJeJ55wb34=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 927707471;
	Mon, 12 Mar 2012 21:55:24 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EB78A7470; Mon, 12 Mar 2012
 21:55:23 -0400 (EDT)
In-Reply-To: <20120312071121.GA17269@burratino> (Jonathan Nieder's message of
 "Mon, 12 Mar 2012 02:11:22 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 98FF3C7C-6CAF-11E1-8B53-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192968>

Jonathan Nieder <jrnieder@gmail.com> writes:

> ....  As a person reading the history, I admit I don't like it.
> I enjoyed being able to get a simple overview at a higher level of
> what has been happening in "pu" with "git log --merges junio/pu" or
> "git log --first-parent junio/pu", and these extra lines before and
> adjacent to the "* name of topic:" header interfere with that.

I'd hold making that judgement for a several weeks until my eyes get
used to if I were you. I've seen that people (including myself)
react really badly to _any_ change and make loud noises (including
"we will never get used to this updated output, it is horrible!"),
and then eventually get used to it as if nothing happened, and that
happened often enough recently.

In any case, if you only look at "git log --first-parent" output and
search for your own topic, it of course is useless to see your name
there, as you already know.

> By contrast, the
> ...
> descriptions in Linus's repo are very pleasant.

When you compare Linus's history and my history between master..pu,
you are literally comparing apples and oranges.

The merges between master..pu are made several times a day, with a
series of mechanical "merge --no-edit" process and automated tree
tweaking (including but not limited to rerere).  The purpose of
these merges is primarily to reduce the risk of mismerges to master
(and next to a lessor degree), especially when one topic among many
that have been cooking between master..pu gets closer to graduation.
By shuffling the order of topics that are merged between master..pu
so that topics close to graduation come earlier in the fully rebuilt
pu, a mid-point in master..pu is verified to exactly match the tree
of next (otherwise you may have spotted a mismerge to next, and I
did spot a few mismerges to next this way). This also allows earlier
parts of the master..pu to be tested individually.

The purpose of these merges is _not_ about describing what the side
branches are about. Unlike Linus's lieutenants' "for-linus" branch
names, the branch names are often enough to describe that they are.

On the other hand, the merges on Linus's tree are etched in stone,
and he has every incentive to record what happened in the side
branch for the _last_ time with carefully chosen words.

Having said that, I tweaked the automated rebuilding procedure a bit
today, and made it annotate these merges with snippets from the
branch description in the "What's cooking" document, so the commits
on master..pu are hopefully "very pleasant"ly annotated.  This not
only prettifies the merges between master..pu, but more importantly,
would save effort to explain the merges when a topic finally hits
master. If I have a good description in "What's cooking", I can then
reuse it in these merges and also in the release notes.

The update to the rebuild procedure is not published yet. I'll be
playing with it for a few days before publishing the changes.
