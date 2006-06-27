From: Jeff King <peff@peff.net>
Subject: Re: bisect help
Date: Tue, 27 Jun 2006 18:04:21 -0400
Message-ID: <20060627220421.GA7234@coredump.intra.peff.net>
References: <20060627201302.GA16658@bork.org> <7vy7vi70bm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Hicks <mort@bork.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 28 00:04:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FvLfX-0001M6-Gm
	for gcvg-git@gmane.org; Wed, 28 Jun 2006 00:04:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030410AbWF0WEY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Jun 2006 18:04:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030411AbWF0WEY
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jun 2006 18:04:24 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:25784 "HELO
	peff.net") by vger.kernel.org with SMTP id S1030410AbWF0WEX (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Jun 2006 18:04:23 -0400
Received: (qmail 4972 invoked from network); 27 Jun 2006 18:04:01 -0400
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 27 Jun 2006 18:04:01 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 27 Jun 2006 18:04:21 -0400
To: Junio C Hamano <junkio@cox.net>
Mail-Followup-To: Junio C Hamano <junkio@cox.net>,
	Martin Hicks <mort@bork.org>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vy7vi70bm.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22755>

On Tue, Jun 27, 2006 at 02:31:09PM -0700, Junio C Hamano wrote:

>               o---o---o---o satadev
>              /             \   
>             /               o test
>            /               / 
>    2.6.17 o---o---o---o---o master
> 
> You say master works but test does not.  But everything between
> 2.6.17 and satadev would not work with your board *anyway*, so
> bisect by itself is not very useful between master and test.

Since 'test' is a throwaway branch anyway, might it not make sense to
clone master to test and then rebase satadev onto it? Thus you would end
up with the linear history:
  o---o---o---o---o---o---o test (satadev')
  |           |
2.6.17      master

You know that master works and satadev' doesn't, and the bisection is
simple. After you find that bug, you can throw away the test branch.

-Peff
