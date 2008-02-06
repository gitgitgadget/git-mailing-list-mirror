From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH-v4 4/4] git-commit: add a prepare-commit-msg hook
Date: Wed, 06 Feb 2008 01:08:00 -0800
Message-ID: <7vy79y1mhb.fsf@gitster.siamese.dyndns.org>
References: <E1JMe6e-0004HH-Uq@fencepost.gnu.org>
	<7v1w7q4khm.fsf@gitster.siamese.dyndns.org>
	<E1JMfN3-0006XI-Qs@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Wed Feb 06 10:08:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMgGu-0004df-9h
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 10:08:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759814AbYBFJIO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2008 04:08:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759906AbYBFJIN
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Feb 2008 04:08:13 -0500
Received: from rune.pobox.com ([208.210.124.79]:59721 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759761AbYBFJIK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2008 04:08:10 -0500
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id 5CEC2192236;
	Wed,  6 Feb 2008 04:08:30 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 80DA4192065;
	Wed,  6 Feb 2008 04:08:24 -0500 (EST)
In-Reply-To: <E1JMfN3-0006XI-Qs@fencepost.gnu.org> (Paolo Bonzini's message of
	"Tue, 5 Feb 2008 08:04:18 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72777>

Paolo Bonzini <bonzini@gnu.org> writes:

> 	The way it can be used instead of the pre-commit hook
> 	is now documented differently: it is for verification
> 	that must *not* be skipped even for automatic commits
> 	(if there is such a beast).

I really do not think we should encourage this as a verification
method.  If you encourage it as such, I am sure people would
complain "Why can't I bypass this hook with --no-verify!!!".
I do not want to spend cycles defending the behaviour to error
out on non-zero exit from the hook.

Instead, I think you should _stress_ that people must _NOT_ use
this as a replacement for pre-commit hook.

The same comment applies to the comment in the example hook.
