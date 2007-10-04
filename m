From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (topics)
Date: Thu, 04 Oct 2007 00:10:48 -0700
Message-ID: <7vmyuzbbif.fsf@gitster.siamese.dyndns.org>
References: <7v1wdcch06.fsf@gitster.siamese.dyndns.org>
	<7v1wd1d0le.fsf@gitster.siamese.dyndns.org>
	<7vfy11yyxk.fsf@gitster.siamese.dyndns.org>
	<20070927023633.GA28902@coredump.intra.peff.net>
	<20071002041652.GA32133@coredump.intra.peff.net>
	<7vsl4up0tf.fsf@gitster.siamese.dyndns.org>
	<20071002050820.GA4261@coredump.intra.peff.net>
	<20071002051332.GA4462@coredump.intra.peff.net>
	<86ejge6o8b.fsf@lola.quinscape.zz>
	<20071002161114.GC6828@coredump.intra.peff.net>
	<86ve9p32cp.fsf@lola.quinscape.zz>
	<alpine.LFD.0.999.0710021916080.3579@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Kastrup <dak@gnu.org>, Jeff King <peff@peff.net>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Oct 04 09:11:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdKrX-0004w0-BN
	for gcvg-git-2@gmane.org; Thu, 04 Oct 2007 09:11:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755100AbXJDHK5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2007 03:10:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754962AbXJDHK5
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Oct 2007 03:10:57 -0400
Received: from rune.pobox.com ([208.210.124.79]:35948 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751421AbXJDHK4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2007 03:10:56 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id 8FCA91412A9;
	Thu,  4 Oct 2007 03:11:17 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id B943714179E;
	Thu,  4 Oct 2007 03:11:12 -0400 (EDT)
In-Reply-To: <alpine.LFD.0.999.0710021916080.3579@woody.linux-foundation.org>
	(Linus Torvalds's message of "Tue, 2 Oct 2007 19:28:19 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59923>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> Hmm. The patch depends on half-way subtle issues like the fact that the 
> hashtables are guaranteed to not be full => we're guaranteed to have zero 
> counts at the end => we don't need to do any steenking iterator count in 
> the loop. A few comments might in order.

The patch actually is quite readable.  That double-loop finding
the matching hashval in destination hash was simply silly to
begin with, so even if this is not "orders of magnitude"
improvement, I think your patch is worth doing.
