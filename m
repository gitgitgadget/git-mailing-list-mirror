From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase -p -i: handle "no changes" gracefully
Date: Mon, 17 Dec 2007 12:23:24 -0800
Message-ID: <7vprx56pfn.fsf@gitster.siamese.dyndns.org>
References: <2791F15A-EB72-4FE4-8DB3-7A4B4DCB07B3@frim.nl>
	<47623129.2030303@viscovery.net>
	<9CC305E7-3325-4D17-A43E-0A2072F52084@ai.rug.nl>
	<Pine.LNX.4.64.0712171649420.9446@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pieter de Bie <pdebie@ai.rug.nl>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Dec 17 21:24:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4MVU-0007Ja-EW
	for gcvg-git-2@gmane.org; Mon, 17 Dec 2007 21:24:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757802AbXLQUXm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 15:23:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757784AbXLQUXl
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 15:23:41 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:54750 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757577AbXLQUXl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 15:23:41 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id E0DE142A9;
	Mon, 17 Dec 2007 15:23:32 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 22A814298;
	Mon, 17 Dec 2007 15:23:26 -0500 (EST)
In-Reply-To: <Pine.LNX.4.64.0712171649420.9446@racer.site> (Johannes
	Schindelin's message of "Mon, 17 Dec 2007 16:59:38 +0000 (GMT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68611>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Since commit 376ccb8cbb453343998e734d8a1ce79f57a4e092, unchanged
> SHA-1s are no longer mapped via $REWRITTEN.  But the updating
> phase was not prepared for the old head not being rewritten.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>
> 	On Mon, 17 Dec 2007, Pieter de Bie wrote:
>
> 	> Ok, but what about the error in the rebase?
> 	> 
> 	> On Dec 14, 2007, at 2:21 AM, Pieter de Bie wrote:
> 	> > Tirana:~/git pieter$ time git rebase -p -i HEAD~100
> 	> > cat:
> 	> > /Users/pieter/git/.git/.dotest-merge/rewritten/1e8df762b38e01685f3aa3613e2d61f73346fcbe:
> 	> > No such file or directory
>
> 	This buglet was not caught earlier, probably because a 
> 	non-rewriting rebase is not really interesting ;-)

Hmph, care to add a test to t3404?
