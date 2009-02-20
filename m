From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Recovering from missing objects?
Date: Thu, 19 Feb 2009 22:09:20 -0800
Message-ID: <7vmychiqr3.fsf@gitster.siamese.dyndns.org>
References: <alpine.LRH.2.00.0902191447040.16988@vixen.sonytel.be>
 <7vvdr6j6hz.fsf@gitster.siamese.dyndns.org>
 <20090220025810.GB22419@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 20 07:10:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaOb9-0004d6-PK
	for gcvg-git-2@gmane.org; Fri, 20 Feb 2009 07:10:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751875AbZBTGJ2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2009 01:09:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751754AbZBTGJ2
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Feb 2009 01:09:28 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:53818 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750984AbZBTGJ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2009 01:09:27 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 4F2CD2B861;
	Fri, 20 Feb 2009 01:09:26 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 6E00F2B85E; Fri,
 20 Feb 2009 01:09:22 -0500 (EST)
In-Reply-To: <20090220025810.GB22419@coredump.intra.peff.net> (Jeff King's
 message of "Thu, 19 Feb 2009 21:58:10 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 06B7AAF8-FF15-11DD-ACD0-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110799>

Jeff King <peff@peff.net> writes:

> Might it not be simpler to just copy or hardlink the pack from the new
> clone into the old directory's .git/objects/pack? That will get more
> than you need, but things should start working, at which point a "git
> repack -a -d" will make it small again.
>
> Or am I misunderstanding something?

If you already have a good clone and a half-broken one locally, of course,
what you said is the easiest.

I just assumed that Geert did not really want to copy the whole pack.
Maybe he doesn't mind in this particular case, but the next breakage may
involve gigapacks he'd rather not re-clone.

I also assumed that anybody who is reading the message can easily guess
that the copy I was demonstrating in the description could be done across
machines, instead of via local /var/tmp/, and "In the new clone" steps
could even be done in the original one.  Presenting the knowledge that
way, the solution hopefully would be adjustable for more people who are
reading this thread.
