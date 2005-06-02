From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] Stop inflating the whole SHA1 file only to check size.
Date: Wed, 01 Jun 2005 20:51:28 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0506012048330.17354@localhost.localdomain>
References: <Pine.LNX.4.58.0505301253070.1876@ppc970.osdl.org>
 <Pine.LNX.4.62.0505301644430.5330@localhost.localdomain>
 <7vacmapo18.fsf@assigned-by-dhcp.cox.net>
 <7vu0kilc21.fsf_-_@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0506011032570.7439@localhost.localdomain>
 <7vpsv6kqx0.fsf@assigned-by-dhcp.cox.net>
 <7v1x7lk8fl.fsf_-_@assigned-by-dhcp.cox.net>
 <7vpsv5hbm5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@osdl.org>,
	"Daniel Barkalow <barkalow@iabervon.org> Git Mailing List" 
	<git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 02 02:48:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dddsv-0007Ea-UB
	for gcvg-git@gmane.org; Thu, 02 Jun 2005 02:48:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261205AbVFBAva (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Jun 2005 20:51:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261264AbVFBAva
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Jun 2005 20:51:30 -0400
Received: from relais.videotron.ca ([24.201.245.36]:57699 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S261205AbVFBAv2
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 1 Jun 2005 20:51:28 -0400
Received: from xanadu.home ([24.200.213.96]) by VL-MO-MR011.ip.videotron.ca
 (iPlanet Messaging Server 5.2 HotFix 1.21 (built Sep  8 2003))
 with ESMTP id <0IHF00C7TMDS8N@VL-MO-MR011.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 01 Jun 2005 20:51:28 -0400 (EDT)
In-reply-to: <7vpsv5hbm5.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@localhost.localdomain
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, 1 Jun 2005, Junio C Hamano wrote:

> Using the new unpack_sha1_file_partial() function, stop
> inflating the whole SHA1 file when rename detector wants to know
> only the filesize.

Beware.  If you have delta objects you'll get the size of the delta 
itself and not the final object size, unless you recurse until a non 
delta object is found.


Nicolas
