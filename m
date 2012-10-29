From: Lars Damerow <lars@pixar.com>
Subject: Re: [PATCH v3 0/8] Fix GIT_CEILING_DIRECTORIES that contain symlinks
Date: Sun, 28 Oct 2012 22:34:00 -0700
Message-ID: <20121029053400.GA19771@pixar.com>
References: <1350799057-13846-1-git-send-email-mhagger@alum.mit.edu>
 <7v7gqkgvxe.fsf@alter.siamese.dyndns.org>
 <CAJDDKr4ki+NjSeuZpAU6bM=YAQ_3mdHCtawstdCqe9Ewvp=arQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jiang Xin <worldhello.net@gmail.com>,
	Lea Wiemann <lewiemann@gmail.com>,
	David Reiss <dreiss@facebook.com>,
	Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	Marc Jordan <marc.jordan@disneyanimation.com>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 29 06:43:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TSi8W-0001Nx-As
	for gcvg-git-2@plane.gmane.org; Mon, 29 Oct 2012 06:43:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753604Ab2J2Fnc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Oct 2012 01:43:32 -0400
Received: from smx.pixar.com ([12.25.180.94]:53815 "EHLO smx.pixar.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752992Ab2J2Fnc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Oct 2012 01:43:32 -0400
X-Greylist: delayed 571 seconds by postgrey-1.27 at vger.kernel.org; Mon, 29 Oct 2012 01:43:32 EDT
X-PixarMID: 19264547
X-PixarRecvListener: OutboundMail
X-PixarRemoteIP: 138.72.131.157
X-IronPort-AV: E=Sophos;i="4.80,669,1344236400"; 
   d="scan'208,223";a="19264547"
Received: from helper.dynamic.pixar.com (HELO helper.pixar.com) ([138.72.131.157])
  by stratus.pixar.com with ESMTP; 28 Oct 2012 22:34:00 -0700
Received: by helper.pixar.com (Postfix, from userid 1690)
	id ADADA5C2073; Sun, 28 Oct 2012 22:34:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAJDDKr4ki+NjSeuZpAU6bM=YAQ_3mdHCtawstdCqe9Ewvp=arQ@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-12-10)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208586>

>From David Aguilar <davvid@gmail.com>, Sun, Oct 28, 2012 at 05:15:29PM -0700:
> 
> In 8030e44215fe8f34edd57d711a35f2f0f97a0423 Lars added
> GIT_ONE_FILESYSTEM to fix a related issue.
> Do you guys have GIT_CEILING_DIRECTORIES set too?

Once GIT_DISCOVERY_ACROSS_FILESYSTEM (the eventual name for GIT_ONE_FILESYSTEM) was accepted, we stopped setting GIT_CEILING_DIRECTORIES in our environment.

Even so, the way our filesystems work, stat() or lstat() calls on the paths that we used to have in GIT_CEILING_DIRECTORIES wouldn't have caused a problem.

I don't personally have an objection to patches that explicitly access the GIT_CEILING_DIRECTORIES paths, but it seems like other folks' configurations could be harmed by them.

-lars

--
lars r. damerow :: button pusher :: pixar animation studios
