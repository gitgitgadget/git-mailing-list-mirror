From: Junio C Hamano <gitster@pobox.com>
Subject: Re: first parent, commit graph layout, and pull merge direction
Date: Fri, 24 May 2013 09:26:41 -0700
Message-ID: <7vli74baym.fsf@alter.siamese.dyndns.org>
References: <20130522115042.GA20649@inner.h.apk.li>
	<7v4ndukhx0.fsf@alter.siamese.dyndns.org>
	<20130523090657.GB23933@inner.h.apk.li>
	<CAEBDL5WqYPYnU=YoCa2gMzcJCxeNbFmFgfWnHh=+HuouXLLsxg@mail.gmail.com>
	<20130523102959.GP9448@inner.h.apk.li>
	<20130523110839.GT27005@serenity.lan>
	<7vd2shheic.fsf@alter.siamese.dyndns.org>
	<20130523164114.GV27005@serenity.lan>
	<7vbo81e7gs.fsf@alter.siamese.dyndns.org>
	<20130523215557.GX27005@serenity.lan>
	<7vli75cpom.fsf@alter.siamese.dyndns.org>
	<CA+55aFz2Uvq4vmyjJPao5tS-uuVvKm6mbP7Uz8sdq1VMxMGJCw@mail.gmail.com>
	<7vppwhb52f.fsf@alter.siamese.dyndns.org>
	<CAMP44s0NmKO7qkxVDMqR7Lxutm19MdOQ+6u5_3MY6f18C_V3PA@mail.gmail.com>
	<CAMP44s3Ba7L5fvEQPo0VADzNn9pJeyr2=f+OyW+_V5kkuKqEEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	John Keeping <john@keeping.me.uk>,
	Andreas Krey <a.krey@gmx.de>,
	John Szakmeister <john@szakmeister.net>,
	Git Mailing List <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 24 18:26:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfupN-0002dE-HZ
	for gcvg-git-2@plane.gmane.org; Fri, 24 May 2013 18:26:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755504Ab3EXQ0p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 12:26:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36038 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755260Ab3EXQ0o (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 12:26:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DA57D206A6;
	Fri, 24 May 2013 16:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kYmSghRWF6AagFQzKix6YDBqT6Y=; b=f1nXGP
	ATJqM1AJ5kx9BvDogaV0Y0KEn4cWGUYOrNYqZpFGl3iePv6pm45RM541oa/RgXFJ
	25yiSdtrzP4Ihg4VxepP07ztZg5Izw7fauXE7n2WdkVq6hnMM8V9p9g6vNVUJyQ0
	sVSTE+4OVfH2obDyXJy5byUgY9GartBgweHDc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cxGpERhjZuxboiFaU+dTk874NkxPOPvc
	FDC9026deEgPbKtMCuybWIrZzVSGktoFK2tv/Y9pTD1p9O/rwJvcRmnCvaiIsNMr
	8tEbT9bkCIr9XvCCH1qovDJHnUKDxPE7/XdH1KXNxWyJrPlRCGvM2sCxD3Iu+G6q
	pCsJkUxGhrs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CC517206A5;
	Fri, 24 May 2013 16:26:43 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 23119206A4;
	Fri, 24 May 2013 16:26:43 +0000 (UTC)
In-Reply-To: <CAMP44s3Ba7L5fvEQPo0VADzNn9pJeyr2=f+OyW+_V5kkuKqEEw@mail.gmail.com>
	(Felipe Contreras's message of "Thu, 23 May 2013 19:32:59 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B8557AC2-C48E-11E2-8C9D-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225376>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> ... but I don't see why something small like that
> wouldn't make sense:
>
> The pull was not fast-forward, please either merge or rebase.

OK, I think I got what John was getting at and this single liner
message is a good summary of it.

Instead of telling them "you cannot push this thing without losing
history from the location you are pushing to; you need to become up
to date with respect to them before pushing" upon seeing a non ff
push failure, we can tell them "you cannot update your history to
what the place you get new changes from has without losing your
history; you need to integrate the two".

Initially I said limiting "git pull" to "--ff-only" by default did
not make sense, but when we view it that way, I now see how such a
default makes sense.

In another subthread, John Szakmeister mentioned that the "please
'git pull' first" message that a "push" gives when it stops due to
non-ff nudges the users in a wrong direction, because they often
take that 'git pull' too literally (e.g. 'pull --rebase' may be
necessary in their project, not 'git pull<ENTER>').

The original message deliberately avoided mentioning 'git pull' for
that exact reason, but in mid 2010 we made it worse.  The log of
that change says that it attempted to

    ... remains fuzzy to include "git pull", "git pull --rebase" and
    others, but directs the user to the simplest solution in the
    vast majority of cases.

but this thread shows that it did not work; the simplest solution
was a wrong one.  The message also may need to be rethought to
complement this direction being proposed for "pull".
