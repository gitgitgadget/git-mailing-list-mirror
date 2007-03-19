From: Steve =?ISO-8859-1?Q?Fr=E9cinaux?= <nudrema@gmail.com>
Subject: Re: Libification project (SoC)
Date: Mon, 19 Mar 2007 11:33:38 +0100
Message-ID: <1174300418.5884.50.camel@mejai>
References: <20070316042406.7e750ed0@home.brethil>
	 <20070316060033.GD31606@spearce.org>
	 <7vps79wueu.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.63.0703161251200.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <20070316130958.GD1783@peter.daprodeges.fqdn.th-h.de>
	 <Pine.LNX.4.63.0703161509560.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <20070318140816.GG4489@pasky.or.cz>
	 <Pine.LNX.4.63.0703190045520.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <20070319012111.GS18276@pasky.or.cz>
	 <Pine.LNX.4.63.0703190235330.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <e5bfff550703190001k761541c7v2c259ef3f7695b10@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 19 11:33:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTFBP-0003qf-CV
	for gcvg-git@gmane.org; Mon, 19 Mar 2007 11:33:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750872AbXCSKdm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Mar 2007 06:33:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751862AbXCSKdm
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Mar 2007 06:33:42 -0400
Received: from serv108.segi.ulg.ac.be ([139.165.32.111]:41336 "EHLO
	serv108.segi.ulg.ac.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750872AbXCSKdl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2007 06:33:41 -0400
Received: (qmail 28514 invoked by uid 510); 19 Mar 2007 11:33:39 +0100
Received: from 83.182.28.64 by serv108.segi.ulg.ac.be (envelope-from <nudrema@gmail.com>, uid 501) with qmail-scanner-1.25 
 (clamdscan: 0.90/2867.  
 Clear:RC:1(83.182.28.64):. 
 Processed in 0.023799 secs); 19 Mar 2007 10:33:39 -0000
Received: from unknown (HELO [10.0.0.14]) (s020908@[83.182.28.64])
          (envelope-sender <nudrema@gmail.com>)
          by serv108.segi.ulg.ac.be (qmail-ldap-1.03) with SMTP
          for <mcostalba@gmail.com>; 19 Mar 2007 11:33:39 +0100
In-Reply-To: <e5bfff550703190001k761541c7v2c259ef3f7695b10@mail.gmail.com>
X-Mailer: Evolution 2.10.0 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42604>

On Mon, 2007-03-19 at 08:01 +0100, Marco Costalba wrote:

> Please which are, in your opinion, the possible tools that could use a
> non-reentrant, blocking libgit? In case tool is already existent
> please write the name, in case it's a 'would be' one give a brief
> description.

Another idea that I just remembered about: two years ago there was a SoC
project to make nautilus (the file manager from gnome) able to version
directories. It was using SVN (and failed, but it's another story).

While nautilus is heavily multi-threaded, it's a "single-instance app",
so there is at most only one instance of nautilus ever running. Under
the hypothesis of a "versioned directories" support using libgit (that
would be easier to do and support since it doesn't need to set up a
server), it's quite obvious that a non-reentrant git would not be
enough: you are likely to have more than one versioned directories on
screen at the same time! OTOH, blocking doesn't look like an issue since
gnomevfs already deals with quite a number of blocking synchronous libs
and exposes an async API on top of those (similar to what QT Threading
does, I guess).

BTW, if some Gnome people are reading, if libgit comes into life, such a
project is something I'd like to see for real ;-)
