From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] - "git commit --amend" commits, when exiting the editor 
 with no changes written
Date: Tue, 02 Feb 2010 15:44:03 -0800
Message-ID: <7vfx5j19vg.fsf@alter.siamese.dyndns.org>
References: <76c5b8581002021207y3eccdc19i9a4abcc3d04315f0@mail.gmail.com>
 <8c9a061002021214j673afbc8vfa5d941fba518648@mail.gmail.com>
 <32541b131002021227o1ec9f369w6096e85382857b8a@mail.gmail.com>
 <76c5b8581002021247j6df8f609ld9e5d87a060a5423@mail.gmail.com>
 <394FB581-C9B9-40AB-AFB6-39B68ED5BEAD@wincent.com>
 <76c5b8581002021356m52bb1817k9a4a29da0d4b681d@mail.gmail.com>
 <77153A83-158D-4D36-A622-7AA3947C7D52@wincent.com>
 <76c5b8581002021431o2b5073a0s42b273b6d61893db@mail.gmail.com>
 <alpine.DEB.1.00.1002022356460.4985@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eugene Sajine <euguess@gmail.com>,
	Wincent Colaiuta <win@wincent.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Jacob Helwig <jacob.helwig@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Feb 03 00:44:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcSQ3-00042o-1h
	for gcvg-git-2@lo.gmane.org; Wed, 03 Feb 2010 00:44:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755797Ab0BBXo1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2010 18:44:27 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:42506 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755782Ab0BBXoX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2010 18:44:23 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 462E396E03;
	Tue,  2 Feb 2010 18:44:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vl8OOr7g1hmHdKIqhGmeYg6FfU0=; b=do40pf
	FCt4NoTwRAOz+cXXB3PFK5bF91EaCLiFtoA8tuw7FshCsj6eaqyKg+9fHqgzbhiS
	sP7Ikxu/EDL7ZiOeOTALEEH0/zOmddH6YF/3J0MF5FBdhLUJ7DtrwrOt936c1fT9
	2soFU03bOgWA4qDHcTOcI/xfpD+/Y+frp0Cn0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ai145VLZcIWzbJpg9/+7APX++Glqfpaa
	oOpwC1gdZu6Z/jxtFzI03mhJTwEeob0M3doPZTV2LjHQQb/RpNURxffmisFnT5dx
	T9Nsk6m41T8GLpHZpJBbUtCo4FV95g+xBkhzuH2SewUuXMhzs3rUW2D4F0taQmpM
	A0/l40EXaqA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D67A096E02;
	Tue,  2 Feb 2010 18:44:12 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A3F7E96E00; Tue,  2 Feb
 2010 18:44:05 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.1002022356460.4985@pacific.mpi-cbg.de>
 (Johannes Schindelin's message of "Wed\, 3 Feb 2010 00\:00\:26 +0100
 \(CET\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: DDC6B6C8-1054-11DF-88CE-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138785>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> No. If not saving, then it means that the user was fine with the message 
> as-is.
>
> Remember, --amend is usually for amending the _content_ of the patch, not 
> so much the message.

I very often use --amend to update only the message, so I would strongly
disagree with the "usually".

But that doesn't change my conclusion ;-) It is immaterial if you amended
the tree or the message.  If either or both changed, we do need to create
a new commit---there is no question about it, so which one is more often
done does not matter.  Eugene does not gain anything by "Remember"ing it.

What is more important is what to do when neither changed.

If you run "rebase -i" and leave the earlier "pick"s intact, it seems to
try keeping the commits intact, instead of rewriting.

It is understandable if somebody wanted to keep using the old commit
object when the committer timestamp is the _only_ thing that is different
between the original and the amended commit, after "git commit --amend" is
run.  Essentially, the behaviour of "rebase -i" for earlier "pick"s comes
from the same motivation.

Right now, if you run this in a loop:

    while hell has not frozen over
    do
	git reset && EDITOR=: git commit --amend
    done

it will keep generating almost identical commits, except for their
committer timestamps.  The very first one may have different committer
identity from the original if you are amending somebody else's commit, but
after that it will be all you over and over again, only at different
times.

I am inclined to say that it is a feature that it updates the commit in
such a case to record the _last time_ you touched the commit.  You ran
"commit --amend" and did not use the any published method to _abort_ the
amend.

As mentioned already, @{1} is your friend.  Regardless of the difference
between @{0} and @{1}, it is a way to go back to the previous commit if
you do not like the latest commit for whatever reason; the latest commit
may have a "wrong tree", a "wrong message", or a "wrong committer
timestamp".
