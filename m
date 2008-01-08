From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 1/2] sideband.c: Use xmalloc() instead of variable-sized
 arrays.
Date: Tue, 08 Jan 2008 12:01:07 -0500 (EST)
Message-ID: <alpine.LFD.1.00.0801081154460.3054@xanadu.home>
References: <4783A3B2.3060801@viscovery.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Jan 08 18:01:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCHpZ-0001UW-MX
	for gcvg-git-2@gmane.org; Tue, 08 Jan 2008 18:01:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754804AbYAHRBK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2008 12:01:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754247AbYAHRBJ
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jan 2008 12:01:09 -0500
Received: from relais.videotron.ca ([24.201.245.36]:30600 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751641AbYAHRBI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2008 12:01:08 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JUC00B1L4LR0930@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 08 Jan 2008 12:01:03 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <4783A3B2.3060801@viscovery.net>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69892>

On Tue, 8 Jan 2008, Johannes Sixt wrote:

> From: Johannes Sixt <johannes.sixt@telecom.at>
> 
> How come we got along with this not very portable construct for so long?
> Probably because the array sizes were computed from the results of
> strlen() of string constants.

Maybe because it isn't not so unportable anymore?  I doubt that 
compilers that don't know about automatic arrays would be smart enough 
to notice the variable was actually a constant due to the strlen() of a 
constant string and just do like if there wasn't any variable for the 
array size.

> Anyway, a follow-up patch will make the
> lengths really non-constant.

Fair enough.


Nicolas
