From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Fix t3404 assumption that `wc -l` does not use
 whitespace.
Date: Thu, 15 May 2008 10:18:52 -0700
Message-ID: <7vr6c3h4eb.fsf@gitster.siamese.dyndns.org>
References: <20080427151610.GB57955@Hermes.local>
 <alpine.DEB.1.00.0804271620440.16320@eeepc-johanness>
 <B287EA35-6C5D-4A5A-BEF1-C55A70D913ED@silverinsanity.com>
 <20080428094119.GA20499@sigill.intra.peff.net>
 <e2b179460804280256g4ff903bu39c9460086df7157@mail.gmail.com>
 <20080513091143.GA26248@sigill.intra.peff.net>
 <e2b179460805131110k3cf582fdn9b8bd31046b90ca7@mail.gmail.com>
 <e2b179460805150316n77513037y5409042b01170d4e@mail.gmail.com>
 <20080515112030.GA12781@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mike Ralphson <mike.ralphson@gmail.com>,
	Brian Gernhardt <benji@silverinsanity.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 15 19:20:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jwh7b-0003cZ-6f
	for gcvg-git-2@gmane.org; Thu, 15 May 2008 19:20:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751082AbYEORTN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2008 13:19:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750905AbYEORTN
	(ORCPT <rfc822;git-outgoing>); Thu, 15 May 2008 13:19:13 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:60558 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750830AbYEORTM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2008 13:19:12 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 1AE945869;
	Thu, 15 May 2008 13:19:08 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 22ED55862; Thu, 15 May 2008 13:19:00 -0400 (EDT)
In-Reply-To: <20080515112030.GA12781@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 15 May 2008 07:20:30 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 06DA7028-22A3-11DD-86DD-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82212>

Jeff King <peff@peff.net> writes:

> On Thu, May 15, 2008 at 11:16:27AM +0100, Mike Ralphson wrote:
>
>> Which branch(es) would it be most useful on which to have this
>> automated build/test cycle?
>
> I would think maint, master, and next, but with next as the least
> important. I think Junio generally tests maint and master before
> publishing, but presumably not always next (as there was test breakage
> in next earlier today).

I'd prefer heterogeneous automated test coverage to be on 'next' and
'master'.  If the coverage extends to 'maint' that would be nicer, but on
the other hand, I rarely apply anything remotely questionable directly on
top of maint (instead, I'd fork from maint and merge the result first to
next or master), so if we can catch master and next, we should be Ok.

Before any push-out, I ran tests on all four integration branches on
Debian (etch) and FC (I think it is FC5), both x86-64.  But sometimes 'pu'
is shipped with known breakage in tests.  I can not push out with broken
tests in 'maint', 'master' or 'next' (automated procedure on my end
prevents me from doing so).
