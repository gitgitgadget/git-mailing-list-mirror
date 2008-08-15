From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] add boolean diff.suppress-blank-empty config option
Date: Fri, 15 Aug 2008 11:28:38 -0700
Message-ID: <7v4p5mb0a1.fsf@gitster.siamese.dyndns.org>
References: <87k5eiphro.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>, Paul Eggert <eggert@cs.ucla.edu>
To: Jim Meyering <jim@meyering.net>
X-From: git-owner@vger.kernel.org Fri Aug 15 20:29:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KU43Z-0004fU-Av
	for gcvg-git-2@gmane.org; Fri, 15 Aug 2008 20:29:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756505AbYHOS2q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Aug 2008 14:28:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755180AbYHOS2q
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Aug 2008 14:28:46 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:35650 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754573AbYHOS2p (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Aug 2008 14:28:45 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id BBB57607EB;
	Fri, 15 Aug 2008 14:28:44 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 2DE53607EA; Fri, 15 Aug 2008 14:28:41 -0400 (EDT)
In-Reply-To: <87k5eiphro.fsf@rho.meyering.net> (Jim Meyering's message of
 "Fri, 15 Aug 2008 14:47:07 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: FE56DD86-6AF7-11DD-AD93-B29498D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92505>

Jim Meyering <jim@meyering.net> writes:

> GNU diff's --suppress-blank-empty option makes it so that diff does not
> add a space or tab before each empty output line of context.  With this
> option, empty context lines are empty also in "git diff" output.

AFAIK, ERN 103/120 inspired by your comment merely says an empty context
is either an empty line or a line with a single space on it and does not
deprecate the latter, more traditional, form (I do not know the current
status of the update to the POSIX --- what's the recommended way to find
it out by outsiders?)

We've hacked the patch application side to accomodate this special case to
grok output from recent GNU diff already.  Can't we just stop at that,
without having to do the same for generation side?  What's the downside of
not doing so?
