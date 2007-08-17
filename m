From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix read-tree merging more than 3 trees using 3-way merge
Date: Thu, 16 Aug 2007 19:14:47 -0700
Message-ID: <7vbqd6j4a0.fsf@gitster.siamese.dyndns.org>
References: <600399.61066.qm@web52807.mail.re2.yahoo.com>
	<7vbqd8o1qs.fsf@gitster.siamese.dyndns.org>
	<alpine.LFD.0.999.0708161750550.30176@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Perrin Meyer <perrinmeyer@yahoo.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Aug 17 04:15:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILrNG-0004EV-6o
	for gcvg-git@gmane.org; Fri, 17 Aug 2007 04:15:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757985AbXHQCO7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Aug 2007 22:14:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759888AbXHQCO6
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Aug 2007 22:14:58 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:39483 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758132AbXHQCO5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Aug 2007 22:14:57 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 14992122BE0;
	Thu, 16 Aug 2007 22:15:10 -0400 (EDT)
In-Reply-To: <alpine.LFD.0.999.0708161750550.30176@woody.linux-foundation.org>
	(Linus Torvalds's message of "Thu, 16 Aug 2007 17:59:18 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56039>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> Sorry. I didn't even realize people did this. Oops.

This is no big deal.  It would have triggered if you are using
resolve strategy _and_ did a multi merge-base merge, the former
of which is quite unusual these days.

> What *is* the behaviour for four trees? Reading "unpack_trees()" source 
> implies that all other trees go into stage 1, where the first matching 
> entry is used?

Documentation/technical/trivial-merge.txt describes this under
three-way case.  Essentially this was an attempt to extend the
original merge-resolve so that it would catch problematic
criss-cross cases (case #16 in the description).
