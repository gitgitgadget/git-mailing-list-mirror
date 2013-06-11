From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] build: get rid of the notion of a git library
Date: Tue, 11 Jun 2013 12:59:48 -0700
Message-ID: <7vehc8a05n.fsf@alter.siamese.dyndns.org>
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
	<7vtxl4blht.fsf@alter.siamese.dyndns.org>
	<CAMP44s02PqGFNmrGEcJVT6xcQHx8k4NYqJ_TtOTUEY8XHPj0BA@mail.gmail.com>
	<7vppvsbkc3.fsf@alter.siamese.dyndns.org>
	<CAMP44s02KaMaMUz4618n5RqVqVSXzr_D9rPS1uesy2XEdqnq5A@mail.gmail.com>
	<CA+55aFwYAFuz5p0=8QiAFDy4e66f1pF3v=D5nnL6+3um7Z3L2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Jeff King <peff@peff.net>,
	Vincent van Ravesteijn <vfr@lyx.org>,
	John Keeping <john@keeping.me.uk>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Jun 11 22:00:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmUjV-00014U-PT
	for gcvg-git-2@plane.gmane.org; Tue, 11 Jun 2013 21:59:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755994Ab3FKT7y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jun 2013 15:59:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57708 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755964Ab3FKT7w (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jun 2013 15:59:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 25C632487A;
	Tue, 11 Jun 2013 19:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7Rixeyq5zR7NHy/9uIxWXRsyl7Y=; b=PZb3PW
	sFNVIiEa02sFb9hdcaWpmE0ergXC94GSAqX3WBL1cli9fuzLy7oERXxhbQg8OhyC
	Rh57k0kD6Y4ewwlgVuolKy0JiBFABf1DVeYSCjmzOCyjJURgehLPkA1//V57l58Z
	KEgHL2fiOH9EmYa4uc7+Iqx+sZjhanMMgpaXU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MI8xiaNEObdt9wmHKnmyaGaKr0bNOoRF
	BvGW7uYCzoDN8ZNduTbHQZIdCecTcp5SNUbJ9p2h7XBbuOfhZeSnValaLZNRutkw
	WQuSQRj7y7WkKsWvXoPFMMDqohqj/fBdgJdbxf7W3NX9GblBZ4rNKCaLyhuQGNTA
	tSPw3Yh49+c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1909024879;
	Tue, 11 Jun 2013 19:59:51 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4A1F324878;
	Tue, 11 Jun 2013 19:59:50 +0000 (UTC)
In-Reply-To: <CA+55aFwYAFuz5p0=8QiAFDy4e66f1pF3v=D5nnL6+3um7Z3L2g@mail.gmail.com>
	(Linus Torvalds's message of "Tue, 11 Jun 2013 11:14:54 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 79911DF4-D2D1-11E2-8FD6-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227509>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> This whole thread has been one long argument about totally pointless
> things that wouldn't improve anything one way or the other. It's
> bikeshedding of the worst kind. Just let it go.

The proposal to move sequencer.c to builtins/sequencer.c and then
adding a filter in Makefile to exclude so that "git-sequencer" is
not built is "it wouldn't improve anything one way or the other".
It is to throw in something into a set to which it does not belong,
and then working around that mistake with another kludge.

The problem that triggered the wrong solution actually is real,
however.

A function that sequencer.c (in libgit.a so that it could be used by
standalone) may want to use in the future currently lives in
builtin/notes.c.  If you add a call to that function to sequencer.c
without doing anything else, standalones like git-upload-pack will
stop linking correctly.  The git-upload-pack wants the revision
traversal machinery in revision.o, which in turn wants to be able to
see log-tree.o, which in turn wants to link with sequencer.o to see
one global variable (there may be other dependencies).  All of these
objects are currently in libgit.a so that both builtins and standalones
can use them.

Moving sequencer.c to builtin/ is not even a solution.  Linking
git-upload-pack will still pull in builtin/notes.o along with
cmd_notes(), which is not called from main(); as you remember,
cmd_foo() in all builtin/*.o are designed to be called from
git.c::main().

There is only one right solution.  If a useful function is buried in
builtin/*.o as a historical accident (i.e. it started its life as a
helper for that particular command, and nobody else used it from
outside so far) and that makes it impossible to use the function
from outside builtin/*.o, refactor the function and its callers and
move it to libgit.a.

So I do not think this is not even a bikeshedding.  Just one side
being right, and the other side continuing to repeat nonsense
without listening.
