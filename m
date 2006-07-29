From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git prune pig slow
Date: Sat, 29 Jul 2006 13:40:01 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607291339200.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20060729090250.GC26956@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 29 13:40:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G6nAt-0003LU-Du
	for gcvg-git@gmane.org; Sat, 29 Jul 2006 13:40:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932647AbWG2LkE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 29 Jul 2006 07:40:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932648AbWG2LkD
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Jul 2006 07:40:03 -0400
Received: from mail.gmx.net ([213.165.64.21]:2497 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932647AbWG2LkC (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 29 Jul 2006 07:40:02 -0400
Received: (qmail invoked by alias); 29 Jul 2006 11:40:01 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp037) with SMTP; 29 Jul 2006 13:40:01 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Russell King <rmk@arm.linux.org.uk>
In-Reply-To: <20060729090250.GC26956@flint.arm.linux.org.uk>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24423>

Hi,

On Sat, 29 Jul 2006, Russell King wrote:

> Hi,
> 
> git 1.4.0, P4 2.6GHz, 1GB.
> 
> I'm trying to use "git prune" to remove some unreachable objects from
> my git tree.  However, it appears to be _extremely_ expensive:
> 
> rmk      13376 91.3 15.7 165980 161556 pts/0   R+   09:50   5:14 git-fsck-object
> 
> stracing it shows that it's doing lots and lots of brk() calls.

Does git-count-objects show a high amount of unpacked objects? You should 
try "git-repack -a -d" _before_ git-prune, then.

Hth,
Dscho
