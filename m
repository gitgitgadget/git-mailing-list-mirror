From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] make sha1_sort inline
Date: Thu, 17 Aug 2006 22:43:03 -0700
Message-ID: <7vsljud2fs.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0608172229070.25827@chino.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 18 07:43:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GDx8S-0000Z4-4p
	for gcvg-git@gmane.org; Fri, 18 Aug 2006 07:43:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964803AbWHRFnI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Aug 2006 01:43:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964804AbWHRFnI
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Aug 2006 01:43:08 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:12995 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S964803AbWHRFnH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Aug 2006 01:43:07 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060818054304.MTVM29796.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 18 Aug 2006 01:43:04 -0400
To: David Rientjes <rientjes@google.com>
In-Reply-To: <Pine.LNX.4.63.0608172229070.25827@chino.corp.google.com> (David
	Rientjes's message of "Thu, 17 Aug 2006 22:30:46 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25630>

David Rientjes <rientjes@google.com> writes:

> Inlines sha1_sort as discussed in previous thread.

The only use of this function is to got its address taken of,
and then the variable that has its address (current_sort) is
used by sort_comparator() function, whose address is given to
the library routine qsort(3).

Does it still make sense to declare it inline?
