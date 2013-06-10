From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] build: get rid of the notion of a git library
Date: Mon, 10 Jun 2013 16:41:37 -0700
Message-ID: <7v8v2hedou.fsf@alter.siamese.dyndns.org>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Vincent van Ravesteijn <vfr@lyx.org>,
	John Keeping <john@keeping.me.uk>,
	Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 11 01:42:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmBio-0003BC-PT
	for gcvg-git-2@plane.gmane.org; Tue, 11 Jun 2013 01:41:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754119Ab3FJXlw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jun 2013 19:41:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52064 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752862Ab3FJXlu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 19:41:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CDFF3279A0;
	Mon, 10 Jun 2013 23:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AOQASyoYG40NrK76jqlUkfFduqs=; b=fw43ra
	R4QiOA84PitK7jelfsfciKIrxV6TU0zRefakY5OyzchM7/W2gZzM9d0SPSbA/fnE
	g/MEQ1TmvCxShqg1qME+EoqReqsu9/+QNMBZiAyTfjxAgiiK/V/0eFQjp1KR/IFN
	2Zld09AVxd3Sgz129sMludj+4N+MVTrAyD+QI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=crSYvN2/sSbO6YM04AzYc89f9ZL80y99
	EsMK8I91zi5Krgr9qRpuFbLAjFVWJ7Odx8sIOgvktEtbxQj1pJ8nhyNgkjylxTcu
	7pprD3AEwg3kWH5VMXUYWlFiMX9Z9Gli4TGyHP840f7bKhA7t7Y/TkRiFdWGwgXH
	WBq0K6xVsk8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C16F72799F;
	Mon, 10 Jun 2013 23:41:49 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CE7892799A;
	Mon, 10 Jun 2013 23:41:48 +0000 (UTC)
In-Reply-To: <7vk3m1efda.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 10 Jun 2013 16:05:21 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 519F4B36-D227-11E2-BFC6-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227403>

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> My general impression of the goal of our current code organization is:
>>
>>   1. builtin/*.c should each contain a single builtin command and its
>>      supporting static functions. Each file gets linked into git.o to
>>      make the "main" git executable.
>
> Correct; that is what we aimed for when we made builtin-*.c (later
> moved to builtin/*.c).  Some builtin/*.c files can contain more than
> one cmd_foo implementations, so "single" is not a solid rule, and it
> does not have to be, because all of them are expected to be linked
> into the main binary together with git.c to be called from main().
>
> And as you hinted, if some global data or functions in it turns out
> to be useful for standalone binaries, their definitions must migrate
> out of buitlin/*.c to ./*.c files, because standalone binaries with
> their own main() definition cannot be linked with builtin/*.o, the
> latter of which requires to be linked with git.o with its own main().
> ...
> The rationale behind libgit.a was so that make targets for the
> standalone binaries (note: all of them were standalone in the
> beginning) do not have to list *.o files that each of them needs to
> be linked with.  It was primary done as a convenient way to have the
> linker figure out the dependency and link only what was needed.

For the particular case of trying to make sequencer.o, which does
not currently have dependencies on builtin/*.o, depend on something
that is in builtin/notes.o, the link phase of standalone that wants
anything from revision.o (which is pretty much everything ;-) goes
like this:

        upload-pack.c   wants handle_revision_opt etc.
        revision.c      provides handle_revision_opt
                        wants name_decoration etc.
        log-tree.c      provides name_decoration
                        wants append_signoff
        sequencer.c     provides append_signoff

So sequencer.o _is_ meant to be usable from standalone and belongs
to libgit.a

If sequencer.o wants to call init_copy_notes_for_rewrite() and its
friends [*1*] that are currently in builtin/notes.o, first the
called function(s) should be moved outside builtin/notes.o to
notes.o or somewhere more library-ish place to be included in
libgit.a, which is meant to be usable from standalone.


[Footnote]

*1* ... which is a very reasonable thing to do.  But moving
    sequencer.o to builtin/sequencer.o is *not* the way to do this.
