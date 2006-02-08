From: Ryan Anderson <ryan@michonline.com>
Subject: Re: [PATCH] Add git-annotate - a tool for annotating files with the revision and person that created each line in the file.
Date: Wed, 8 Feb 2006 16:07:57 -0500
Message-ID: <20060208210756.GA9490@mythryan2.michonline.com>
References: <11394103753694-git-send-email-ryan@michonline.com> <7vd5hxpr2d.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 08 22:09:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F6wZ0-0003Nj-1G
	for gcvg-git@gmane.org; Wed, 08 Feb 2006 22:09:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964960AbWBHVJT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Feb 2006 16:09:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964922AbWBHVJT
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Feb 2006 16:09:19 -0500
Received: from mail.autoweb.net ([198.172.237.26]:50155 "EHLO
	mail.internal.autoweb.net") by vger.kernel.org with ESMTP
	id S964914AbWBHVJS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Feb 2006 16:09:18 -0500
Received: from c-68-60-186-73.hsd1.mi.comcast.net ([68.60.186.73] helo=h4x0r5.com)
	by mail.internal.autoweb.net with esmtp (Exim 4.50)
	id 1F6wYp-0005rl-O9; Wed, 08 Feb 2006 16:09:13 -0500
Received: from mythical ([10.254.251.11] ident=Debian-exim)
	by h4x0r5.com with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.60)
	(envelope-from <ryan@michonline.com>)
	id 1F6wYj-0008B9-8h; Wed, 08 Feb 2006 16:09:11 -0500
Received: from ryan by mythical with local (Exim 4.60)
	(envelope-from <ryan@mythryan2.michonline.com>)
	id 1F6wYA-0003LQ-VK; Wed, 08 Feb 2006 16:08:30 -0500
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vd5hxpr2d.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15750>

On Wed, Feb 08, 2006 at 11:51:22AM -0800, Junio C Hamano wrote:
> Ryan Anderson <ryan@michonline.com> writes:
> 
> > Signed-off-by: Ryan Anderson <ryan@michonline.com>
> >
> > ---
> >
> > I think this version is mostly ready to go.
> >
> > Junio, the post you pointed me at was very helpful (once I got around to
> > listening to it), but the code it links to is missing - if that's a
> > better partial implementation than this, can you ressurrect it
> > somewhere?  I'd be happy to reintegrate it together.
> 
> I still have it, but the reason why I withdrew circulating it
> was because I found that on some inputs it did not work
> correctly as intended.  Not that the algorithm was necessarily
> broken but the implementation certainly was.
> 
> Unlike yours mine reads and interprets diff output to find which
> lines are common and which lines are added, and I think the diff
> interpretation logic has various corner cases wrong.  I did
> combine-diff.c diff interpreter without looking at my
> 'git-blame', so I do not remember where I got it wrong,
> though...

I tried that approach at first, and it was much much more confusing to
try to keep track of.  The problem Linus found (that of a missing
"all_lines_claimed()") was related to that code.  This implementation is
simple, though it has to have some problems with guessing at duplicated
lines incorrectly.

> It's been a while since I looked at it the last time so it may
> not even work with the current git, but here it is..

I'll take a look through this in greater detail later, hopefully your
approach can be applied.  Diff-analyzing is apparently tricky.

-- 

Ryan Anderson
  sometimes Pug Majere
