From: "Dave O'Neill" <dmo@roaringpenguin.com>
Subject: Re: [PATCH] Let git-svnimport clean up SVK commit messages.
Date: Thu, 21 Jun 2007 10:14:15 -0400
Message-ID: <20070621141415.GA21065@magnesium.roaringpenguin.com>
References: <1182392095394-git-send-email-dmo@roaringpenguin.com> <4679EE45.2080605@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Thu Jun 21 16:14:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1NQQ-0007kO-H0
	for gcvg-git@gmane.org; Thu, 21 Jun 2007 16:14:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752616AbXFUOOR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Jun 2007 10:14:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752052AbXFUOOR
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jun 2007 10:14:17 -0400
Received: from www.roaringpenguin.com ([206.191.13.82]:1087 "EHLO
	www.roaringpenguin.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751391AbXFUOOQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jun 2007 10:14:16 -0400
Received: from magnesium.roaringpenguin.com (ottawa-hs-64-26-171-99.s-ip.magma.ca [64.26.171.99])
	by www.roaringpenguin.com (8.14.1/8.14.0) with ESMTP id l5LEEEvG025600;
	Thu, 21 Jun 2007 10:14:15 -0400
Received: from magnesium.roaringpenguin.com (localhost.localdomain [127.0.0.1])
	by magnesium.roaringpenguin.com (8.12.10/8.12.10) with ESMTP id l5LEEFWo022492;
	Thu, 21 Jun 2007 10:14:15 -0400
Received: (from dmo@localhost)
	by magnesium.roaringpenguin.com (8.12.10/8.12.10/Submit) id l5LEEFHO022489;
	Thu, 21 Jun 2007 10:14:15 -0400
Content-Disposition: inline
In-Reply-To: <4679EE45.2080605@midwinter.com>
User-Agent: Mutt/1.4.1i
X-Scanned-By: CanIt (www . roaringpenguin . com) on 206.191.13.82
X-Scanned-By: MIMEDefang 2.57 on 192.168.10.12
X-Spam-Score: undef - spam scanning disabled
X-CanItPRO-Stream: outgoing (inherits from default)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50630>

On Wed, Jun 20, 2007 at 08:19:33PM -0700, Steven Grimm wrote:

> Any chance of applying this to git-svn instead? There has been talk of 
> deprecating git-svnimport since git-svn now does everything 
> git-svnimport does, and more. (If you believe that's not the case, 
> please describe what you're doing with git-svnimport that you can't do 
> with git-svn.)

Sure, I can probably apply it to git-svn as well, but based on the
testing I've done, git-svnimport still works better for what I'm doing.
I'm trying to do a straight conversion from SVN to git, so we can do
away with our Subversion repositories, so I won't need the bidirectional
support of git-svn.  

If git-svn had a --one-way option that could 
  - know that I'm converting, and import my SVN tags and branches to
    local tags and heads rather than remotes
  - turn off the git-svn-id: tags in the commit
  - avoid preserving a .git/svn/ directory (a git-svn conversion was 50%
    larger than one from git-svnimport because of this)
  - convert svn:ignore attrs to .gitignore (like the -I option of
    git-svnignore)

then I wouldn't need git-svnimport.  Alternatively, if there's some way
to postprocess my clone to do all of the above, that would probably be
good enough.

Cheers,
Dave
