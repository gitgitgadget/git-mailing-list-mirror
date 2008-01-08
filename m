From: Junio C Hamano <gitster@pobox.com>
Subject: Re: CRLF problems with Git on Win32
Date: Mon, 07 Jan 2008 23:29:30 -0800
Message-ID: <7vejcswzad.fsf@gitster.siamese.dyndns.org>
References: <Pine.LNX.4.64.0801071010340.1864@ds9.cixit.se>
	<200801071947.28586.robin.rosenberg.lists@dewire.com>
	<alpine.LSU.1.00.0801071915470.10101@racer.site>
	<200801072203.23938.robin.rosenberg.lists@dewire.com>
	<alpine.LSU.1.00.0801072115120.10101@racer.site>
	<3B08AC4C-A807-4155-8AD7-DC6A6D0FE134@zib.de>
	<7vzlvhxpda.fsf@gitster.siamese.dyndns.org>
	<5310CD2F-C3B4-404A-9C2E-1D3084B5CC96@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds 
	<public-torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@hugh.gmane.org>,
	Johannes Schindelin 
	<public-Johannes.Schindelin-Mmb7MZpHnFY@hugh.gmane.org>,
	Robin Rosenberg 
	<public-robin.rosenberg.lists-RgPrefM1rjDQT0dZR+AlfA@hugh.gmane.org>,
	Jeff King <public-peff-AdEPDUrAXsQ@hugh.gmane.org>,
	Peter Karlsson 
	<public-peter-wzhfs8O2nkI+/KzbbBz5qQ@hugh.gmane.org>,
	Git Mailing List 
	<public-git-u79uwXL29TY76Z2rM5mHXA@hugh.gmane.org>,
	msysGit <public-msysgit-/JYPxA39Uh5TLH3MbocFFw@hugh.gmane.org>
To: public-prohaska-wjoc1KHpMeg@hugh.gmane.org
X-From: git-owner@vger.kernel.org Tue Jan 08 10:48:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCB4q-0000kb-VH
	for gcvg-git-2@gmane.org; Tue, 08 Jan 2008 10:48:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752935AbYAHJs3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2008 04:48:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756411AbYAHJs3
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jan 2008 04:48:29 -0500
Received: from blaine.gmane.org ([80.91.229.8]:59387 "EHLO hugh.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751575AbYAHJs1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2008 04:48:27 -0500
X-Greylist: delayed 2161 seconds by postgrey-1.27 at vger.kernel.org; Tue, 08 Jan 2008 04:48:27 EST
Received: from public by hugh.gmane.org with local (Exim 4.63)
	(envelope-from <public@hugh.gmane.org>)
	id 1JCAVR-0005va-LC
	for git@vger.kernel.org; Tue, 08 Jan 2008 10:12:21 +0100
Received: from public by hugh.gmane.org with local (Exim 4.63)
	(envelope-from <gitster@pobox.com>)
	id 1JCAUo-0005Qq-VF
	for public-git-u79uwXL29TY76Z2rM5mHXA@hugh.gmane.org; Tue, 08 Jan 2008 10:11:42 +0100
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25] helo=sasl.smtp.pobox.com)
	by hugh.gmane.org with esmtp (Exim 4.63)
	(envelope-from <gitster@pobox.com>)
	id 1JC8uF-0000Bo-V0; Tue, 08 Jan 2008 08:29:52 +0100
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 3B9A31CF7;
	Tue,  8 Jan 2008 02:29:44 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 6CE501CF6;
	Tue,  8 Jan 2008 02:29:34 -0500 (EST)
In-Reply-To: <5310CD2F-C3B4-404A-9C2E-1D3084B5CC96@zib.de> (Steffen Prohaska's
	message of "Tue, 8 Jan 2008 08:02:47 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-TMDA-Confirmed: Tue, 08 Jan 2008 10:11:42 +0100
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69853>




Steffen Prohaska <prohaska-wjoc1KHpMeg@public.gmane.org> writes:

> But core.autocrlf  = true has a slight danger of data corruption.
> AFAIK, git's binary detection checks the first "few" bytes (with
> few = 8000).  This may be sufficient in most case, but I already
> met a file that was wrongly classified.  (A File format that
> starts with a large ASCII header and has chunks of binary data
> attached later.)

I presume that's where .gitattributes kicks in.

> I like Linus' idea of "warn" or Gregory's "fail".

Yeah, that feels like a sensible thing to do.

> I'm asking the last question because every Unix developer should
> think about the option, too.  Neither Unix or Windows are causing
> the problem alone.

That's the logical conclusion.

If you are introducing crlf = warn, that means you are declaring
that CRLF should be treated as a disease, and that should apply
everywhere, not just on Windows (which some people may consider
a disease itself, but that is a separate topic).
