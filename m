From: Jon Loeliger <jdl@freescale.com>
Subject: Re: [Census] So who uses git?
Date: Tue, 31 Jan 2006 13:44:27 -0600
Message-ID: <1138736666.24410.38.camel@cashmere.sps.mot.com>
References: <46a038f90601251810m1086d353ne8c7147edee4962a@mail.gmail.com>
	 <Pine.LNX.4.64.0601272345540.2909@evo.osdl.org>
	 <46a038f90601272133o53438987ka6b97c21d0cdf921@mail.gmail.com>
	 <1138446030.9919.112.camel@evo.keithp.com>
	 <7vzmlgt5zt.fsf@assigned-by-dhcp.cox.net>
	 <20060130185822.GA24487@hpsvcnb.fc.hp.com>
	 <Pine.LNX.4.63.0601311127250.25248@wbgn013.biozentrum.uni-wuerzburg.de>
	 <Pine.LNX.4.64.0601310926330.7301@g5.osdl.org>
	 <20060131181248.GE11955@fieldses.org>
	 <7vbqxsyyym.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Jan 31 20:47:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F41SC-0001DI-Gk
	for gcvg-git@gmane.org; Tue, 31 Jan 2006 20:46:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751343AbWAaTon (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 Jan 2006 14:44:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751405AbWAaTon
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jan 2006 14:44:43 -0500
Received: from az33egw02.freescale.net ([192.88.158.103]:13547 "EHLO
	az33egw02.freescale.net") by vger.kernel.org with ESMTP
	id S1751343AbWAaTom (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jan 2006 14:44:42 -0500
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id k0VJur6C014321
	for <git@vger.kernel.org>; Tue, 31 Jan 2006 12:56:53 -0700 (MST)
Received: from [10.82.19.2] (cashmere.am.freescale.net [10.82.19.2])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id k0VJr1vp009792
	for <git@vger.kernel.org>; Tue, 31 Jan 2006 13:53:02 -0600 (CST)
To: Git List <git@vger.kernel.org>
In-Reply-To: <7vbqxsyyym.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.ydl.1) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15337>

On Tue, 2006-01-31 at 13:33, Junio C Hamano wrote:
> "J. Bruce Fields" <bfields@fieldses.org> writes:

> I think many good stuff git offers would not be helpful to the
> users until index is understood as the third entity, in addition
> to the usual "committed state" and "working tree state".  It
> might be better to talk about it sooner rather than later.  And
> the tool is geared towards taking advantage of it, so until the
> user understands that, behaviour of some tools would feel
> unintuitive.

Agreed.

> You can have local throw-away modifications while applying
> patches and merging (I once broke merges by ignoring that it is
> perfectly valid to have index and working tree files be
> different and keep working that way.  That was a hard lesson).
> The index file knows what working tree changes are meant to be
> committed.  Another thing I find useful, which cannot be done
> without index, is to sanity check while developing.  When "git
> diff" gives too many diffs, running update-index on paths that I
> think are more-or-less OK helps to reduce clutter, and I can
> view only further changes to those paths.

And right there is where people get caught by surprise.
What "they" then want to do is actually pick certain
files to commit.  And when they do, they get caught off
guard by the _additional_ files.

I have done this style of "update-index on more-or-less OK
files in order to clear up the diff.  And it is also in that
time frame that I start feeling that certain changes belong
to "one commit" or another.  The result is, I want to then
pick the parts that get committed together.  But _really_
being certain exactly which files, and _only_ those files,
will really be committed is tough.

jdl
