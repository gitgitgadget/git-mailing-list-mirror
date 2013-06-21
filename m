From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [HELP] Corrupted repository
Date: Fri, 21 Jun 2013 12:00:16 -0700
Message-ID: <7vzjujl267.fsf@alter.siamese.dyndns.org>
References: <CALkWK0mQj+x3bxbxWKuwpeMj8E8bfvyK-c2bAWna6a9Xe=nBOQ@mail.gmail.com>
	<7v7ghno2lz.fsf@alter.siamese.dyndns.org>
	<CALkWK0mTZqtGFp-BW9XBjX4Cm2hCZ1=P5M0a4cMBuE0v__LpZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 21 21:00:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uq6ZX-0005GE-4R
	for gcvg-git-2@plane.gmane.org; Fri, 21 Jun 2013 21:00:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423598Ab3FUTAb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Jun 2013 15:00:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60297 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423554Ab3FUTAa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jun 2013 15:00:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D4B3A2A6E1;
	Fri, 21 Jun 2013 19:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WO0zrOhGYGq9MH2TelZ/PlTLRto=; b=qZ69vc
	46Nrx4AyINj6zxMDOuDlOv1OlI5DPURabX5iStIvUX7wqGWDXKn0B6rT0n1p0UKC
	+0mgyQLp7iBReO8w1OsDWwT6EuKFqs87nGw8Gw4DReR99xBvXGICuCTgmAbdJmLU
	NrLgItAgZeJZWP8pZMuCnxhSAk3wGeNKQjt1Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=I5YIca3YImmRu8N1V6lanYRFSixpRxLA
	pYU5TyJZF7gwra0YPFW05DJKSeIPG4aOQbHOMX5bbs/w6QimmEx0WcSeXOZfkOiG
	N99edxaGZvVoeh5JQlug06i0wynHtISOU2jUtVxtMb+rcjqfszyCygGEDyxhjKCh
	X0lnCVTtsQg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CA5A02A6E0;
	Fri, 21 Jun 2013 19:00:29 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 16E0B2A6DB;
	Fri, 21 Jun 2013 19:00:28 +0000 (UTC)
In-Reply-To: <CALkWK0mTZqtGFp-BW9XBjX4Cm2hCZ1=P5M0a4cMBuE0v__LpZw@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Fri, 21 Jun 2013 22:14:06 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D665D99A-DAA4-11E2-9139-80EC6777888E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228653>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Junio C Hamano wrote:
>>>   $ ~/src/git
>>>   error: object file
>>> .git/objects/8e/6a6dda24b017915449897fcc1353a9b848fd2f is empty
>>>   error: object file
>>> .git/objects/8e/6a6dda24b017915449897fcc1353a9b848fd2f is empty
>>>   fatal: loose object 8e6a6dda24b017915449897fcc1353a9b848fd2f (stored
>>> in .git/objects/8e/6a6dda24b017915449897fcc1353a9b848fd2f) is corrupt
>>
>> So fsync() and close() thought that the filesystem stored this loose
>> object safely, but it turns out that the data is not on disk.
>
> Where should I start digging if I want to fix this?  Actually you just
> need to tell me how to build reduced-case corruptions to test: I can
> trace and figure out the rest.

That is a trip in the kernel source, isn't it?  I cannot be your
guide there.

>
>>>   artagnon|remote-cruft*+:~/src/git$ git prune
>>>   artagnon|remote-cruft*+:~/src/git$ git status
>>>   fatal: bad object HEAD
>>>   fatal: bad object HEAD
>>
>> And the value in the HEAD was???
>
> ref: refs/heads/remote-cruft.  That's why I included my prompt :)
>
>>>   artagnon|remote-cruft*+:~/src/git$ git symbolic-ref HEAD refs/heads/master
>>>   artagnon|master*+=:~/src/git$ git status
>>>   ## master
>>>   MM Documentation/git-ls-remote.txt
>>>   MM remote.c
>>>   MM t/t5505-remote.sh
>>>   MM t/t5510-fetch.sh
>>>   MM t/t5515-fetch-merge-logic.sh
>>>   MM t/t5516-fetch-push.sh
>>>   ?? lib/
>>>   ?? outgoing/
>>>
>>> That status is completely bogus, by the way.
>>
>> ... which may suggest that your index file may have been corrupted
>> on the filesystem.
>
> Yeah, my question pertains to why is the index half-corrupted.  Is
> there no checksum to say "index corrupted; do not display bogus
> nonsense"?

Another possibility is perhaps the objects that are referred to by
the index were missing or unreadable, and the index weren't.

>
>>>   artagnon|master*+=:~/src/git$ git checkout remote-cruft
>>>   fatal: reference is not a tree: remote-cruft
>>>   artagnon|master=:~/src/git$ git reflog
>>>   21ff915 HEAD@{10 minutes ago}: rebase -i (finish): returning to
>>> refs/heads/remote-cruft
>>>
>>> What happened to the rest of my reflog?!
>>
>> On the filesystem known to not record the last consistent state of
>> the repository, the answer to that question may be rather obvious,
>> no?
>
> I didn't understand.  What does .git/logs/HEAD have to do with any of
> this?  Why is it truncated?

Explain why .git/objects/8e/6a6dda24b017915449897fcc1353a9b848fd2f
was truncated to yourself, and the same explanation would apply to
the .git/logs/HEAD file, I think.

> This was mainly a learning exercise for me: I wanted to see how good
> git was at working with corrupted repositories.

You could have just asked ;-).

A tl;dr is that we _trust_ our refs and everything reachable from
them has to be complete.  If that is not the case, things will not
work, and it is not a priority to add workarounds in the normal
codepath to slow things down.

That does not forbid an addition of "git recover-corrupted-repo"
command, whose "assume everything might be broken" code is not
shared with the fastpath of other commands.
