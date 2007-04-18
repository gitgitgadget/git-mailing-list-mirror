From: Peter Baumann <waste.manager@gmx.de>
Subject: Re: [PATCH] pack-refs: dereference .git/packed-refs if it is a
	symlink
Date: Wed, 18 Apr 2007 19:47:53 +0200
Message-ID: <20070418174753.GC5913@xp.machine.xx>
References: <20070417161720.GA3930@xp.machine.xx> <Pine.LNX.4.64.0704172253140.14155@beast.quantumfyre.co.uk> <20070418055215.GA32634@xp.machine.xx> <7v7isajfl1.fsf@assigned-by-dhcp.cox.net> <20070418102823.GA5586@xp.machine.xx> <alpine.LFD.0.98.0704180908360.2828@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Apr 18 19:47:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HeEG4-0002KB-7v
	for gcvg-git@gmane.org; Wed, 18 Apr 2007 19:47:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992949AbXDRRrx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Apr 2007 13:47:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992950AbXDRRrx
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Apr 2007 13:47:53 -0400
Received: from magnum.hofmann.stw.uni-erlangen.de ([131.188.23.34]:54265 "HELO
	mail.hofmann.stw.uni-erlangen.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with SMTP id S2992949AbXDRRrw (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Apr 2007 13:47:52 -0400
Received: (qmail 10326 invoked by uid 0); 18 Apr 2007 17:47:50 -0000
Received: from ho135.hofmann.stw.uni-erlangen.de (HELO localhost) (p.b@hofmann.stw.uni-erlangen.de@172.17.27.135)
  by mail.hofmann.stw.uni-erlangen.de with SMTP; 18 Apr 2007 17:47:50 -0000
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.98.0704180908360.2828@woody.linux-foundation.org>
User-Agent: Mutt/1.5.14+cvs20070403 (2007-04-02)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44920>

On Wed, Apr 18, 2007 at 09:09:13AM -0700, Linus Torvalds wrote:
> 
> 
> On Wed, 18 Apr 2007, Peter Baumann wrote:
> >
> > git-new-workdir creates a new working directory where everything
> > necessary, including .git/packed-refs, is symlinked to your master repo.
> > But git-pack-refs breaks the symlink, so you could accidentally loose some
> > refs. This fixes it to first dereference .git/packed-refs if it is a
> > symlink.
> 
> Wouldn't it be nicer to instead make "git gc" *notice* the fact that we're 
> in a workdir, and just "cd" to the main git repository instead?
> 
> 		Linus
> 

Don't think so. Because then all the low level tools aren't aware of this.
And restricting a WorkDir to use only porcelanish commands isn't what I
want. And teaching every tool about symklinked workdirs doesn't sound right
to me.

-Peter
