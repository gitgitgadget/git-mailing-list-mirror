From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git checkout preserve timestamp?
Date: Thu, 1 Mar 2007 23:13:27 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703012304200.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <17895.18265.710811.536526@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Thu Mar 01 23:13:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMtWo-0005hE-TJ
	for gcvg-git@gmane.org; Thu, 01 Mar 2007 23:13:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030435AbXCAWNc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Mar 2007 17:13:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030447AbXCAWNc
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Mar 2007 17:13:32 -0500
Received: from mail.gmx.net ([213.165.64.20]:53731 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1030435AbXCAWNb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2007 17:13:31 -0500
Received: (qmail invoked by alias); 01 Mar 2007 22:13:29 -0000
X-Provags-ID: V01U2FsdGVkX1+7TmZdPFq7hrq3sNrD/xji9Rf+CGfGH0zAYPWKgO
	iecYcEkXuqOXm1
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <17895.18265.710811.536526@lisa.zopyra.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41136>

Hi Bill,

On Thu, 1 Mar 2007, Bill Lear wrote:

> I often find myself in branch A, with everything checked in and 
> compiled, wanting to look at something on branch B.

I did that, too, until git-show learnt about the nice ":" syntax.

For example, if I want to know what is in branch B, I do

	$ git show B:

which shows the root directory of the revision "B" (this is in line with 
<commit>:<pathspec> if you interpret "" as the root path). The subtrees 
are all identified by trailing slashes. Then you can say

	$ git show B:Documentation/Makefile

If you want to know the differences to the file "doc/GNUMakefile" in your 
current working tree, do

	$ git diff B:Documentation/Makefile -- doc/GNUMakefile

No need to switch branches.

And if you _do_ need to switch branches, why not make a local clone, 
sharing the object database:

	$ git clone -l -s . test-directory

This is _very_ fast, since it basically checks out the branches in 
test-directory/. Right now, you have to go to the test-directory, and 
switch the branches manually (I think), but talk has been that you may be 
able to tell git-clone which branch you really want.

Hth,
Dscho
