From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] build: get rid of the notion of a git library
Date: Mon, 10 Jun 2013 18:53:35 -0700
Message-ID: <7vwqq1ct0g.fsf@alter.siamese.dyndns.org>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Vincent van Ravesteijn <vfr@lyx.org>,
	John Keeping <john@keeping.me.uk>,
	Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>
To: Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 11 03:53:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmDmK-0005ZN-5o
	for gcvg-git-2@plane.gmane.org; Tue, 11 Jun 2013 03:53:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754348Ab3FKBxj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jun 2013 21:53:39 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64242 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753996Ab3FKBxi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 21:53:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 39E1F14AA8;
	Tue, 11 Jun 2013 01:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eTcqmk6jneXER1B8+LNMHgEOGbg=; b=H/Yald
	gPJinxHWzNoPU7yZcVmZotc9Hj1Y/m7NhHoNl8BwhKTARVMZnlyjXuFiOd4DOigY
	qVhi0mrmbDsSmzuBKz43CwqoEyFvvR0gJUb1hWvnsloO/oPJBxM5aSRwwWpdxEdf
	NsTfTyBg35Vq6QQUyUzlUUL4kv/PnZtW5lZso=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wBr7AuNBYkBttFdTizXShgp+RX9PQzpH
	78vcaEfS2sHsZ3qZBQ3k+/SffBVBkMRdIHAVNlWkzjgzl4KDmPuo4ZmZVnqJMm2/
	xgh4Vm4bo13vk+ckcn5acLsD/DOyPz4/frLKn4xtvvSrcuBSY8iWtbjBHO3WwtM+
	SLzPUaFxBas=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 307AB14AA7;
	Tue, 11 Jun 2013 01:53:38 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5E4D014AA6;
	Tue, 11 Jun 2013 01:53:37 +0000 (UTC)
In-Reply-To: <7v4nd5ecmy.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 10 Jun 2013 17:04:21 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BB7B52AE-D239-11E2-AA0E-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227410>

Junio C Hamano <gitster@pobox.com> writes:

> And I do not see the reason why builtin/*.o should not depend on
> each other.  It is not messed up at all.  They are meant to be
> linked into a single binary---that is what being "built-in" is.
>
> A good way forward, the way it *SHOULD* be, is to slim the builtin/*.o
> by moving parts that do not have to be in the single "git" binary
> but are also usable in standalone binaries out of them.

Actually, as long as these pieces are currently used by builtins,
moving them (e.g. init_copy_notes_for_rewrite()) out of builtin/*.o 
will not make these parts not to be in the single "git" binary at
all, so the above is grossly misstated.

 - There may be pieces of usefully reusable code buried in
   builtin/*.o;

 - By definition, any code (piece of data or function definition) in
   builtin/*.o cannot be used in standalone binaries, because all of
   builtin/*.o expect to link with git.o and expect their cmd_foo()
   getting called from main in it;

 - By moving the useful reusable pieces ont of builtin/*.o and
   adding them to libgit.a, these pieces become usable from
   standalone binaries as well.

And that is the reason why slimming builtin/*.o is the way it
*SHOULD* be.

Another thing to think about is looking at pieces of data and
functions defined in each *.o files and moving things around within
them.  For example, looking at the dependency chain I quoted earlier
for sequencer.o to build upload-pack, which is about responding to
"git fetch" on the sending side:

        upload-pack.c   wants handle_revision_opt etc.
        revision.c      provides handle_revision_opt
                        wants name_decoration etc.
        log-tree.c      provides name_decoration
                        wants append_signoff
        sequencer.c     provides append_signoff

It is already crazy. There is no reason for the pack sender to be
linking with the sequencer interpreter machinery. If the function
definition (and possibly other ones) are split into separate source
files (still in libgit.a), git-upload-pack binary does not have to
pull in the whole sequencer.c at all.

Coming back to the categorization Peff earlier made in the thread, I
think I am OK with adding new two subdirectories to the root level,
i.e.

    builtin/	- the ones that define cmd_foo()
    commands/   - the ones that has main() for standalone commands
    libsrc/     - the ones that go in libgit.a

We may also want to add another subdirectory to hold scripted
Porcelains, but the primary topic of this thread is what to do about
the C library, so it is orthogonal in that sense, but if we were to
go in the "group things in subdirectories to slim the root level"
direction, it may be worth considering doing so at the same time.
