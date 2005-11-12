From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: git-archimport
Date: Sun, 13 Nov 2005 00:30:13 +1300
Message-ID: <46a038f90511120330y537c74cat56cce259ad661243@mail.gmail.com>
References: <D92ED0A1-B83A-43C3-B39C-AA8A21934D7F@desertsol.com>
	 <46a038f90511101332r3389734uc1aa1effd2898e15@mail.gmail.com>
	 <20051110214959.GO9131@raven.localdomain>
	 <46a038f90511101421o7988a1bfi89eb0e33bd34e4bb@mail.gmail.com>
	 <20051111051910.GP9131@raven.localdomain>
	 <46a038f90511102158k5078e37fn2558cf69bc5794fa@mail.gmail.com>
	 <20051111232428.GS9131@raven.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 12 12:31:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EataQ-0003eV-LM
	for gcvg-git@gmane.org; Sat, 12 Nov 2005 12:30:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932340AbVKLLaP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 Nov 2005 06:30:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932344AbVKLLaP
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Nov 2005 06:30:15 -0500
Received: from zproxy.gmail.com ([64.233.162.202]:22981 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932340AbVKLLaN convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Nov 2005 06:30:13 -0500
Received: by zproxy.gmail.com with SMTP id 40so788501nzk
        for <git@vger.kernel.org>; Sat, 12 Nov 2005 03:30:13 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=j3i3NedHY48Hxqv2E1W72k1Wr3uvSzSvTKphuqwamA6/ntqB7VSyHkkJPQN+hgq1w/DXc6N4w52nCP68jHV0G7f8yorlQzfmSoBVqDH2zxzMP4g7bOLQWp6I8hGCWZQuLJJ2CFAeqUBSkLWUUhGPOXTe4MGo41F3qVnfKQQysBU=
Received: by 10.64.210.17 with SMTP id i17mr626461qbg;
        Sat, 12 Nov 2005 03:30:13 -0800 (PST)
Received: by 10.64.242.4 with HTTP; Sat, 12 Nov 2005 03:30:13 -0800 (PST)
To: Kevin Geiss <kevin@desertsol.com>
In-Reply-To: <20051111232428.GS9131@raven.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11670>

On 11/12/05, Kevin Geiss <kevin@desertsol.com> wrote:
> it's not really public, perhaps I can make it public though. can a tla mirror
> be served over http? or does it require ssh?

It can be served over http, though the repo needs to be setup with
some special options. You can easily setup a mirror that works over
http, though I can't remember the exact options.

> I'm confident the gpg signatures aren't the problem. I imported some branches
> yesterday which were all signed, they worked fine.

Cool. That's good to know...

> I suspuect the problem is that after tagging the oco branch from the base
> branch, there are several places where I replayed some patches from one of the
> branches to the other. some patches were skipped, some were replayed.  there
> was definitely a lot of hard core cherry picking going on, in both directions.
> do you think that would cause a problem?

The archimport script was written and tested against the branches I
maintained in Arch, which had a reasonably rich and messy scheme of
branching, cherry picking and replaying of patches. We just imported
some additional branches from an unrelated project and it worked
pretty well. So cherry picking/replaying itself should not be an
issue.

On the other hand, some versions of tla are notoriously sloppy in the
patchsets they generate, forgetting to add files or adding them in two
consecutive patchsets. I don't think archimport is too tolerant, and I
did find some particular patchsets that wouldn't work correctly.

I'm interested in patches that make the import more resilient, though.
So if you can fixup archimport so your import works, and the patch is
sane, I'll vouch for its inclusion.

cheers,



martin
