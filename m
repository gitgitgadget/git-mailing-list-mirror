From: Eric Wong <normalperson@yhbt.net>
Subject: Re: Git-SVN on Cygwin: svn+ssh good, https awkward
Date: Thu, 23 Apr 2009 12:03:08 -0700
Message-ID: <20090423190308.GA10437@dcvr.yhbt.net>
References: <op.usulh7a71e62zd@balu.cs.uni-paderborn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marcus Griep <marcus@griep.us>, git@vger.kernel.org
To: Matthias Andree <matthias.andree@gmx.de>
X-From: git-owner@vger.kernel.org Thu Apr 23 21:06:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lx4E1-0003fK-CL
	for gcvg-git-2@gmane.org; Thu, 23 Apr 2009 21:04:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758470AbZDWTDL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Apr 2009 15:03:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758473AbZDWTDJ
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Apr 2009 15:03:09 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:57324 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758469AbZDWTDI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Apr 2009 15:03:08 -0400
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7EFAB1F602;
	Thu, 23 Apr 2009 19:03:08 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <op.usulh7a71e62zd@balu.cs.uni-paderborn.de>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matthias Andree <matthias.andree@gmx.de> wrote:
> Hi Eric,
>
> === Short story ===
>
> git-svn on Cygwin works well with svn+ssh://, but needs some fixes around 
> tempfile and/or subprocess handling for https:// - please help.

Hi Matthias,

Marcus Griep did a lot of work for more efficiently handling of
tempfiles in Git.pm a few months ago, so maybe he has more insight into
how things work...

git-svn used to use IO::File->new_tmpfile() which was much simpler and
probably less prone to portability problems, but cycled through inodes
too quickly for Marcus (and probably some other people).


Speaking only for myself and not other contributors:

  I have no interest in dealing with crazy systems like Windows.  Ever.

  However, I'll gladly accept patches to make things work if they don't
  break existing use cases.

  Keep in mind that I'm an extremist.  I dislike Windows (and some other
  crazy software systems) to the point that I refuse to deal with them
  even in paid contracts and employment.

-- 
Eric Wong
