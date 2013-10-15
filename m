From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Oct 2013, #02; Mon, 14)
Date: Tue, 15 Oct 2013 11:32:12 -0700
Message-ID: <xmqqiowye66r.fsf@gitster.dls.corp.google.com>
References: <20131014184524.GW9464@google.com>
	<20131015001231.GA9464@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 15 20:33:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VW9Qo-0002Gl-U0
	for gcvg-git-2@plane.gmane.org; Tue, 15 Oct 2013 20:33:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757042Ab3JOSdP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Oct 2013 14:33:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65197 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753170Ab3JOSdO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Oct 2013 14:33:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6332E4A108;
	Tue, 15 Oct 2013 18:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2GNQBtMIa8XLEAgwPdLlh5guWnc=; b=XYzXxA
	ysfQOPaPb38UYR+ZgxpO3UJDQjIaUhwKN6J5NUDCeMuYCs9T7uObu3qdIfV50wnW
	3aSx6CZtxhnWcy8Zj6OuMoXasYupXRPQtNf6vby0z1Bp0imcv4pZzBs/w7BJEysu
	3Yp4KzztzZJHr2Arkunr2sqWjCQ0KMJCn1sE4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ELncvPZiaTt8FqDoiKBaBwlJhoSFKLyx
	ASQeJRZgRSsp36SODg/y7zLs2wcHmofqneDn/Obu9bQ275044rJWNZ2gbsv4h7rI
	yFe33togR3meCk6onMKFL6/xVZL5xF7fyKIPMkaUMb5py65V/2XWk0hbnWCBn+gy
	abfQsQzWTWw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 96A734A0D8;
	Tue, 15 Oct 2013 18:32:48 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C766A4A04C;
	Tue, 15 Oct 2013 18:32:15 +0000 (UTC)
In-Reply-To: <20131015001231.GA9464@google.com> (Jonathan Nieder's message of
	"Mon, 14 Oct 2013 17:12:31 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 2C2EF4FA-35C8-11E3-84AC-8F264F2CC097-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236192>

Jonathan Nieder <jrnieder@gmail.com> writes:

> What's cooking in git.git (Oct 2013, #02; Mon, 14)
> Tying up loose ends before the hand-off.

I'll try:

 - slurping your integration branches,
 - teasing the topics apart out of your 'pu',
 - populating my rerere database to match your confict resolution,
 - reconstructing the Meta/Reintegrate insn for 'pu', and
 - rebuilding 'pu' to make sure the end result matches yours

and then push the result out to the usual places listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

I haven't had enough time to go through the new/updated patches in
tree to look at them carefully (let alone peeking into patches that
are not in 'pu'), but it appears to me that the list has been busy
adding quality fixes and enhancements while I was away.

Thanks.

> --------------------------------------------------
> [Stalled]
> ...
> * mg/more-textconv (2013-05-10) 7 commits
>   (merged to 'next' on 2013-10-14 at 8a12490)
>  + grep: honor --textconv for the case rev:path
>  + grep: allow to use textconv filters
>  + t7008: demonstrate behavior of grep with textconv
>  + cat-file: do not die on --textconv without textconv filters
>  + show: honor --textconv for blobs
>  + diff_opt: track whether flags have been set explicitly
>  + t4030: demonstrate behavior of show with textconv
>
>  Make "git grep" and "git show" pay attention to --textconv when
>  dealing with blob objects.
>
>  There was a question about how defaulting to 'git show --textconv'
>  would interact with the "git show HEAD:file.c >file.c" habit.
>  $gmane/221833

I'll move this to the Cooking category (caught it by looking at the
output of "Meta/cook -w").

> [Cooking]
>
> * ak/submodule-foreach-quoting (2013-09-27) 1 commit
>   (merged to 'next' on 2013-10-14 at d77c5f1)
>  + submodule foreach: skip eval for more than one argument
>
>  A behavior change, but a worthwhile one: "git submodule foreach"
>  was treating its arguments as part of a single command to be
>  concatenated and passed to a shell, making writing buggy
>  scripts too easy.
>
>  This patch preserves the old "just pass it to the shell" behavior
>  when a single argument is passed to 'git submodule foreach' and
>  moves to a new "skip the shell and use the arguments passed
>  unmolested" behavior when more than one argument is passed.

When scripts give 'echo' and '$path' (two args), does this change
allow the 'echo' command to see the value of $path (coming from
$sm_path), or just the not-useful-because-not-exported variable name
'$path'?

>  The old behavior (always concatenating and passing to the shell)
>  was similar to the 'ssh' command, while the new behavior (switching
>  on the number of arguments) is what 'xterm -e' does.
>
>  May need more thought to make sure this change is advertised well
>  so that scripts that used multiple arguments but added their own
>  extra layer of quoting are not broken.

I suspect no amount of thinking is enough to avoid fallout from this
change.  People will not read advertisement and will complain.

> * ew/keepalive (2013-10-14) 1 commit
>   (merged to 'next' on 2013-10-14 at 24d786f)
>  + http: enable keepalive on TCP sockets
>
>  $gmane/236154 has a follow-up to do more magic with recent curl.

Thanks for leaving a good note here.
Will take a look at that follow-up in tomorrow's integration cycle.

> * jc/revision-range-unpeel (2013-09-20) 2 commits
>  - (possible fixup) jc/revision-range-unpeel - peel only when necessary
>  - revision: do not peel tags used in range notation
>
>  "git rev-list --objects ^v1.0^ v1.0" gave v1.0 tag itself in the
>  output, but "git rev-list --objects v1.0^..v1.0" did not.
>
>  Need to decide either squashing the top fixup in, or dropping it
>  and then merge to 'next'.

Funny that you did not "decide" as the interim maintainer ;-)
I'll squash these two, per $gmane/235339, and have it advance,
perhaps in tomorrow's integration cycle.

> * jk/format-patch-from (2013-09-20) 1 commit
>   (merged to 'next' on 2013-09-20 at 0506530)
>  + format-patch: print in-body "From" only when needed
>
>  "format-patch --from=<whom>" forgot to omit unnecessary in-body
>  from line, i.e. when <whom> is the same as the real author.
>
>  Will merge to 'master'.

There seem to be many topics marked for 'master' but have been
cooking in 'next' for very long.  Will start moving them later this
week (i.e. not today, not tomorrow).

> * jc/upload-pack-send-symref (2013-09-17) 7 commits
>  - clone: test the new HEAD detection logic
> ...
>  Will merge to 'next'.

Likewise for the ones slated for 'next'.

Thanks.
