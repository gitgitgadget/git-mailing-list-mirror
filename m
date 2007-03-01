From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: defaults for where to merge from
Date: Thu, 1 Mar 2007 08:55:18 +0100
Message-ID: <81b0412b0702282355i176ad7e5t7b9e417b27e524fb@mail.gmail.com>
References: <es450f$d58$1@sea.gmane.org>
	 <200702281522.14965.andyparkins@gmail.com>
	 <Pine.LNX.4.64.0702281526270.15314@reaper.quantumfyre.co.uk>
	 <Pine.LNX.4.63.0702281643200.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <81b0412b0702281045u2e511ebfie14a7b718531f8c4@mail.gmail.com>
	 <45E5DE8A.2080101@lu.unisi.ch>
	 <81b0412b0702281607l6f9b1cadg9f3a84b06b9acd7d@mail.gmail.com>
	 <Pine.LNX.4.63.0703010221000.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Paolo Bonzini" <paolo.bonzini@lu.unisi.ch>,
	"Julian Phillips" <julian@quantumfyre.co.uk>,
	"Andy Parkins" <andyparkins@gmail.com>, git@vger.kernel.org,
	"Paolo Bonzini" <bonzini@gnu.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Mar 01 08:55:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMg8H-0004mH-IF
	for gcvg-git@gmane.org; Thu, 01 Mar 2007 08:55:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752348AbXCAHzU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Mar 2007 02:55:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752350AbXCAHzU
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Mar 2007 02:55:20 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:3791 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752348AbXCAHzT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2007 02:55:19 -0500
Received: by ug-out-1314.google.com with SMTP id 44so312659uga
        for <git@vger.kernel.org>; Wed, 28 Feb 2007 23:55:18 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=t0LZ5sywiJZuUU4mErbvxTubZveXUVx9HoZlIY15mYBMp9BHfnbOoNu5AqFAOPkfOPVHwYBt83zJUDdfHi5654HQR5Aaf9A3z5HbmPtK9L7dlNum8hMIr/5B0IF7tOpR/dUlXRwH9jINQ93WByC+JkMER2YDYgQM/gN7Ydo8Hbo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CE6abEkUCl/0Hm1sMbFiOHWt18hz6fokzwB20L8ZppHxJea0aZeWzlw/YnPpNS3pF0Eg5xx/66WS6QVW6AHokFUmHULKsIyqeWQBiR/5Sszwu7sBSReTAXSw4Osaq0/YqPqsF3CI9RKpdBE4VIhCiEgu+YVFBbhRz/VGf9SgJaM=
Received: by 10.78.97.7 with SMTP id u7mr132573hub.1172735718515;
        Wed, 28 Feb 2007 23:55:18 -0800 (PST)
Received: by 10.78.139.9 with HTTP; Wed, 28 Feb 2007 23:55:18 -0800 (PST)
In-Reply-To: <Pine.LNX.4.63.0703010221000.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41044>

On 3/1/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>
> > Well, I find it unobvious for pull to magically starting merging.
>
> Pull is _all_ about merging.
>

... from what the user _conciously_ meant it to.

> > Perhaps I'm using branch configuration in .git/config for too long, and
> > actually expect nothing to be merged if there is no appropriate branch
> > configuration.
>
> It is not possible that you use that feature you described for too long,
> since it was not there in 1.4.x. There, whenever you said "git pull", it

the syntax was introduced about half a year ago. Plenty of time
to get used to it

> would try to blindly pull the default branch of the remote "origin", which
> might have been correct for the default branch (i.e. the branch
> automatically set up by git-clone), but not necessarily for the other
> branches.

which everyone hated. With this change it will not that blindly,
but still unexpectedly jump to some remote branch.

> However, with the proposed behaviour, more new users would get less "Huh?"
> experiences.

yes, it will be the old users who'd get the experiences. What do they
do, edit out unwanted tracking from .git/config everytime a branch
from remote is created?

Besides, I'm was just asking about providing an option (command-line
parameter) to change the behavior to what it was before!
Just "--no-tracking"?
