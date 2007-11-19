From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: ! [rejected] master -> master (non-fast forward)
Date: Mon, 19 Nov 2007 17:54:05 -0500
Message-ID: <9e4733910711191454i40d56fa2h9791415c092b9b9c@mail.gmail.com>
References: <9e4733910711180712n6ee271fau774310e63ab08f6d@mail.gmail.com>
	 <7v7ikfwhkj.fsf@gitster.siamese.dyndns.org>
	 <9e4733910711181042x123e99efjad38486654db17e2@mail.gmail.com>
	 <tnxbq9qyvom.fsf@pc1117.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Catalin Marinas" <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 19 23:54:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IuFVa-0007sm-1S
	for gcvg-git-2@gmane.org; Mon, 19 Nov 2007 23:54:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751765AbXKSWyJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Nov 2007 17:54:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751706AbXKSWyI
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Nov 2007 17:54:08 -0500
Received: from nz-out-0506.google.com ([64.233.162.233]:6964 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750914AbXKSWyG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Nov 2007 17:54:06 -0500
Received: by nz-out-0506.google.com with SMTP id s18so1429284nze
        for <git@vger.kernel.org>; Mon, 19 Nov 2007 14:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=yBTjNKgTWbdj7HuLdNMK8oFKiIkgt5KtnQOhvoETQtM=;
        b=tE29tKGKTFod6WKbCtY7InyCweQ6ckVanUVqnWCeuKPsY3U3Z4jW8RSctmcXotOxtfeVEjxpNNoSVcRtQANH3O1mHueGcZ6Ihx2/MJSbLx+bL1mbwn4R6W57zPfp2xLTuguSnW2dOSACQv2pQIdvqiQf0f2zRJbndx3V5RHHv6o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=T2Ab/LjGZ7QN6oTgSV4OI1/ouiJH+7OJ8YqudT8XsBgs4i0A/pnsCehq54fjwLNZc4JkFgZqNBrQNYoUO60TmbcaCQ9FEE2LmF212eqTgIygHrFJzLrxoNDgu8ju92bAb0xtkzmydZnjN3i3ipfjs5oRw1gva//uHOWnt9TVIwE=
Received: by 10.114.204.7 with SMTP id b7mr273584wag.1195512845388;
        Mon, 19 Nov 2007 14:54:05 -0800 (PST)
Received: by 10.115.54.19 with HTTP; Mon, 19 Nov 2007 14:54:05 -0800 (PST)
In-Reply-To: <tnxbq9qyvom.fsf@pc1117.cambridge.arm.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65514>

On 11/19/07, Catalin Marinas <catalin.marinas@arm.com> wrote:
> "Jon Smirl" <jonsmirl@gmail.com> wrote:
> > On 11/18/07, Junio C Hamano <gitster@pobox.com> wrote:
> >> "Jon Smirl" <jonsmirl@gmail.com> writes:
> >>
> >> > What's causing this? I'm using stgit on the master branch.
> [...]
> >> pushed "A" to the remote's 'master', then built this history:
> >>
> >>          o---o---A
> >>         /
> >>     ---o---o---o---o---A'
> >>
> >> by rewinding and rebuilding, and the tip of the branch now
> >> points at A', which you tried to push to the remote.
> >
> > stgit must be doing this when I rebase. It pops all of it's patches,
> > moves to head of linus/master and then rebases them.
> [...]
> > What is the right way to share repositories using stgit? I have a set
> > of patches which I am working on for kernel inclusion. I have them
> > applied as a stgit stack on top of linus/master. I need to share this
> > patch stack with other developers. These developers may want to change
> > one of my patches. Right now they are emailing me deltas and I apply
> > them to the appropriate stgit patch. I have seventeen patches in my
> > stack currently.
>
> StGIT is meant for keeping a clean history but with the big
> disadvantage that this history is volatile.
>
> A solution is for the other developers to use StGIT or just git-rebase
> so that they always have the same base (volatile) history and keep
> their patches on top of yours.
>
> A 2nd approach is to use topic branches rather than StGIT patches but
> you might lose some flexibility.
>
> Yet another approach (which I used) is to keep a public branch (can be
> maintained by StGIT) where the history doesn't change and a devel
> volatile branch. When I modify some patches and they are ready for
> publishing, switch to the public branch and cherry-pick them (stg
> pick) from the devel branch. Because this is done with a three-way
> merge in StGIT, you will only get the new changes rather than the full
> patch. You need to change the patch message (as it is that of the
> original patch) to describe the specific changes and run 'stg refresh
> && stg commit' to store it into the immutable history (well, there is
> an 'uncommit' command as well if something goes wrong).


Is a StGit where we can transparently share patches under version
control in the works?

Something like this:
clone repo with stgit
normal stg commands work with no setup
change a patch
stg push the repo

I stg pull and the patch is updated.
I also get rebased forward if the base repo has been updated

-- 
Jon Smirl
jonsmirl@gmail.com
