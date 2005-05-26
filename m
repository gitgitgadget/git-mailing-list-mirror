From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] mkdelta enhancements
Date: Thu, 26 May 2005 08:44:50 -0400 (EDT)
Message-ID: <Pine.LNX.4.62.0505260840420.16151@localhost.localdomain>
References: <Pine.LNX.4.62.0505252340270.16151@localhost.localdomain>
 <7vll62egoe.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 26 14:45:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DbHie-0007qQ-G3
	for gcvg-git@gmane.org; Thu, 26 May 2005 14:44:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261373AbVEZMqE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 May 2005 08:46:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261376AbVEZMqE
	(ORCPT <rfc822;git-outgoing>); Thu, 26 May 2005 08:46:04 -0400
Received: from relais.videotron.ca ([24.201.245.36]:59118 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S261373AbVEZMqB
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2005 08:46:01 -0400
Received: from xanadu.home ([24.200.213.96]) by VL-MO-MR007.ip.videotron.ca
 (iPlanet Messaging Server 5.2 HotFix 1.21 (built Sep  8 2003))
 with ESMTP id <0IH3009NUKQQXU@VL-MO-MR007.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 26 May 2005 08:44:51 -0400 (EDT)
In-reply-to: <7vll62egoe.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@localhost.localdomain
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, 25 May 2005, Junio C Hamano wrote:

> I have not measured and I have not studied how the current
> mkdelta does things, but if you are not doing so already it may
> make sense to keep the later one expanded in full and represent
> older ones as delta, since that would give faster access to more
> often used items (I am assuming more recent version are likely
> to be accessed more frequently, which I believe is what SCMs
> typically do.

This is precisely what is done with git-deltafy-script.

The mkdelta program doesn't know about object history.  It only enforce 
delta precedence according to the order objects are listed on the 
command line.  It's up to mkdelta users to enforce any ordering policy.


Nicolas
