From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH (take 2)] gitweb: Do not parse refs by hand, use git-peek-remote instead
Date: Fri, 15 Sep 2006 02:05:43 -0700
Message-ID: <7vr6ydzehk.fsf@assigned-by-dhcp.cox.net>
References: <200609142327.23059.jnareb@gmail.com> <eedjrj$tja$1@sea.gmane.org>
	<7vvenpzi1h.fsf@assigned-by-dhcp.cox.net>
	<200609151043.20681.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 15 11:05:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GO9ds-0005qk-9H
	for gcvg-git@gmane.org; Fri, 15 Sep 2006 11:05:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750809AbWIOJFp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Sep 2006 05:05:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750817AbWIOJFp
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Sep 2006 05:05:45 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:28884 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1750809AbWIOJFo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Sep 2006 05:05:44 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060915090544.RLDQ13992.fed1rmmtao11.cox.net@fed1rmimpo02.cox.net>;
          Fri, 15 Sep 2006 05:05:44 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id NZ5l1V00B1kojtg0000000
	Fri, 15 Sep 2006 05:05:45 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <200609151043.20681.jnareb@gmail.com> (Jakub Narebski's message
	of "Fri, 15 Sep 2006 10:43:20 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27071>

Jakub Narebski <jnareb@gmail.com> writes:

> Junio C Hamano wrote:
>> Jakub Narebski <jnareb@gmail.com> writes:
>> 
>> > But, if we change git_get_refs_list to do also work of git_get_references,
>> > we should also change git_get_references to not use info/refs file at all
>> > (it can, and usually for unknown reasons is stale) but always use
>> > git-peek-remote, for consistency.
>> 
>> Yes that would make sense.  A repository served by gitweb does
>> not necessarily has to serve objects over http transport, so it
>> is nicer not to require info/refs to even exist or up to date.
>
> We do not require info/refs, as currently git_get_references falls
> back to git-ls-remotes (should be git-peek-remote as it is faster)
> if info/refs does not exist. But info/refs is usually stale; I guess
> it is updated on pull/fetch/push, but not on commit.

Yes, we are in agreement and are saying the same thing.
