From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] build: get rid of the notion of a git library
Date: Tue, 11 Jun 2013 11:17:24 -0700
Message-ID: <7vd2rsbjgr.fsf@alter.siamese.dyndns.org>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Vincent van Ravesteijn <vfr@lyx.org>,
	John Keeping <john@keeping.me.uk>,
	Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 11 20:17:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmT8N-0005Tt-5R
	for gcvg-git-2@plane.gmane.org; Tue, 11 Jun 2013 20:17:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755221Ab3FKSR1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jun 2013 14:17:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42113 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750887Ab3FKSR0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jun 2013 14:17:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0E90D24328;
	Tue, 11 Jun 2013 18:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eBA+kvssEaGOVt1O+LcmRA7Yya4=; b=sLNl+X
	2lxvcoP5QF7N+DY6od2hf9BeE0EmVBAKZvh7lA37OWAH18gxGfKcVF9dToXYV5fP
	4/dATd97fj5yoplVJVUnYBJF7w55EyKG1N6gkSpokHeiZsOytMKLkRnVJ2LK0cNZ
	Zg9ZS17rtazibWJqR0FLvfQE9mIIq+CwZOMi0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=U7bElLDjCjLBpILh21oJglwuhZWwt2HV
	AZfKToMsttw/ikOqaSARkhClaMuoZpl8TMiYq8Dp9vgaaTwMimPe43senO02JGe7
	29lSjGWfUfwgezMT6LE+h7d5nyarYWEgDejvmf/z4Dz5QnRWhEjruPL3cox6ukMo
	z8qExg72dw4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0296A24327;
	Tue, 11 Jun 2013 18:17:26 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 616A424326;
	Tue, 11 Jun 2013 18:17:25 +0000 (UTC)
In-Reply-To: <CAMP44s02KaMaMUz4618n5RqVqVSXzr_D9rPS1uesy2XEdqnq5A@mail.gmail.com>
	(Felipe Contreras's message of "Tue, 11 Jun 2013 13:06:27 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2AE921BE-D2C3-11E2-98A5-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227483>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Moreover, if you are going to argue that we shouldn't be closing the
> door, then why not link ./builtin/*.o to libgit.a?

Huh?  It does not make any sense.  builtin/*.o files have cmd_foo()
that are expected to be called from git.c::main(), but libgit.a
files are linked with no constraints whose main() they are linking
with.

> If you are
> seriously considering the highly unlikely hypothetical standalone
> git-filter-branch scenario, you should consider the even more likely
> scenario where somebody needs to access code from ./builtin/*.o; that
> scenario is not even hypothetical, we know it's happened multiple
> times, and we know it's going to happen again.

That is exactly why I said that builtin/*.o should be refactored to
pick "does not have to be in builtin" bits, which will result in a
better division of labor.  Reusable bits should live in the library,
while a particular implementation of command remain in builtin/*
that utilize the reusable bits.

You still haven't justified why we have to _forbid_ any outside
callers from calling copy_notes_for_rewrite().
