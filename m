From: Junio C Hamano <gitster@pobox.com>
Subject: Re: tracking perms/ownership
Date: Sat, 25 Aug 2007 12:35:08 -0700
Message-ID: <7v4pin5rwz.fsf@gitster.siamese.dyndns.org>
References: <1187716461.5986.71.camel@beauty>
	<20070821134030.b763e9d3.seanlkml@sympatico.ca>
	<1187817948.5986.159.camel@beauty>
	<alpine.LFD.0.999.0708221618510.30176@woody.linux-foundation.org>
	<1187905879.5986.199.camel@beauty>
	<Pine.LNX.4.64.0708241136301.16728@wbgn129.biozentrum.uni-wuerzburg.de>
	<20070824095217.GB16853@coredump.intra.peff.net>
	<1187970632.6357.108.camel@beauty>
	<20070824205820.GA19152@coredump.intra.peff.net>
	<Pine.LNX.4.64.0708251630460.16728@wbgn129.biozentrum.uni-wuerzburg.de>
	<7vy7fz659s.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Josh England <jjengla@sandia.gov>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Aug 25 21:35:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IP1Pl-00007E-Ij
	for gcvg-git@gmane.org; Sat, 25 Aug 2007 21:35:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765912AbXHYTfS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Aug 2007 15:35:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764229AbXHYTfR
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Aug 2007 15:35:17 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:44382 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759965AbXHYTfQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Aug 2007 15:35:16 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 6D8EB1284D4;
	Sat, 25 Aug 2007 15:35:32 -0400 (EDT)
In-Reply-To: <7vy7fz659s.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sat, 25 Aug 2007 07:46:39 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56648>

Junio C Hamano <gitster@pobox.com> writes:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
>> Yes, please do.  Even if you do not end up implementing the perms/owner 
>> tracking using the clean/smudge filter, it seems odd that the filter 
>> should not get the filename.
>
> Please don't.  Go back to the list discussion and recall why any
> filters that depends on nothing but contents are bad ("crlf good,
> keyword bad").  Don't feed paths to filters.

Gaaaaah.  I meant "a filter whose action depends on anything
other than contents".  Those other things include history (so
"commit ID" is out) and pathnames.
