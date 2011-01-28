From: Jeff King <peff@peff.net>
Subject: Re: Keeping the file modification date with git
Date: Fri, 28 Jan 2011 17:25:52 -0500
Message-ID: <20110128222552.GA10372@sigill.intra.peff.net>
References: <87bp30vmek.fsf@an-dro.info.enstb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Ronan Keryell <Ronan.Keryell@hpc-project.com>
X-From: git-owner@vger.kernel.org Fri Jan 28 23:26:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Piwll-0005m5-Ef
	for gcvg-git-2@lo.gmane.org; Fri, 28 Jan 2011 23:26:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753602Ab1A1W0A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Jan 2011 17:26:00 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:59399 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753536Ab1A1WZ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Jan 2011 17:25:59 -0500
Received: (qmail 27653 invoked by uid 111); 28 Jan 2011 22:25:55 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Fri, 28 Jan 2011 22:25:55 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 28 Jan 2011 17:25:52 -0500
Content-Disposition: inline
In-Reply-To: <87bp30vmek.fsf@an-dro.info.enstb.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165645>

On Fri, Jan 28, 2011 at 08:49:39PM +0100, Ronan Keryell wrote:

> After heavily using git for code development, we plan to use it for
> administrative storage and I need to keep the modification date
> of the files.
> [...]
> So I'm envisioning different solutions:
> 
> - it is already done. I have missed this. :-) But would be great. :-)

Nope. The tree format does not have a date field.

> - giving up. Not an option :-)

Right. :)

> - it is added to git core functions because it is quite useful for some
>   people. Too time-consuming for me since I'm not a git developer... But
>   someone else could do this...

Nope. That would require changing one of the fundamental data structures
of git (the tree object) and is not likely to happen for a variety of
reasons (mostly it becomes a performance hit and a compatibility issue
when the majority of people don't even care about this issue).

> - add this concept aside. For example, just as there are .gitignore or
>   .gitattributes files, we could have a .gitdates that would store in a
>   human-readable manner the modification time of the files in its
>   directory.

Yep, this is a good solution. Check out metastore:

  http://david.hardeman.nu/software.php

-Peff
