From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH jh/notes-merge-in-git-dir-worktree] fixup! t3310 on
 Windows
Date: Wed, 14 Mar 2012 10:44:46 -0700
Message-ID: <7vlin3qdpt.fsf@alter.siamese.dyndns.org>
References: <1319438176-7304-3-git-send-email-pclouds@gmail.com>
 <1331563647-1909-1-git-send-email-johan@herland.net>
 <1331563647-1909-2-git-send-email-johan@herland.net>
 <4F60593A.5070106@viscovery.net>
 <CALKQrgdjYvkSBn8UORSsZecSVyhJbfU5tjU0hPJOYn1OMVxMyw@mail.gmail.com>
 <4F60882E.90303@viscovery.net>
 <CALKQrgdWZM959OyrEp+WCCehczZmMA3K8_RAcf23aAczKBCfvA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	david@tethera.net, pclouds@gmail.com
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Mar 14 18:44:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7sFq-00059T-TS
	for gcvg-git-2@plane.gmane.org; Wed, 14 Mar 2012 18:44:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761194Ab2CNRou (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Mar 2012 13:44:50 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43642 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760995Ab2CNRot (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2012 13:44:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7AB486E96;
	Wed, 14 Mar 2012 13:44:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=z9negj4SE7MDJsl1WWbIP3SfKNk=; b=BOze9N
	u9vyH2RcmB57KHRomN2YVBf/EGpRqRpkD4iOooXURjPeUdiudCJjRkkD0HFC6RVa
	I8OhLwdpZsK2NVxVny+PGbPVyIV0Gm6LUyRRkXJ7oxV1313MZOleeqgEP0SZOKKb
	QTqkZvkPQ2g6k7jJ9K+NIQHK//bummJcNZfcE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pfvNsq+CLmIjpgQ2wiXKv+0Nwey3LyzA
	UUpccTkAno/jV4stBPe7sQj2QuEReA1xdpcoqGYPOqU1A4OQLCqyi4D0v2jYYev7
	LimKVHLC8ZHGjUdIJcXHAh2UIzTOzUnWE/759kM0UAQHd1lq/tNVavs474AlQZEQ
	nZuVyMXgGXE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 71A986E95;
	Wed, 14 Mar 2012 13:44:48 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 06C3E6E94; Wed, 14 Mar 2012
 13:44:47 -0400 (EDT)
In-Reply-To: <CALKQrgdWZM959OyrEp+WCCehczZmMA3K8_RAcf23aAczKBCfvA@mail.gmail.com> (Johan
 Herland's message of "Wed, 14 Mar 2012 13:56:44 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 64A31F3A-6DFD-11E1-A43F-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193138>

Johan Herland <johan@herland.net> writes:

> On Wed, Mar 14, 2012 at 12:59, Johannes Sixt <j.sixt@viscovery.net> wrote:
> ...
>> I doubt that the use-case that is tested here makes sense.
>
> As David wrote, the use case is likely to pop up among regular users.
> We can't simply ignore it.
>
>> Or .git/NOTES_MERGE_WORKTREE should not be removed. Would it be an option
>> to clear it out only when it is needed, right before it is filled again?
>
> Maybe, but then we wouldn't be able to warn or abort in the case where
> there is a previous unfinished notes merge, and the user tries to
> start a new notes merge. Instead, we'd silently overwrite the previous
> unfinished notes merge...

We cannot simply ignore it.

You _could_ do is perhaps to do something like:

 - when you notice that you need to ask the user to hand-merge a temporary
   file (i.e. when 'notes merge' is run), check if .git/N_M_W/done exists.

    - If you see that marker file, remove it everything in the
      directory, deposit the temporary file you want the user to edit,
      and expect the user to later tell you that he is done by "notes
      merge --commit";

    - If you don't, the user didn't give you "notes merge --commit"
      during the earlier run.  Tell him to first abandon the previous
      round with "notes merge --abandon" or something.

 - "notes merge --commit" will just mark .git/N_M_W/ with "done".

 - "notes merge --abandon" will remove .git/N_M_W/.

but it only supports the simplest "Run 'notes merge', cd to .git/N_M_W,
edit all, run 'notes merge --commit'" workflow.  If the user decides to
abandon instead of commit, he will be inside the problematic directory, so
trying to be more elaborate like the above does not really solve anything
fundamental.  The user has to come out of that temporary directory
eventually anyway.

So I think the following is not just an improvement over the current code,
but probably an acceptable solution, given its simplicity.

> Maybe it's better to simply detect if cwd is inside
> .git/NOTES_MERGE_WORKTREE, and then abort, telling the user to chdir
> out before trying again?
