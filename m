From: Matthew L Foster <mfoster167@yahoo.com>
Subject: Re: git and time
Date: Wed, 27 Sep 2006 15:46:51 -0700 (PDT)
Message-ID: <20060927224651.26627.qmail@web51013.mail.yahoo.com>
References: <20060927215612.GB21839@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@osdl.org>, Andreas Ericsson <ae@op5.se>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 28 00:47:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSiBJ-0004kO-Fb
	for gcvg-git@gmane.org; Thu, 28 Sep 2006 00:47:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031170AbWI0Wq4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Sep 2006 18:46:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031174AbWI0Wqz
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Sep 2006 18:46:55 -0400
Received: from web51013.mail.yahoo.com ([68.142.224.83]:60753 "HELO
	web51013.mail.yahoo.com") by vger.kernel.org with SMTP
	id S965164AbWI0Wqx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Sep 2006 18:46:53 -0400
Received: (qmail 26629 invoked by uid 60001); 27 Sep 2006 22:46:51 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=C0gVdFoM9w2QlBwLPIJzubCpn+BtsN/gP2EiD/yJyePZDXR4ICRGY9yIkxFWdTB+qW4OjRoQuuZNRtmUhdvrXCxMyqhKk/pzRTVb+Hf+JqiPmRB2pRibhITJi3gCZOe8akB2FS9Z9/s0CiWpz8xUb0359Uxh5ucygiFwLxteTOA=  ;
Received: from [207.172.80.85] by web51013.mail.yahoo.com via HTTP; Wed, 27 Sep 2006 15:46:51 PDT
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20060927215612.GB21839@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27940>

--- Shawn Pearce <spearce@spearce.org> wrote:

> Because of the potentical for clock skew even on a single system
> you can't take much stock in a timestamp.  But with Git you can at
> least completely trust the commit graph, provided that you trust
> those who made commits before your own commit.  Of course this
> trust is only possible because the commit graph cannot be altered
> once a node has been added into it.
> 
> As such the commit graph is consistent between repositories (assuming
> they have the same head commits), but the timestamps of the reflogs
> within each will widely differ.  They could widely differ even on
> the same system due to ntpd updating the clock at the exact wrong
> moment for example.  :)

I am not arguing for git to try to achieve "exact" time just merely locally time consistent commit
order. This might all just be a gitweb.cgi time display issue, it should be more impossible for a
commit to appear as being made 2 days in the future and impossible for local time order to be out
of sync with commit order. If each git repo used local time to track commits/merges you wouldn't
have to worry if any remote git server's time was grossly misconfigured. Time doesn't need to be
exact, all I am saying is each git repo should trust/prefer its local time rather than a remote
git server's timestamp.

-Matt


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
