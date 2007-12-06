From: David Brown <git@davidb.org>
Subject: git-p4: Import not at root of tree.
Date: Wed, 5 Dec 2007 21:15:24 -0800
Message-ID: <20071206051524.GA21207@old.davidb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Dec 06 06:16:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J095P-0006WX-FJ
	for gcvg-git-2@gmane.org; Thu, 06 Dec 2007 06:15:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751487AbXLFFP0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Dec 2007 00:15:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751448AbXLFFP0
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Dec 2007 00:15:26 -0500
Received: from mail.davidb.org ([66.93.32.219]:45599 "EHLO mail.davidb.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751399AbXLFFPZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Dec 2007 00:15:25 -0500
Received: from davidb by mail.davidb.org with local (Exim 4.68 #1 (Debian))
	id 1J0952-0005cP-U9
	for <git@vger.kernel.org>; Wed, 05 Dec 2007 21:15:24 -0800
Mail-Followup-To: Git <git@vger.kernel.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67241>

I'm trying to mirror a directory deep down in a very chaotically organized
Perforce repo.  I'd like the git tree to contains the contents of this
directory, but not at the root of my tree.

In other words I'd like to have something like

   git-p4 clone --strip=//depot/a/b/c --destination=foo //depot/a/b/c/d

Result in:
   foo/d/...

and have only a single directory 'd' at the top of the resulting git repo.
My current choices seem to be to put the contents of 'd' at the root, or
have the whole 'a/b/c/d' tree visible as what the '--keep-path' option does.

If this isn't implemented, any suggestions on the best way to go about
implementing this, or another way to do this.

What I'm trying to do is emulate the behavior of a P4 client spec.  There
is a single directory (now, there will probably be others later) that is in
a different place in Perforce and it needs to be in this directory in order
to build.  I've tried working with a submodule, but it is cumbersome to do
things like bisections when there are dependencies between the trees.

Thanks,
Dave
