From: Jeff King <peff@peff.net>
Subject: Re: A tracking tree for the active work space
Date: Sun, 11 Mar 2007 17:40:11 -0400
Message-ID: <20070311214011.GA21155@coredump.intra.peff.net>
References: <9e4733910703110706m14abae25r2a965b644d8c3bbb@mail.gmail.com> <7vhcsrwn8d.fsf@assigned-by-dhcp.cox.net> <9e4733910703111335j20c0acf4wa12c2d410580898b@mail.gmail.com> <Pine.LNX.4.63.0703112209160.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Mar 11 22:40:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQVmL-0004Ow-QT
	for gcvg-git@gmane.org; Sun, 11 Mar 2007 22:40:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932704AbXCKVkP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Mar 2007 17:40:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932744AbXCKVkP
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Mar 2007 17:40:15 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3382 "HELO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932704AbXCKVkN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Mar 2007 17:40:13 -0400
Received: (qmail 11784 invoked from network); 11 Mar 2007 17:40:34 -0400
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 11 Mar 2007 17:40:34 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 11 Mar 2007 17:40:11 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0703112209160.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41988>

On Sun, Mar 11, 2007 at 10:31:58PM +0100, Johannes Schindelin wrote:

> - how do you want to cope with regular expressions? (The previous problem 
>   only addresses simple, constant search terms, i.e. no true regular 
>   expressions.)

I expect you could extract any obvious tokens from the regex, and then
run the regex only over the files which contain those tokens. Obviously
your worst case performance will be the same as the original grep (plus
the overhead of looking up the tokens), but in practice, I expect you
could end up searching through only a fraction of the files (depending
on your regexp and how diverse the data set is).

Of course, I have never had a complaint about the speed of git-grep, so
maybe it's not all that compelling. :)

-Peff
