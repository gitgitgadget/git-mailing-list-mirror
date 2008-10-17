From: Anders Melchiorsen <anders@kalibalik.dk>
Subject: Re: --diff-filter=T does not list x changes
Date: Fri, 17 Oct 2008 21:33:54 +0200
Message-ID: <87wsg7m2xp.fsf@kalibalik.dk>
References: <871vyhbsys.fsf@cup.kalibalik.dk>
	<20081016102201.GB20762@sigill.intra.peff.net>
	<7vhc7cq8uq.fsf@gitster.siamese.dyndns.org>
	<87ej2fvgv9.fsf@kalibalik.dk>
	<7v1vyfoca2.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 17 21:35:14 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kqv6P-00028w-GL
	for gcvg-git-2@gmane.org; Fri, 17 Oct 2008 21:35:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755816AbYJQTd6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Oct 2008 15:33:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755804AbYJQTd6
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Oct 2008 15:33:58 -0400
Received: from mail.hotelhot.dk ([77.75.163.100]:60251 "EHLO mail.hotelhot.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755525AbYJQTd5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Oct 2008 15:33:57 -0400
Received: from mail.hotelhot.dk (localhost [127.0.0.1])
	by mail.hotelhot.dk (Postfix) with ESMTP id 1F60814062;
	Fri, 17 Oct 2008 21:33:58 +0200 (CEST)
Received: from dylle (router.kalibalik.dk [192.168.0.1])
	by mail.hotelhot.dk (Postfix) with ESMTP id CF3031405A;
	Fri, 17 Oct 2008 21:33:57 +0200 (CEST)
In-Reply-To: <7v1vyfoca2.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's message of "Fri\, 17 Oct 2008 01\:29\:09 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98490>

Junio C Hamano <gitster@pobox.com> writes:

> Anders Melchiorsen <mail@cup.kalibalik.dk> writes:
>
>> I hope you agree that this reading is not obvious from the
>> documentation,...
>
> Yup, didn't I already say that the documentation is buggy?

Possibly, though not in this thread.


>> How about adding a diff-filter=X for the executable bit?
>
> I do not think it is a good idea for two reasons. Backward
> compatibility and sane design.
>
> For one thing, "diff --name-status" never shows X, so you would
> introduce an unnecessary inconsistency. If you change
> "--name-status" to avoid that, you would be breaking people's
> existing scripts that expect to see "M" for such a change.

(I noticed that X is already used in diff-filter, but will keep it for
this discussion)

I was thinking that X could be a subset of M. So only if you
specifically ask for diff-filter=X (and not M) would you get this new
functionality. That should keep it compatible. It would then pick
files that have had their x flipped, regardless of their change in
content. With diff-filter=M, it would work as it does today.

If name-status output must be consistent, it could even output M for
these changes. That would still be unambiguous (but probably confusing).

...

As you say that this is an unnecessary inconsistency, I wonder whether
you have a different way to pick out the commits that toggle the x
bit? That is a problem that I am facing, with no solution shown so far ...


Anders.
