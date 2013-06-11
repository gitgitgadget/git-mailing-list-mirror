From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] build: get rid of the notion of a git library
Date: Tue, 11 Jun 2013 10:33:34 -0700
Message-ID: <7vtxl4blht.fsf@alter.siamese.dyndns.org>
References: <1370712574-27688-1-git-send-email-felipe.contreras@gmail.com>
	<CALkWK0mA7MXQv1k5bFpZLARDOHxU5kzKFXzcyUfb6NLZZY-=FA@mail.gmail.com>
	<CAMP44s0cozMsTo7KQAjnqkqmvMwMw9D3SZrVxg48MOXkH9UQJQ@mail.gmail.com>
	<CALkWK0=7PRndNc7XQ-PCPbVCp9vck909bA561JhQG6uXXj1n4g@mail.gmail.com>
	<20130609151235.GA22905@serenity.lan>
	<CAMP44s0L9nQxp5OeK8uT4Ls5WUerCjVpR9uONUcOwvTD6k7Jfg@mail.gmail.com>
	<51B4BBB7.8060807@lyx.org>
	<20130610214504.GG13333@sigill.intra.peff.net>
	<CAMP44s2-94LTu54oX1_m14tnE3KfwK+N=pPxgUSqGCgd51EA5A@mail.gmail.com>
	<20130610220627.GB28345@sigill.intra.peff.net>
	<7vk3m1efda.fsf@alter.siamese.dyndns.org>
	<7v8v2hedou.fsf@alter.siamese.dyndns.org>
	<CAMP44s1HM0zFvkGmaHrX2Wq2JSzDNk8uwNSz3bNo12eWxDcL8A@mail.gmail.com>
	<7v4nd5ecmy.fsf@alter.siamese.dyndns.org>
	<7vwqq1ct0g.fsf@alter.siamese.dyndns.org>
	<CAMP44s0r96ByEs3+N1Qo+O18rOmT72rHk4zAEFAyFdU_DsQ8wA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Vincent van Ravesteijn <vfr@lyx.org>,
	John Keeping <john@keeping.me.uk>,
	Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 11 19:33:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmSRy-00060h-TL
	for gcvg-git-2@plane.gmane.org; Tue, 11 Jun 2013 19:33:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754270Ab3FKRdi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jun 2013 13:33:38 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44020 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753450Ab3FKRdh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jun 2013 13:33:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 728B42424A;
	Tue, 11 Jun 2013 17:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XTsYAdPj9z1xY/PFgCAt4kAxaKc=; b=CXtbdc
	Jd5ktZU4KMgog/jN9VeT5gfMmogNHSBlcsPJHvWE5NR9h99wmC1oM6CQNeaksicF
	XMUrGGngWLwlrIklZHrTzD0jRs87vrRGlTRr+NITHvpz6QhT3w8b0d94y2uN7vzg
	nIp8cS2J/8zrRvgz1rfQJ4CSuHNpaoFk0Ejsg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jsbxYh+Df1bihPDLoFyADVDbawARTyYa
	vJnIH2f+wm6q+Mklfn8oJP9248K13LzjzEBLcODSLSjU7mubUTLhaLBxaJ/a1++c
	NvULMkMGWYiFFXZ/hSuVGN//w6W9OXP2UwPnDTtl3WjIPwmjPbr2RBO7xZ7m5yHO
	Qdp7iRLLgUg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6703224249;
	Tue, 11 Jun 2013 17:33:36 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AF09C24248;
	Tue, 11 Jun 2013 17:33:35 +0000 (UTC)
In-Reply-To: <CAMP44s0r96ByEs3+N1Qo+O18rOmT72rHk4zAEFAyFdU_DsQ8wA@mail.gmail.com>
	(Felipe Contreras's message of "Mon, 10 Jun 2013 23:15:14 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0B7F3648-D2BD-11E2-AEFE-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227474>

Felipe Contreras <felipe.contreras@gmail.com> writes:

>>  - There may be pieces of usefully reusable code buried in
>>    builtin/*.o;
>>
>>  - By definition, any code (piece of data or function definition) in
>>    builtin/*.o cannot be used in standalone binaries, because all of
>>    builtin/*.o expect to link with git.o and expect their cmd_foo()
>>    getting called from main in it;
>>
>>  - By moving the useful reusable pieces ont of builtin/*.o and
>>    adding them to libgit.a, these pieces become usable from
>>    standalone binaries as well.
>
> What if these reusable pieces should not be used by standalone binaries?

I am not sure what you mean.  A piece is either reusable or not.
When would one piece _be_ reusable and should *not* be used in one
context but not in another?

There are distinctions between being "useful" and "usable", but I
think the zeroth order of approximation when thinking about this is
to think builtin/*.o as set of subroutines called by git.c::main().

These set of subroutines may call out to more generic helper
functions that are usable from anywhere both within builtins and
also from standalone.  They may also call to their own helper
functions that were originally designed to support only their use
by the original caller from somewhere in builtin/*.o (most commonly
in the same file, marked as static).

The general direction, if we want to have an improve libgit.a,
should be to see if the functions and their data that are private
to builtin/*.o can be used from standalone, either as they are or
with more generalization, and turn them from helpers specific to one
cmd_foo() into more generally useful library-ish functions.

There may be pieces in the callchain from that entry point to
cmd_foo() that are implementation details of git.c::main(); for
example the loop that does command dispatching to check with
builtins, external commands that begin with git-, and aliases, is
one of them, and would not be usable (nor it is useful) outside the
context of "git" aggregate binary.  But there are things that ought
to be usable that are currently in builtin/*.o, which prevents them
from being used by standalone binaries.  If a remote helper binary
that is standalone wants to call "create_note()", it is not
sufficient to make it non-static in builtin/notes.o, for example.

But if it is moved outside builtin/notes.o, it becomes usable.

I think the "git notes", being one of the most recent additions,
haven't gone through enough round of refactoring to come to the best
separation between library-ish part (i.e. could be in notes.o, even
though it is mostly about the underlying data structure manipulation
and contains no higher-level operations like actually creating and
copying, which might want to be in a separate source notes-lib.o)
and its CLI implementation "builtin/notes.o".

> But this doesn't answer the question; what about code that is shared
> between builtins, but cannot be used by standalone programs?

Again, I do not know what you mean by "cannot" here.  My tentative
answer to that question is "the eventual goal should be not to have
any code in that class, and that is a reasonable goal we can achieve
once we refactor what ought to be reusable out of builtin/*.o".

What are the examples you have in mind, code that we want to forbid
standalone from using?
