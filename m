From: Klas Lindberg <klas.lindberg@gmail.com>
Subject: Re: Fetching SHA id's instead of named references?
Date: Wed, 8 Apr 2009 22:03:49 +0200
Message-ID: <4CBB910C-24F5-4F51-A02D-7760839CCE18@gmail.com>
References: <33f4f4d70904060513k320fb6a0ya928c714dcd11e89@mail.gmail.com> <alpine.DEB.1.00.0904061431020.6619@intel-tinevez-2-302> <20090406144047.GE23604@spearce.org> <33f4f4d70904060922t5c868ec0x89ed5891cf4b19c2@mail.gmail.com> <alpine.LFD.2.00.0904061245111.6741@xanadu.home> <33f4f4d70904061640j1b03c499x1765da1a72a411f3@mail.gmail.com> <alpine.LFD.2.00.0904062214170.6741@xanadu.home>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Git Users List <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Apr 08 22:06:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lre23-0001D2-2l
	for gcvg-git-2@gmane.org; Wed, 08 Apr 2009 22:05:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934093AbZDHUD6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Apr 2009 16:03:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765216AbZDHUD5
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Apr 2009 16:03:57 -0400
Received: from mail-ew0-f165.google.com ([209.85.219.165]:53659 "EHLO
	mail-ew0-f165.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763638AbZDHUD4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Apr 2009 16:03:56 -0400
Received: by ewy9 with SMTP id 9so345072ewy.37
        for <git@vger.kernel.org>; Wed, 08 Apr 2009 13:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:cc:message-id:from:to
         :in-reply-to:content-type:content-transfer-encoding:mime-version
         :subject:date:references:x-mailer;
        bh=0bkB6Fa6+tIy+WW58XdEQ52Ay+ZsaJ/6iAOWp2EySew=;
        b=wUfzCktqzlS9P+vpsdUgmfxdNVg65p2q72LTX5DLHzTklwhnZlnxWHMT1AdHmGDW6d
         KX6qJKGy1UZLqEjgf+zo2Go/snN5oaZbMtadH4WJy6sORDzxP+dSijyCuz9y05veFIxI
         TNu9TQ7mqOOBLzFubEc9noFyLAqZ8jeG9DsCI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=cc:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:mime-version:subject:date:references
         :x-mailer;
        b=OGLD+yUU0LVbEz/GGIbn71FY7BP4ZA2kvcAx3rWDp7rXq7UbI6Kjv71iJij2AP81pv
         TzqvpeJAIXgjJ5j5d7QWX8iO4jz965ZRenmZ9U+iMv+PIBg8UUHQsFxDsBgayeQkK18K
         kZB7cKSS+nwrcyiBvb97IzLZl9kKnFWw99LDw=
Received: by 10.216.30.71 with SMTP id j49mr414073wea.89.1239221034236;
        Wed, 08 Apr 2009 13:03:54 -0700 (PDT)
Received: from ?192.168.1.103? (90-228-223-91-no119.tbcn.telia.com [90.228.223.91])
        by mx.google.com with ESMTPS id j8sm5032616gvb.21.2009.04.08.13.03.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 08 Apr 2009 13:03:53 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.0904062214170.6741@xanadu.home>
X-Mailer: Apple Mail (2.929.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116118>

7 apr 2009 kl. 04.34 skrev Nicolas Pitre:

> In git terms, this is called "history rewriting".  And you really  
> don't
> want to do that if your repository is pulled by other people, unless
> there is an explicit statement about that fact.

I thought you had to use filter-branch to qualify for history  
rewriting? Anyway, the scenario I have in mind is when a new branch is  
created from the old one, the old one deleted and then the name of the  
old one gets reused. The deltas are still there, intact, but now you  
have to use a different named reference to reach them  :-(

> Thing is, with the distributed nature of git, nothing prevents you  
> from
> keeping a local version of the commit you're interested in.  Unlike  
> with
> a central repository where someone else might delete a branch you  
> need,
> with git you will still have access to that particular commit locally
> regardless if the remote repository has deleted it or not.

This is true, and Git is indeed very good at saving your ass on the  
client side. Other systems spend much more effort on saving your ass  
on the server side. My problem is that "my" people responsible for the  
overall system are mostly interested in the server side. At least that  
is where they put the tough requirements on perpetual availability.

However, it is good enough if there is some way to somehow guarantee  
that a branch or tag will never be misused as outlined above. This  
could be solved through basic file system mechanisms (like write  
protecting the refs/tags files perhaps?) or a backup mechanism that  
raises an alarm on forbidden manipulations, or a host of other more or  
less weird mechanisms. Git doesn't have to provide the mechanism  
directly, but it would be nice for enterprise users if it did.

> There is nothing a tool can do for you if someone is determined to be
> stupid with it.  In other words, don't delete a branch if it contains
> important stuff.  You may rename it if you wish.  And if you don't  
> want
> to fetch everything then you may always find out about the right  
> branch
> to pull with "git branch --contains <SHA1>".

This is all very true. And I wasn't aware of the --contains switch  
before. That one covers an entire scenario for me. Thanks!!

BR / Klas
