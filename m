From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/5] Let git-add--interactive read colors from configuration
Date: Fri, 23 Nov 2007 01:17:33 -0800
Message-ID: <7vk5o9uxqq.fsf@gitster.siamese.dyndns.org>
References: <20071102224100.71665182@paradox.zwell.net>
	<20071104045735.GA12359@segfault.peff.net>
	<7v640ivagv.fsf@gitster.siamese.dyndns.org>
	<20071104054305.GA13929@sigill.intra.peff.net>
	<20071110180109.34febc3f@paradox.zwell.net>
	<20071122045606.0232fc2d@paradox.zwell.net>
	<20071122121836.GG12913@sigill.intra.peff.net>
	<7v63zu3r7h.fsf@gitster.siamese.dyndns.org>
	<20071122223050.GC3620@sigill.intra.peff.net>
	<474665E0.1010104@zwell.net>
	<20071123090918.GC5196@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dan Zwell <dzwell@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Wincent Colaiuta <win@wincent.com>,
	Jonathan del Strother <maillist@steelskies.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Frank Lichtenheld <frank@lichtenheld.de>,
	Jakub Narebski <jnareb@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Nov 23 10:18:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IvUfl-00028R-Kd
	for gcvg-git-2@gmane.org; Fri, 23 Nov 2007 10:18:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752359AbXKWJRr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Nov 2007 04:17:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752198AbXKWJRr
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Nov 2007 04:17:47 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:59520 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751670AbXKWJRq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Nov 2007 04:17:46 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id B90FD2F0;
	Fri, 23 Nov 2007 04:18:06 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 22D2C97D02;
	Fri, 23 Nov 2007 04:17:56 -0500 (EST)
In-Reply-To: <20071123090918.GC5196@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 23 Nov 2007 04:09:18 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65879>

Jeff King <peff@peff.net> writes:

> Note that there is one tricky part of config_bool, which is what
> config_bool('my.key', undef) should do (is it "default false" or "no
> default"?).

I am glad somebody finally got to the trick question I posed
earlier ;-)

But config_bool('key') and config_bool('key', undef) would both
return undef to say "The value is false" when key does not
exist, so it was not much of a trick.  It does not make a
difference if the undef came because the default parameter was
undef, or because there was no default parameter given and the
built-in behaviour of config_bool() was to return undef for a
missing key.
