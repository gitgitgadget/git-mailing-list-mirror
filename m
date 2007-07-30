From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Efficient way to import snapshots?
Date: Mon, 30 Jul 2007 14:04:57 -0700
Message-ID: <7vps29k3gm.fsf@assigned-by-dhcp.cox.net>
References: <20070730180710.GA64467@nowhere>
	<alpine.LFD.0.999.0707301144180.4161@woody.linux-foundation.org>
	<20070730192922.GB64467@nowhere>
	<alpine.LFD.0.999.0707301240330.4161@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Craig Boston <craig@olyun.gank.org>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Jul 30 23:06:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFcQW-0001cn-GD
	for gcvg-git@gmane.org; Mon, 30 Jul 2007 23:05:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937192AbXG3VE7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Jul 2007 17:04:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936837AbXG3VE7
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jul 2007 17:04:59 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:45144 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764776AbXG3VE6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2007 17:04:58 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070730210458.NNBM26965.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Mon, 30 Jul 2007 17:04:58 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Vx4x1X00V1kojtg0000000; Mon, 30 Jul 2007 17:04:57 -0400
In-Reply-To: <alpine.LFD.0.999.0707301240330.4161@woody.linux-foundation.org>
	(Linus Torvalds's message of "Mon, 30 Jul 2007 12:52:52 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54264>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> That said, I just noticed something nasty: "git add ." is *horrible*. It 
> does the full SHA1 re-computation even though the index is up-to-date. 
> That's really nasty.
>
> So right now, due to this performance bug, it's actually much better to do 
> something more complex, namely something like
>
> 	git ls-files -o | git update-index --add --stdin
> 	git commit -a
>
> which is a lot more efficient than just doing "git add .".
>
> Junio? I _thought_ we already took the index into account with "git add", 
> but we obviously don't. 

I do not know offhand.

By the way, the above "something more complex" may be a simple
"git add -u".
