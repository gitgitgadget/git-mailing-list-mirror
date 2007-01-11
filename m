From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: MinGW port (was: Re: [ANNOUNCE] qgit4 aka qgit ported to Windows)
Date: Thu, 11 Jan 2007 14:24:39 +0100
Organization: eudaptics software gmbh
Message-ID: <45A63A97.E160751F@eudaptics.com>
References: <e5bfff550701091314k71e282e8x125db65d5c287a94@mail.gmail.com>
		 <46a038f90701101517s1d5e818eq2fba220d17a6aa03@mail.gmail.com>
		 <45A604ED.5EF73A1E@eudaptics.com>
		 <Pine.LNX.4.63.0701111037330.22628@wbgn013.biozentrum.uni-wuerzburg.de> <e5bfff550701110456y51b8b678s59974cc1d8655a90@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 11 14:51:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H50KY-0006Un-RU
	for gcvg-git@gmane.org; Thu, 11 Jan 2007 14:50:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030460AbXAKNtY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Jan 2007 08:49:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030453AbXAKNtN
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jan 2007 08:49:13 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160]:15453 "EHLO
	linz.eudaptics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030449AbXAKNtJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jan 2007 08:49:09 -0500
X-Greylist: delayed 1512 seconds by postgrey-1.27 at vger.kernel.org; Thu, 11 Jan 2007 08:49:08 EST
Received: from eudaptics.com (tethys.linz.eudaptics [192.168.1.88])
	by linz.eudaptics.com (Postfix) with ESMTP
	id B8EB66B4; Thu, 11 Jan 2007 14:23:53 +0100 (CET)
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
To: Marco Costalba <mcostalba@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36591>

Marco Costalba wrote:
> > On Thu, 11 Jan 2007, Johannes Sixt wrote:
> > > [*] because shell scripts like merge-one-file can't be invoked from an
> > > exe like merge-index, yet. Fortunately this looks like the easiest part
> > > to solve.
> >
> 
> >From an exe you could run:
> 
>      cmd.exe /c  <script with arguments>
> 
> Of course the problem is that the content of the script should be
> understandable by cmd.exe windows interpreter.

We are talking about git's own scripts, which are (ba)sh and perl.

The route I'm going is to do the path lookup manually (if necessary),
then look at the first few bytes of the file for the interpreter, then
something like

 spawnvp(<interpreter-w/o-path>, <full-path-of-script plus args>)

-- Hannes
