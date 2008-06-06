From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/2] Allow git-apply to ignore the hunk headers
Date: Fri, 06 Jun 2008 08:14:44 -0700
Message-ID: <7vej7awq6z.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0806051115570.21190@racer>
 <4847CCD9.6000305@viscovery.net> <alpine.DEB.1.00.0806051403370.21190@racer>
 <4847EBC3.8060509@viscovery.net> <alpine.DEB.1.00.0806051441560.21190@racer>
 <4847F49F.8090004@viscovery.net> <alpine.DEB.1.00.0806051548140.21190@racer>
 <48480123.7030903@viscovery.net> <alpine.DEB.1.00.0806051719170.21190@racer>
 <alpine.DEB.1.00.0806051720070.21190@racer>
 <7vabhz1t2f.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0806052304300.21190@racer>
 <7v4p87zcv6.fsf@gitster.siamese.dyndns.org> <87iqwmzwcn.fsf@osv.gnss.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Sergei Organov <osv@javad.com>
X-From: git-owner@vger.kernel.org Fri Jun 06 17:16:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4dfe-00037Y-20
	for gcvg-git-2@gmane.org; Fri, 06 Jun 2008 17:16:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757946AbYFFPPA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2008 11:15:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757652AbYFFPPA
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jun 2008 11:15:00 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:35343 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757508AbYFFPO7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2008 11:14:59 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id D18355842;
	Fri,  6 Jun 2008 11:14:57 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 22155583B; Fri,  6 Jun 2008 11:14:52 -0400 (EDT)
In-Reply-To: <87iqwmzwcn.fsf@osv.gnss.ru> (Sergei Organov's message of "Fri,
 06 Jun 2008 14:33:28 +0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 533EA2CE-33DB-11DD-975C-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84077>

Sergei Organov <osv@javad.com> writes:

> Don't you think it's time to fix git-format-patch to put some reliable
> "end-of-patch" marker line before the signature?

Not at all.  git-apply is designed to (and has to) grok any reasonable
e-mailed patch, not just format-patch output.  And we should consider
having e-mail signature separator at the end as "reasonable".

It only becomes an issue when you start deviating from the rule of
reliable diff parsing, such as ignoring the old/new line count, which is
the topic of Dscho's patch.
