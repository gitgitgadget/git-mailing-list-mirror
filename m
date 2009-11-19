From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] gitk: Use git-difftool for external diffs
Date: Fri, 20 Nov 2009 09:21:26 +1100
Message-ID: <19205.50406.91209.309984@cargo.ozlabs.ibm.com>
References: <1258341126-2108-1-git-send-email-davvid@gmail.com>
	<19205.2531.205062.980468@cargo.ozlabs.ibm.com>
	<20091119193913.GA25410@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: peff@peff.net, sam@vilain.net, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 19 23:21:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBFNh-0000jV-80
	for gcvg-git-2@lo.gmane.org; Thu, 19 Nov 2009 23:21:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755764AbZKSWVZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Nov 2009 17:21:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755233AbZKSWVZ
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Nov 2009 17:21:25 -0500
Received: from ozlabs.org ([203.10.76.45]:42566 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753053AbZKSWVZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Nov 2009 17:21:25 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
	id E78A9B6F0D; Fri, 20 Nov 2009 09:21:30 +1100 (EST)
In-Reply-To: <20091119193913.GA25410@gmail.com>
X-Mailer: VM 8.0.12 under 22.2.1 (i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133263>

David Aguilar writes:

> On Thu, Nov 19, 2009 at 08:03:31PM +1100, Paul Mackerras wrote:
> > David Aguilar writes:
> > 
> > > This teaches gitk about git-difftool.  A benefit of this change is
> > > that gitk's external diff now works with read-only repositories.
> > 
> > What version of git does git difftool first appear in?  I prefer not
> > to introduce hard requirements on very recent versions of git into
> > gitk.
> > 
> > Paul.
> 
> git-difftool appeared in git 1.6.3.
> 
> If this patch is not going in then how do you suggest we fix the
> read-only repository bug?

I have no problem with using git difftool if the underlying git is new
enough, I just don't want gitk to explode when it isn't.

If the underlying git isn't new enough then we should probably make a
directory under $TMPDIR with a reasonably unpredictable name.

Also, I don't think we should remove the ability for the user to
choose which external diff tool to use; if we're using git difftool
then we should pass the selected tool with the -t option of git
difftool.  Maybe we need a "use default from git config" option
as well, though.

Paul.
