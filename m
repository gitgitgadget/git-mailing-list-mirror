From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: why git-reset needed after "cp -a" of a git repo?
Date: Wed, 22 Aug 2007 16:14:35 -0400
Message-ID: <20070822201435.GK20946@fieldses.org>
References: <alpine.LFD.0.999.0708221208090.30176@woody.linux-foundation.org> <200708221919.l7MJJNkX012184@agora.fsl.cs.sunysb.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Erez Zadok <ezk@cs.sunysb.edu>
X-From: git-owner@vger.kernel.org Wed Aug 22 22:14:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INwbI-00024B-2b
	for gcvg-git@gmane.org; Wed, 22 Aug 2007 22:14:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932124AbXHVUOn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Aug 2007 16:14:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763204AbXHVUOm
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Aug 2007 16:14:42 -0400
Received: from mail.fieldses.org ([66.93.2.214]:56487 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759573AbXHVUOl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2007 16:14:41 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1INwb5-0002MR-Gu; Wed, 22 Aug 2007 16:14:35 -0400
Content-Disposition: inline
In-Reply-To: <200708221919.l7MJJNkX012184@agora.fsl.cs.sunysb.edu>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56415>

On Wed, Aug 22, 2007 at 03:19:23PM -0400, Erez Zadok wrote:
> Thanks for the info and tips.  It's a good idea of course to detect any
> possible changes, but I wonder if for those of us who know what they're
> doing (i.e., living on the edge :-), there could be an option to ignore
> inode numbers and just depend on good 'ol ctime/mtime (as other tools like
> make do).

I don't think there's any need for that.  You can always just run
git-update-index --refresh or just git-status to refresh the stat data
that's kept in the index.  That miscellaneous stat data (ctime, mtime,
inode number) is just there as an optimization, so git-diff doesn't have
to read every file.  It can be tossed out and regenerated any time.

--b.
