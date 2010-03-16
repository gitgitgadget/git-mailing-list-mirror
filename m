From: Lars Damerow <lars@pixar.com>
Subject: Re: [PATCH] Add support for GIT_ONE_FILESYSTEM
Date: Mon, 15 Mar 2010 20:28:58 -0700
Message-ID: <20100316032857.GA8734@pixar.com>
References: <20100315214003.GB11157@pixar.com> <20100316023306.GA14253@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 16 04:38:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrNc7-0004MG-0C
	for gcvg-git-2@lo.gmane.org; Tue, 16 Mar 2010 04:38:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965021Ab0CPDid (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Mar 2010 23:38:33 -0400
Received: from emx.pixar.com ([199.108.77.30]:26752 "EHLO emx.pixar.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964992Ab0CPDic (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Mar 2010 23:38:32 -0400
X-Greylist: delayed 574 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 Mar 2010 23:38:32 EDT
X-PixarMID: 1566335
X-PixarRecvListener: OutboundMail
X-PixarRemoteIP: 138.72.131.152
X-IronPort-AV: E=Sophos;i="4.49,647,1262592000"; 
   d="scan'208,223";a="1566335"
Received: from helper.dynamic.pixar.com ([138.72.131.152])
  by iris.pixar.com with ESMTP; 15 Mar 2010 20:29:00 -0700
Received: from helper.dynamic.pixar.com (localhost [127.0.0.1])
	by helper.dynamic.pixar.com (8.14.3/8.14.3) with ESMTP id o2G3SwoU008788;
	Mon, 15 Mar 2010 20:28:58 -0700
Received: (from lars@localhost)
	by helper.dynamic.pixar.com (8.14.3/8.14.3/Submit) id o2G3Sw3C008787;
	Mon, 15 Mar 2010 20:28:58 -0700
Content-Disposition: inline
In-Reply-To: <20100316023306.GA14253@coredump.intra.peff.net>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142296>

>From Jeff King <peff@peff.net>, Mon, Mar 15, 2010 at 10:33:06PM -0400:
> On Mon, Mar 15, 2010 at 02:40:03PM -0700, Lars Damerow wrote:
> 
> > +		if (getenv("GIT_ONE_FILESYSTEM") != NULL) {
> 
> Should this really trigger for GIT_ONE_FILESYSTEM=0? We already have
> git_env_bool, which will handle 0/1, true/false, etc. Probably you
> should use it here.

Thanks for the pointer--I wasn't aware of git_env_bool. I'll use it
instead.

> I am not a big fan of the environment variable name, either, but I don't
> have another good suggestion. It is closely related to
> GIT_CEILING_DIRECTORIES (in fact, you could probably solve the same
> problem with GIT_CEILING_DIRECTORIES, but I think your solution is much
> nicer in that it lets the user get away with being less verbose).

I was thinking about cp's -x option and its description in the man page
when I chose GIT_ONE_FILESYSTEM. Before I wrote this patch I configured
my machines to have their most popular automount points in
GIT_CEILING_DIRECTORIES, but need a more complete solution and don't
want to have a cron job running to keep the list up to date.

Do the overall idea and implementation have enough merit that the patch
could get accepted?

thanks,
-lars

--
lars r. damerow :: button pusher :: pixar animation studios

The big print giveth and the small print taketh away.
