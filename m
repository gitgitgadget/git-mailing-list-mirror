From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Dec 2015, #01; Tue, 1)
Date: Wed, 02 Dec 2015 14:11:32 -0800
Message-ID: <xmqq4mg05wmj.fsf@gitster.mtv.corp.google.com>
References: <20151202002450.GA27994@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Dec 02 23:11:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a4Fcn-0001Qi-98
	for gcvg-git-2@plane.gmane.org; Wed, 02 Dec 2015 23:11:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757178AbbLBWLl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2015 17:11:41 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:55964 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757174AbbLBWLk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2015 17:11:40 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0F8423134A;
	Wed,  2 Dec 2015 17:11:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FTaoWVKyxFPZVUj9gFrREIEtB0M=; b=ub8E50
	brq4z0SgUn5CR51GaptItyoknsPPU9vbCrzb0PoOjtpxbJnQ1Sxy2yvEjTkWBYNI
	3KvXoCL0vPjJ76uWUnFm843reSp166XRaee6H/3qG1MJQuJppYdal3y8GsJ5qnGV
	OROjID2K6aosNCF9P0YGzRdWqTXWjeLWGiNNQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cICE4S4VEfnr5EywVbGTplVwclKs0Lpv
	Obs3nSdZPsqJsBba9Iy1e+TiQKYHz52KtE/yxIhvhRZUtUxJiEAW6muqK1AD8Af1
	YI7+yvUYTayGiJ8mZM2YJP81s994rLrRx0PTzPTVLe7KeEQxew+Sb2nkYONNo5Qu
	RSxu9yq3t54=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0681331349;
	Wed,  2 Dec 2015 17:11:34 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 64EAF31348;
	Wed,  2 Dec 2015 17:11:33 -0500 (EST)
In-Reply-To: <20151202002450.GA27994@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 1 Dec 2015 19:24:50 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A58FC9B2-9941-11E5-A551-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281917>

Jeff King <peff@peff.net> writes:

> What's cooking in git.git (Dec 2015, #01; Tue, 1)
> --------------------------------------------------
>
> Here are the topics that have been cooking.  Commits prefixed with
> '-' are only in 'pu' (proposed updates) while commits prefixed with
> '+' are in 'next'.
>
> This should by my final whats-cooking before handing things back to
> Junio. Thanks all for review help and for your patience during the past
> few weeks.

I think I managed to get my working area (together with a handful of
new entries in the rerere database and a few merge-fix/ entries) in
sync with what you pushed out well enough that my automated
procedure would recreate the status of various branches you pushed
out exactly.

I haven't caught up with the changes in the component branches,
though, so it may take a few days until I start picking up new
topics from the list traffic.

> * bc/object-id (2015-11-20) 12 commits
>  - remote: convert functions to struct object_id
>  - Remove get_object_hash.
>  - Convert struct object to object_id
>  - Add several uses of get_object_hash.
>  - object: introduce get_object_hash macro.
>  - ref_newer: convert to use struct object_id
>  - push_refs_with_export: convert to struct object_id
>  - get_remote_heads: convert to struct object_id
>  - parse_fetch: convert to use struct object_id
>  - add_sought_entry_mem: convert to struct object_id
>  - Convert struct ref to use object_id.
>  - sha1_file: introduce has_object_file helper.
>
>  More transition from "unsigned char[40]" to "struct object_id".
>
>  This needed a few merge fixups, but is mostly disentangled from other
>  topics.
>
>  Will merge to 'next'.

Aside from niggles on titles of a handful of changes in this topic,
I have a bit of concern with this one and dt/refs-backend-pre-vtable
topic (marked as "Will merge to 'master' two cycles from now.",
which I am reading as "two cycles" means 2 x (8-10 week release
cycle), not "two integration cycles by the maintainer, aka two
issues of What's cooking report", which is typically less than a
week).

The merge resolution in 'pu' discards what this topic did to refs.c
because much of the original goes away from there, but does it mean
(remember, I haven't caught up with the contents of the topics yet)
that the merge reverts part of what this topic did, and in an ideal
world, if the other one were more mature when this topic got
started, more use of "unsigned char[40]" would have been migrated to
"struct object_id" in new files the other one introduced?  Or
perhaps we would want to go the other way around, i.e. as this topic
conceptually is fairly straight-forward, merge this to 'next' and
then down to 'master' (which would not take two release cycles) and
then redo the other topic on top?

> * mr/ff-refs (2015-11-28) 6 commits
>  - builtin/ff-refs.c: mark some file-local variables static
>  - ff-refs: Add tests
>  - ff-refs: Add documentation
>  - ff-refs: add --dry-run and --skip-worktree options
>  - ff-refs: update each updatable ref
>  - ff-refs: builtin cmd to check and fast forward local refs to their upstream
>
>  Specialized command to fast-forward refs to match their upstream.
>
>  I remain skeptical that this is necessary or sufficient. Comments
>  welcome.
>
>  Will hold.

This is another one that needs some evil-merge interaction with
bc/object-id, but I have a feeling that this is not such a good
addition to our workflow elements, so I am not worried too much
about it.  I'm inclined to eject this topic (and will welcome if
people come up with an alternative, perhaps based on the "let fetch
do so instead" approach discussed there).

> * ps/rebase-keep-empty (2015-11-24) 2 commits
>  - rebase: fix preserving commits with --keep-empty
>  - rebase: test broken behavior with --keep-empty
>
>  Keep duplicate commits via rebase --keep-empty.
>
>  I'm not sure if I agree with this interpretation of the "rebase
>  --keep-empty" documentation, but I haven't thought too hard about it.
>  Comments welcome.

"--keep-empty" has always been about keeping an originally empty
commit, not a commit that becomes empty because of rebasing
(i.e. what has already been applied to the updated base).  The
documentation, if it leads to any other interpretation, needs to be
fixed.

Besides, if "--keep-empty" were to mean "keep redundant ones that
are already in the updated base", the patch must do a lot more,
e.g. stop filtering with git-cherry patch equivalence.

I'm inclined to eject this topic.


> * ls/test-must-fail-sigpipe (2015-11-28) 2 commits
>   (merged to 'next' on 2015-12-01 at d374686)
>  + add "ok=sigpipe" to test_must_fail and use it to fix flaky tests
>  + implement test_might_fail using a refactored test_must_fail
>
>  Fix some racy client/server tests by treating SIGPIPE the same as a
>  normal non-zero exit.
>
>  Will merge to 'master' two cycles from now.

Hmm, perhaps I misread what you meant by "two cycles", as this is
only the test suite and I cannot imagine we would want to be
ultra-safe to cook that for two release cycles, and you did mean two
issues of "What's cooking" report?

If so, I'll have to rethink the comment on bc/object-id I made
earlier...

> * dt/refs-backend-pre-vtable (2015-11-20) 10 commits
>   (merged to 'next' on 2015-11-24 at 8fd7293)
>  + refs: break out ref conflict checks
>  + files_log_ref_write: new function
>  + initdb: make safe_create_dir public
>  + refs: split filesystem-based refs code into a new file
>  + refs/refs-internal.h: new header file
>  + refname_is_safe(): improve docstring
>  + pack_if_possible_fn(): use ref_type() instead of is_per_worktree_ref()
>  + copy_msg(): rename to copy_reflog_msg()
>  + verify_refname_available(): new function
>  + verify_refname_available(): rename function
>
>  Code preparation for pluggable ref backends.
>
>  Will merge to 'master' two cycles from now.

... that is, I'd very much prefer bc/object-id redone on top of an
updated codebase that already has dt/refs-backend-pre-vtable in it.

Thanks.
