From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add [HOWTO] using merge subtree.
Date: Tue, 08 Jan 2008 17:35:33 -0800
Message-ID: <7vwsqjpyqi.fsf@gitster.siamese.dyndns.org>
References: <1199838182-15178-1-git-send-email-vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sean <seanlkml@sympatico.ca>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Wed Jan 09 02:36:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCPrk-00081L-D0
	for gcvg-git-2@gmane.org; Wed, 09 Jan 2008 02:36:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752604AbYAIBf5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2008 20:35:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752010AbYAIBf5
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jan 2008 20:35:57 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:62938 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751894AbYAIBf4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2008 20:35:56 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 05A961856;
	Tue,  8 Jan 2008 20:35:55 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 43E1E1852;
	Tue,  8 Jan 2008 20:35:50 -0500 (EST)
In-Reply-To: <1199838182-15178-1-git-send-email-vmiklos@frugalware.org>
	(Miklos Vajna's message of "Wed, 9 Jan 2008 01:23:02 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69942>

Miklos Vajna <vmiklos@frugalware.org> writes:

NAK.  It may be well intentioned, but it lacks too much context
to be usable as a generic teaching material.

> +Abstract: In this article, Sean demonstrates how one can use the subtree merge
> + strategy.
> +Message-ID: <BAYC1-PASMTP12374B54BA370A1E1C6E78AE4E0@CEZ.ICE>
> +
> +How to use the subtree merge strategy
> +=====================================

Here, before diving to the actual command sequence, you need to
tell the reader what the objective of the whole exercise is.

What's /path/to/B and how its contents relate to the contents of
the current repository?  How was that other repository prepared?
What's the ultimate goal, IOW, what overlayed tree layout are
you trying to create?  Why do you want to have that overlayed
layout?

When you heard it on the mailing list you may have had enough
background material from the discussion thread.  Your readers
won't have that.

> +----
> +$ git remote add -f B /path/to/B <1>
> +$ git merge -s ours --no-commit B/master <2>
> +$ git read-tree --prefix=B/ -u B/master <3>
> +$ git commit -m "Merge commit 'B/master'" <4>
> +----
> +<1> creates and fetches the remote.
> +<2> initiates a merge, but stops before committing it.
> +<3> reads B/master into the subdirectory "sub".
> +<4> all that remains is committing the completed merge.
> +
> +You only need this procedure for the first commit, after which `git merge -s
> +subtree B/master` is all you need.

Complaints for an overly long line aside, after that
description, having another code example block to illustrate the
exact command line would be more consistent with the above
display.  Alternatively, make it <5> and annotate that entry
with "You only need the above four steps once, after that you
can keep doing 'git pull -s subtree B master'".
