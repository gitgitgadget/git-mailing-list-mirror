From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/2] Teach Git how to parse standard power of 2 suffixes.
Date: Sat, 30 Dec 2006 18:57:09 -0800
Message-ID: <7vk608hiwq.fsf@assigned-by-dhcp.cox.net>
References: <20061231020218.GA5366@spearce.org>
	<7vodpkhjzq.fsf@assigned-by-dhcp.cox.net>
	<20061231023809.GC5082@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 31 03:57:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H0qss-0003xH-FD
	for gcvg-git@gmane.org; Sun, 31 Dec 2006 03:57:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932178AbWLaC5M (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Dec 2006 21:57:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932691AbWLaC5M
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Dec 2006 21:57:12 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:49892 "EHLO
	fed1rmmtao05.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932178AbWLaC5L (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Dec 2006 21:57:11 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061231025710.HAST15640.fed1rmmtao05.cox.net@fed1rmimpo01.cox.net>;
          Sat, 30 Dec 2006 21:57:10 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 5EwP1W00b1kojtg0000000; Sat, 30 Dec 2006 21:56:24 -0500
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20061231023809.GC5082@spearce.org> (Shawn Pearce's message of
	"Sat, 30 Dec 2006 21:38:09 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35658>

Shawn Pearce <spearce@spearce.org> writes:

>> Also can we fix the definition of core.packedGitWindowSize to be
>> independent of the page size on a particular platform?
>
> What do you mean?  mmap() only works in page units, and because of
> the way the code is built the minimum size we can allow is 2 pages.
>
> Asking mmap() to map less than a full page in the last page of
> a given window is silly, as that is just going to waste virtual
> address space or cause pain for the OS, depending on how that
> gets implemented.

Ah, I misread the code.  I thought the value is integer that
states number of pages, but you are only rounding it down and
enforcing two-page minimum.

Sorry for the noise.
