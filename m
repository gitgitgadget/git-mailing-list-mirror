From: Nicolas Pitre <nico@cam.org>
Subject: Re: If you would write git from scratch now, what would you change?
Date: Mon, 26 Nov 2007 16:28:40 -0500 (EST)
Message-ID: <alpine.LFD.0.99999.0711261620220.9605@xanadu.home>
References: <200711252248.27904.jnareb@gmail.com>
 <858x4l2apc.fsf@lola.goethe.zz>
 <alpine.LFD.0.99999.0711261417580.9605@xanadu.home>
 <854pf8243i.fsf@lola.goethe.zz> <20071126195750.GD25784@efreet.light.src>
 <85prxwzqvn.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jan Hudec <bulb@ucw.cz>, Jakub Narebski <jnareb@gmail.com>,
	git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Mon Nov 26 22:29:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwlVk-0006Gi-Dm
	for gcvg-git-2@gmane.org; Mon, 26 Nov 2007 22:29:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753189AbXKZV2m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2007 16:28:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753173AbXKZV2m
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Nov 2007 16:28:42 -0500
Received: from relais.videotron.ca ([24.201.245.36]:27654 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752640AbXKZV2l (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2007 16:28:41 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JS400HIEUBS38D0@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 26 Nov 2007 16:28:40 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <85prxwzqvn.fsf@lola.goethe.zz>
User-Agent: Alpine 0.99999 (LFD 814 2007-11-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66129>

On Mon, 26 Nov 2007, David Kastrup wrote:

> Jan Hudec <bulb@ucw.cz> writes:
> 
> > On Mon, Nov 26, 2007 at 20:34:25 +0100, David Kastrup wrote:
> >> Nicolas Pitre <nico@cam.org> writes:
> >> > On Mon, 26 Nov 2007, David Kastrup wrote:
> >> >> Get rid of plumbing at the command line level.
> >> >
> >> > We can't get rid of plumbing.
> >> 
> >> What about "at the command line level" did you not understand?
> >
> > Which part of we neither can nor want did you not understant?
> >
> > The availability of plumbing is really big part of a reason why git is
> > so good and has so many scripts and tool built on top of it.
> 
> Which is the reason I proposed making the plumbing available at a
> scripting level, not at the command line level.

You're mixing two orthogonal issues, namely: 1) the scripting language, 
and 2) the too large number of Git command accessible through your 
default path.

#1 is a non issue really.  We don't want to lock plumbing to any 
particular scripting language, and the current interface is the most 
universal one in that regard.

#2 can be solved through a single multiplexer such as 'git low-level'.

That 'git low-level foo' may just look up git-foo in some libexec 
directory, and only 'git-low-level' need to be in the path instead of 
all those plumbing commands.

Need only to have both forms ('git foo' and 'git low-level foo') to work 
for a transition period.


Nicolas
