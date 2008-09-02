From: Nicolas Pitre <nico@cam.org>
Subject: Re: [RFC] Detached-HEAD reminder on commit?
Date: Tue, 02 Sep 2008 18:53:00 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0809021849390.23787@xanadu.home>
References: <1220383905-48316-1-git-send-email-pdebie@ai.rug.nl>
 <7vk5dujn9h.fsf@gitster.siamese.dyndns.org>
 <20080902210524.GB7757@leksak.fem-net> <200809022339.20123.johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Stephan Beyer <s-beyer@gmx.net>,
	Junio C Hamano <gitster@pobox.com>,
	Pieter de Bie <pdebie@ai.rug.nl>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Sep 03 00:54:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KaelK-0006PS-WB
	for gcvg-git-2@gmane.org; Wed, 03 Sep 2008 00:54:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753189AbYIBWxJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Sep 2008 18:53:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753158AbYIBWxI
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Sep 2008 18:53:08 -0400
Received: from relais.videotron.ca ([24.201.245.36]:55722 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753157AbYIBWxH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2008 18:53:07 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K6L007UZBKCL6E6@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 02 Sep 2008 18:53:00 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <200809022339.20123.johan@herland.net>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94733>

On Tue, 2 Sep 2008, Johan Herland wrote:

> On Tuesday 02 September 2008, Stephan Beyer wrote:
> > Junio C Hamano wrote:
> > > Pieter de Bie <pdebie@ai.rug.nl> writes:
> > > > Vienna:git pieter$ ./git commit --allow-empty -m"test"
> > > > Created commit 6ce62c8b: test
> > > > You are on a detached head, so this commit has not been recorded in a
> > > > branch. If you don't want to lose this commit, checkout a branch and
> > > > then run: git merge 6ce62c8bfcfb341106f3587d1c141c3955c2544c
> > > >
> > > > Are there any comments to this / strong opinions against such a
> > > > change?
> > >
> > > Unconditionally doing this is too loud for my taste.  You probably can
> > > do this in your post-commit hook.
> >
> > Well, Pieter probably can do this in his post-commit hook. But I think
> > this is useful for usability... especially for beginners who might not
> > even know what a hook is. ;)
> 
> I'm not sure I like this personally, but if we _really_ don't want newbies 
> to shoot themselves in the foot, we could make "git commit" fail on a 
> detached HEAD unless the user has indicated that s/he knows what's going 
> on; i.e. something like this:
> 
> Vienna:git pieter$ ./git commit --allow-empty -m"test"
> You are on a detached head, so this commit would not be recorded in a
> branch. If you don't want to lose this commit, please switch to a (new) 
> branch before committing. If you know what you're doing, and want to
> proceed on a detached HEAD, please enable commit.detached in your 
> configuration (git config --global commit.detached true)
> 
> ...but I sympathize with those that think this is overkill.

This is going over board indeed.

Adding commits to a detached head is _cool_, and it is also _useful_ in 
many occasions.  Let's not obfuscate that capability.

Adding an extra line of warning when the commit is done is fine, but 
more than that is too much IMHO.


Nicolas
