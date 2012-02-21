From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-subtree Ready #2
Date: Mon, 20 Feb 2012 22:34:22 -0800
Message-ID: <7vwr7gitjl.fsf@alter.siamese.dyndns.org>
References: <877gztmfwy.fsf@smith.obbligato.org>
 <8739acra5j.fsf@smith.obbligato.org>
 <20120215050855.GB29902@sigill.intra.peff.net>
 <87sjicpsr1.fsf@smith.obbligato.org> <87ty2ro1zf.fsf@smith.obbligato.org>
 <20120220205346.GA6335@sigill.intra.peff.net>
 <7vd399jdwc.fsf@alter.siamese.dyndns.org>
 <87ehtowxu7.fsf@smith.obbligato.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Avery Pennarun <apenwarr@gmail.com>
To: greened@obbligato.org (David A. Greene)
X-From: git-owner@vger.kernel.org Tue Feb 21 07:34:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RzjJ2-0006Md-2f
	for gcvg-git-2@plane.gmane.org; Tue, 21 Feb 2012 07:34:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752943Ab2BUGe0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Feb 2012 01:34:26 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34700 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751800Ab2BUGe0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Feb 2012 01:34:26 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1593C7EE2;
	Tue, 21 Feb 2012 01:34:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hGg64WC0lclh9ne6+kFXczcYdOQ=; b=AXs5rT
	p+8x1i6kyJXl4/7S8PuG47ezCNROgOqFx8h4V2j1DlYlyx4ncwMGYZwHrPb/hBNv
	0VU6X9BosRQAUPHl8fn22lPV5WeVSX/uy15ioH1TZjfHxOlIJ3Z0X5+ZsbXtIZ/U
	F7jttY3SkDl5X/em2VXNW1Bv4GloLMXlUdVuI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oKbZ97UlbzzyIpYffL5RVTtI343hK0ZE
	Kysvo1uCQsKat6+FwNvw7JP0IaXhufe40pNXleo7gW0U7dE/D4EGdTxJqqM2mHeZ
	T316jjS6tUniCaFYqO1SWsfRWVKSErjW6pC//o2l2LDfjouePOq9o4l48VFRrwgv
	TnYX61EzdyM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 053187EE1;
	Tue, 21 Feb 2012 01:34:25 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 404BB7EE0; Tue, 21 Feb 2012
 01:34:24 -0500 (EST)
In-Reply-To: <87ehtowxu7.fsf@smith.obbligato.org> (David A. Greene's message
 of "Mon, 20 Feb 2012 23:37:52 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1851732E-5C56-11E1-BAA9-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191135>

greened@obbligato.org (David A. Greene) writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Jeff King <peff@peff.net> writes:
>>
>> It sounds like the simplest and cleanest would be to treat it as if its
>> current version came as a patch submission, cook it just like any other
>> topic in 'pu' down to 'next' down to eventually 'master', with the usual
>> review cycle of pointing out what is wrong and needs fixing followed by a
>> series of re-rolls.
>
> Ok, but we will preserve the history via the subtree merge, yes?

I'll comment on just this part, but a short answer is "no, I do not think
so".

Even though you left "Jeff King writes", you removed everything he said
that I was quoting, and in order to understand why the answer is 'no', it
would have been better if you kept this part from what he said in your
reply:

>> ... Either way, I do think it's
>> worth saving the commit history by doing a real merge.

as that was what I was agreeing to with my "as if ... a patch submission".

>> After looking at the history of subtree branch there, however, I agree
>> that it would not help anybody to have its history in my tree with log
>> messages like these (excerpt from shortlog output):
>>
>>       update todo
>>       Some todo items reported by pmccurdy
>>       todo
>>       Docs: when pushing to github, the repo path needs to end in .git
>>       todo
>>       todo^
>>       todo
>>       todo: idea for a 'git subtree grafts' command
>
> Ok, these are Avery's commits.  I don't know that I have enough context
> to improve the logs but I will look throught revisions and try to figure
> things out.  Avery, could you be of any help here?  It sounds like we
> need more descriptive log messages.

That was not what I was suggesting.

I was saying that the history up to the current state, littered with these
commits that are not "logical progression" but merely "a snapshot of
then-current state" may not be worth preserving, with or without better
messages.

Rewriting the entire history to make it a logical progression just for the
sake of history is obviously not worth the effort.

Which suggests that taking the end result that exists at the tip of your
subtree branch as a single code-drop, without pulling its history, lets us
start from a reasonably well tested state and would not lose us anything
of value.  And that was what I was suggesting.  For our history to explain
why/how the code got there better, another approach might be to instead
treat your bd7b2cf (Add 'contrib/subtree/' from commit '2793ee6ba...',
2012-01-29), which is where you took Avery's then-current state, as the
code-drop event that adds everything in contrib/subtree/ with a single
patch submission. I.e. in a git.git repository:

	git checkout -b subtree master
	git fetch git://sources.obbligato.org/git/git.git subtree
        git merge --squash bd7b2cf
        git commit -m "contrib: add git-subtree from Avery's tree"

to take the tip of your subtree branch.  The history up to that point is
in Avery's repository where he stopped, which such an approach will not
pull in to git.git.  And then we can replay bd7b2cf..FETCH_HEAD like so:

	git checkout FETCH_HEAD
	git rebase --onto subtree bd7b2cf
	git push . HEAD:subtree
        git checkout pu
        git merge subtree

to preserve the history since that single code-drop event that records
your effort to adjust the code-dump into a better shape to live in our
contrib/ area.  That will make it clear the division of blame on the code
added to git.git between Avery (everything before the squashed merge) and
you (everything after that).
