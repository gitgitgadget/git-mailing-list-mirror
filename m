From: Junio C Hamano <junkio@cox.net>
Subject: Re: Questions about git-rev-parse
Date: Tue, 27 Feb 2007 18:40:47 -0800
Message-ID: <7vvehn2eds.fsf@assigned-by-dhcp.cox.net>
References: <E1HMETh-0004BO-Lw@candygram.thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Theodore Ts'o" <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Wed Feb 28 03:40:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMEkN-0006wY-OP
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 03:40:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751161AbXB1Ckt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 21:40:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751196AbXB1Ckt
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 21:40:49 -0500
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:33337 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751161AbXB1Cks (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 21:40:48 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070228024049.KEQR1226.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Tue, 27 Feb 2007 21:40:49 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Uqgn1W00y1kojtg0000000; Tue, 27 Feb 2007 21:40:48 -0500
In-Reply-To: <E1HMETh-0004BO-Lw@candygram.thunk.org> (Theodore Ts'o's message
	of "Tue, 27 Feb 2007 21:23:37 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40876>

"Theodore Ts'o" <tytso@mit.edu> writes:

> So I'm wondering if I'm missing something about historical context,
> since from looking at git-rev-parse, it looks like not a lot of thought
> went into its design, and it has a bunch of stuff that grew via
> accretion; or maybe I'm not understanding why it was designed the way it
> was?

You are lacking historical context that our porcelain-ish were
all Bourne shell scripts.  If you check out an old version (say
v0.99), it would be apparent why translating symbolic names to
object names and canonicalizing a..b to b ^a were useful to help
them.

These days, "log" family got sufficiently smart that there are
not many reasons to write shell pipeline that has rev-list on
the upstream with diff-tree --stdin on the downstream anymore,
and rev-parse outlived its original purpose of sifting between
rev-list args/flags and others.
