From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: Re: Locally manage user/branch setting files without pushing them
	remotely
Date: Thu, 12 Nov 2009 12:15:30 +0100
Message-ID: <20091112111530.GC25398@vidovic>
References: <9accb4400911110401g5c44d011u50cafcfe736a2ec6@mail.gmail.com> <20091111192449.GH27518@vidovic> <9accb4400911120118t3257a1n6f2a05abb1008c8@mail.gmail.com> <20091112092909.GA25398@vidovic> <9accb4400911120129h54609846jac9eb3b6cb07b792@mail.gmail.com> <20091112093146.GB25398@vidovic> <9accb4400911120213w35efcad3q8a24d99c37a5e8c5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Git Mailing List <git@vger.kernel.org>
To: Daniele Segato <daniele.bilug@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 12 12:15:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8XeU-0000o7-0R
	for gcvg-git-2@lo.gmane.org; Thu, 12 Nov 2009 12:15:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752110AbZKLLPe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Nov 2009 06:15:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751911AbZKLLPe
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Nov 2009 06:15:34 -0500
Received: from ey-out-2122.google.com ([74.125.78.27]:61062 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751643AbZKLLPd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Nov 2009 06:15:33 -0500
Received: by ey-out-2122.google.com with SMTP id 9so557143eyd.19
        for <git@vger.kernel.org>; Thu, 12 Nov 2009 03:15:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=PHlsMmAOqqu9Vto03fYtfV17V56swCNV6gECiEgw4vk=;
        b=vDq6CqGXVihy0oqPu6roxkkqG7r5/wOt3HII1lGaVV5YiE1x2NcIMQUpa5sv06ynTT
         dCXG+wFPGMB2Yk0OYgShhxgfQXI37HWBRrr2j+iTR3SS3dDNNuZotd5tXSSG+uTNUoKR
         MnJOWZIRRD6snZfuhTnLf5fZNzUTm8BN6mcmQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=GBhYO5twQsSTWbUf5xvF7sPE84LDBfrKLjBf/yvJ7YtwVs0NMpPKNt3IlGZJkwose6
         AshtCFhSn+qnMraJpj90BNtSTz9g0gYgU29dv7asKWCQUtbXMCQp8VnGSRmQJUNp3ubQ
         A+neL08yGefRcrY1TlYhhWdJ6OfgoCHbHr7Ys=
Received: by 10.213.24.24 with SMTP id t24mr711483ebb.16.1258024538395;
        Thu, 12 Nov 2009 03:15:38 -0800 (PST)
Received: from @ (91-165-129-166.rev.libertysurf.net [91.165.129.166])
        by mx.google.com with ESMTPS id 5sm3200118eyf.4.2009.11.12.03.15.34
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 12 Nov 2009 03:15:36 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <9accb4400911120213w35efcad3q8a24d99c37a5e8c5@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132764>

The 12/11/09, Daniele Segato wrote:
> 
> > I think you should look at 'git subtree' or 'git submodule' to track the
> > setting files out of the _main_ repository and _inside_ the main
> > development directory.
> 
> will they work with git-svn?
> I'm not very familiar with them anyway.

Not the way you'd like to, I think. This could mean having as many svn
repo as git subtree/submodule.

> May be using an external/local repository for those files.
> but then I would like to have a way to link them automatically.
> 
> may be this can be achieved with some hook script..

You could look at 'man githooks'.

> What I have in mind is something like this:
> 
> 1. creating a local repo "confrepo" on the same directory where I have
> the real repo
> 2. .gitignore for all my local config file in the real repo
> 3. using the confrepo to store my local scripts and replicate in it
> the same branch structure of my real repo
> 
> 4. may be then I can create some hook script that when I do
> 
> $ git checkout experimental
> 
> a) it try to do the same on the confrepo (checkout experimental), if
> the branch doesn't exist it does nothing else
> b) copy everythink in the confrepo to my realrepo (overwriting if needed)
> 
> 
> that way I could have something automatic. The only think I couldn't
> have is, looking back in history, a way to know which config was in
> place for an old commit.
> 
> 
> could you tell me if this is even possible?

I think, yes.

> I'm going a little off-topic here proposing an idea for a new feature
> What about adding a git feature to "link" different git repository?
> Or providing a way to have 2 (or more) git repository in the same working area.

Patches are welcome. That said, I guess it won't be needed. As you
pointed out, the flexibility has been implemented in the hooks system.
Consequently, we all have to write the appropriate scripts. But OTOH, it
is more flexible than any feature matching _one_ workflow.


-- 
Nicolas Sebrecht
