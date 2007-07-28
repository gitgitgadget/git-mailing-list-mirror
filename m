From: Thomas Glanzmann <thomas@glanzmann.de>
Subject: Re: [PATCH] Don't rely on unspecified behavior
Date: Sat, 28 Jul 2007 19:39:48 +0200
Message-ID: <20070728173948.GD23337@cip.informatik.uni-erlangen.de>
References: <11856407793933-git-send-email-tschwinge@gnu.org> <11856407791617-git-send-email-tschwinge@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Michael Gernoth <simigern@cip.informatik.uni-erlangen.de>
To: Thomas Schwinge <tschwinge@gnu.org>
X-From: git-owner@vger.kernel.org Sat Jul 28 19:39:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEqGf-0007A2-U0
	for gcvg-git@gmane.org; Sat, 28 Jul 2007 19:39:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754106AbXG1Rju (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 Jul 2007 13:39:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753406AbXG1Rju
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jul 2007 13:39:50 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:37838 "EHLO
	faui03.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750794AbXG1Rjt (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 28 Jul 2007 13:39:49 -0400
Received: by faui03.informatik.uni-erlangen.de (Postfix, from userid 31401)
	id B07DA3F428; Sat, 28 Jul 2007 19:39:48 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <11856407791617-git-send-email-tschwinge@gnu.org>
User-Agent: Mutt/1.5.15 (2007-05-02)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54044>

Hello,

> Calling access(p, m) with p == NULL is not specified, so don't do
> that.  On GNU/Hurd systems doing so will result in an SIGSEGV.

a friend of mine choked on this one when tried git for the second time
(the first time "git-repack -a -d -f" screwed his repository after the
initial checkout. This is fixed for a long time). Lucky me that he had
his libusbdriver in LD_PRELOAD which could not handle the NULL argument.
And I always thought libc would make the check before it does the system
call or does GNU/hurts not use the gnu libc?

	Thomas
