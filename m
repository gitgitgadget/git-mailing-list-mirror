From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: remove --first-parent, add --upstream
Date: Thu, 6 Sep 2007 14:35:56 -0700
Message-ID: <20070906213556.GA21234@soma>
References: <20070906075104.GA10192@hand.yhbt.net> <1189096669534-git-send-email-hjemli@gmail.com> <20070906210155.GA20938@soma>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 06 23:36:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITP19-0005nR-Vx
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 23:36:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932417AbXIFVf7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Sep 2007 17:35:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932382AbXIFVf6
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 17:35:58 -0400
Received: from hand.yhbt.net ([66.150.188.102]:60225 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932339AbXIFVf6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2007 17:35:58 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 317782DC08D;
	Thu,  6 Sep 2007 14:35:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20070906210155.GA20938@soma>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57933>

Eric Wong <normalperson@yhbt.net> wrote:
> Lars Hjemli <hjemli@gmail.com> wrote:
> > This makes git-svn always issue the --first-parent option to git-log when
> > trying to establish the "base" subversion branch, so the --first-parent
> > option to git-svn is no longer needed. Instead a new option, --upstream
> > <revspec>, is introduced. When this is specified the search for embedded
> > git-svn-id lines in commit messages starts at the specified revision, if
> > not specified the search starts at HEAD.
> > 
> > Signed-off-by: Lars Hjemli <hjemli@gmail.com>
> 
> Looks good to me.
> 
> Acked-by: Eric Wong <normalperson@yhbt.net>

Wait, actually.  --upstream won't ever populate the refs array in
working_head_info for dcommit (but --first-parent should be great for
that).

But the rest of the commands is fine.  I also just noticed cmd_find_rev
passes the @refs argument to working_head_info() unnecessarily.

-- 
Eric Wong
