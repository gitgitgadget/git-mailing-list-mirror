From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] build: get rid of the notion of a git library
Date: Mon, 10 Jun 2013 23:15:14 -0500
Message-ID: <CAMP44s0r96ByEs3+N1Qo+O18rOmT72rHk4zAEFAyFdU_DsQ8wA@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Vincent van Ravesteijn <vfr@lyx.org>,
	John Keeping <john@keeping.me.uk>,
	Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 11 06:15:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmFzR-0006KG-8O
	for gcvg-git-2@plane.gmane.org; Tue, 11 Jun 2013 06:15:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751417Ab3FKEPS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jun 2013 00:15:18 -0400
Received: from mail-la0-f41.google.com ([209.85.215.41]:58783 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750950Ab3FKEPR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jun 2013 00:15:17 -0400
Received: by mail-la0-f41.google.com with SMTP id fn20so6457877lab.14
        for <git@vger.kernel.org>; Mon, 10 Jun 2013 21:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=lAlv7d0evMdIb9mnxKA69uIOSUVIjkDA2WfvEdVU7zg=;
        b=dtwf1xupfcTMOgmUfaQEYkjtOCx/E/6tXRLZM4JXGfx22fp3sg2u5tpW9psRWC3UiB
         N95zFM48KmYP64/O3IHMaRChqfD+B28L8y0L9lqNi6VP7TPzlgzuVL0QBq6G8uC5LQgY
         K/cvzOhZb89AaaSqPiRiT8nqr5tWbmMIMqZRo5lgscY8HJfzzVoA9jlRFmkKkK7zpliU
         tdxrJWkH1us+Cs7TC+fLNRUG0eaw340JgrHO4oNf7EtTm29NN2jD9PytqMSeQflytfb6
         +ZDsY5Eeqt6zkN87DugMJs38qswpTFvioVMMNVFVxsd5p4aH/ETK1tZbDFpnHm396RaI
         URxQ==
X-Received: by 10.112.157.226 with SMTP id wp2mr7777592lbb.65.1370924115088;
 Mon, 10 Jun 2013 21:15:15 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Mon, 10 Jun 2013 21:15:14 -0700 (PDT)
In-Reply-To: <7vwqq1ct0g.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227413>

On Mon, Jun 10, 2013 at 8:53 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> And I do not see the reason why builtin/*.o should not depend on
>> each other.  It is not messed up at all.  They are meant to be
>> linked into a single binary---that is what being "built-in" is.
>>
>> A good way forward, the way it *SHOULD* be, is to slim the builtin/*.o
>> by moving parts that do not have to be in the single "git" binary
>> but are also usable in standalone binaries out of them.
>
> Actually, as long as these pieces are currently used by builtins,
> moving them (e.g. init_copy_notes_for_rewrite()) out of builtin/*.o
> will not make these parts not to be in the single "git" binary at
> all, so the above is grossly misstated.
>
>  - There may be pieces of usefully reusable code buried in
>    builtin/*.o;
>
>  - By definition, any code (piece of data or function definition) in
>    builtin/*.o cannot be used in standalone binaries, because all of
>    builtin/*.o expect to link with git.o and expect their cmd_foo()
>    getting called from main in it;
>
>  - By moving the useful reusable pieces ont of builtin/*.o and
>    adding them to libgit.a, these pieces become usable from
>    standalone binaries as well.

What if these reusable pieces should not be used by standalone binaries?

> And that is the reason why slimming builtin/*.o is the way it
> *SHOULD* be.
>
> Another thing to think about is looking at pieces of data and
> functions defined in each *.o files and moving things around within
> them.  For example, looking at the dependency chain I quoted earlier
> for sequencer.o to build upload-pack, which is about responding to
> "git fetch" on the sending side:
>
>         upload-pack.c   wants handle_revision_opt etc.
>         revision.c      provides handle_revision_opt
>                         wants name_decoration etc.
>         log-tree.c      provides name_decoration
>                         wants append_signoff
>         sequencer.c     provides append_signoff
>
> It is already crazy. There is no reason for the pack sender to be
> linking with the sequencer interpreter machinery. If the function
> definition (and possibly other ones) are split into separate source
> files (still in libgit.a), git-upload-pack binary does not have to
> pull in the whole sequencer.c at all.

Agreed, which is precisely why my patches move that code out of
sequencer.c. Maybe log-tree.c is not the right destination, but it is
a step in the right direction.

> Coming back to the categorization Peff earlier made in the thread, I
> think I am OK with adding new two subdirectories to the root level,
> i.e.
>
>     builtin/    - the ones that define cmd_foo()

As is the case right now.

>     commands/   - the ones that has main() for standalone commands

Good.

>     libsrc/     - the ones that go in libgit.a

lib/ is probably descriptive enough.

But this doesn't answer the question; what about code that is shared
between builtins, but cannot be used by standalone programs?

I'd wager it belongs to builtin/ and should be linked to
builtin/lib.a. Maybe you would like to have a separate builtin/lib/
directory, but I think that's overkill.

> We may also want to add another subdirectory to hold scripted
> Porcelains, but the primary topic of this thread is what to do about
> the C library, so it is orthogonal in that sense, but if we were to
> go in the "group things in subdirectories to slim the root level"
> direction, it may be worth considering doing so at the same time.

Agreed. Plus there's completions, shell prompt, and other script-like
tools that shouldn't really belong in contrib/, and probably installed
by default.

-- 
Felipe Contreras
