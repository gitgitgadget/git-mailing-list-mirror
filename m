From: Matt Kraai <kraai@ftbfs.org>
Subject: Re: [PATCH] Improve QNX support in GIT
Date: Tue, 26 Feb 2013 13:02:46 -0800
Message-ID: <20130226210246.GB3502@ftbfs.org>
References: <20130226201305.GA3502@ftbfs.org>
 <CAHXAxrOcC7GX-rhT793t4vcF68TvrE9w9OW856+7cGDBGMx0VA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mike Gorchak <mike.gorchak.qnx@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 26 22:03:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UARgA-0008LX-Fd
	for gcvg-git-2@plane.gmane.org; Tue, 26 Feb 2013 22:03:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759658Ab3BZVCt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Feb 2013 16:02:49 -0500
Received: from kvm.ftbfs.org ([46.22.115.26]:43068 "EHLO kvm.ftbfs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758026Ab3BZVCt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Feb 2013 16:02:49 -0500
Received: from kraai by kvm.ftbfs.org with local (Exim 4.72)
	(envelope-from <kraai@ftbfs.org>)
	id 1UARfi-00011s-EW; Tue, 26 Feb 2013 13:02:46 -0800
Mail-Followup-To: Matt Kraai <kraai@ftbfs.org>,
	Mike Gorchak <mike.gorchak.qnx@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <CAHXAxrOcC7GX-rhT793t4vcF68TvrE9w9OW856+7cGDBGMx0VA@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217182>

On Tue, Feb 26, 2013 at 10:32:16PM +0200, Mike Gorchak wrote:
> I see. Most resource managers use procmgr_daemon(), which has no such
> limitation. Anyway, as far as I can see current git sources do not use
> fork together with pthread, except for daemonize() function.

If threads are enabled, git does use fork after calling pthread_create:

 * When I run "git grep foo".
 * When I run "git fetch" to update my git working copy, which is
   using an HTTPS remote.

Both of these commands fail as a result.
