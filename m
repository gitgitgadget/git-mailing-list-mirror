From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] refer to post-patch lines in whitespace warnings
Date: Wed, 09 Jan 2008 12:42:16 -0800
Message-ID: <7vabnehgt3.fsf@gitster.siamese.dyndns.org>
References: <alpine.LNX.1.00.0801091046100.13593@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Jan 09 21:42:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JChlH-00014L-IG
	for gcvg-git-2@gmane.org; Wed, 09 Jan 2008 21:42:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751893AbYAIUm2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2008 15:42:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752367AbYAIUm2
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jan 2008 15:42:28 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:34035 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751642AbYAIUm1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2008 15:42:27 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 0F60D1C8E;
	Wed,  9 Jan 2008 15:42:26 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 89E4E1C8D;
	Wed,  9 Jan 2008 15:42:23 -0500 (EST)
In-Reply-To: <alpine.LNX.1.00.0801091046100.13593@iabervon.org> (Daniel
	Barkalow's message of "Wed, 9 Jan 2008 10:57:40 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70011>

Daniel Barkalow <barkalow@iabervon.org> writes:

> When I rebase series with bad whitespace, I end up with unhelpful messages 
> like:
>
> .dotest/patch:412: trailing whitespace.
> -- 
> .dotest/patch:446: trailing whitespace.
> -- 
>
> These line numbers obviously refer to lines in a file that's been removed 
> by the time I can do anything about it. It seems to me like the message 
> would be more useful if, in the case where it leaves the working tree 
> modified with the non-compliant whitespace, it gave this location rather 
> than the patch's location (because, even if you have the patch still, 
> you'd need to revert it first in order to be able to apply a fixed version 
> anyway). Anybody see any problems with this theory?

I realize that I did not answer your primary question in the
previous response.

I think it is fine if you are thinking about _adding_ line
number of postimage (or preimage for that matter) to the warning
output, but I do not think we would want to remove the in-patch
line numbers we currently have and replace them with something
else.  I often very much appreciate the fact that these messages
precisely identify the problematic spots in the patch so that I
can go in and fix them in place before applying.
