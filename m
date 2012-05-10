From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: git submodule delete?
Date: Thu, 10 May 2012 18:53:11 +0200
Message-ID: <20120510165311.GB76400@book.hvoigt.net>
References: <4FAB0D32.3000503@palm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Rich Pixley <rich.pixley@palm.com>
X-From: git-owner@vger.kernel.org Thu May 10 18:53:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSWcB-0005Dw-1I
	for gcvg-git-2@plane.gmane.org; Thu, 10 May 2012 18:53:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756747Ab2EJQxO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 May 2012 12:53:14 -0400
Received: from t2784.greatnet.de ([83.133.105.219]:40137 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752349Ab2EJQxN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2012 12:53:13 -0400
Received: (qmail 22685 invoked from network); 10 May 2012 16:53:11 -0000
Received: from localhost (127.0.0.1)
  by darksea.de with SMTP; 10 May 2012 16:53:11 -0000
Content-Disposition: inline
In-Reply-To: <4FAB0D32.3000503@palm.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197600>

On Wed, May 09, 2012 at 05:34:58PM -0700, Rich Pixley wrote:
> Put another way, I've made a commit pointing to a nonexistent submodule  
> commit.  And the submodule commit is now lost.  Can I manually force the  
> submodule commit to the previous value?  Or can I remove the submodule  
> and re-add it with an existing value?

If want to create a new commit with a valid submodule sha1 then you can
simply checkout the submodule at the desired commit and commit that
change in the superproject.

As far as changing the existing commit is concerned. That is not
possible wihout rewriting history. If your commit is on a branch
which nobody else is using you can use rebase to modify that commit.

If it is on a shared branch its not easy since everybody will notice and
would have to reset to the new history which will be a hassle.

Cheers Heiko
