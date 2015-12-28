From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] user-manual: remove temporary branch entry from todo list
Date: Mon, 28 Dec 2015 09:29:13 -0800
Message-ID: <xmqqr3i6lbx2.fsf@gitster.mtv.corp.google.com>
References: <1450918023-30309-1-git-send-email-ischis2@cox.net>
	<3065044.ki4VpYSZvR@thunderbird>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>
To: Stephen & Linda Smith <ischis2@cox.net>
X-From: git-owner@vger.kernel.org Mon Dec 28 18:29:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aDbcK-0002p6-55
	for gcvg-git-2@plane.gmane.org; Mon, 28 Dec 2015 18:29:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752092AbbL1R3S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Dec 2015 12:29:18 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:55429 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751371AbbL1R3Q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Dec 2015 12:29:16 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B185F343F4;
	Mon, 28 Dec 2015 12:29:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=V+asdGE7C/JrI03y8zUGj2rFYnc=; b=h8KoV+
	Ta6Enp0+RvV65TMNxD7PK8B1HpaTWw/3DpTPN0M2PKQsPae0YwuNUU9DcnxDXdke
	r9cYysjA95EyTGFoqDJ6Ss0yXUG0PWRwYpgz0VA18lDxnVTjs8g14+05ipO5YpQ9
	5SYvu0mwkoavN1jUKLIOXQ6UOig2kWv5NayNA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=T1/CJzmp/H9y8MBNfQylTKkY2bM8Vl4M
	OSmFvO774qSTacnaiMHWPjcAAmECZkaO8wD2VBbcZk8foQgFI4Kb1Qi/gKnCYzQG
	b8Elti4weIigxyO0+4ZngDHVkEZ30CpO9RGyap8Jt1Fgn7q6uldwhGogAa6XkHKw
	x/duoXMfjKw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9AC9F343F3;
	Mon, 28 Dec 2015 12:29:15 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 17B0D343F1;
	Mon, 28 Dec 2015 12:29:15 -0500 (EST)
In-Reply-To: <3065044.ki4VpYSZvR@thunderbird> (Stephen & Linda Smith's message
	of "Sun, 27 Dec 2015 23:02:31 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 844731EA-AD88-11E5-8E46-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283038>

Stephen & Linda Smith <ischis2@cox.net> writes:

> I think that this is a stale todo.   
>  
> The only place there is a mention of temporary branches (which is
> then parenthetically called a topic branch) is in relation to how
> Tony Luck organizes his work.  Additionally there is already a
> subsection on using a detatched head ("Examining an old version
> without creating a new branch).

I suspect that you stared at the output from "git grep" for
"temporary" or even "temporary branch" and further I suspect that
the experience blinded you.

The two lines in that todo item were first introduced at d5cd5de4
(Documentation: begin discussion of git-remote in user manual,
2007-01-09), and then were updated at b181d57f (user-manual:
reorganize fetch discussion, add internals, etc., 2007-01-27).  In
between these two, the lines were rewrapped at 2f99710c
(user-manual: rewrap, fix heading levels, 2007-01-14) but that
commit was purely cosmetic.

When the todo item was introduced, it ended with a full-stop; the
update changed it to a question mark, which I read it as hinting
that the item might not be a good change.

The output from

    $ git diff -U40 d5cd5de4 b181d57f Documentation/user-manual.txt

gives us a fairly good answer.  When the todo item was introduced,
the "beginning" section was titled "Repositories and Branches", and
showed you how to clone the Linux kernel in its first subsection,
and then the next subsection showed "How to check out a different
version", and showed that "git checkout -b new v2.6.13", followed by
"git reset --hard v2.6.17", are the commands to use for sightseeing
the project's landmarks.

The "new" is used as a temporary branch in the context of that
example; the user is not building anything on top of these commits,
the use of a named branch is ephemeral and the only reason a named
branch is used is because the detached HEAD was a fairly new
invention, introduced at c847f537 (Detached HEAD (experimental),
2007-01-01) and was merged to the mainline at c388761c (Merge branch
'jc/detached-head', 2007-01-11).

After commit b181d57f, aka "Let's keep the todo item for now, but I
am no longer sure if it is a good idea so end it with a question
mark", the "beginning" is a new section called "Git Quick Start",
but the same "git checkout -b new v2.6.15" for sightseeing appears
in this new section.

Another thing to notice is that the "temporary branch" you found in
"git grep" about Tony's workflow did not exist in the user-manual
back in these days.  It was added to the user-manual at 9e2163ea
(user-manual: move howto/using-topic-branches into manual,
2007-05-13), so the todo item couldn't possibly have been referring
to that example.

>> > -Simplify beginning by suggesting disconnected head instead of
>> > -temporary branch creation?
>> > -
>> 
>> What does "beginning" refer to in this sentence, though?
>
> I had that question too even after looking at the 2007 version of the manual.
>> 
>> After a quick reading of the beginning part of the document, I am
>> getting the impression that it refers to the use of the 'new'
>> branch, which is initially created out of v2.6.13 and then later
>> reset to v2.6.17 while the user is in the sightseeing mode.  And
>> this way of working _is_ a remnant from the days back when detached
>> HEAD was not with us.
>> 
>> It is a completely separate matter if it is a good idea to teach
>> detached HEAD that early in the tutorial, though.  
>  
> So are you suggesting a move of the section further down?   
> Or are you suggesting that that is excised from the manual?

Neither.  Because the current text does not teach detached HEAD
early in the tutorial, I see no need to move any section down, or
excising a section.

>> So "remove the task because detached HEAD is a bit too weird
>> thing to learn in that early stage in the learning curve"
>> (i.e. the latter reason) might apply.
>  
> Could it be there are two reasons to remove the todo?

There could be, but I do not think it is the case here.

I do not think "it was already done" is a valid reason for removing
this todo item, as I do not think it was done yet.

I think the only possible reason to remove that todo item is because
teaching detached HEAD that early in the user manual gives a bit too
steep learning curve--and I do not disagree with that justification.
