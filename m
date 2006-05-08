From: Pavel Roskin <proski@gnu.org>
Subject: Re: Implementing branch attributes in git config
Date: Sun, 07 May 2006 21:55:29 -0400
Message-ID: <1147053329.17371.52.camel@dv>
References: <1147037659.25090.25.camel@dv>
	 <Pine.LNX.4.64.0605071629080.3718@g5.osdl.org>
	 <Pine.LNX.4.64.0605071718440.3718@g5.osdl.org>
	 <Pine.LNX.4.63.0605080303410.13588@wbgn013.biozentrum.uni-wuerzburg.de>
	 <1147051300.17371.32.camel@dv>
	 <Pine.LNX.4.63.0605080327490.13794@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 08 03:55:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FcuyQ-0001XG-Fj
	for gcvg-git@gmane.org; Mon, 08 May 2006 03:55:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932251AbWEHBzf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 May 2006 21:55:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932252AbWEHBzf
	(ORCPT <rfc822;git-outgoing>); Sun, 7 May 2006 21:55:35 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:18612 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S932251AbWEHBze
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 7 May 2006 21:55:34 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1FcuyD-0001oZ-Mo
	for git@vger.kernel.org; Sun, 07 May 2006 21:55:33 -0400
Received: from proski by dv.roinet.com with local (Exim 4.62)
	(envelope-from <proski@dv.roinet.com>)
	id 1Fcuy9-000804-Te; Sun, 07 May 2006 21:55:29 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0605080327490.13794@wbgn013.biozentrum.uni-wuerzburg.de>
X-Mailer: Evolution 2.6.1 (2.6.1-3) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19748>

On Mon, 2006-05-08 at 03:27 +0200, Johannes Schindelin wrote:
> > Now, how can I get a description for the "netdev" branch by one
> > git-repo-config command, without pipes?
> 
> 	git-repo-config --get branchdata.description ' for netdev$'

No, it doesn't remove "for netdev".  What I really don't like is that
git-repo-config treats it as "not my problem".

git-repo-config places extremely tight limitations of the names of the
sections and the keys.  But sometimes a relationship between two loosely
defined strings needs to be presented.  It's a real need.  And
git-repo-config doesn't address this need.

I believe git-repo-config should allow direct retrieval of data from any
depth, and the syntax should be explicit rather than fuzzy.  A dot is
more explicit than "for", especially if the dot appears after a name
that may not contain dots.

Another question is how we want to group the data.  Do we want to have
all descriptions together or in separate sections?  Whatever the answer,
git-repo-config should provide means to extract all data in one command,
without need for postprocessing.

So I understand arguing where to place the branch name.  But what I
don't like is the desire to offload part of the processing on the
callers.

-- 
Regards,
Pavel Roskin
