From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: Deprecation/Removal schedule
Date: Tue, 6 Feb 2007 14:09:45 +0100
Message-ID: <81b0412b0702060509l1283fcb2j105a0580a718b2e0@mail.gmail.com>
References: <7v8xfdnlqm.fsf@assigned-by-dhcp.cox.net>
	 <eq6tj6$80m$2@sea.gmane.org>
	 <81b0412b0702050750m5760ce61le34acc8adfdb8081@mail.gmail.com>
	 <20070205194508.GD8409@spearce.org>
	 <81b0412b0702051449l3951ee43s34bde4614c83612d@mail.gmail.com>
	 <20070205225505.GA9222@spearce.org>
	 <81b0412b0702060220l3887624ax762e5cba3f75fd0c@mail.gmail.com>
	 <Pine.LNX.4.63.0702061144430.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <20070206110015.GA10231@coredump.intra.peff.net>
	 <Pine.LNX.4.63.0702061202260.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Jeff King" <peff@peff.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 06 14:10:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEQ5C-0000yw-HF
	for gcvg-git@gmane.org; Tue, 06 Feb 2007 14:10:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752056AbXBFNJw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Feb 2007 08:09:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752054AbXBFNJw
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Feb 2007 08:09:52 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:27061 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752056AbXBFNJw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Feb 2007 08:09:52 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1598212uga
        for <git@vger.kernel.org>; Tue, 06 Feb 2007 05:09:50 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nAZCqyXGz0nTAr6WZ74NitX7oRGMW2qh8fqggbQNq1QqP4xpsBzhYtZxVu/dGqaB/+IbErmL0eqLvQPxe7EzOih+r9c+OspWBs/VOO+46647i6638wzlxuA+rHqdaW5wskopLbtuQ3d5CxG6d+MIm8J11EH0vbIzl3HlOJT48HU=
Received: by 10.78.176.20 with SMTP id y20mr402082hue.1170767385208;
        Tue, 06 Feb 2007 05:09:45 -0800 (PST)
Received: by 10.78.139.9 with HTTP; Tue, 6 Feb 2007 05:09:45 -0800 (PST)
In-Reply-To: <Pine.LNX.4.63.0702061202260.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38836>

On 2/6/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > > > git gc (repack -d of it) is too dangerous in a shared repo: it breaks
> > > > the repos which depend on the master repository, have sent (by some
> > > > means) some objects over to the master, and accidentally removed
> > > > the reference, and were pruned afterwards.
> > >
> > > We no longer call git-prune automatically in git-gc. You have to say
> > > "git-gc --prune" to trigger that behaviour.
> >
> > repack -d can lose objects, too:
> >
> > # fully packed test repo with 2 commits
>
> This is the culprit.
>
> The solution is very easy: do not --reference a repository which resets or
> deletes branches. IMHO this is all too obvious.
>

Or just do no repack in the referenced repo.

Anyway, the discussion outlived its usefulness.
I have what I wanted (git fsck --unreachable), and nobody can force
me to repack my shared repo, so the issue does not exist for the original
poster.
