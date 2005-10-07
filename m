From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add support for parallel HTTP transfers
Date: Fri, 07 Oct 2005 11:08:46 -0700
Message-ID: <7vachl42tt.fsf@assigned-by-dhcp.cox.net>
References: <20051005214447.GF15593@reactrix.com>
	<Pine.LNX.4.63.0510061550510.23242@iabervon.org>
	<20051007000041.GH15593@reactrix.com>
	<Pine.LNX.4.63.0510071149550.23242@iabervon.org>
	<7v8xx55kia.fsf@assigned-by-dhcp.cox.net>
	<20051007172206.GK15593@reactrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 07 20:11:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ENwed-0000I0-LC
	for gcvg-git@gmane.org; Fri, 07 Oct 2005 20:09:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030544AbVJGSIt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Oct 2005 14:08:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030548AbVJGSIt
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Oct 2005 14:08:49 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:38033 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1030544AbVJGSIs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Oct 2005 14:08:48 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051007180830.JCZJ24014.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 7 Oct 2005 14:08:30 -0400
To: Nick Hengeveld <nickh@reactrix.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9811>

Nick Hengeveld <nickh@reactrix.com> writes:

> I think the only downside to leaving that check in place is that when
> pull() finishes there may be completed requests left behind in the
> queue, possibly with unreported transfer errors.  Would it make sense
> to just release any requests left in the queue after pull(), and report
> if any of them had transfer errors?

Pull finishing and reporting success while some requests have
still been outstanding with transfer errors sounds to me that
decision to finish and declare success is made prematurely.
What do these leftover requests you are worried about ask for?
Are you making redundant requests, which can turn out to be
unneeded?
