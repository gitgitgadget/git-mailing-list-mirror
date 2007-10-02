From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Change "refs/" references to symbolic constants
Date: Tue, 02 Oct 2007 10:59:38 -0700
Message-ID: <7v1wcdmm7p.fsf@gitster.siamese.dyndns.org>
References: <200709291359.59147.andyparkins@gmail.com>
	<200710012141.44459.andyparkins@gmail.com>
	<20071002011659.GA7938@coredump.intra.peff.net>
	<200710020941.05288.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 02 20:00:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Icm2H-0005qP-0y
	for gcvg-git-2@gmane.org; Tue, 02 Oct 2007 19:59:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753973AbXJBR7p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2007 13:59:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753951AbXJBR7p
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Oct 2007 13:59:45 -0400
Received: from rune.pobox.com ([208.210.124.79]:52052 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753941AbXJBR7o (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2007 13:59:44 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id DEFBD1400AB;
	Tue,  2 Oct 2007 14:00:05 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 3845113FE9D;
	Tue,  2 Oct 2007 14:00:02 -0400 (EDT)
In-Reply-To: <200710020941.05288.andyparkins@gmail.com> (Andy Parkins's
	message of "Tue, 2 Oct 2007 09:41:03 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59705>

Andy Parkins <andyparkins@gmail.com> writes:

> I noticed a couple of places where memcmp() has been used where prefixcmp() 
> would work fine.  I'm tempted to change them too - what do you think?  
> Perhaps a separate patch?

In general, probably it is preferable to have a separate
"preliminary patch" to normalize the existing code without using
the new infrastructure (i.e. REF_* macros), and then to have the
main patch.  That way would make the main patch more about
mechanical conversion, which would be easier to verify
independently.
