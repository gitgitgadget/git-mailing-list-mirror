From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] --walk-reflogs: actually find the right commit by date.
Date: Sat, 20 Jan 2007 22:36:31 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701202225020.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0701201048560.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vhcum80u4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 20 22:36:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H8NtC-0006tn-7c
	for gcvg-git@gmane.org; Sat, 20 Jan 2007 22:36:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965393AbXATVgd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 20 Jan 2007 16:36:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965396AbXATVgd
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Jan 2007 16:36:33 -0500
Received: from mail.gmx.net ([213.165.64.20]:59040 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965393AbXATVgd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Jan 2007 16:36:33 -0500
Received: (qmail invoked by alias); 20 Jan 2007 21:36:31 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp045) with SMTP; 20 Jan 2007 22:36:31 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vhcum80u4.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37293>

Hi,

On Sat, 20 Jan 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Embarassing thinko.
> 
> Aha, progress ;-).  But it still seems to pick up entry that is
> less than specified number of hours if I do:
> 
> 	$ git log --walk-reflogs -4 master@{1.hour} | head -2
>         commit 33dd19c2a9c0b114436f53d86fc1c2c5e00c26bb
>         Reflog: master@{Sat, 20 Jan 2007 00:01:35 -0800} (Junio C Ham
> 
> It is Jan 20th 02:10 now and the master was not pointing at that
> commit 1 hour ago.

I tried to reproduce this effect, but so far no luck. I even let the 
function get_reflog_recno_by_time() output what it does, and it picks 
exactly the right commit. Do you have a time skew?

Ciao,
Dscho
