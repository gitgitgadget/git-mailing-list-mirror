From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git svn unhandled.log compression
Date: Thu, 19 Mar 2009 10:55:15 -0700
Message-ID: <20090319175514.GC23127@dcvr.yhbt.net>
References: <gps05u$905$1@ger.gmane.org> <fabb9a1e0903190406r31396bbao2717f94d7269b50a@mail.gmail.com> <49C23815.5010204@klingt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org
To: Tim Blechmann <tim@klingt.org>
X-From: git-owner@vger.kernel.org Thu Mar 19 18:57:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkMU3-0008CU-Iy
	for gcvg-git-2@gmane.org; Thu, 19 Mar 2009 18:56:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752748AbZCSRzS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2009 13:55:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752570AbZCSRzR
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 13:55:17 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:41207 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751383AbZCSRzQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2009 13:55:16 -0400
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 21F191F43E;
	Thu, 19 Mar 2009 17:55:15 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <49C23815.5010204@klingt.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113802>

Tim Blechmann <tim@klingt.org> wrote:
> >> i am not familiar with the git svn codebase, so i am not sure, whether
> >> it is feasible to implement a compression of the unhandled.log files,
> >> but it would definitely save me quite a lot of hd space ...
> > 
> > On that note, Eric, what does the unhandled.log file do in the first
> > place? It's name would suggest it lists all revisions that aren't
> > handled yet, but the contents of the file seem to only grow over time,
> > what gives?
> 
> according to the man page, it logs unhandled svn properties

Yup, it logs things that git-svn currently cannot handle.  It's meant to
be machine parseable so other tools[1] can process them after-the-fact.
I would accept a patch for a command like "git svn gc" to deal with
compressing them.

[1] - as far as I know there are none

-- 
Eric Wong
