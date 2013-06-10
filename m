From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] build: get rid of the notion of a git library
Date: Mon, 10 Jun 2013 16:05:21 -0700
Message-ID: <7vk3m1efda.fsf@alter.siamese.dyndns.org>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Vincent van Ravesteijn <vfr@lyx.org>,
	John Keeping <john@keeping.me.uk>,
	Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 11 01:05:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmB9V-000649-3e
	for gcvg-git-2@plane.gmane.org; Tue, 11 Jun 2013 01:05:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752546Ab3FJXFZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jun 2013 19:05:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59270 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752230Ab3FJXFY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 19:05:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F2544268AC;
	Mon, 10 Jun 2013 23:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cmWT7I14nJw1NzZeHHL0zy/+ofc=; b=uW+Xf7
	Wt42Uf4TnyTU7Ks1yv3c/YqlBieccHuF1HjFri+PlcYM2bc8TTni52XqQl+mCafu
	TT4e9NcRvPotAm3cMBb5k6p3pErQPLjCivyt/IzbkpWvdFPeeVvWrWaIDh6AX8nB
	Ph4VJTdZIwRpsOcCRXrAemtJQHXVPVvEIECNM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=R0s5s2iP2NJO0CQET+YaSyRTDKcchxSC
	OlwU3oCI7tX5Gs08I1XgkfUf9Li6cYxAeqO15ARa5EzfVLhLigSS/eNGA1u5koeA
	1hJuSRBMc0upYZGl+eNtIQpKRePZj6qkhAjXCcMZ9iBaK/kmicrAnGlru7CcGL24
	MepRoFOCbnk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E55F4268AB;
	Mon, 10 Jun 2013 23:05:23 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 31598268A8;
	Mon, 10 Jun 2013 23:05:23 +0000 (UTC)
In-Reply-To: <20130610220627.GB28345@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 10 Jun 2013 18:06:27 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3ADF60F2-D222-11E2-8189-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227400>

Jeff King <peff@peff.net> writes:

> My general impression of the goal of our current code organization is:
>
>   1. builtin/*.c should each contain a single builtin command and its
>      supporting static functions. Each file gets linked into git.o to
>      make the "main" git executable.

Correct; that is what we aimed for when we made builtin-*.c (later
moved to builtin/*.c).  Some builtin/*.c files can contain more than
one cmd_foo implementations, so "single" is not a solid rule, and it
does not have to be, because all of them are expected to be linked
into the main binary together with git.c to be called from main().

And as you hinted, if some global data or functions in it turns out
to be useful for standalone binaries, their definitions must migrate
out of buitlin/*.c to ./*.c files, because standalone binaries with
their own main() definition cannot be linked with builtin/*.o, the
latter of which requires to be linked with git.o with its own main().

>   2. ./*.c is one of:
>
>        a. Shared code usable by externals and builtins, which gets
>           linked into libgit.a
>
>        b. An external command itself, with its own main(). It gets
>           linked against libgit.a.
>
>   3. Functions in libgit.a should be defined in a header file specific
>      to their module (e.g., refs.h). cache.h picks up the slack for
>      things that are general, or too small to get their own header file,
>      or otherwise don't group well.
>
> I said it was a "goal", because I know that we do not follow that in
> many places, so it is certainly easy to find counter-examples (and nor
> do I think it cannot be changed; I am just trying to describe the
> current rationale). Under that organization, there is no place for "code
> that does not go into libgit.a, but is not a builtin command in itself".
> There was never a need in the past, because libgit.a was a bit of a
> dumping ground for linkable functions, and nobody cared that it had
> everything and the kitchen sink.

The rationale behind libgit.a was so that make targets for the
standalone binaries (note: all of them were standalone in the
beginning) do not have to list *.o files that each of them needs to
be linked with.  It was primary done as a convenient way to have the
linker figure out the dependency and link only what was needed.
