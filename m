From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCH 2/2] t/t9802: explicitly name the upstream branch to use
 as a base
Date: Tue, 18 Jun 2013 09:42:07 -0400
Message-ID: <20130618134207.GA28716@padd.com>
References: <1371519650-17869-1-git-send-email-bcasey@nvidia.com>
 <1371519650-17869-2-git-send-email-bcasey@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org,
	Brandon Casey <drafnel@gmail.com>
To: Brandon Casey <bcasey@nvidia.com>
X-From: git-owner@vger.kernel.org Tue Jun 18 15:48:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UowGY-0005b9-9p
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 15:48:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932582Ab3FRNsF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 09:48:05 -0400
Received: from honk.padd.com ([74.3.171.149]:35082 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932561Ab3FRNsE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 09:48:04 -0400
X-Greylist: delayed 352 seconds by postgrey-1.27 at vger.kernel.org; Tue, 18 Jun 2013 09:48:04 EDT
Received: from arf.padd.com (unknown [50.55.134.154])
	by honk.padd.com (Postfix) with ESMTPSA id 6DC89620D;
	Tue, 18 Jun 2013 06:42:10 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 152FF22F05; Tue, 18 Jun 2013 09:42:08 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1371519650-17869-2-git-send-email-bcasey@nvidia.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228229>

bcasey@nvidia.com wrote on Mon, 17 Jun 2013 18:40 -0700:
> From: Brandon Casey <drafnel@gmail.com>
> 
> Prior to commit fa83a33b, the 'git checkout' DWIMery would create a
> new local branch if the specified branch name did not exist and it
> matched exactly one ref in the "remotes" namespace.  It searched
> the "remotes" namespace for matching refs using a simple comparison
> of the trailing portion of the remote ref names.  This approach
> could sometimes produce false positives or negatives.
> 
> Since fa83a33b, the DWIMery more strictly excludes the remote name
> from the ref comparison by iterating through the remotes that are
> configured in the .gitconfig file.  This has the side-effect that
> any refs that exist in the "remotes" namespace, but do not match
> the destination side of any remote refspec, will not be used by
> the DWIMery.
> 
> This change in behavior breaks the tests in t9802 which relied on
> the old behavior of searching all refs in the remotes namespace,
> since the git-p4 script does not configure any remotes in the
> .gitconfig.  Let's work around this in these tests by explicitly
> naming the upstream branch to base the new local branch on when
> calling 'git checkout'.

Thanks for finding and fixing this.  Great explanation.  I
tested it locally too.

Acked-by: Pete Wyckoff <pw@padd.com>

		-- Pete
