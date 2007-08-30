From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add post-merge hook.
Date: Thu, 30 Aug 2007 16:07:27 -0700
Message-ID: <7v7inc7hao.fsf@gitster.siamese.dyndns.org>
References: <11885136172952-git-send-email-jjengla@sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: jjengla@sandia.gov
X-From: git-owner@vger.kernel.org Fri Aug 31 01:07:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQt6u-0006MC-9c
	for gcvg-git@gmane.org; Fri, 31 Aug 2007 01:07:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762335AbXH3XHc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Aug 2007 19:07:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759965AbXH3XHc
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Aug 2007 19:07:32 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:55641 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759548AbXH3XHb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Aug 2007 19:07:31 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 6BB4D12B6B3;
	Thu, 30 Aug 2007 19:07:51 -0400 (EDT)
In-Reply-To: <11885136172952-git-send-email-jjengla@sandia.gov>
	(jjengla@sandia.gov's message of "Thu, 30 Aug 2007 16:40:17 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57088>

jjengla@sandia.gov writes:

> From: Josh England <jjengla@sandia.gov>
>
> This adds a post-merge hook that will run after `git pull` operations
> if enabled.  The hook is passed no arguments and cannot affect the
> outcome of a merge.
>
> Signed-off-by: Josh England <jjengla@sandia.gov>

Thanks for your patch.

Two questions.

 * Do you want to run the post-merge hook even for a squash
   merge?

 * After resolving a conflicted merge, you would conclude it
   with "git commit"; don't you want to have the same hook apply
   at the commit time, or is that what you expect the user to
   deal with with post-commit hook?


And two requests and a half.

 - We would want a new test in the test suite for this, to make
   sure that later changes by others would not break this new
   feature you would depend upon.

 - You described _what_ the patch and the new feature do in the
   log message and in the documentation.

   You need to also explain _why_ somebody might want to have
   such a hook in his repository.

   . In the documentation, you would want to make the reader
     realize "aha, this is something that would help me" with an
     example.

   . In the log message, you would want to make sure other
     people understand why this new feature was added, what the
     design consideration were at the point of the feature was
     added.

   The latter is important to me personally.  I want to have
   something better than "this change does not break anything
   existing, and it is something somebody wants to get added, so
   while I can not image the exact use scenario why anybody
   would want to use such a hook I'd apply the change" to
   convince myself.

 - We are deep in feature-freeze for 1.5.3; I'd appreciate a
   resend for any patch that is not a bugfix / documentation
   update after 1.5.3 final.
