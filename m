From: "Bert Wesarg" <bert.wesarg@googlemail.com>
Subject: Re: linearising TopGit forests into patch series (was: [ANNOUNCE] TopGit - A different patch queue manager)
Date: Thu, 7 Aug 2008 21:58:35 +0200
Message-ID: <36ca99e90808071258h62b65981s20a5b053d9bc5754@mail.gmail.com>
References: <20080803031424.GV32184@machine.or.cz>
	 <20080807175623.GA16833@lapse.rw.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Petr Baudis" <pasky@suse.cz>, git@vger.kernel.org,
	"vcs distro packaging discussion list" 
	<vcs-pkg-discuss@lists.alioth.debian.org>
To: "martin f krafft" <madduck@debian.org>
X-From: git-owner@vger.kernel.org Thu Aug 07 21:59:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRBe7-0000uD-Ib
	for gcvg-git-2@gmane.org; Thu, 07 Aug 2008 21:59:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752684AbYHGT6i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Aug 2008 15:58:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752631AbYHGT6i
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Aug 2008 15:58:38 -0400
Received: from an-out-0708.google.com ([209.85.132.246]:51319 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752646AbYHGT6h (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Aug 2008 15:58:37 -0400
Received: by an-out-0708.google.com with SMTP id d40so107167and.103
        for <git@vger.kernel.org>; Thu, 07 Aug 2008 12:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=psdxG6ns5Dakff46M1cCQ3dBt04tBa8jtVtsvX2G6No=;
        b=j2TzjzNMW+Q+WSaTD30ba8kVQpqL48X82rsdoUY47un6rYsN8Xe1/PpqwhsMC4wQXz
         YclvZ1xIfrqNsxZbNXenoCWTzwonun6R2XVk4Y238EGVR8dK3rZn/MfO5VEm0bQBs1Ln
         YHLFVHZFDJlQOmtEKp+K7DUBNuSudDHsPJQNE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=mxjQO5vaHRgs3GRX50lrRykeJ5AgWIeyHQ2C9Mo7OYuhF/lmCj+gmx/q8ZVA1AKUW1
         rPhvLja1wxhYe6HAyEW+ANbiAE9iE296OVNjfbJ1owdzqZ0+JDaMZxL2Kim1uL2EwSba
         Kvlo73PArM4qcfNwNWRRLdRA49AoHPEtZEDpE=
Received: by 10.100.227.6 with SMTP id z6mr2818714ang.76.1218139115306;
        Thu, 07 Aug 2008 12:58:35 -0700 (PDT)
Received: by 10.70.28.18 with HTTP; Thu, 7 Aug 2008 12:58:35 -0700 (PDT)
In-Reply-To: <20080807175623.GA16833@lapse.rw.madduck.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91600>

Hi,

On Thu, Aug 7, 2008 at 19:56, martin f krafft <madduck@debian.org> wrote:
> Hi Petr and everyone else,
>
> as some of you may know, I am working on http://vcs-pkg.org, and
> Pierre kindly alerted me to your announcement, which looks very
> interesting for what we are trying to do.
>
> Assuming a number of interdependent topic branches, does TopGit
> provide a way for me to linearise/flatten/serialise these branches
> in a one-patch-per-branch fashion, so that I could turn any TopGit
> repository into a quilt series? I am only interested in a one-way
> conversion from TopGit to quilt for now.
Should be doable, I think. At least you can get a topological sorted
list of the TopGit branches (with git show-branch --topo-order <list
of TopGit-branches>). But than it get complicated, because you don't
need the diff from branch-base to branch-head, this would only work
for a single dependent list of topic branches.

At least this is my current point of thinking for this problem.

Regards
Bert
> Thank you,
