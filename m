From: Nicolas Pitre <nico@cam.org>
Subject: Re: [Census] So who uses git?
Date: Wed, 01 Feb 2006 17:25:18 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0602011717010.5397@localhost.localdomain>
References: <46a038f90601251810m1086d353ne8c7147edee4962a@mail.gmail.com>
 <Pine.LNX.4.64.0601272345540.2909@evo.osdl.org>
 <46a038f90601272133o53438987ka6b97c21d0cdf921@mail.gmail.com>
 <1138446030.9919.112.camel@evo.keithp.com>
 <7vzmlgt5zt.fsf@assigned-by-dhcp.cox.net>
 <20060130185822.GA24487@hpsvcnb.fc.hp.com>
 <Pine.LNX.4.63.0601311127250.25248@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0601311750270.25300@iabervon.org>
 <7vek2oot7z.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0601311623240.7301@g5.osdl.org>
 <7v4q3jlgw2.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0602011125370.5397@localhost.localdomain>
 <7vhd7ibza2.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0602011307250.21884@g5.osdl.org>
 <7v8xsu91vf.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 01 23:30:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F4QPj-0004Kq-KP
	for gcvg-git@gmane.org; Wed, 01 Feb 2006 23:25:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422983AbWBAWZV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Feb 2006 17:25:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422984AbWBAWZU
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Feb 2006 17:25:20 -0500
Received: from relais.videotron.ca ([24.201.245.36]:17267 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1422983AbWBAWZT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Feb 2006 17:25:19 -0500
Received: from xanadu.home ([24.202.136.67]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0IU100AFF4Y6UX80@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 01 Feb 2006 17:25:19 -0500 (EST)
In-reply-to: <7v8xsu91vf.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@localhost.localdomain
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15456>

On Wed, 1 Feb 2006, Junio C Hamano wrote:

> To recap:
> 
>  - "git commit fileA..." means: update index at listed paths
>    (add/remove if necessary) and then commit the tree described
>    in index (the same as the current behaviour with explicit
>    paths).

No.

>  - "git commit -a" means: update index with all local changes and
>    then commit the tree described in index (the same as the
>    current behaviour).

Sensible.

>  - "git commit" means: write out the current index and commit
>    (the same as the current behaviour).

Sensible.

>  - "git commit --only fileA..." means: create a temporary index
>    from the current HEAD commit (or empty index if there is
>    none), update it at listed paths (add/remove if necessary)
>    and commit the resulting tree.  Also update the real index at
>    the listed paths (add/remove if necessary).  In the original
>    index file, the paths listed must be either empty or match
>    exactly the HEAD commit -- otherwise we error out (Linus'
>    suggestion).

Actually, my opinion is that should be the behavior for your first item 
above (when only filenames are specified).  If you want to _also_ 
include the index like you describe in your first item then an 
additional switch should be provided.

In other words, the --only should become --with-index with the behavior 
swapped.

The fact is that when you simply specify a filename, you really expect 
_only_ that filename will be affected and the rest be left alone.  
That's the most probable expectation for any tool.  If you want 
_additional_ stuff to also be merged along with the files specified then 
it is logical to have an additional argument in that case, not the other 
way around.


Nicolas
