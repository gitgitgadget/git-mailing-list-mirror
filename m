From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] Documentation: add a planning document for the next CLI
 revamp
Date: Thu, 30 Oct 2008 12:53:49 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0810301105350.13034@xanadu.home>
References: <1225338485-11046-1-git-send-email-sam@vilain.net>
 <alpine.LFD.2.00.0810301024300.13034@xanadu.home>
 <20081030145253.GK14786@spearce.org> <20081030145928.GA21707@glandium.org>
 <20081030150135.GG24098@artemis.corp>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Mike Hommey <mh@glandium.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Sam Vilain <sam@vilain.net>, git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Thu Oct 30 17:56:03 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kvand-0004gq-Km
	for gcvg-git-2@gmane.org; Thu, 30 Oct 2008 17:55:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753655AbYJ3Qx4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Oct 2008 12:53:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753746AbYJ3Qx4
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Oct 2008 12:53:56 -0400
Received: from relais.videotron.ca ([24.201.245.36]:22272 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753591AbYJ3Qxz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Oct 2008 12:53:55 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K9K00A929KLT5F0@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 30 Oct 2008 12:53:10 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20081030150135.GG24098@artemis.corp>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99500>

On Thu, 30 Oct 2008, Pierre Habouzit wrote:

> On Thu, Oct 30, 2008 at 02:59:28PM +0000, Mike Hommey wrote:
> > On Thu, Oct 30, 2008 at 07:52:53AM -0700, Shawn O. Pearce <spearce@spearce.org> wrote:
> > > +1 to Nico's NAK.
> > > 
> > > Although I was at the GitTogether I don't remember this change to
> > > checkout being discussed.  I must have been asleep reading email
> > > or something.  I am _NOT_ in favor of this change; I think the
> > > current behavior of "git checkout origin/master" is correct and as
> > > sane as we can make it.
> > 
> > Except he was talking about 'git checkout branch', not 'git checkout
> > origin/branch'. And I would be fine with 'git checkout branch' doing
> > what 'git checkout -b branch $remote/branch' does if $remote is unique
> > (i.e. there is no other 'branch' branch in any other remote) and the
> > 'branch' branch doesn't already exist.
> 
> Seconded.
> 
> Having git-checkout $foo being a shorthand for git checkout -b $foo
> origin/$foo when origin/$foo exists and $foo doesn't is definitely handy.

No.  This is only the first step towards insanity.

In many cases origin/$foo == origin/master so this can't work in that 
case which is, after all, the common case.  Therefore I think this is 
wrong to add magic operations which are not useful for the common case 
and actively _hide_ how git actually works.  Not only will you have to 
explain how git works anyway for that common origin/master case, but 
you'll also have to explain why sometimes the magic works and sometimes 
not.  Please keep such convenience shortcuts for your own scripts and/or 
aliases.


Nicolas
