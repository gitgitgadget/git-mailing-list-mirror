From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add git-imap-send.
Date: Thu, 9 Mar 2006 12:30:38 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0603091227560.20277@wbgn013.biozentrum.uni-wuerzburg.de>
References: <440C3499.9080000@codeweavers.com> <7vacbz7vod.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Mike McCormack <mike@codeweavers.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 09 12:31:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FHJLy-0004Nl-0B
	for gcvg-git@gmane.org; Thu, 09 Mar 2006 12:30:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751805AbWCILam (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Mar 2006 06:30:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751830AbWCILam
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Mar 2006 06:30:42 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:53449 "EHLO
	mailrelay.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751805AbWCILam (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Mar 2006 06:30:42 -0500
Received: from virusscan.mail (mail04.mail [172.25.1.103])
	by mailrelay.mail (Postfix) with ESMTP id BD0A51D23;
	Thu,  9 Mar 2006 12:30:38 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id B0F045CF6;
	Thu,  9 Mar 2006 12:30:38 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id 4C7E6192E;
	Thu,  9 Mar 2006 12:30:38 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vacbz7vod.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17407>

Hi,

On Thu, 9 Mar 2006, Junio C Hamano wrote:

> Mike McCormack <mike@codeweavers.com> writes:
> 
> > +		if (!memcmp( "imaps:", val, 6 )) {
> > +			if (!memcmp( "imap:", val, 5 ))
> 
> Is val always longer than 5 or 6 bytes here?

That does not matter, since they are strings, and the memcmp should not 
look further if they are shorter (because the comparison to '\0' failed 
already).

However, if !memcmp("imaps:", val, 6), it means that val starts with 
the string "imaps:", right? Then !memcmp("imap:", val, 5) must always 
fail, no?

Ciao,
Dscho
