From: Pete Wyckoff <pw@padd.com>
Subject: Re: How does --assume-unchanged impact git-p4?
Date: Sun, 25 Mar 2012 09:55:48 -0400
Message-ID: <20120325135548.GA4664@padd.com>
References: <20120309155848.GA5998@jerec>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Corey Thompson <cmtptr@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 25 15:56:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SBnvN-00085m-8P
	for gcvg-git-2@plane.gmane.org; Sun, 25 Mar 2012 15:56:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754722Ab2CYNzy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Mar 2012 09:55:54 -0400
Received: from honk.padd.com ([74.3.171.149]:54141 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754322Ab2CYNzx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Mar 2012 09:55:53 -0400
Received: from arf.padd.com (unknown [50.55.145.32])
	by honk.padd.com (Postfix) with ESMTPSA id 9FC09D02;
	Sun, 25 Mar 2012 06:55:52 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 192033149B; Sun, 25 Mar 2012 09:55:48 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20120309155848.GA5998@jerec>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193867>

cmtptr@gmail.com wrote on Fri, 09 Mar 2012 10:58 -0500:
> My workplace uses Perforce, so I've started using git-p4 to interface
> with it.  Some of the files included in our depot are cached
> pre-compiled binaries which do a great deal of damage to git's
> performance, so after some research I found that I can "git update-index
> --assume-unchanged" on these files.  This is great except that now I'm
> worried that this might prevent git-p4 from doing its thing when someone
> else updates these files.
> 
> So am I going to miss updates to our cached binaries using this method?
> Is there a better method I should be using in this scenario?

When you use "git-p4 sync" to pull content from p4, it doesn't
look at any of the existing files.  Then when you rebase or
merge, changes from p4 will show up in your workspace okay, again
regardless of the setting of --assume-unchanged.

The risks outlined in the documentation for git-update-index are
still there, but using git-p4 shouldn't add any new ones.

		-- Pete
