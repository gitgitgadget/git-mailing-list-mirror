From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix Solaris Workshop Compiler issues
Date: Wed, 14 Nov 2007 19:27:41 -0800
Message-ID: <7vpryc89xu.fsf@gitster.siamese.dyndns.org>
References: <Pine.LNX.4.64.0711142125460.17530@bianca.dialin.t-online.de>
	<20071114204732.GE3973@steel.home>
	<7vprycfrk6.fsf@gitster.siamese.dyndns.org>
	<Pine.LNX.4.64.0711150011020.4135@bianca.dialin.t-online.de>
	<20071114232809.GH3973@steel.home>
	<20071115001756.GA25021@atjola.homenet>
	<7v3av89wq7.fsf@gitster.siamese.dyndns.org>
	<alpine.LFD.0.9999.0711141640400.2786@woody.linux-foundation.org>
	<85ir441exj.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	=?utf-8?Q?Bj=C3=B6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	Alex Riesen <raa.lkml@gmail.com>,
	Guido Ostkamp <git@ostkamp.fastmail.fm>, git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Thu Nov 15 04:28:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsVP2-0003R7-6n
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 04:28:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753631AbXKOD2M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2007 22:28:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753728AbXKOD2L
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Nov 2007 22:28:11 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:52890 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752166AbXKOD2K (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2007 22:28:10 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 82CB82F0;
	Wed, 14 Nov 2007 22:28:27 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 9215295ED3;
	Wed, 14 Nov 2007 22:28:20 -0500 (EST)
In-Reply-To: <85ir441exj.fsf@lola.goethe.zz> (David Kastrup's message of "Thu,
	15 Nov 2007 02:21:44 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65048>

David Kastrup <dak@gnu.org> writes:

> ...  I am pretty sure I have seen size calculations in
> the deltifying code that would break badly using FLEX_ARRAY=1.  So _IFF_
> -DFLEX_ARRAY=1 is supposed to be necessary for some compilers, I could
> try seeing whether I find those locations again.

I do recall that I received a patch with an explicit member
elem[1] that is in fact used as a flexible array, foolishly
converted it to use FLEX_ARRAY and saw it mysteriously fail, and
realized what it was doing and reverted my changes, and applied
the patch as received.  IIRC it all happened before I pushed the
results out.  I unfortunately do not recall which area the patch
was about.
