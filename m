From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANNOUNCE] tig-0.14
Date: Fri, 06 Feb 2009 23:28:05 -0800
Message-ID: <7vprhuzoxm.fsf@gitster.siamese.dyndns.org>
References: <20090205204436.GA6072@diku.dk>
 <20090206191511.GD19494@coredump.intra.peff.net>
 <2c6b72b30902061410l64c98c33g19b97f656d347c83@mail.gmail.com>
 <20090207071056.GB14856@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonas Fonseca <fonseca@diku.dk>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Feb 07 08:29:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVhdI-0003Y9-IS
	for gcvg-git-2@gmane.org; Sat, 07 Feb 2009 08:29:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753238AbZBGH2R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Feb 2009 02:28:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753114AbZBGH2R
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Feb 2009 02:28:17 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:60083 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753218AbZBGH2R (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Feb 2009 02:28:17 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 6DEF497185;
	Sat,  7 Feb 2009 02:28:15 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 19FF097182; Sat,
  7 Feb 2009 02:28:06 -0500 (EST)
In-Reply-To: <20090207071056.GB14856@coredump.intra.peff.net> (Jeff King's
 message of "Sat, 7 Feb 2009 02:10:56 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E2184904-F4E8-11DD-BF30-8B21C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108821>

Jeff King <peff@peff.net> writes:

> My impression is that tig is currently doing (1).  I think (2) will
> suffer from the same problem, but in practice the margin of error will
> be much smaller because your are rewinding through fewer changes. So if
> that is what you were suggesting, I think it is probably worth trying.

It has been quite a while since I did the "show previous" feature of
"git-blame --porcelain" that has been forever queued in 'next'; if I
remember correctly, it implemented (2).

The reason why it never graduated from 'next' is exactly this issue.  By
definition, there is no "previous" line number (if there were such a thing
that says "This line was at line N in the parent of the blamed commit",
then the commit wouldn't have taken the blame but would have passed it
down to the parent), and we need to come up with a reasonable heuristics.

So perhaps this discussion would motivate somebody to finish that part
off, and tig and other Porcelains can just read the necessary line number
from the git-blame output.
