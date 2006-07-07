From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] do not use locale specific strftime when preparing 2822 date
Date: Fri, 07 Jul 2006 12:25:17 -0700
Message-ID: <7vveq9w736.fsf@assigned-by-dhcp.cox.net>
References: <7vlkr7bvc1.fsf@assigned-by-dhcp.cox.net>
	<1152298675925-git-send-email-jnareb@gmail.com>
	<e8mb4l$t1u$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 07 21:25:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fyvx4-0000tu-MG
	for gcvg-git@gmane.org; Fri, 07 Jul 2006 21:25:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932276AbWGGTZU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Jul 2006 15:25:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932278AbWGGTZU
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Jul 2006 15:25:20 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:13487 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S932276AbWGGTZS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jul 2006 15:25:18 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060707192518.GZQD6235.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 7 Jul 2006 15:25:18 -0400
To: jnareb@gmail.com
In-Reply-To: <e8mb4l$t1u$1@sea.gmane.org> (Jakub Narebski's message of "Fri,
	07 Jul 2006 21:03:02 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23461>

Jakub Narebski <jnareb@gmail.com> writes:

> It looks like it is _almost_ correct. It should be
>   Date: Fri, 07 Jul 2006 20:57:55 +0200
> instead of
>   Date: Fri,  7 Jul 2006 20:57:55 +0200
>
> It is "day = ([FWS] 1*2DIGIT) / obs-day" in RFC2822.

I think you are reading ABNF wrong. <a>*<b>element means at least
<a> times and at most <b> times occurrences of element.  Exact
number of repetition is written as <n>element (which is a
short-and for <n>*<n>element).

See the definition of "hour" and friends a few lines below what
you quoted.  It is defined as "2DIGIT / obs-hour" and that is
why we say "01:23:45" not "1:23:45"
