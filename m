From: Junio C Hamano <gitster@pobox.com>
Subject: Re: warning: no common commits - slow pull
Date: Sun, 17 Feb 2008 09:54:53 -0800
Message-ID: <7vhcg71n9u.fsf@gitster.siamese.dyndns.org>
References: <200802102007.38838.lenb@kernel.org>
 <7vd4r4clnb.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.00.0802162239090.5496@iabervon.org>
 <alpine.LSU.1.00.0802171449230.30505@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Len Brown <lenb@kernel.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Feb 17 18:56:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQnk3-0001tN-74
	for gcvg-git-2@gmane.org; Sun, 17 Feb 2008 18:55:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752891AbYBQRzT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2008 12:55:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752324AbYBQRzT
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Feb 2008 12:55:19 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:53396 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752100AbYBQRzR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2008 12:55:17 -0500
Received: from a-sasl-quonix.pobox.com (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 3ADC661CE;
	Sun, 17 Feb 2008 12:55:14 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id
 C124261CA; Sun, 17 Feb 2008 12:55:05 -0500 (EST)
In-Reply-To: <alpine.LSU.1.00.0802171449230.30505@racer.site> (Johannes
 Schindelin's message of "Sun, 17 Feb 2008 14:57:15 +0000 (GMT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74147>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Sat, 16 Feb 2008, Daniel Barkalow wrote:
>
>> I wonder if the problem is that something isn't getting reinitialized 
>> for the second connection. It's not a separate invocation of fetch-pack, 
>> and I can't say for sure that it's sending the right info to the server 
>> when the statics in builtin-fetch-pack.c are left over from the earlier 
>> call. This would particularly explain the information that hitting 
>> ctrl-c and trying again fixes it.
>
> Oh, that should be it!  After all, the code in get_rev() in 
> builtin-fetch-pack.c marks commits as SEEN and COMMON and POPPED.

I seem to be slow today, but how does that explain that the
problem is reported only by Len so far?
