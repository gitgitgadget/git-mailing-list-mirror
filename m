From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Make xstrndup common
Date: Thu, 03 May 2007 22:20:54 -0700
Message-ID: <7vtzutxiyx.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0705022248040.28708@iabervon.org>
	<81b0412b0705030206u3a6b8a46qfd98ccf597d3c96e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Daniel Barkalow" <barkalow@iabervon.org>, git@vger.kernel.org,
	"Junio C Hamano" <junkio@cox.net>
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 04 07:21:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HjqDz-0008BK-Qa
	for gcvg-git@gmane.org; Fri, 04 May 2007 07:21:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754572AbXEDFU4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 May 2007 01:20:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754574AbXEDFU4
	(ORCPT <rfc822;git-outgoing>); Fri, 4 May 2007 01:20:56 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:62078 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754572AbXEDFU4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2007 01:20:56 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070504052054.MVXA6556.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Fri, 4 May 2007 01:20:54 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id utLu1W00b1kojtg0000000; Fri, 04 May 2007 01:20:55 -0400
In-Reply-To: <81b0412b0705030206u3a6b8a46qfd98ccf597d3c96e@mail.gmail.com>
	(Alex Riesen's message of "Thu, 3 May 2007 11:06:05 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46130>

"Alex Riesen" <raa.lkml@gmail.com> writes:

> I'd suggest using platform-optimized memchr:

True.  On some architectures, strnlen() is a single instruction.
