From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t9600: require cvsps 2.1 to perform tests
Date: Tue, 04 Dec 2007 09:39:59 -0800
Message-ID: <7vhciy5pg0.fsf@gitster.siamese.dyndns.org>
References: <4752A53E.4030000@gmail.com>
	<20071202163426.GA29781@coredump.intra.peff.net>
	<47533D75.1090002@gmail.com>
	<Pine.LNX.4.64.0712022340250.27959@racer.site>
	<20071203015954.GB8322@coredump.intra.peff.net>
	<47548CEC.6010701@gmail.com>
	<7vir3fe54c.fsf@gitster.siamese.dyndns.org>
	<20071204014145.GA20145@coredump.intra.peff.net>
	<7v1wa3aukt.fsf@gitster.siamese.dyndns.org>
	<20071204154454.GA2994@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitzilla@gmail.com,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Dec 04 18:40:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Izbl2-00081Z-Cv
	for gcvg-git-2@gmane.org; Tue, 04 Dec 2007 18:40:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751004AbXLDRkM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Dec 2007 12:40:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751239AbXLDRkM
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Dec 2007 12:40:12 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:45136 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750964AbXLDRkK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Dec 2007 12:40:10 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id C6C052F0;
	Tue,  4 Dec 2007 12:40:28 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 36FD09CB46;
	Tue,  4 Dec 2007 12:40:24 -0500 (EST)
In-Reply-To: <20071204154454.GA2994@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 4 Dec 2007 10:44:54 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67066>

Jeff King <peff@peff.net> writes:

> On Mon, Dec 03, 2007 at 09:37:54PM -0800, Junio C Hamano wrote:
>
>> I wonder if it is better to grep for ' [-A] ' instead, like:
>> 
>> cvsps_supports_A=$(cvsps -h 2>&1 | sed -ne '/\[-A\]/p')
>> case "$cvsps_supports_A" in
>> '')
>> 	say 'skipping cvsimport tests, lacking cvsps that supports -A option'
>> 	test_done
>>         exit
>> esac
>
> I am not too opposed to that, but I felt that checking the version was a
> little bit more future proof. I.e., I have no idea if it is only -A that
> we need, but I know that 2.1 works and prior to 2.1 doesn't.

You are right about "we may be depending on what 2.1 has other than
-A".  Will apply as-is.

Thanks, both.

The primary reason I asked about '\[-A\]' was what will happen if
somebody uses 2.2.
