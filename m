From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] cast pid_t to long for printing
Date: Mon, 26 Jun 2006 02:26:02 -0700
Message-ID: <7vr71ci7yt.fsf@assigned-by-dhcp.cox.net>
References: <20060626080912.GA3646@informatik.uni-freiburg.de>
	<20060626082606.GC3646@informatik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 26 11:26:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FunM9-0004NG-Aj
	for gcvg-git@gmane.org; Mon, 26 Jun 2006 11:26:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964963AbWFZJ0F (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Jun 2006 05:26:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964967AbWFZJ0F
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jun 2006 05:26:05 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:8105 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S964964AbWFZJ0E (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jun 2006 05:26:04 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060626092603.ONPJ22974.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 26 Jun 2006 05:26:03 -0400
To: Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>
In-Reply-To: <20060626082606.GC3646@informatik.uni-freiburg.de> (Uwe
	Zeisberger's message of "Mon, 26 Jun 2006 10:26:06 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22668>

Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de> writes:

> While fixing daemon.c, I saw that there is a call to syslog using %d for
> pid_t, too.  I fixed that in the same way without further testing and
> manual reading. I assume that's OK.

Is anybody using pid_t that is wider than int?  IOW, I wonder if
it would make more sense to use "%d" with casting to int.
