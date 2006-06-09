From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: Figured out how to get Mozilla into git
Date: Fri, 9 Jun 2006 15:06:11 +1200
Message-ID: <46a038f90606082006t5c6a5623q4b9cf7b036dad1e5@mail.gmail.com>
References: <9e4733910606081917l11354e49q25f0c4aea40618ea@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 09 05:06:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FoXKK-0005Fk-KL
	for gcvg-git@gmane.org; Fri, 09 Jun 2006 05:06:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965110AbWFIDGN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Jun 2006 23:06:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965115AbWFIDGN
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jun 2006 23:06:13 -0400
Received: from wr-out-0506.google.com ([64.233.184.231]:43620 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S965110AbWFIDGM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jun 2006 23:06:12 -0400
Received: by wr-out-0506.google.com with SMTP id 69so742395wri
        for <git@vger.kernel.org>; Thu, 08 Jun 2006 20:06:12 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=g6LN8sDgmKjlThxkVKPSa5XvV1SOt/zR/UCSj+XPkqIpM9y2OWG6b7wJ9iJx6lbllG3CtstRxhJI+ojhTpdlzf6qCnNQFQmgSPjUgnOcuK0DMWE8L3TLunHCwlQikIUgksW4feFOm/m2VO1BhwLAKdZNsqzfKuy3iL69vn4IqPk=
Received: by 10.54.128.19 with SMTP id a19mr1439891wrd;
        Thu, 08 Jun 2006 20:06:12 -0700 (PDT)
Received: by 10.54.71.4 with HTTP; Thu, 8 Jun 2006 20:06:11 -0700 (PDT)
To: "Jon Smirl" <jonsmirl@gmail.com>
In-Reply-To: <9e4733910606081917l11354e49q25f0c4aea40618ea@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21523>

Jon,

oh, I went back to a cvsimport that I started a couple days ago.
Completed with no problems...

Last commit:
commit 5ecb56b9c4566618fad602a8da656477e4c6447a
Author: wtchang%redhat.com <wtchang%redhat.com>
Date:   Fri Jun 2 17:20:37 2006 +0000

    Import NSPR 4.6.2 and NSS 3.11.1

mozilla.git$ du -sh .git/
2.0G    .git/

It took
43492.19user 53504.77system 40:23:49elapsed 66%CPU (0avgtext+0avgdata
0maxresident)k
0inputs+0outputs (77334major+3122469478minor)pagefaults 0swaps

> I should have the results in the morning. I wonder how long it will
> take to start gitk on a 10GB repository.

Hopefully not that big :) -- anyway, just do gitk --max-count=1000

> Once I get this monster into git, are there tools that will let me
> keep it in sync with Mozilla CVS?

If you use git-cvsimport, you can safely re-run it on a cronjob to
keep it in sync. Not too sure about the cvs2svn => git-svnimport,
though git-svnimport does support incremental imports.

> SVN renamed numeric branches to this form, unlabeled-3.7.24, so that
> may be a problem.

Ouch,

> Any advice on how to pack this to make it run faster?

git-repack -a -d but it OOMs on my 2GB+2GBswap machine :(


martin
