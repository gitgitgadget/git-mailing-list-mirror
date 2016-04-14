From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/25] worktree lock, move, remove and unlock
Date: Thu, 14 Apr 2016 09:08:35 -0700
Message-ID: <xmqqfuuoi35o.fsf@gitster.mtv.corp.google.com>
References: <1460553346-12985-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 14 18:14:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqjup-0003Kg-Or
	for gcvg-git-2@plane.gmane.org; Thu, 14 Apr 2016 18:14:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755214AbcDNQOn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Apr 2016 12:14:43 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65049 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753178AbcDNQOm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Apr 2016 12:14:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 06E9C107F7;
	Thu, 14 Apr 2016 12:14:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=SXctZkwHnrtn
	gNNHcrO/bZK4/AY=; b=XUrVqcu/zeh0nW3tGL2Omrhp14Fm0vMX+a7Q1AwQIef0
	zdwcdN91uf/Ia4/9+8Gk8cOKteDYoWsPXz928RPoaEp8mRMBo1zf8e/Q0DNVGqji
	Z7uPcC9wbeESCiQIBUdnzKj3Bxb/O2EObZx4yrzwr6IxRs4lnuK0pAqW2sP+2bc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=f5BxdR
	JtDl6VenfO1/ISCkDt7HVBNpe0vH0b1flnGkOYrsHX/VsL/mInUgY4iK66MXWW9e
	1Yq0tZQi0JWyb9uCs5a8ivFW9S+wdqcCdxuXuQZNKF2Sv/31tXgsrcgP5GK2J5Cj
	pRHJ6Q+G24orYvrIC6CK282UTdd1Si8KlGb4w=
Received: from pb-smtp2. (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E987D107F6;
	Thu, 14 Apr 2016 12:14:40 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 09CD71068B;
	Thu, 14 Apr 2016 12:08:36 -0400 (EDT)
In-Reply-To: <1460553346-12985-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Wed, 13
 Apr 2016 20:15:21 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 252F4224-025B-11E6-BADE-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291529>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> This is basically a resend from last time, which happened during rc
> time.

It would have made them a much more pleasant read if you re-read
them during that time and added the missing "why" to many of the
commit log message.

> It adds 4 more commands, basically cleaning up the "TODO" list
> in git-worktree.txt.
>
> So far I've only actually used move and remove (and maybe unlock once
> because worktree-add failed on me and I had to unlock it manually).
> And I don't get to move worktrees a lot either so not really extensiv=
e
> testing.
>
>   [01/25] usage.c: move format processing out of die_errno()
>   [02/25] usage.c: add sys_error() that prints strerror() automatical=
ly

This looks parallel to die_errno(); isn't error_errno() a better name?

>   [03/25] copy.c: import copy_file() from busybox
>   [04/25] copy.c: delete unused code in copy_file()
>   [05/25] copy.c: convert bb_(p)error_msg to (sys_)error
>   [06/25] copy.c: style fix
>   [07/25] copy.c: convert copy_file() to copy_dir_recursively()

Somewhere among these, there needs to be a single overview of why we
want "cp" implementation of busybox, e.g. what part of "cp" we want?
the whole thing?  or "because this is to be used from this and that
codepaths to make copy of these things, we only need these parts and
can remove other features like this and that?"

>   [08/25] completion: support git-worktree
>   [09/25] git-worktree.txt: keep subcommand listing in alphabetical o=
rder

I'd defer doing this immediately before 21 if I were doing this
series.

Offhand, I think it makes it easier to look things up in an
alphabetical list in the description section, but it probably is
easier to get an overview if the synopsis part groups things along
concepts and/or lists things along the order in typical workflows
(e.g. "create, list, rename, remove" would be a list along
lifecycle), not alphabetical.

But such judgement is better done when we know what are the final
elements that are to be listed, i.e. closer to where new things are
introduced.  This is especially true, as the log messages of patches
leading to 21 are all sketchy and do not give the readers a good
birds-view picture.

>   [10/25] path.c: add git_common_path() and strbuf_git_common_path()

Write "what for" when adding a new API function.  "Wanting to learn
X is very common and there are many existing code or new code that
repeats sequence A, B and C to compute it.  Give a helper function
to do so to refactor the existing codepaths" or something like that?

Move some part of [12/25] that is not about "store 'id'" but is
about this refactoring to this commit.

>   [11/25] worktree.c: use is_dot_or_dotdot()
>   [12/25] worktree.c: store "id" instead of "git_dir"

It is better to have these (and other conceptually "small and
obvious" ones) as preliminary clean-up to make the main body of the
series that may need to go through iterations smaller.

>   [13/25] worktree.c: add clear_worktree()
>   [14/25] worktree.c: add find_worktree_by_path()
>   [15/25] worktree.c: add is_main_worktree()
>   [16/25] worktree.c: add validate_worktree()
>   [17/25] worktree.c: add update_worktree_location()
>   [18/25] worktree.c: add is_worktree_locked()
>   [19/25] worktree: avoid 0{40}, too many zeroes, hard to read
>   [20/25] worktree: simplify prefixing paths
>   [21/25] worktree: add "lock" command
>   [22/25] worktree: add "unlock" command
>   [23/25] worktree: add "move" commmand
>   [24/25] worktree move: accept destination as directory
>   [25/25] worktree: add "remove" command
>
> Total 11 files changed, 1028 insertions(+), 48 deletions(-)
