From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] Add a "fix" command to "rebase --interactive"
Date: Fri, 04 Dec 2009 23:39:37 -0800
Message-ID: <7vd42t6f9i.fsf@alter.siamese.dyndns.org>
References: <cover.1259934977.git.mhagger@alum.mit.edu>
 <4B192701.4000308@drmicha.warpmail.net> <vpqfx7qocwl.fsf@bauges.imag.fr>
 <7vws12r5v2.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.1.00.0912041945161.21557@intel-tinevez-2-302>
 <20091205062708.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Sat Dec 05 08:40:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGpFI-0002pk-16
	for gcvg-git-2@lo.gmane.org; Sat, 05 Dec 2009 08:40:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753280AbZLEHjs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Dec 2009 02:39:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752910AbZLEHjr
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Dec 2009 02:39:47 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:36285 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752865AbZLEHjr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Dec 2009 02:39:47 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4C59B85B04;
	Sat,  5 Dec 2009 02:39:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=//1Rvnf8wnNDjEwyIC7XsX6A+Ss=; b=SaQhVuaKn5r08fms7PhslV+
	s4AxXZakBBOwL05P1xne/SXzwcKqlvSIuIJqjDtyOc7bxQbAKwbd79p22TKdhY6s
	GuOq0kD+GVyd9DasjO0WKaNRzPrJlEqnBUvwDmLySaKKs01UU1Y1wRmJ6GH5iOso
	24Ox9ie2INU9eFfqzID8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=dnuj2c9ur2qoG3ksl/WT9ZX9M6nZSiC5EeoXNOyLHRghE/0nf
	0+J/zPfwgaoW57kxwVIigp446Qz5OaceJRGGMNrbwvnTa1ILlcTOM8YHNET1XYrb
	H1S6ziyqUHiHiqc3gAlNw1jFHF4Ng0DPcnOwJOFen6HojYk2E1vro0qiz8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E328585AFD;
	Sat,  5 Dec 2009 02:39:46 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7CF9D85AFC; Sat,  5 Dec
 2009 02:39:38 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5C949A3C-E171-11DE-B0A3-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134594>

Nanako Shiraishi <nanako3@lavabit.com> writes:

> I think Junio is referring to this thread:
>
>   http://thread.gmane.org/gmane.comp.version-control.git/127923/focus=121874

Yes, that was the one I had in mind, and it is a shame that we somehow
ended up not taking it, perhaps in an improved form, back then.  Even
today alone, I missed the "mark for later fixing/squashing and then rebase
at the end" feature twice at dayjob.

> I too think Michael's "fix" is a good feature, and in the 
> workflow by Shawn, he knows he is fixing up an earlier 
> commit, and he knows he doesn't want to add anything to 
> the message by the fix-up commit when he makes that commit 
> (how else would he have messages like "a", "s", or "foo").

There is a slight distinction between "Shawn's fix-up commits have garbage
message and he does not want any part of them in the final commit message"
and "Shawn is happy with the message of the original commit whose tree
these fix-up commits are meant to correct."  He may still not be entirely
happy with the original message.  Wanting to edit the commit log message,
and not wanting to use the messages from follow-up commits, are two
different things.

I would agree that it is a good idea for "rebase -i" with only "fix" and
not "squash" to skip the editing of the final message.  You manually move,
or tell your "rebase --autosquash" option to automatically move, the
follow-up commits next to the ones they are meant to correct while editing
the rebase-i insn, and you change their "pick" to "fix" (or "fixup" as
Dscho and others suggested in the earlier round you quoted) only when you
know you want to keep the message of the original commit.  Otherwise you
can change them to "squash" not to "fix", and you can edit the final log
message that way.

If Michael rolls his second round with your "--autosquash", or you do so
yourself on top of his patch, I think it _might_ be safer to mark the ones
automatically moved as "squash", and not as "fix", and have the users
explicitly change the "squash" they want to "fix" themselves.
Alternatively, you can also use two magic tokens (i.e. instead of one
"fixup!", allow people to use "squash!" and "fixup!")  and change the
action chosen for the moved commits to "squash" and "fixup" respectively.

> I don't think your objection should block *others* (like
> Shawn and Junio) who can decide when they make commits 
> from using the feature from my old patch to make it even 
> easier to clean up their topics. If *you* can't decide if 
> you want to amend or not when you make a fix-up commit, you 
> can leave your fix-up commits unmarked, run interactive 
> rebase without the --autosquash option, and use Michael's 
> 'fix' manually. People who can sometimes but not always 
> decide when they make commits can do the same when they 
> can't.
>
> Isn't it what Junio suggested by his "on top of this feature", 
> and wouldn't that make everybody happy?

The answer to the first question is "yes"---I did't understand why Dscho
objected to a feature he can choose not to use if he doesn't want to, and
I still don't (unless I was misreading your earlier patch back then and it
somehow forced all rebase-i users to decide upfront at the commit time,
but I highly doubt it).

I don't know about the second one but I am guessing it would also be
"yes".
