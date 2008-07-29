From: Junio C Hamano <gitster@pobox.com>
Subject: Re: theirs/ours was Re: [PATCH 6/6] Add a new test for using a
 custom merge strategy
Date: Mon, 28 Jul 2008 23:35:30 -0700
Message-ID: <7viqupkxjh.fsf@gitster.siamese.dyndns.org>
References: <bd6139dc0807280754x76b6ffedg6bf756dfce23f1e3@mail.gmail.com>
 <20080728185604.GA26322@sigill.intra.peff.net>
 <alpine.DEB.1.00.0807282008470.8986@racer>
 <7vproxrcvu.fsf@gitster.siamese.dyndns.org>
 <bd6139dc0807281310j16b4ef5alf9738ec0f3270ba0@mail.gmail.com>
 <7vljzlrca9.fsf@gitster.siamese.dyndns.org>
 <bd6139dc0807281324k38198fffwd3b586394b354ed2@mail.gmail.com>
 <7vvdyppv4c.fsf@gitster.siamese.dyndns.org>
 <20080729050845.GE26997@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: sverre@rabbelier.nl,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailinglist <git@vger.kernel.org>,
	Miklos Vajna <vmiklos@frugalware.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jul 29 08:36:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNip7-0005HO-MS
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 08:36:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751103AbYG2Gfl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 02:35:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750925AbYG2Gfl
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 02:35:41 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:35906 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750728AbYG2Gfk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2008 02:35:40 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 3698F43671;
	Tue, 29 Jul 2008 02:35:38 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 5D08F43670; Tue, 29 Jul 2008 02:35:32 -0400 (EDT)
In-Reply-To: <20080729050845.GE26997@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 29 Jul 2008 01:08:45 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8E8C86EE-5D38-11DD-AB94-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90592>

Jeff King <peff@peff.net> writes:

> Your reason was "it keeps your crap in the history". And while I
> generally am in favor of getting rid of crap and keeping a clean
> history, I think it is very much dependent on the individual project's
> preferences. IOW, that history might not contain "crap" but rather
> now-obsolete changes that are of historical interest.
>
> But I do agree that -Xtheirs is crap. ;)

Yes, that is why I did not merge 'master' with "theirs" merge into it to
subsume it.  I reverted -Xtheirs from 'next' (due to "never-rewind during
the cycle" rule) and intend to rebuild 'next' without it when 1.6.0 ships.

However, that does not keep me from holding onto its tip privately (and I
do, as the machinery to pass -Xoption through git-merge to backends would
be useful later).

IOW, "now-obsolete changes that are of historical interest" does not
necessarily justify a "subsuming" merge using "-s ours" or "-s theirs".
