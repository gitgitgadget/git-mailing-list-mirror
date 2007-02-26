From: Junio C Hamano <junkio@cox.net>
Subject: Re: RFC: Patch editing
Date: Mon, 26 Feb 2007 11:51:01 -0800
Message-ID: <7vveholmu2.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0702252156190.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<20070226180314.GA2108@spearce.org>
	<Pine.LNX.4.63.0702261949560.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<20070226185655.GB2108@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Feb 26 20:51:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLlsL-0001x3-9n
	for gcvg-git@gmane.org; Mon, 26 Feb 2007 20:51:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752464AbXBZTvF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Feb 2007 14:51:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752465AbXBZTvF
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Feb 2007 14:51:05 -0500
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:42396 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752464AbXBZTvE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Feb 2007 14:51:04 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070226195102.EWHQ3767.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Mon, 26 Feb 2007 14:51:02 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id UKr11W00v1kojtg0000000; Mon, 26 Feb 2007 14:51:02 -0500
In-Reply-To: <20070226185655.GB2108@spearce.org> (Shawn O. Pearce's message of
	"Mon, 26 Feb 2007 13:56:55 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40651>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Yea - this is a lot like rebase.  I was also thinking that the -m
> (merge mode) in rebase probably should be the only option offered.
> I don't see why rebase should format-patch|am when we have the
> whole commit available and merge-recursive does an excellent job
> on tree level merges.

One reason is that it just matches the practice to the mental
model.  Rebasing is like sending yourself a patch series and
applying with 'am' on top of a known commit afresh, which is
exactly what the command without -m does.

The other historical reason is that reconstructing (with -3) the
only part of the tree that matters in the 3-way merge and
running the merge was a lot faster with the merge tool we had,
than a full 3-way merge.
