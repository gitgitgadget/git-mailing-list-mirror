From: Ryan Anderson <ryan@michonline.com>
Subject: Re: Cannot install git RPM
Date: Tue, 9 Aug 2005 20:30:12 -0400
Message-ID: <20050810003012.GB22778@mythryan2.michonline.com>
References: <20050809104040.B9C61352B36@atlas.denx.de> <20050809110705.6B1FF352B36@atlas.denx.de> <7v3bpjxoi1.fsf@assigned-by-dhcp.cox.net> <7vr7d3uj7n.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Wolfgang Denk <wd@denx.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 10 02:31:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E2eUA-0002te-R2
	for gcvg-git@gmane.org; Wed, 10 Aug 2005 02:30:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750976AbVHJAaU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Aug 2005 20:30:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750991AbVHJAaU
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Aug 2005 20:30:20 -0400
Received: from mail.autoweb.net ([198.172.237.26]:36498 "EHLO mail.autoweb.net")
	by vger.kernel.org with ESMTP id S1750976AbVHJAaT (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Aug 2005 20:30:19 -0400
Received: from pcp01184054pcs.strl301.mi.comcast.net ([68.60.186.73] helo=michonline.com)
	by mail.autoweb.net with esmtp (Exim 4.44)
	id 1E2eU2-0003oz-0L; Tue, 09 Aug 2005 20:30:14 -0400
Received: from mythical ([10.254.251.11] ident=Debian-exim)
	by michonline.com with esmtp (Exim 3.35 #1 (Debian))
	id 1E2eU1-0002RG-00; Tue, 09 Aug 2005 20:30:13 -0400
Received: from ryan by mythical with local (Exim 4.52)
	id 1E2eU0-0005bT-VG; Tue, 09 Aug 2005 20:30:12 -0400
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vr7d3uj7n.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 09, 2005 at 10:13:32AM -0700, Junio C Hamano wrote:
> Junio C Hamano <junkio@cox.net> writes:
> 
> >> But the resulting RPM cannot be installed either,  at  least  not  in
> >> standard Fedora Core 2/3/4 installations:
> >> ...
> >> Is there at least some  documentation  which  external  packages  are
> >> needed, and where to find these?
> 
> The problematic one is git-send-email-script.  

Yup.  I'll take the blame for that one - I forget how inclusive the
Debian packaging is compared to the other distributions.

> I have to admit that it was a mistake to take that patch; I was
> trying to be _too_ inclusive.  The script does not even read
> from nor write into a git repository, and the only relevance to
> git is that it is useful for people to patchbomb the list with
> git generated patches.  In other words, the program may be
> useful, but its usefulness does not have much to do with git, so
> it does not belong to git.

Well, here I think I disagree.  I think it's a valid, possibly vital,
part of the suggested workflow for maintainers of projects.  Admittedly,
the emails can be sent by hand in many cases - but for the "clean up the
history" goal of exporting things out as patches, the email step is
important.

> My short-term plan is to downgrade it to "contrib" status, and
> not touch it from the main Makefile.  It will be in the 0.99.4
> sources but will not be installed nor made into binary package.
> I hope Ryan does not mind this decision.

Not at all.  I agree that the RPM dependency problem is a good reason to
not install it by default.   What I will do is make this the beginning
of my directory structure reorganization.  I'll probably also convert
the Debian package to a multi-package system, so we have a demonstration
of splitting these two items up.

-- 

Ryan Anderson
  sometimes Pug Majere
