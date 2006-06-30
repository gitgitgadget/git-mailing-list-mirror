From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 4/4] save another call to git-update-index
Date: Fri, 30 Jun 2006 11:56:50 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0606301155050.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20060630002756.GD22618@steel.home> 
 <Pine.LNX.4.63.0606300235300.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <81b0412b0606300022k68d13dg8e292d9b768df51c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Alex Riesen <fork0@t-online.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 30 11:57:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FwFk7-0002pL-V6
	for gcvg-git@gmane.org; Fri, 30 Jun 2006 11:56:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932420AbWF3J4x (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Jun 2006 05:56:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932461AbWF3J4x
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jun 2006 05:56:53 -0400
Received: from mail.gmx.net ([213.165.64.21]:36482 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932420AbWF3J4w (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Jun 2006 05:56:52 -0400
Received: (qmail invoked by alias); 30 Jun 2006 09:56:50 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp043) with SMTP; 30 Jun 2006 11:56:50 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <81b0412b0606300022k68d13dg8e292d9b768df51c@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22974>

Hi,

On Fri, 30 Jun 2006, Alex Riesen wrote:

> On 6/30/06, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > 
> > FYI I've been just battling this pipe for a couple of hours. The first
> > steps were easy, but since I wanted to do it incrementally, the index has
> > to be written every so often, and I seem not to be able to get that right.
> > 
> Are you sure? Does something use the index between starting update-index
> pipe and pclose?

Yes, I am sure you have to write the cache before git-read-tree and 
git-write-tree ;-) I must have done something severely wrong, though, 
since there are not too many places where they are called. The problem is 
more likely that the cache has to be _read_, and _before_ the first 
substituted call to git-update-index.

Ciao,
Dscho
