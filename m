From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Make the output of "git svn clone" less confusing.
Date: Thu, 18 Oct 2007 03:06:17 -0400
Message-ID: <20071018070617.GA29238@spearce.org>
References: <87k5poflp5.fsf@lysator.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: David =?utf-8?Q?K=C3=A5gedal?= <davidk@lysator.liu.se>,
	git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Thu Oct 18 09:06:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiPSn-0000wR-1t
	for gcvg-git-2@gmane.org; Thu, 18 Oct 2007 09:06:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761447AbXJRHGY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 03:06:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761418AbXJRHGX
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 03:06:23 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:54074 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761271AbXJRHGV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 03:06:21 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IiPSQ-0004VC-Ke; Thu, 18 Oct 2007 03:06:14 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id CCA0220FBAE; Thu, 18 Oct 2007 03:06:17 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <87k5poflp5.fsf@lysator.liu.se>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61497>

David Kgedal <davidk@lysator.liu.se> wrote:
> The problem is that the first thing it prints is
> 
>   Initialized empty Git repository in .git/
> 
> even if actually created a subdirectory and changed into it first. But to the
> user, it looks like it is creating a .git/ dir in the directory he/she is
> started git from.

Eric, ack/nack?

> ---
>  git-svn.perl |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> This change makes it more chatty, which might not be a good thing. But
> I think the previous output was worse.
> 
> diff --git a/git-svn.perl b/git-svn.perl
> index 777e436..d4450ca 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -286,6 +286,7 @@ sub do_git_init_db {
>  
>  sub init_subdir {
>  	my $repo_path = shift or return;
> +	print "Creating directory $repo_path\n";
>  	mkpath([$repo_path]) unless -d $repo_path;
>  	chdir $repo_path or die "Couldn't chdir to $repo_path: $!\n";
>  	$ENV{GIT_DIR} = '.git';
> -- 
> 1.5.3.4.213.gb3127-dirty

-- 
Shawn.
