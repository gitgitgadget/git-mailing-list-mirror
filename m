From: Pete Wyckoff <pw@padd.com>
Subject: Re: Fwd: git p4: feature request - branch check filtering
Date: Wed, 23 Apr 2014 15:46:35 -0400
Message-ID: <20140423194635.GA19597@padd.com>
References: <CADtnS+zWzPY6ftwxWUE+Gb-OKq_Kzf9y+fFfgJ-demWyX3azCg@mail.gmail.com>
 <CADtnS+weco6Lvk3hHuM7BcaRsvMkeDCmqH26s19TrgWvBYXAvA@mail.gmail.com>
 <20140223151247.GA1272@padd.com>
 <CADtnS+w9q0dmnGsZoDr12GZ-RSZzcfPs6rfii-4eK7Hhn2byag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Dan Porter <dpreid@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 23 21:46:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wd381-0001KV-CU
	for gcvg-git-2@plane.gmane.org; Wed, 23 Apr 2014 21:46:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757038AbaDWTqk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2014 15:46:40 -0400
Received: from honk.padd.com ([74.3.171.149]:58596 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751182AbaDWTqj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2014 15:46:39 -0400
Received: from arf.padd.com (unknown [50.105.4.164])
	by honk.padd.com (Postfix) with ESMTPSA id A94B32C1B;
	Wed, 23 Apr 2014 12:46:37 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 27495212DA; Wed, 23 Apr 2014 15:46:35 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <CADtnS+w9q0dmnGsZoDr12GZ-RSZzcfPs6rfii-4eK7Hhn2byag@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246872>

dpreid@gmail.com wrote on Tue, 22 Apr 2014 10:29 +0100:
> There is a patch viewable at this link:
> https://github.com/Stealthii/git/commit/f7a2e611262fd977ac99e066872d3d0743b7df3c
> 
> For the use case this works perfectly - if I define branch mappings
> with git config, followed by setting 'git-p4.skipBranchScan' to true,
> git-p4 will skip scanning of all remote branches and limit to what's
> defined in the map.  An example config:
> 
> [git-p4]
>         skipBranchScan = true
>         branchList = release_1.0.0:release_1.1.0
>         branchList = release_1.1.0:release_1.2.0
> 
> If there is any more information I need to provide let me know. I have
> been using this patch for over two months, testing both use cases with
> and without git-p4.skipBranchScan and I have noticed no issues.  Logic
> of git-p4 is not changed from default behaviour, unless the user
> explicitly sets the boolean flag to skip scanning.

Thanks, Dan.  This looks good and is a fine compromise
considering the various choices we discussed earlier.

Junio's comments about 2.0 non-withstanding, I think this change
should go into the next convenient release.  So 2.1 or 2.0.1;
however the numbers end up working post-2.0.

If you could take a look at Documentation/SubmittingPatches,
and do a few things:

    1.  Write a nice commit message, say:

	git p4: add skipBranchScan to avoid p4 branch scan

	Some more useful text.

    2.  Include at the bottom of that message:

	Acked-by: Pete Wyckoff <pw@padd.com>

    3.  Inline the text of your patch, not just a link to github.

    4.  Consider adding a t98xx test.  This isn't required for
	a fairly minor change like yours, but if you think TDD
	is fun, have at it.  Might protect your feature against
	future hackers who would try to break it.  :)

Then send it to vger, cc junio (and me), and he will be kind
enough to queue it up appropriately.

Thanks!

		-- Pete
