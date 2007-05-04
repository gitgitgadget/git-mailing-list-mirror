From: Junio C Hamano <junkio@cox.net>
Subject: Re: repack: handling of .keep files
Date: Fri, 04 May 2007 02:56:06 -0700
Message-ID: <7vy7k4ud3d.fsf@assigned-by-dhcp.cox.net>
References: <81b0412b0705040225p26679dbib6a1261a1a43ee67@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 04 11:56:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HjuWJ-0002l1-Iu
	for gcvg-git@gmane.org; Fri, 04 May 2007 11:56:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754171AbXEDJ4I (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 May 2007 05:56:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754607AbXEDJ4I
	(ORCPT <rfc822;git-outgoing>); Fri, 4 May 2007 05:56:08 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:53096 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754171AbXEDJ4H (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2007 05:56:07 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070504095605.UXSZ24310.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Fri, 4 May 2007 05:56:05 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id uxw61W0021kojtg0000000; Fri, 04 May 2007 05:56:06 -0400
In-Reply-To: <81b0412b0705040225p26679dbib6a1261a1a43ee67@mail.gmail.com>
	(Alex Riesen's message of "Fri, 4 May 2007 11:25:20 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46155>

"Alex Riesen" <raa.lkml@gmail.com> writes:

> ... Experimenting with the .keep-files I had a crash in git-log,
> when the pack was renamed into .keep.pack, but the
> index was not. git-log complained about two objects it could not
> read and than crashed. It's cygwin.

This part makes me suspect you are not even using the .keep
properly.  In addition to pack-[0-9a-f]{40}.(pack|idx), you
would have a corresponding pack-[0-9a-f]{40}.keep file (whose
contents does not matter) to mark that these should not get
repacked.
