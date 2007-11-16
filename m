From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/3] send-pack: assign remote errors to each ref
Date: Thu, 15 Nov 2007 21:05:16 -0800
Message-ID: <7v8x4y3hmb.fsf@gitster.siamese.dyndns.org>
References: <20071113102500.GA2767@sigill.intra.peff.net>
	<20071113113710.GC15880@sigill.intra.peff.net>
	<7vbq9xpprg.fsf@gitster.siamese.dyndns.org>
	<Pine.LNX.4.64.0711140159550.4362@racer.site>
	<20071115045414.GC9794@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Pierre Habouzit <madcoder@debian.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Alex Riesen <raa.lkml@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Nov 16 06:06:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IstOh-0004uv-Si
	for gcvg-git-2@gmane.org; Fri, 16 Nov 2007 06:05:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751131AbXKPFF0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Nov 2007 00:05:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750865AbXKPFF0
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Nov 2007 00:05:26 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:33723 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751108AbXKPFFZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Nov 2007 00:05:25 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 5B3672EF;
	Fri, 16 Nov 2007 00:05:46 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id B44F6932EB;
	Fri, 16 Nov 2007 00:05:39 -0500 (EST)
In-Reply-To: <20071115045414.GC9794@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 14 Nov 2007 23:54:17 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65190>

Jeff King <peff@peff.net> writes:

> On Wed, Nov 14, 2007 at 02:01:14AM +0000, Johannes Schindelin wrote:
>
>> Since when can refnames contain spaces?  In my copy of git, bad_ref_char() 
>> in refs.c returns 1 if ch <= ' '.  It's the first error path, even.
>
> Oops, I'm clearly an idiot. I explicitly looked at bad_ref_char before
> writing the original message, and somehow read that as strictly less
> than.
>
> So the parsing problem goes away, and I think using the sort order as a
> hint takes away the potential performance problem (I don't even know if
> it was a problem -- there may be other O(n^2) behavior).
>
> I will take a look at the tests Alex has been working on, maybe add a
> few to it, and submit a cleaned-up series.

Thanks.
