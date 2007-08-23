From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Make "git reset" a builtin. (incomplete)
Date: Thu, 23 Aug 2007 23:33:37 +0200
Message-ID: <20070823213337.GC3516@steel.home>
References: <46CC3090.7080500@gmail.com> <86absjenc3.fsf@lola.quinscape.zz> <46CC3C17.8040901@op5.se> <864pirej6w.fsf@lola.quinscape.zz> <alpine.LFD.0.999.0708221154150.16727@xanadu.home> <Pine.LNX.4.64.0708221713540.20400@racer.site> <86mywjcwv7.fsf@lola.quinscape.zz> <20070823202647.GA3516@steel.home> <85zm0igdhv.fsf@lola.goethe.zz>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Thu Aug 23 23:33:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IOKJD-0000fZ-0I
	for gcvg-git@gmane.org; Thu, 23 Aug 2007 23:33:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759463AbXHWVdk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Aug 2007 17:33:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758986AbXHWVdk
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Aug 2007 17:33:40 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:43304 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757650AbXHWVdj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Aug 2007 17:33:39 -0400
Received: from tigra.home (Faaab.f.strato-dslnet.de [195.4.170.171])
	by post.webmailer.de (mrclete mo41) (RZmta 11.0)
	with ESMTP id i011faj7NJ60Xc ; Thu, 23 Aug 2007 23:33:37 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 91831277BD;
	Thu, 23 Aug 2007 23:33:37 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 66155BE01; Thu, 23 Aug 2007 23:33:37 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <85zm0igdhv.fsf@lola.goethe.zz>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CculzxtolCoDQ=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56534>

David Kastrup, Thu, Aug 23, 2007 23:14:20 +0200:
> Alex Riesen <raa.lkml@gmail.com> writes:
> 
> > David Kastrup, Wed, Aug 22, 2007 19:17:16 +0200:
> >> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> >> > And not making the scripts builtins helps Windows users how,
> >> > exactly?
> >> 
> >> Red herring.  The proposal was not to do nothing, but rather give git
> >> a dedicated scripting language internal to it.  Two suggestions of
> >> mine with different advantages were git-busybox and Lua.
> >
> > Different "disadvantages". How do you do pipes and safe
> > inter-program argument passing in Lua? Portably?
> 
> Argument quoting would have to depend on the system.  If you implement
> that, you should be able to use os.popen and os.system.  However, the
> general Lua approach would be to write wrappers around C routines
> dealing with the basic git data structures, giving you things like an
> iterator over the index and similar.  One would usually not call
> executables, but rather functions from a git-specific library.
> 
> Instead of stringing this stuff together with pipes, one would string
> it together using coroutines (Lua "threads" are strictly synchronous,
> about as fast as normal function calls, and a yield/resume rendezvous
> passes a value together with control).
> 
> So pipes would not be a natural building block, anyway.

Now that'll be a mess.

> > What do you propose to do about gitbox becoming a dependency for
> > others, who inevitably start using it (why not? It promised to be
> > portable enough for Git itself!)
> 
> I don't understand what you mean here.
> 

Git gets a script language support. People use the script outside of
git and whine when it breaks or gets removed.
