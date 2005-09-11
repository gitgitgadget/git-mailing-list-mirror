From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: bogus merges
Date: Sun, 11 Sep 2005 19:36:28 +0100
Message-ID: <20050911193628.B24984@flint.arm.linux.org.uk>
References: <59a6e58305090507387d412b3d@mail.gmail.com> <Pine.LNX.4.58.0509050853080.3568@evo.osdl.org> <20050911112130.A7510@flint.arm.linux.org.uk> <46a038f905091104483cc01a11@mail.gmail.com> <43244935.6060703@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: martin.langhoff@gmail.com, Linus Torvalds <torvalds@osdl.org>,
	Wayne Scott <wsc9tt@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 11 20:37:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEWgv-0000N2-CE
	for gcvg-git@gmane.org; Sun, 11 Sep 2005 20:36:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750774AbVIKSgf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Sep 2005 14:36:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751078AbVIKSgf
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Sep 2005 14:36:35 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:11536 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750774AbVIKSge (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Sep 2005 14:36:34 -0400
Received: from flint.arm.linux.org.uk ([2002:d412:e8ba:1:201:2ff:fe14:8fad])
	by caramon.arm.linux.org.uk with esmtpsa (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.52)
	id 1EEWgo-0005v3-C2; Sun, 11 Sep 2005 19:36:30 +0100
Received: from rmk by flint.arm.linux.org.uk with local (Exim 4.52)
	id 1EEWgm-00076o-Ha; Sun, 11 Sep 2005 19:36:28 +0100
To: A Large Angry SCM <gitzilla@gmail.com>
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <43244935.6060703@gmail.com>; from gitzilla@gmail.com on Sun, Sep 11, 2005 at 11:11:49AM -0400
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8316>

On Sun, Sep 11, 2005 at 11:11:49AM -0400, A Large Angry SCM wrote:
> Martin Langhoff wrote:
> > On 9/11/05, Russell King <rmk@arm.linux.org.uk> wrote:
> >>On Mon, Sep 05, 2005 at 09:01:32AM -0700, Linus Torvalds wrote:
> >>>I suspect rmk is using cogito-0.13
> >>Correct, and rmk will probably be extremely nervous about upgrading when
> >>0.14 appears.
> > 
> > Well, *actually* cogito-0.13 didn't include git-core, so we have to
> > look for the reasons elsewhere. Could be the leftover MERGE_HEAD
> > Daniel mentions.
> > 
> > Russel, can you confirm what git-core version you are/were running?
> 
> Russel,
> 
> How are you updating your tree to Linus'? If you are rsyncing from 
> kernel.org, you're probably getting a MERGE_HEAD with the rsync. A while 
> ago I got annoyed enough add the equivalent of:
> 
> 	rm -f ${LOCAL_REPOS}/.git/MERGE_HEAD
> 
> to my (very stupid) git rsync script.

I think you can forget MERGE_HEAD.  Why?  I use cogito for pulling.

cg-pull gets the head, and then rsyncs the objects found in the object
directory.  It doesn't touch MERGE_HEAD.  None of the cogito scripts
that I have know anything about MERGE_HEAD itself.

(Plus, it's actually a two stage pull - I have a cron-based cg-pull
into a master repository on one box, which I then cg-pull to the
development box which is only powered when I'm working.)

-- 
Russell King
