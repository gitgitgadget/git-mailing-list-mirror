From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] shortlog: take the first populated line of the description
Date: Wed, 05 Mar 2008 16:47:29 -0500 (EST)
Message-ID: <alpine.LFD.1.00.0803051638150.2947@xanadu.home>
References: <1204727050.0@pinky>
 <alpine.LFD.1.00.0803051346200.2947@xanadu.home>
 <7vy78wlv46.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Andy Whitcroft <apw@shadowen.org>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 05 22:49:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JX1T8-0003Oy-AG
	for gcvg-git-2@gmane.org; Wed, 05 Mar 2008 22:48:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752264AbYCEVrb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2008 16:47:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752522AbYCEVrb
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 16:47:31 -0500
Received: from relais.videotron.ca ([24.201.245.36]:32714 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752239AbYCEVra (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2008 16:47:30 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JXA00LZO1V5Y9S0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 05 Mar 2008 16:47:29 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <7vy78wlv46.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76274>

On Wed, 5 Mar 2008, Junio C Hamano wrote:

> Nicolas Pitre <nico@cam.org> writes:
> 
> > On Wed, 5 Mar 2008, Andy Whitcroft wrote:
> > ...
> >> 	...  I cannot think of any good reason not to take the first
> >> 	populated line for a shortlog.	The alternative less agressive
> >> 	compromise might be to skip only completly empty lines at the
> >> 	start, but I am not sure that adds any value.
> >> 
> >> 	I seem to get a lot of these in converted SVN commits.
> >> 
> >> 	Comments?
> >
> > Maybe it is the SVN conversion that needs fixing?
> 
> I thought about saying the same, but I am of two minds.
> 
> It is likely that you would want to clean-up when importing,
> especially when you are planning to abandon the other system and
> switch to git.  But you may want to have an import that is as
> close to the original as possible, excess blank lines in the log
> messages and all.

I don't think excess blank lines at the _beginning_ of the commit log 
has any value worth preserving though.

> I think Andy's fix to make the output side take away
> unnecessary blank lines is unconditionally good.

It is not "bad" in itself.  However that feels like papering over 
another problem which IMHO has greater merits to be fixed.  We have 
given special semantics to the first line of a commit log in many other 
places now, so unless all those places are also made aware of 
substandard commit logs too, I think it would be more productive to make 
sure those logs are semi sensible upon entering Git in the first place 
instead.


Nicolas
