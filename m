From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] post-checkout hook, and related docs and tests
Date: Fri, 21 Sep 2007 17:15:26 -0700
Message-ID: <7vzlzfh7xd.fsf@gitster.siamese.dyndns.org>
References: <1190406421-15620-1-git-send-email-jjengla@sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Josh England <jjengla@sandia.gov>
X-From: git-owner@vger.kernel.org Sat Sep 22 02:15:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYseo-0005Yl-19
	for gcvg-git-2@gmane.org; Sat, 22 Sep 2007 02:15:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753164AbXIVAPd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2007 20:15:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753225AbXIVAPc
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Sep 2007 20:15:32 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:44219 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753099AbXIVAPc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Sep 2007 20:15:32 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id EE57A139556;
	Fri, 21 Sep 2007 20:15:49 -0400 (EDT)
In-Reply-To: <1190406421-15620-1-git-send-email-jjengla@sandia.gov>
	(root@sandia.gov's message of "Fri, 21 Sep 2007 14:27:01 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58899>

"root" <root@sandia.gov> writes:

> +post-checkout
> +-----------
> +
> +This hook is invoked when a `git-checkout` is run on a local repository.
> +The hook is given two parameters: the ref of the previous HEAD, and the ref of 
> +the new HEAD.  This hook cannot affect the outcome of `git-checkout`.
> +
> +This hook can be used to perform repository validity checks, auto-display
> +differences from the previous HEAD, or set working dir metadata properties.
> +

People may wonder why this is not run when they do "git checkout
otherbranch path.c"; the second sentence from the above
description implies why it shouldn't, but the first sentence
probably should state it more clearly.

What's the _semantics_ you are trying to achieve?

Why does the hook run every time git-bisect suggests the next
revision to try?

Why does the hook run when rebase starts its work?

When "git pull" or "git merge" results in a fast forward, the
situation is no different from checking out a new revision.  Why
doesn't the hook run in these cases?
