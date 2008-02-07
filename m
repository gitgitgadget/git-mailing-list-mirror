From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Applying patches from gmane can be dangerous.
Date: Thu, 07 Feb 2008 00:21:36 -0800
Message-ID: <7vsl05p46n.fsf@gitster.siamese.dyndns.org>
References: <20080205211044.GP26392@lavos.net>
	<7vodatqu6w.fsf@gitster.siamese.dyndns.org>
	<ve51w5yb.fsf@blue.sea.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Thu Feb 07 09:22:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JN21S-0004yj-3i
	for gcvg-git-2@gmane.org; Thu, 07 Feb 2008 09:22:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754342AbYBGIVp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2008 03:21:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754305AbYBGIVp
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Feb 2008 03:21:45 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:40738 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754143AbYBGIVo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2008 03:21:44 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 2B8022B13;
	Thu,  7 Feb 2008 03:21:43 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 76EAE2B12;
	Thu,  7 Feb 2008 03:21:40 -0500 (EST)
In-Reply-To: <ve51w5yb.fsf@blue.sea.net> (Jari Aalto's message of "Thu, 07 Feb
	2008 10:01:32 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72908>

Jari Aalto <jari.aalto@cante.net> writes:

> FYI,
>
> Emacs Gnus + news.gmane.org gives access to raw articles with single
> command. Suppose cursor is at thread start "!"
>
> ! R. [  40: Junio C Hamano         ] Applying patches from gmane can be dangerous.
>   R.     [  19: Nicolas Pitre          ]
>
>
> Pressing "C-u g" will display the unmodified article as seen by mail
> transport. Running git's apply command can be automated pretty easily
> from there.

I do not think Gnus demiming (that C-u g helps us with) is not
an issue.

Have you tried to look at the article in question?  Inside your
Gnus + news.gmane.org, try typing this:

	j 7 2 6 9 9 <Enter> C-u g

The last two keystrokes are your "C-u g".

And look at the second line in the buffer, that says:

    From: Brian Downing <bdowning-oU/tDdhfGLReoWH0uzbU5w@public.gmane.org>

and weep X-<.

Then scroll down to find Signed-off-by: lines that are similarly
mangled, and weep more.

Maybe you run a much newer Gnus, and Lars taught "C-u g" to
unmangle them.  After all, gmane and Gnus are both his
creations, so it _is_ possible.  But somehow I doubt it.

If there weren't gmane address mangling, a quickest way to apply
a gmane patch to commit is:

	C-u g | g i t  a m - 3 - s <Enter>

	For Gnus uninitiated, it reads: show as raw as opposed
	to demimed (C-u g), pipe the article to the shell
	command (|) that is "git am -3 -s".

But I usually work in batches, so I first C-o (write to file)
the articles to a separate mbox, review and _edit_ them as
needed before running "git am".  And C-o does not suffer from
Gnus demiming, so C-u g is not useful in my workflow.
