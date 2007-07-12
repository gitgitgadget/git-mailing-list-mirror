From: Eric Wong <normalperson@yhbt.net>
Subject: Re: mtimes of working files
Date: Thu, 12 Jul 2007 11:25:02 -0700
Message-ID: <20070712182502.GA24854@hand.yhbt.net>
References: <f36b08ee0707110808h56ecbc7at9c92727c01cca508@mail.gmail.com> <Pine.LNX.4.64.0707111902040.4516@racer.site> <f36b08ee0707111136t198cf559vc85c561decf9707f@mail.gmail.com> <Pine.LNX.4.64.0707111940080.4516@racer.site> <20070712062605.GD29676@muzzle> <86myy122mm.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
X-From: git-owner@vger.kernel.org Thu Jul 12 20:25:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I93Ln-0004ry-16
	for gcvg-git@gmane.org; Thu, 12 Jul 2007 20:25:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757197AbXGLSZI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jul 2007 14:25:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755691AbXGLSZH
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jul 2007 14:25:07 -0400
Received: from hand.yhbt.net ([66.150.188.102]:40756 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754834AbXGLSZF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jul 2007 14:25:05 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 5EA5C2DC032;
	Thu, 12 Jul 2007 11:25:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <86myy122mm.fsf@blue.stonehenge.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52311>

"Randal L. Schwartz" <merlyn@stonehenge.com> wrote:
> >>>>> "Eric" == Eric Wong <normalperson@yhbt.net> writes:
> 
> Eric> open FH, "git log -r --name-only --no-color --pretty=raw -z @ARGV |" or die $!;
> 
> This breaks needlessly on @ARGV names that contain spaces.  You want:
> 
>   open FH, "-|", qw(git log -r --name-only --no-color --pretty=raw -z), @ARGV or die $!;
> 
> But that sounds familiar.... I think there's a function somewhere included in
> the git distro that does this.  I'm old and senile though. :)

Yep, I added that @ARGV at the last second and didn't care enough to fix
it.  I didn't want to link this into the git build system so that it
could find Git.pm, either.

So I'll just go with this 5.8-ism.  I didn't really intend for that
script to go anywhere, maybe somebody who wants it badly enough can make
the ls-files call respect any path limiting intended in @ARGV but still
allow revision ranges to be passed (my original intention of supporting
@ARGV was only revision ranges).

-- 
Eric Wong
