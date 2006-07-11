From: Pavel Roskin <proski@gnu.org>
Subject: Re: [PATCH] Avoid C++ comments, use C comments instead
Date: Tue, 11 Jul 2006 01:17:27 -0400
Message-ID: <1152595047.29932.9.camel@dv>
References: <20060710065751.22902.43316.stgit@dv.roinet.com>
	 <7vzmfhdhrf.fsf@assigned-by-dhcp.cox.net>
	 <20060710094653.GA52962@dspnet.fr.eu.org>
	 <Pine.LNX.4.63.0607101306030.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	 <20060710114117.GA62514@dspnet.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 11 07:17:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G0Aco-0004m4-CM
	for gcvg-git@gmane.org; Tue, 11 Jul 2006 07:17:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965148AbWGKFRb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 11 Jul 2006 01:17:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965158AbWGKFRb
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Jul 2006 01:17:31 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:60822 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S965148AbWGKFRb
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jul 2006 01:17:31 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1G0Ack-0005tA-9V
	for git@vger.kernel.org; Tue, 11 Jul 2006 01:17:30 -0400
Received: from proski by dv.roinet.com with local (Exim 4.62)
	(envelope-from <proski@dv.roinet.com>)
	id 1G0Ach-0007uM-9U; Tue, 11 Jul 2006 01:17:27 -0400
To: Olivier Galibert <galibert@pobox.com>
In-Reply-To: <20060710114117.GA62514@dspnet.fr.eu.org>
X-Mailer: Evolution 2.7.3 (2.7.3-9) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23685>

Hello!

On Mon, 2006-07-10 at 13:41 +0200, Olivier Galibert wrote:
> Supporting old, not-standard-anymore compilers has a cost in
> maintainability, by precluding the use of better constructs (//
> comments, declarations near initialisation, struct initializers...).
> Additionally, it gets harder and harder to have people test for them.

Sorry for one more addition to this thread.  I just want to clear some
misunderstanding.  The whole point of fixing the comments is to make is
easier to test for other compatibility issues using gcc.

For gcc to report post-c89 features, "-pedantic -std=c89" should be
supplied.  This option makes gcc report the c99 comments as errors and
other c99 features as warnings.  The errors would stand in the way of
finding the warnings.

I'm not saying all non-c89 constructs should be fixed, but if we get a
report that some feature is not working with some compiler, we could
compile git with "-pedantic -std=c89", find corresponding warnings and
fix them.  The comments would stand in the way for somebody using gcc.

-- 
Regards,
Pavel Roskin
