From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH (take 2)] gitweb: Do not parse refs by hand, use git-peek-remote instead
Date: Fri, 15 Sep 2006 00:48:58 -0700
Message-ID: <7vvenpzi1h.fsf@assigned-by-dhcp.cox.net>
References: <200609142327.23059.jnareb@gmail.com>
	<7v8xkm2gfs.fsf@assigned-by-dhcp.cox.net>
	<200609150343.28334.jnareb@gmail.com>
	<7v4pv91wqk.fsf@assigned-by-dhcp.cox.net> <eedjrj$tja$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 15 09:49:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GO8Rb-0007po-QF
	for gcvg-git@gmane.org; Fri, 15 Sep 2006 09:49:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751391AbWIOHtB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Sep 2006 03:49:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751392AbWIOHtA
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Sep 2006 03:49:00 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:45281 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1751391AbWIOHtA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Sep 2006 03:49:00 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060915074859.WWBQ22977.fed1rmmtao08.cox.net@fed1rmimpo02.cox.net>;
          Fri, 15 Sep 2006 03:48:59 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id NXp01V00S1kojtg0000000
	Fri, 15 Sep 2006 03:49:01 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <eedjrj$tja$1@sea.gmane.org> (Jakub Narebski's message of "Fri,
	15 Sep 2006 09:14:23 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27066>

Jakub Narebski <jnareb@gmail.com> writes:

> But, if we change git_get_refs_list to do also work of git_get_references,
> we should also change git_get_references to not use info/refs file at all
> (it can, and usually for unknown reasons is stale) but always use
> git-peek-remote, for consistency.

Yes that would make sense.  A repository served by gitweb does
not necessarily has to serve objects over http transport, so it
is nicer not to require info/refs to even exist or up to date.
