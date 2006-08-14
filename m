From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Multiple refs from the same remote in one git fetch
Date: Sun, 13 Aug 2006 17:20:16 -0700
Message-ID: <7vac68i2wv.fsf@assigned-by-dhcp.cox.net>
References: <7vveoxo8ni.fsf@assigned-by-dhcp.cox.net>
	<20060814001329.GA24694@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 14 02:20:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCQBz-0005QY-6M
	for gcvg-git@gmane.org; Mon, 14 Aug 2006 02:20:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751746AbWHNAUU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 13 Aug 2006 20:20:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751758AbWHNAUT
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Aug 2006 20:20:19 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:62194 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1751754AbWHNAUS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Aug 2006 20:20:18 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060814002017.CSBZ2704.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 13 Aug 2006 20:20:17 -0400
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
In-Reply-To: <20060814001329.GA24694@mellanox.co.il> (Michael S. Tsirkin's
	message of "Mon, 14 Aug 2006 03:13:29 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25302>

"Michael S. Tsirkin" <mst@mellanox.co.il> writes:

>> > Could this go into next then? 
>> 
>> No.  Spoke too fast.  Breaks t6200 test because it reports the
>> refs fetched in duplicates.
>
> Right, The problem was with the way I coded the loop in git-fetch.sh.
> Here's the fixed versin - seems to pass make test fine.

But what are you doing for single_force and not_for_merge when
there are more than one matches in the patch?  They seem to get
set to a random value depending on whatever happens to match
last, which does not feel quite right.
