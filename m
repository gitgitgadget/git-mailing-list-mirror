From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/6] builtin-commit: Add newline when showing which commit was created
Date: Sun, 02 Dec 2007 10:34:49 -0800
Message-ID: <7vtzn1x7w6.fsf@gitster.siamese.dyndns.org>
References: <Pine.LNX.4.64.0711111730580.4362@racer.site>
	<Pine.LNX.4.64.0711111736440.4362@racer.site>
	<20071201222106.GA27102@coredump.intra.peff.net>
	<Pine.LNX.4.64.0712012238510.27959@racer.site>
	<20071202054030.GA393@coredump.intra.peff.net>
	<Pine.LNX.4.64.0712021212490.27959@racer.site>
	<20071202165409.GA30998@coredump.intra.peff.net>
	<Pine.LNX.4.64.0712021716220.27959@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org, krh@redhat.com,
	gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Dec 02 19:35:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iytf1-00013M-8y
	for gcvg-git-2@gmane.org; Sun, 02 Dec 2007 19:35:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750977AbXLBSe7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Dec 2007 13:34:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750954AbXLBSe7
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Dec 2007 13:34:59 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:39152 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750888AbXLBSe6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Dec 2007 13:34:58 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id CE09E2EF;
	Sun,  2 Dec 2007 13:35:18 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 48D8D9C207;
	Sun,  2 Dec 2007 13:35:13 -0500 (EST)
In-Reply-To: <Pine.LNX.4.64.0712021716220.27959@racer.site> (Johannes
	Schindelin's message of "Sun, 2 Dec 2007 17:18:24 +0000 (GMT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66805>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> I have made several attempts to reproduce the problem, looked a bit
>> through the log-tree code, and checked the results of the t750* series
>> of tests; but I have found nothing.
>
> I remember again.  When I did "commit -s -m bla" the  empty line between 
> the oneline and the signoff would be missing.  But in the meantime, the 
> signoff was dragged into the strbuf and all is well.

Sorry, now I am confused.  Building the version before that change and
doing "./git-commit -a -s -m bla", I do not see the extra blank line in
the "Created commit" response, and I see a blank line before and after
the sign-off in the "git show" output for the resulting commit.

Was this unnecessary change from the beginning?  I am inclined to think
so...
