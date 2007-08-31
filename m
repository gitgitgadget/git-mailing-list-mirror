From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Git.pm: Add remote_refs() git-ls-remote frontend
Date: Thu, 30 Aug 2007 17:26:22 -0700
Message-ID: <7vr6lk5z2p.fsf@gitster.siamese.dyndns.org>
References: <20070825221143.6514.22516.stgit@rover>
	<20070830233749.4480.72281.stgit@rover>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Fri Aug 31 02:27:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQuLm-0001at-1X
	for gcvg-git@gmane.org; Fri, 31 Aug 2007 02:27:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757078AbXHaA0m (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Aug 2007 20:26:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756996AbXHaA0m
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Aug 2007 20:26:42 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:56509 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756179AbXHaA0l (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Aug 2007 20:26:41 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id F3C3112B74F;
	Thu, 30 Aug 2007 20:27:00 -0400 (EDT)
In-Reply-To: <20070830233749.4480.72281.stgit@rover> (Petr Baudis's message of
	"Fri, 31 Aug 2007 01:37:49 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57097>

Petr Baudis <pasky@suse.cz> writes:

> Should support all the important features, I guess. Too bad that
>
> 	git-ls-remote --heads .
> 	
> is subtly different from
>
> 	git-ls-remote . refs/heads/
>
> so we have to provide the interface for specifying both.

Are they subtly different?  To me they look like asking for
completely different things.  IIRC, the patterns are ref globs,
so

	git ls-remote $URL 'refs/heads/*'

would be the same as the former one.

> This patch also converts git-remote.perl to use it.
>
> Signed-off-by: Petr Baudis <pasky@suse.cz>
> ---
> This version re-adds missed out stripping of refs/heads/ in git-remote.perl.

Ah, that was the bug you were talking about on #git channel, I
guess...
