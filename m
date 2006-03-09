From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add git-imap-send.
Date: Thu, 9 Mar 2006 12:44:01 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0603091243001.20908@wbgn013.biozentrum.uni-wuerzburg.de>
References: <440C3499.9080000@codeweavers.com> <7vacbz7vod.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0603091227560.20277@wbgn013.biozentrum.uni-wuerzburg.de>
 <4410140E.2000609@op5.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Mike McCormack <mike@codeweavers.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 09 12:44:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FHJYw-0008D4-76
	for gcvg-git@gmane.org; Thu, 09 Mar 2006 12:44:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932093AbWCILoF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Mar 2006 06:44:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751850AbWCILoF
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Mar 2006 06:44:05 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:23262 "EHLO
	mailrelay.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751849AbWCILoE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Mar 2006 06:44:04 -0500
Received: from virusscan.mail (mail03.mail [172.25.1.102])
	by mailrelay.mail (Postfix) with ESMTP id E3089192E;
	Thu,  9 Mar 2006 12:44:01 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id D65C0A9C;
	Thu,  9 Mar 2006 12:44:01 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id BC472192E;
	Thu,  9 Mar 2006 12:44:01 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <4410140E.2000609@op5.se>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17409>

Hi,

On Thu, 9 Mar 2006, Andreas Ericsson wrote:

> Johannes Schindelin wrote:
> > Hi,
> > 
> > On Thu, 9 Mar 2006, Junio C Hamano wrote:
> > 
> > 
> > > Mike McCormack <mike@codeweavers.com> writes:
> > > 
> > > 
> > > > +		if (!memcmp( "imaps:", val, 6 )) {
> > > > +			if (!memcmp( "imap:", val, 5 ))
> > > 
> > > Is val always longer than 5 or 6 bytes here?
> > 
> > 
> > That does not matter, since they are strings, and the memcmp should not look
> > further if they are shorter (because the comparison to '\0' failed already).
> > 
> 
> That's what strcmp() does. memcmp() walks the lenghth even if it encounters
> nul bytes. Perhaps you confuse it with strncmp()?

Sorry, I was unclear. Of course, memcmp() does not stop on NUL. But it 
stops when that NUL is different from what the other pointer has. Which is 
the case here.

Ciao,
Dscho
