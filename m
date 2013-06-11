From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] build: get rid of the notion of a git library
Date: Tue, 11 Jun 2013 12:24:20 -0700
Message-ID: <7vobbca1sr.fsf@alter.siamese.dyndns.org>
References: <1370712574-27688-1-git-send-email-felipe.contreras@gmail.com>
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
	<7vd2rsbjgr.fsf@alter.siamese.dyndns.org>
	<CAMP44s3SL7qs-Pmfz=kV-4U5OnPedK2RDLZDOyU-eq8WebLt+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Vincent van Ravesteijn <vfr@lyx.org>,
	John Keeping <john@keeping.me.uk>,
	Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 11 21:24:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmUBC-0007Du-Q5
	for gcvg-git-2@plane.gmane.org; Tue, 11 Jun 2013 21:24:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755612Ab3FKTYZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jun 2013 15:24:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51092 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754906Ab3FKTYY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jun 2013 15:24:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4999627432;
	Tue, 11 Jun 2013 19:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BlQ465fqJ3tm4p7TvLJ1vOQ9Ths=; b=LfblbZ
	6OYHN3FiM9JaQd4mucksf1CjqHJKaj6ZDodKElg7ECPYnuarU0XmXNvh4lOLILfC
	+io2K18F7TtPP7ymknO5eJJGph6o2YATw5bJzhhQ2o1nXE9EegH3vMTfz3aXsvHo
	1O3DSV2ELVPNWc7e+JuarSFYpm2LrMJXb3KMU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=e95VGiHH43pyZrTJ7/V981Ux1ku4kXt1
	S/ipzy4szRVmK53+NJxF4J2noBACyp3Ibz0xX6s4OD0DKWtXdNRvXBuvjJQCsNc6
	XqZkGixFna85rWUHPeeT2RZsQNDmmm63NGmU+iNQLHwvc5wKOSJQ+qxmLFZozKC4
	JvEdDPpXq94=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3E8FC27431;
	Tue, 11 Jun 2013 19:24:23 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 830922742C;
	Tue, 11 Jun 2013 19:24:22 +0000 (UTC)
In-Reply-To: <CAMP44s3SL7qs-Pmfz=kV-4U5OnPedK2RDLZDOyU-eq8WebLt+Q@mail.gmail.com>
	(Felipe Contreras's message of "Tue, 11 Jun 2013 14:01:15 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 854F4BE8-D2CC-11E2-9903-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227502>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Tue, Jun 11, 2013 at 1:17 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>
>>> Moreover, if you are going to argue that we shouldn't be closing the
>>> door, then why not link ./builtin/*.o to libgit.a?
>>
>> Huh?  It does not make any sense.  builtin/*.o files have cmd_foo()
>> that are expected to be called from git.c::main(), but libgit.a
>> files are linked with no constraints whose main() they are linking
>> with.
> ...
>> That is exactly why I said that builtin/*.o should be refactored to
>> pick "does not have to be in builtin" bits, which will result in a
>> better division of labor.  Reusable bits should live in the library,
>> while a particular implementation of command remain in builtin/*
>> that utilize the reusable bits.
>>
>> You still haven't justified why we have to _forbid_ any outside
>> callers from calling copy_notes_for_rewrite().
>
> Because only builtins _should_ use it.

And there is no justification behind that "_should_" claim; you are
not making any technical argument to explain it.

> I asked you for an example, and
> you said a hypothetical standalone 'git-filter-branch' might use it,

Of course it has to be hypothetical; I already said with the current
code no standalone does use it---it is not arranged to be doable so
there is no user.  If you want to have examples of future possible
callers, they have to be hypothetical---the future by definition
hasn't happened.  But that does not mean hypothetical is impractical
nor useless.

There are out-of-tree programs like cgit that will not be built-in
but already link with libgit.a.  Moving things that can be used by
outside people out of builtin/*.o to libgit.a would allow uses that
you and I cannot imagine offhand.  I do not see a reason for us to
forbid a filter-branch replacement out of tree as a standalone.

I do not see a point in continuing to discuss this (or any design
level issues) with you.  You seem to go into a wrong direction to
break the design of the overall system, not in a direction to
improve anything.  I do not know, and at this point I do not care,
if you are doing so deliberately to sabotage Git.  Just stop.
