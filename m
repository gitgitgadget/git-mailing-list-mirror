From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFH] straightening out "read-tree -m"
Date: Sun, 18 Mar 2007 17:04:06 -0700
Message-ID: <7v1wjmnlop.fsf@assigned-by-dhcp.cox.net>
References: <7vtzwjnhcb.fsf@assigned-by-dhcp.cox.net>
	<20070318121810.GA17807@moooo.ath.cx>
	<7v8xdul2rt.fsf@assigned-by-dhcp.cox.net>
	<45FDC95B.5020106@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthias Lederhofer <matled@gmx.net>, git@vger.kernel.org
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Mon Mar 19 01:21:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HT5cj-0006ik-Sx
	for gcvg-git@gmane.org; Mon, 19 Mar 2007 01:21:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964932AbXCSAVR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Mar 2007 20:21:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964934AbXCSAVR
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Mar 2007 20:21:17 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:44419 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964932AbXCSAVQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Mar 2007 20:21:16 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070319002115.TJWU1606.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Sun, 18 Mar 2007 20:21:15 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id cQMF1W00M1kojtg0000000; Sun, 18 Mar 2007 20:21:15 -0400
In-Reply-To: <45FDC95B.5020106@midwinter.com> (Steven Grimm's message of "Sun,
	18 Mar 2007 16:20:59 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42549>

Steven Grimm <koreth@midwinter.com> writes:

> On my to-do list for next week is to try to come up with a minimally
> complex test case to demonstrate the problem, as the actual
> repositories in question are pretty convoluted and there were a bunch
> of other unrelated changes. I didn't mention it before now because I
> knew my description was certain to be too vague to be useful without a
> test case to look at.

You are free to come up with test case, but I have a feeling
that the problem is already well understood (and that is why the
last part of my RFH matters a lot more than the former "case
table").  In short, "read-tree -m" (and unpack-trees) is screwy
in the presense of D/F conflicts.
