From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Mar 2013, #07; Tue, 26)
Date: Wed, 27 Mar 2013 14:47:25 -0700
Message-ID: <7vy5d8jz0y.fsf@alter.siamese.dyndns.org>
References: <7v620dss3j.fsf@alter.siamese.dyndns.org>
 <20130327203535.GA5220@sigill.intra.peff.net>
 <878v58worp.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>, Philip Oakley <philipoakley@iee.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Matthew Blissett <matt@blissett.me.uk>,
	David Aguilar <davvid@gmail.com>,
	John Keeping <john@keeping.me.uk>, Johannes Sixt <j6t@kdbg.org>
To: Jeff King <peff@peff.net>, Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Mar 27 22:47:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKyCJ-0000MJ-Pu
	for gcvg-git-2@plane.gmane.org; Wed, 27 Mar 2013 22:47:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754282Ab3C0Vr3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Mar 2013 17:47:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52027 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752311Ab3C0Vr2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Mar 2013 17:47:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C96EEBC01;
	Wed, 27 Mar 2013 17:47:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fGx+dGinJKUj2tOLF9qCzC8RhR0=; b=xybNqp
	0tWickQUq99fmxr28eAHfq2TpDe7NrdgUyYNXCpsSPj76FTpXVdUrAYQj0suoDCQ
	TRhDm1VTLxJdPYGtkkgzR2pjRr54OODMFr+6m2bsEdjaDd2cm/pWe4VChSa5n2ZV
	5eh41mNZE1oC0TsN3Cq67nxSeyE1BgArdNBqc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ES8hmd+0O4LYRBl02CCGli9SRvXEl024
	gHWuS0tF6XWCOL4itqMTZd7EZhr9hC+AY6+emcAgFQemsCSsmRfXWR4fgnL3qXb7
	ZSxG4l4EFNWVKVSjVdPZDUWM89m1G2UlmErpMdF7hxEPDVVvny6KS0W0StAMVJRV
	QR7b4XsR9XQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BCDE8BC00;
	Wed, 27 Mar 2013 17:47:27 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C6955BBFC; Wed, 27 Mar 2013
 17:47:26 -0400 (EDT)
In-Reply-To: <878v58worp.fsf@linux-k42r.v.cablecom.net> (Thomas Rast's
 message of "Wed, 27 Mar 2013 21:50:34 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EA8358A0-9727-11E2-89B3-CBA22E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219335>

Thomas Rast <trast@student.ethz.ch> writes:

> Jeff King <peff@peff.net> writes:
>
>> On Tue, Mar 26, 2013 at 03:40:00PM -0700, Junio C Hamano wrote:
>>
>>> [Cooking]
>>> [...]
>>> * jk/index-pack-correct-depth-fix (2013-03-20) 1 commit
>>>  - index-pack: always zero-initialize object_entry list
>>> 
>>>  "index-pack --fix-thin" used uninitialize value to compute delta
>>>  depths of objects it appends to the resulting pack.
>>
>> Any reason this is still in pu? I'd have expected it to be fairly
>> uncontroversial and slated for maint.
>
> Me too, along with the other two we found in the same topic:
>
>> * nd/index-pack-threaded-fixes (2013-03-19) 2 commits
>>  - index-pack: guard nr_resolved_deltas reads by lock
>>  - index-pack: protect deepest_delta in multithread code
>>
>>  "index-pack --verify-stat" used a few counters outside protection
>>  of mutex, possibly showing incorrect numbers.

Yes.

Speaking of which... (cc'ed various people involved in the topics
listed below)

> [Stalled]

It may be time to discard all the stalled topics (without
prejudice), except for some.

> * jc/format-patch (2013-02-21) 2 commits
>  - format-patch: --inline-single
>  - format-patch: rename "no_inline" field
>
>  A new option to send a single patch to the standard output to be
>  appended at the bottom of a message.  I personally have no need for
>  this, but it was easy enough to cobble together.  Tests, docs and
>  stripping out more MIMEy stuff are left as exercises to interested
>  parties.
>
>  Not ready for inclusion.

Somebody may want to pick this up to give it finishing touches.

I am reasonably sure that some MIMEy stuff are still leaked to the
output.  From the UI point of view, this does not let you say

    git format-patch --inline-single [<commit>]

with omitted <commit> defalting to HEAD (instead you have to say "-1").

> * po/help-guides (2013-03-03) 5 commits

I know Philip said a reroll is planned, so if it comes, it can be
requeued.

> * mb/gitweb-highlight-link-target (2012-12-20) 1 commit
>  - Highlight the link target line in Gitweb using CSS
>
>  Expecting a reroll.
>  $gmane/211935

Highlighting was cute but the anchor was not.

> [Cooking]
>
> * jc/merge-tag-object (2013-03-19) 1 commit
>  - merge: a random object may not necssarily be a commit

Probably we should eventually merge this as a bugfix to maintenance
track.

> * jk/index-pack-correct-depth-fix (2013-03-20) 1 commit
>  - index-pack: always zero-initialize object_entry list

This is in the same class as the ones you two were wondering about,
I think.

> * jk/difftool-dir-diff-edit-fix (2013-03-14) 3 commits
>   (merged to 'next' on 2013-03-19 at e68014a)
>  + difftool --dir-diff: symlink all files matching the working tree
>  + difftool: avoid double slashes in symlink targets
>  + git-difftool(1): fix formatting of --symlink description

I lost track of various discussions on "difftool" and its "symlink
so that the user can edit working tree files in the tool".

> * tr/line-log (2013-03-23) 6 commits
>  - Speed up log -L... -M
>  - log -L: :pattern:file syntax to find by funcname
>  - Implement line-history search (git log -L)
>  - Export rewrite_parents() for 'log -L'
>  - fixup
>  - Refactor parse_loc
>
>  Rerolled; collides with nd/magic-pathspecs.

Honestly I am not sure what to make of this one.  I'd say we should
merge this down as-is to 'master', expecting that in some future we
would fix "log --follow" to keep the refspecs per history traversal
path, so that this can be more naturally reimplemented.  Objections?


> * jc/push-2.0-default-to-simple (2013-03-18) 15 commits
>  - advice: Remove unused advice_push_non_ff_default
>  - t5570: do not assume the "matching" push is the default
>  - t5551: do not assume the "matching" push is the default
>  - t5550: do not assume the "matching" push is the default
>  - doc: push.default is no longer "matching"
>  - push: switch default from "matching" to "simple"
>  - t9401: do not assume the "matching" push is the default
>  - t9400: do not assume the "matching" push is the default
>  - t7406: do not assume the "matching" push is the default
>  - t5531: do not assume the "matching" push is the default
>  - t5519: do not assume the "matching" push is the default
>  - t5517: do not assume the "matching" push is the default
>  - t5516: do not assume the "matching" push is the default
>  - t5505: do not assume the "matching" push is the default
>  - t5404: do not assume the "matching" push is the default
>
>  Will cook in 'next' until Git 2.0.

At least we should reorder the three test patches near the tip to
come before the "switch the default", and perhaps squash the tip
one and "doc" patch to "switch the default" one, but other than
that, are we ready to commit to this?

> * jn/add-2.0-u-A-sans-pathspec (2013-03-20) 5 commits
>  - git add: -u/-A now affects the entire working tree
>  - add -A: only show pathless 'add -A' warning when changes exist outside cwd
>  - add -u: only show pathless 'add -u' warning when changes exist outside cwd
>  - add: make warn_pathless_add() a no-op after first call
>  - add: make pathless 'add [-u|-A]' warning a file-global function
>
>  Replaces jc/add-2.0-u-A-sans-pathspec topic by not warning against
>  "add -u/-A" that is ran without pathspec when there is no change
>  outside the current directory.

I recall we had a lengthy discussion on this, but how committed are
we on the progression of this series?  Are the bottom four ready to
be merged to 1.8.3, or do they need more polishing?

> * jc/add-2.0-delete-default (2013-03-08) 3 commits
>  - git add <pathspec>... defaults to "-A"
>  - git add: start preparing for "git add <pathspec>..." to default to "-A"
>  - builtin/add.c: simplify boolean variables
>
>  "git add dir/" updated modified files and added new files, but does
>  not notice removed files, which may be "Huh?" to some users.  They
>  can of course use "git add -A dir/", but why should they?
>
>  There seemed to be some interest in this topic, so resurrected and
>  rebased on top of recent documentation updates to propose a
>  possible transition plan.
>
>  Will cook in 'next' until Git 2.0.

The other day I saw somebody at work did "git add ."  (it could have
been "git add dir/") to mark the resolution of a conflicting merge,
when one of the paths should be removed.  It made me wish we had
this already.

I think we discussed this topic in the past a few times, and it is
uncontroversial enough to be in Git 2.0.

Is there any other "we have already well discussed it, we already
know how the implementation would look like if we were to do this,
and we have at least a rough sketch of how the transition may look
like" change we would want to start preparing for Git 2.0?  I am not
asking for pie-in-the-sky proposals (I know you two I am responding
to know this---I am just clarifying for others).

Thanks.
