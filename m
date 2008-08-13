From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 3/3] git-svn: Reduce temp file usage when dealing with non-links
Date: Tue, 12 Aug 2008 20:52:11 -0700
Message-ID: <20080813035211.GA31792@untitled>
References: <1218470035-13864-4-git-send-email-marcus@griep.us> <1218556876-26554-1-git-send-email-marcus@griep.us> <20080813032956.GC5904@untitled> <48A2583A.1000509@griep.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Marcus Griep <marcus@griep.us>
X-From: git-owner@vger.kernel.org Wed Aug 13 05:53:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KT7QD-00039L-Gk
	for gcvg-git-2@gmane.org; Wed, 13 Aug 2008 05:53:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754273AbYHMDwO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Aug 2008 23:52:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754085AbYHMDwO
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Aug 2008 23:52:14 -0400
Received: from hand.yhbt.net ([66.150.188.102]:34383 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752086AbYHMDwO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Aug 2008 23:52:14 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 430092DC01B;
	Tue, 12 Aug 2008 20:52:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <48A2583A.1000509@griep.us>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92177>

Marcus Griep <marcus@griep.us> wrote:
> Eric Wong wrote:
> > Thank you Marcus!
> > 
> > Acked-by: Eric Wong <normalperson@yhbt.net>
> 
> Errr, you want to Ack [PATCH v2 3/3]; not this one; there's one minor
> typo when I shortened the variable $result to $res.
> 
> >> +				my $res;
> >> +				while ($res = sysread($fh, my $str, 1024)) {
> >> +					my $out = syswrite($tmp_fh, $str, $res);
> >> +					defined($out) && $out == $res
> >> +						or croak("write ",
> >> +							$tmp_fh->filename,
> >> +							": $!\n");
> >> +				}
> >> +				defined $result or croak $!;
> 
> That last line causes compilation errors with 'use strict'.  It is fixed
> in the alternate version.

Oops, I applied the right patch but managed to reopen the wrong one when
I acked it.

I've just pushed out my repository with acks to
  git://bogomips.org/git-svn.git

-- 
Eric Wong
