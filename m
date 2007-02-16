From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] pretend-sha1: grave bugfix.
Date: Thu, 15 Feb 2007 23:29:39 -0800
Message-ID: <7v8xeya7bw.fsf@assigned-by-dhcp.cox.net>
References: <7v3b56dhr1.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0702160503290.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<20070216050943.GD28894@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Feb 16 08:29:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHxXM-0000Me-11
	for gcvg-git@gmane.org; Fri, 16 Feb 2007 08:29:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966165AbXBPH3l (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Feb 2007 02:29:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966166AbXBPH3l
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Feb 2007 02:29:41 -0500
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:53407 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966165AbXBPH3k (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Feb 2007 02:29:40 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070216072940.SRGM21704.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Fri, 16 Feb 2007 02:29:40 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Q7Vf1W00V1kojtg0000000; Fri, 16 Feb 2007 02:29:40 -0500
In-Reply-To: <20070216050943.GD28894@spearce.org> (Shawn O. Pearce's message
	of "Fri, 16 Feb 2007 00:09:43 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39896>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Aren't we using this for git-blame --contents?  How'd that ever
> work for a non-empty file?

My guess is that git-blame's blob handling has its own built-in
cache to avoid read_sha1_file(), and that single "initial" blob
is primed by hand, so read_sha1_file() is usually not called for
that object name.
