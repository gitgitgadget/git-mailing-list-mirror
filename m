From: Junio C Hamano <gitster@pobox.com>
Subject: Re: CR codes from git commands
Date: Fri, 23 Jan 2009 08:59:56 -0800
Message-ID: <7v63k6x8j7.fsf@gitster.siamese.dyndns.org>
References: <18805.64312.289059.660023@hungover.brentg.com>
 <alpine.LNX.1.00.0901212319310.19665@iabervon.org>
 <e38bce640901212334v1e672d48t81d5c81fecd929eb@mail.gmail.com>
 <alpine.LNX.1.00.0901220238380.19665@iabervon.org>
 <7vbptzahra.fsf@gitster.siamese.dyndns.org>
 <e2b179460901220204x7b6a43b5hddfee623d2425429@mail.gmail.com>
 <18808.39712.351656.138702@hungover.brentg.com>
 <alpine.LNX.1.00.0901221117110.19665@iabervon.org>
 <alpine.DEB.1.00.0901221751320.3586@pacific.mpi-cbg.de>
 <18809.60512.654436.59819@hungover.brentg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Mike Ralphson <mike.ralphson@gmail.com>, git@vger.kernel.org
To: Brent Goodrick <bgoodr@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 23 18:01:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQPPU-00038f-In
	for gcvg-git-2@gmane.org; Fri, 23 Jan 2009 18:01:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753102AbZAWRAJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2009 12:00:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752000AbZAWRAI
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jan 2009 12:00:08 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:65147 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751185AbZAWRAG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2009 12:00:06 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 2CD8B93AC9;
	Fri, 23 Jan 2009 12:00:05 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 2720193ABE; Fri,
 23 Jan 2009 11:59:57 -0500 (EST)
In-Reply-To: <18809.60512.654436.59819@hungover.brentg.com> (Brent Goodrick's
 message of "Fri, 23 Jan 2009 08:12:16 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 4820622A-E96F-11DD-BB83-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106888>

Brent Goodrick <bgoodr@gmail.com> writes:

>  - Bare minimum: Add a new --no-cr option (e.g., "git --no-cr
>    ...
>  - Nice-to-have: Add a "git --no-progress" message that would never
>  ...
> Both options are intended to be independent of each other.

I do not think so.  --no-progress should imply --no-cr ;-)

I do not think it makes much sense to pollute your non-terminal with 100
lines of 1%,2%,3%,...100% if it cannot sensibly do carriage-returns.  It
may be another knob to tweak, but it's a kind of thing you implement
because you could, not because it makes sense.  I would be mildly against
no-cr.

I suspect we may even be able to solve it without adding --no-progress.
Perhaps some commands do not have --quiet to squelch progress and teaching
them --quiet will solve the issue for you?
