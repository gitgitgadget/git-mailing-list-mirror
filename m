From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Efficiency of initial clone from server
Date: Sun, 11 Feb 2007 23:29:19 -0500
Message-ID: <9e4733910702112029k6ef3fb7bl3bdb134a787512e8@mail.gmail.com>
References: <9e4733910702111153p1691ad99nda97325b34b7a13f@mail.gmail.com>
	 <20070211225326.GC31488@spearce.org>
	 <9e4733910702111525x176053d3y9fd6d809ac447c0a@mail.gmail.com>
	 <Pine.LNX.4.64.0702112022430.1757@xanadu.home>
	 <7vd54gau3r.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Nicolas Pitre" <nico@cam.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Feb 12 05:29:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGSof-0002Rw-OT
	for gcvg-git@gmane.org; Mon, 12 Feb 2007 05:29:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932845AbXBLE3X (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Feb 2007 23:29:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932944AbXBLE3X
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Feb 2007 23:29:23 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:43832 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932845AbXBLE3W (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Feb 2007 23:29:22 -0500
Received: by ug-out-1314.google.com with SMTP id 44so475932uga
        for <git@vger.kernel.org>; Sun, 11 Feb 2007 20:29:21 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ftYQdgazpPzAo/wYUlXc6vU3cwDOEvM/KILP8jA7hP9oLkm1RWIKNS6mRQ9S+DjaN2ZM1Yl2duBsulsCP7l5r2G/D49dCpu3DAWRBjj39EnxAT0meUbzPkXnKGM7FE/l2q1j5XUoZyQ9sdD//LfH9dOSbHOx06eeLBkPZYdeGAc=
Received: by 10.114.12.9 with SMTP id 9mr6594817wal.1171254559854;
        Sun, 11 Feb 2007 20:29:19 -0800 (PST)
Received: by 10.114.195.13 with HTTP; Sun, 11 Feb 2007 20:29:19 -0800 (PST)
In-Reply-To: <7vd54gau3r.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39360>

On 2/11/07, Junio C Hamano <junkio@cox.net> wrote:
> Nicolas Pitre <nico@cam.org> writes:
>
> > On Sun, 11 Feb 2007, Jon Smirl wrote:
> >
> >> On 2/11/07, Shawn O. Pearce <spearce@spearce.org> wrote:
> >> > Jon Smirl <jonsmirl@gmail.com> wrote:
> >> > > remote: Total 63, written 63 (delta 0), reused 63 (delta 0)
> >> > > 100% (63/63) done
> >> > > fatal: pack: not a valid SHA1
> >> > > New branch: 0953670fbcb75e26fb93340bddae934e85618f2e
> >> >
> >> > What version of git is this?  That looks like we're assuming the word
> >> > pack was an object, but I'm not sure why we would do such a thing...
> >
> > This "pack" comes from pack-index when providing the name of the pack.
> > It is either "pack" or "keep" and specifies the name of the .keep file
> > to remove in the later case.
> > This is caught by git-fetch.sh with some code identified with a comment
> > that reads: "# special line coming from index-pack with the pack name"
>
> That is true only if Jon used git-fetch, git-pull or git-clone.
> Unfortunately I noticed that his commandline read "cg clone".

All wireless-dev are all dead.
I can still get to Linus' tree without problem. wireless-2.6 tree is ok too.

jonsmirl@jonsmirl:/extra$ git clone
git://git.kernel.org/pub/scm/linux/kernel/gt/linville/wireless-dev.git
Initialized empty Git repository in /extra/wireless-dev/.git/
fatal: The remote end hung up unexpectedly
fetch-pack from
'git://git.kernel.org/pub/scm/linux/kernel/gt/linville/wireless-dev.git'
failed.
jonsmirl@jonsmirl:/extra$ git clone
git://git2.kernel.org/pub/scm/linux/kernel/gt/linville/wireless-dev.git
Initialized empty Git repository in /extra/wireless-dev/.git/
fatal: The remote end hung up unexpectedly
fetch-pack from
'git://git2.kernel.org/pub/scm/linux/kernel/gt/linville/wireless-dev.git'
failed.
jonsmirl@jonsmirl:/extra$ git clone
git://git1.kernel.org/pub/scm/linux/kernel/gt/linville/wireless-dev.git
Initialized empty Git repository in /extra/wireless-dev/.git/
fatal: The remote end hung up unexpectedly
fetch-pack from
'git://git1.kernel.org/pub/scm/linux/kernel/gt/linville/wireless-dev.git'
failed.
jonsmirl@jonsmirl:/extra$


Clone of the git repo complete without errors

jonsmirl@jonsmirl:/extra$ git clone git://git2.kernel.org/pub/scm/git/git.git
Initialized empty Git repository in /extra/git/.git/
remote: Generating pack...
remote: Done counting 39677 objects.
remote: Deltifying 39677 objects.
remote:  100% (39677/39677) done
Indexing 39677 objects.
remote: Total 39677, written 39677 (delta 27701), reused 39585 (delta 27642)
 100% (39677/39677) done
Resolving 27701 deltas.
 100% (27701/27701) done
Checking files out...
 100% (798/798) done
jonsmirl@jonsmirl:/extra$

I think something is wrong with the wireless-dev tree.

-- 
Jon Smirl
jonsmirl@gmail.com
