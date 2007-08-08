From: Peter Baumann <waste.manager@gmx.de>
Subject: Re: Git'ing a non-labeled set of sources
Date: Wed, 8 Aug 2007 21:37:20 +0200
Message-ID: <20070808193720.GD27470@xp.machine.xx>
References: <CF7E46FCFF66AD478BB72724345289EC170CE4@twx-exch01.twacs.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Sparks, Sam" <SSparks@twacs.com>
X-From: git-owner@vger.kernel.org Wed Aug 08 21:37:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIrLk-0002Ay-42
	for gcvg-git@gmane.org; Wed, 08 Aug 2007 21:37:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762883AbXHHThX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Aug 2007 15:37:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763302AbXHHThW
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Aug 2007 15:37:22 -0400
Received: from mail.gmx.net ([213.165.64.20]:45518 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1761775AbXHHThT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2007 15:37:19 -0400
Received: (qmail invoked by alias); 08 Aug 2007 19:37:18 -0000
Received: from mason.hofmann.stw.uni-erlangen.de (EHLO localhost) [131.188.24.36]
  by mail.gmx.net (mp049) with SMTP; 08 Aug 2007 21:37:18 +0200
X-Authenticated: #1252284
X-Provags-ID: V01U2FsdGVkX190NdlqpVR0udthWAcQhOTylYvt9zFcIBFHyX8+PZ
	Ie6aREWVpHrslD
Mail-Followup-To: "Sparks, Sam" <SSparks@twacs.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <CF7E46FCFF66AD478BB72724345289EC170CE4@twx-exch01.twacs.local>
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55344>

On Wed, Aug 08, 2007 at 01:59:38PM -0500, Sparks, Sam wrote:
> Hello All,
> 
> Please excuse me if this is an ignorant question; I'm new to git and my
> have overlooked something in the documentation.
> 
> I'm attempting to obtain a snapshot of source code from an unlabeled git
> branch in a public repository. I've found in the documentation that a
> timestamp cannot be used to specify a particular version of source code,
> but I believe I can work with the commit value as returned by 'git
> show'.
> 
> However, I have been unsuccessful in my attempts to use this identifier
> to clone or checkout the associated source tree. Has anyone been
> successful in using git to successfully replicate an unlabeled version
> of sources in a repository?
> 
> Here is my latest attempt:
> /dir_i_want_to_replicate $ git show --pretty=short
> commit 5b1313fb2758ffce8b624457f777d8cc6709608d
> Author: ....
> 
> /replication_dir $ git clone git://www.denx.de/git/u-boot.git
> u-boot-mpc83xx
> Blah blah blah..
>  100% (4378/4378) done
> /replication_dir/u-boot-mpc83xx/ $ git checkout
> 5b1313fb2758ffce8b624457f777d8cc6709608d
> error: pathspec '5b1313fb2758ffce8b624457f777d8cc6709608d' did not match
> any. 
> 

Because there is no 5b1313fb2758ffce8b624457f777d8cc6709608d in the
repo.

  $ git clone git://www.denx.de/git/u-boot.git
  Initialized empty Git repository in /tmp/u-boot/.git/
  remote: Generating pack...
  remote: Done counting 40938 objects.
  remote: Deltifying 40938 objects.
  remote:  100% (40938/40938) done
  Indexing 40938 objects...
  remote: Total 40938 (delta 32545), reused 39302 (delta 31040)
  100% (40938/40938) done
  Resolving 32545 deltas...
  100% (32545/32545) done

  $ cd u-boot; git-rev-list --all|grep ^5b1
  5b1d713721c3ea02549940133f09236783dda1f9

-Peter
