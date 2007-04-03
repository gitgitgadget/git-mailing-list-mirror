From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-index-pack really does suck..
Date: Tue, 03 Apr 2007 15:41:23 -0700
Message-ID: <7v8xd9ulm4.fsf@assigned-by-dhcp.cox.net>
References: <db69205d0704031227q1009eabfhdd82aa3636f25bb6@mail.gmail.com>
	<Pine.LNX.4.64.0704031304420.6730@woody.linux-foundation.org>
	<alpine.LFD.0.98.0704031625050.28181@xanadu.home>
	<Pine.LNX.4.64.0704031346250.6730@woody.linux-foundation.org>
	<20070403210319.GH27706@spearce.org>
	<Pine.LNX.4.64.0704031411320.6730@woody.linux-foundation.org>
	<20070403211709.GJ27706@spearce.org>
	<Pine.LNX.4.64.0704031425220.6730@woody.linux-foundation.org>
	<Pine.LNX.4.64.0704031427050.6730@woody.linux-foundation.org>
	<7vd52lum2f.fsf@assigned-by-dhcp.cox.net>
	<20070403223840.GN27706@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Nicolas Pitre <nico@cam.org>, Chris Lee <clee@kde.org>,
	Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Apr 04 00:41:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HYrgx-0003En-EY
	for gcvg-git@gmane.org; Wed, 04 Apr 2007 00:41:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992456AbXDCWl0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Apr 2007 18:41:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992461AbXDCWlZ
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Apr 2007 18:41:25 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:33105 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992456AbXDCWlZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2007 18:41:25 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070403224125.UXEG373.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Tue, 3 Apr 2007 18:41:25 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id imhP1W00e1kojtg0000000; Tue, 03 Apr 2007 18:41:24 -0400
In-Reply-To: <20070403223840.GN27706@spearce.org> (Shawn O. Pearce's message
	of "Tue, 3 Apr 2007 18:38:40 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43686>

"Shawn O. Pearce" <spearce@spearce.org> writes:

>> I wonder if we can have a backdoor to avoid any object transfer
>> in such a case to begin with...
>
> Yea, symlink to the corresponding refs directory of the alternate
> ODB.  Then the refs will be visible.  ;-)

I was thinking about going the other way.  When git-fetch is
asked to fetch over a local transport, it could check if the
source is one of its alternate object stores.
