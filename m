From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Cloning from kernel.org, then switching to another repo
Date: Tue, 13 Nov 2007 11:13:15 -0800
Message-ID: <7vy7d2rmb8.fsf@gitster.siamese.dyndns.org>
References: <9e4733910711120557w62a9966bvb61a02a2bf9b99e9@mail.gmail.com>
	<Pine.LNX.4.64.0711121412410.4362@racer.site>
	<9e4733910711120736g31e3e84cx5a213afc4b889de7@mail.gmail.com>
	<Pine.LNX.4.64.0711121613570.4362@racer.site>
	<9e4733910711120822x18019fe6v40eb8ee0e48282dd@mail.gmail.com>
	<Pine.LNX.4.64.0711121635130.4362@racer.site>
	<9e4733910711120921q651208cby1276426ccd4b5fa4@mail.gmail.com>
	<20071113042017.GB9745@sigill.intra.peff.net>
	<9e4733910711122030q7bbf6057ubb6b5b27e1885500@mail.gmail.com>
	<vpq3avah3r0.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Jon Smirl" <jonsmirl@gmail.com>, "Jeff King" <peff@peff.net>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Git Mailing List" <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Tue Nov 13 20:16:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Is1FM-0007A4-UZ
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 20:16:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761857AbXKMTN1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 14:13:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761785AbXKMTN1
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 14:13:27 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:48167 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761623AbXKMTNX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 14:13:23 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id BA3462EF;
	Tue, 13 Nov 2007 14:13:44 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 1E7C195524;
	Tue, 13 Nov 2007 14:13:38 -0500 (EST)
In-Reply-To: <vpq3avah3r0.fsf@bauges.imag.fr> (Matthieu Moy's message of "Tue,
	13 Nov 2007 10:52:03 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64832>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> "Jon Smirl" <jonsmirl@gmail.com> writes:
>
>> Execute bit was not set. I just set it for all the scripts. +x is not
>> getting turned on with a default git init-db. I just made a new repo
>> to check, no +x on the scripts.
>
> That's by design: "git init" gives you _example_ hooks, but they won't
> run until you activate them explicitely with the appropriate chmod.
>
> That said, I'm not sure there's a really good reason not to run
> update-server-info by default on push. It doesn't cost much and saves
> a lot of troubles for beginners. Perhaps there are cases where the
> performance cost is non-negligible.

One incarnation of u-s-i we had in the past was quite a lot more
expensive, but we discarded the complexity, so I'd agree it
won't cost much in the current shape now.

The expensive one tried to record information to help dumb
transports better, such as "if you have this revision then you
do not have to fetch that pack but instead fetch this", as we
were discussing packs that have objects from duplicated,
staggered ranges.  The idea did not quite pan out.
