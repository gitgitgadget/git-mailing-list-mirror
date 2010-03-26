From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH RFC/RFD] clone: quell the progress report from init
Date: Fri, 26 Mar 2010 16:16:50 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1003261611130.694@xanadu.home>
References: <4BAB2234.4070202@drmicha.warpmail.net>
 <7b9006620fab4214ee0db53ebc9e0caffc397959.1269506526.git.git@drmicha.warpmail.net>
 <7veij6lvze.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org,
	Alex Riesen <raa.lkml@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Neal Kreitzinger <neal@rsss.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 26 21:16:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvFxg-00021b-Hl
	for gcvg-git-2@lo.gmane.org; Fri, 26 Mar 2010 21:16:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752312Ab0CZUQw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Mar 2010 16:16:52 -0400
Received: from relais.videotron.ca ([24.201.245.36]:18527 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752008Ab0CZUQv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Mar 2010 16:16:51 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0KZW00KVCOC2KL10@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 26 Mar 2010 16:16:50 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <7veij6lvze.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143279>

On Fri, 26 Mar 2010, Junio C Hamano wrote:

> An alternative might be to squelch init_db() like your patch did, and then
> replace it with a message of our own, perhaps like this:
> 
>  $ git clone -n /var/tmp/gomi victim-003
>  Cloning into victim-003...
>  done.
>  $ git clone -n file:///var/tmp/gomi victim-004
>  Cloning into victim-004...
>  remote: Counting objects: ...
>  Receiving objects: 100% (120/120), done.
> 
> Here I am assuming we would add "done." to the local codepath.
> 
> Personally I like the total silence your patch gives (i.e. no "Cloning
> into" line in either case, and no "done." in local case) slightly better;
> others may disagree and/or have better ideas.

Personally I like your suggestion above.  A clone is not something you 
perform repeatedly, and it is the first thing that random people told to 
use Git to grab a piece of code will do.  Better give them some comfort 
by telling them what is happening.


Nicolas
