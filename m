From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 2/2] git-repack: -b to pass --delta-base-offset
Date: Fri, 13 Oct 2006 17:58:43 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0610131757050.2435@xanadu.home>
References: <11607177011745-git-send-email-junkio@cox.net>
 <11607177024171-git-send-email-junkio@cox.net>
 <Pine.LNX.4.64.0610130912500.2435@xanadu.home>
 <7v64endi6x.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 13 23:58:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GYV3I-0001Oa-MV
	for gcvg-git@gmane.org; Fri, 13 Oct 2006 23:58:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932078AbWJMV6p (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Oct 2006 17:58:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932081AbWJMV6p
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Oct 2006 17:58:45 -0400
Received: from relais.videotron.ca ([24.201.245.36]:7531 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S932078AbWJMV6p
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Oct 2006 17:58:45 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0J730000WH1VOQV0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 13 Oct 2006 17:58:44 -0400 (EDT)
In-reply-to: <7v64endi6x.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@xanadu.home
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28864>

On Fri, 13 Oct 2006, Junio C Hamano wrote:

> Nicolas Pitre <nico@cam.org> writes:
> 
> > On Thu, 12 Oct 2006, Junio C Hamano wrote:
> >
> >> This new option makes the resulting pack express the delta base
> >> with more compact "offset" format.
> >
> > Actually I thought about making it the default whenever git-pack-objects 
> > supported it, and use a negative option with git-repack to disable it 
> > instead.
> >
> > The fact is that there is little reason for not using delta base offsets 
> > in most cases and specifying -b all the time would become more of an 
> > annoyance.
> >
> > What do you think?
> 
> The only time it matters is if the packs in repository being
> repacked needs to be readable by older git, which I think is
> only when somebody with older git uses commit walkers to
> download the pack into a remote repository to use.  Using or not
> using delta-base-offset is tied to each repository, and in a
> sense that is similar to "repository format version".
> 
> So how about
> 
> 	[core]
>         	repackUseDeltaBase = true

I agree, although "repackUseDeltaBase" is a bit vague as both delta 
types do use a delta base.


Nicolas
