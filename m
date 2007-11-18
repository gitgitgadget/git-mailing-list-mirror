From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] send-pack: track errors for each ref
Date: Sat, 17 Nov 2007 17:21:59 -0800
Message-ID: <7v6400z6tk.fsf@gitster.siamese.dyndns.org>
References: <20071117125323.GA23125@sigill.intra.peff.net>
	<20071117125426.GA23186@sigill.intra.peff.net>
	<Pine.LNX.4.64.0711171217200.12193@iabervon.org>
	<20071118001312.GB4000@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org,
	Alex Riesen <raa.lkml@gmail.com>,
	Pierre Habouzit <madcoder@debian.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Nov 18 02:22:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ItYri-0005w2-Pf
	for gcvg-git-2@gmane.org; Sun, 18 Nov 2007 02:22:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754767AbXKRBWK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Nov 2007 20:22:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754680AbXKRBWJ
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Nov 2007 20:22:09 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:40137 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754233AbXKRBWH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Nov 2007 20:22:07 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 8B4402EF;
	Sat, 17 Nov 2007 20:22:28 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 0496696CC9;
	Sat, 17 Nov 2007 20:22:22 -0500 (EST)
In-Reply-To: <20071118001312.GB4000@sigill.intra.peff.net> (Jeff King's
	message of "Sat, 17 Nov 2007 19:13:14 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65332>

Jeff King <peff@peff.net> writes:

> On Sat, Nov 17, 2007 at 01:05:35PM -0500, Daniel Barkalow wrote:
>
>> > +		if (ref->nonfastforward) {
>> > +			strcat(quickref, "...");
>> > +			type = '+';
>> > +			msg = " (forced update)";
>> > +		}
>> > +		else {
>> 
>> Coding style, IIRC.
>
> Sorry, I don't see the style nit you're mentioning here.

I think Daniel is referring to "Put 'else' on the same line as
the brace that closes the corresponding 'if' opened", iow:

	if (...) {
        	...
	} else {
		...
	}
