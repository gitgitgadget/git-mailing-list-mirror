From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Notes on Using Git with Subprojects
Date: Wed, 27 Sep 2006 11:55:22 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0609271152270.14200@wbgn013.biozentrum.uni-wuerzburg.de>
References: <45196628.9010107@gmail.com> <Pine.LNX.4.64.0609261629160.9789@iabervon.org>
 <20060926213003.GA8177@spearce.org> <4519AACD.7020508@gmail.com>
 <20060927080652.GA8056@admingilde.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: A Large Angry SCM <gitzilla@gmail.com>,
	Shawn Pearce <spearce@spearce.org>,
	Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 27 11:55:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSW8X-0007ed-VD
	for gcvg-git@gmane.org; Wed, 27 Sep 2006 11:55:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965489AbWI0Jz0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Sep 2006 05:55:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965491AbWI0Jz0
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Sep 2006 05:55:26 -0400
Received: from mail.gmx.net ([213.165.64.20]:20925 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S965489AbWI0JzZ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Sep 2006 05:55:25 -0400
Received: (qmail invoked by alias); 27 Sep 2006 09:55:23 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp040) with SMTP; 27 Sep 2006 11:55:23 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Martin Waitz <tali@admingilde.org>
In-Reply-To: <20060927080652.GA8056@admingilde.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27895>

Hi,

On Wed, 27 Sep 2006, Martin Waitz wrote:

> On Tue, Sep 26, 2006 at 03:33:49PM -0700, A Large Angry SCM wrote:
> > So, for each subproject of a parent project, you want to record branch, 
> > version (commit ID), and directory location. Not quite as easy to do in 
> > a makefile but do-able.
> 
> I've been playing with this kind of subprojects a little bit.
> 
> My current approach is like this:
> 
>  * create a .gitmodules file which lists all the directories
>    which contain a submodule.
>  * the .git/refs/heads directory of the submodule gets stored in
>    .gitmodule/<modulename> inside the parent project

Taking this a step further, you could make subproject/.git/refs/heads a 
symbolic link to .git/refs/heads/subproject, with the benefit that fsck 
Just Works.

Nevertheless, you have to take care of the fact that you need to commit 
the state of the root project just after committing to any subproject.

Ciao,
Dscho
