From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jan 2009, #02; Sun, 11)
Date: Sun, 11 Jan 2009 12:24:07 -0800
Message-ID: <7veiz9siag.fsf@gitster.siamese.dyndns.org>
References: <7v63kmtbk6.fsf@gitster.siamese.dyndns.org>
 <20090111122128.GA16108@myhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alexander Potashev <aspotashev@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 11 21:25:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LM6sM-0003BW-Gs
	for gcvg-git-2@gmane.org; Sun, 11 Jan 2009 21:25:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752618AbZAKUYQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jan 2009 15:24:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752538AbZAKUYP
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jan 2009 15:24:15 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:58555 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752363AbZAKUYP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jan 2009 15:24:15 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id C889E1C446;
	Sun, 11 Jan 2009 15:24:13 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 7AFCB1C445; Sun,
 11 Jan 2009 15:24:10 -0500 (EST)
In-Reply-To: <20090111122128.GA16108@myhost> (Alexander Potashev's message of
 "Sun, 11 Jan 2009 15:21:28 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: CFED3EFE-E01D-11DD-A636-2E3B113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105220>

Alexander Potashev <aspotashev@gmail.com> writes:

>> * jc/maint-format-patch (Sat Jan 10 12:41:33 2009 -0800) 1 commit
>>  + format-patch: show patch text for the root commit
>
> My testcases ([PATCH] Add new testcases for format-patch root commits)
> for this don't satisfy the target behaviour.

I thought I squashed the test case from your original to it and they seem
to pass for me, but maybe you are talking about some other tests?  If you
know of breakages please send in incremental updates.

>> * ap/clone-into-empty (Fri Jan 9 02:24:23 2009 +0300) 2 commits
>>  - Use is_pseudo_dir_name everywhere
>>  - Allow cloning to an existing empty directory
>
> As far as I understood from your message, you don't think that cloning
> into empty directories is necessary. So, I thought, the best solution for
> yesterday was "[PATCH] add is_dot_or_dotdot inline function" (to make you
> happy ;)).

I merely said "I am not particularly interested in it."  That's quite
different from "I oppose and reject".

As long as the new feature is maintainability-wise low-impact and does not
hurt users who do _not_ use it, I am not opposed to have a new feature
even when I see it is only narrowly useful.

If a topic brings in a large change that helps to support only one
particular workflow better, while making it cumbersome to update the
resulting code to support some other workflow later, even if the change is
useful for users of that one particular workflow, I may oppose it.  It
would be high-impact from the maintainability point of view [*1*].

But I do not think your "clone here" falls into that category.

It is really up to you to follow through with it, and people with similar
needs to cheer you on.  I thought you took a good strategy to first get
dot-or-dotdot in (which is generally useful), hoping to bring up the
"clone here" topic again by building on top of it later.

> Btw, I've sent some worthwhile patches, I but haven't got any reply from you:
> 	[PATCH] use || instead of | in logical expressions
> 	[PATCH] Replace deprecated dashed git commands in usage
> 	[PATCH] remove unnecessary 'if'
> It's better if you say "No" than nothing.

I do not recall the last one.

The first one I thought was a trivial janitor patch that (1) didn't matter
very deeply but made things somewhat easier to read, and more importantly
(2) you had "oops" reply to yourself.

I often clean up trivial "oops" in a patch that fixes bugs or adds
features to avoid extra round trip with the contributor, but that is only
when bugfix and enhancements are worthwhile by itself.

The purpose of a clean-up patch is to clean things up.  If it itself has
"oops" in it, that fails its own criteria of goodness.  Please don't
expect/force me to spend time cleaning up "oops" in a clean-up patch, but
submit a replacement I can apply straight out of my mailbox.

The second one I was expecting to hear from people who were involved in
the discussion back when we standardized on dashless form to show hands as
I recall these messages were deliberately left with dashed form for some
reason (perhaps to help avoiding "man git foo" vs "man git-foo"
confusion).

[Footnote]

*1* Such a change probably needs to be justified either by showing any
other workflow does not make sense (so supporting that one true workflow
well is sufficient) or by demonstrating that support for some other
equally valid workflows can be included trivially, or both.
