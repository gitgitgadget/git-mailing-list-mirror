From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Restoring files from old commits
Date: Sat, 14 Jul 2007 16:32:33 +0200
Message-ID: <20070714143233.GC2544@steel.home>
References: <4698BD17.5080205@random-state.net> <20070714123754.GA29622@piper.oerlikon.madduck.net>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nikodemus Siivola <nikodemus@random-state.net>,
	martin f krafft <madduck@madduck.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 14 16:32:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9ifr-0004zL-72
	for gcvg-git@gmane.org; Sat, 14 Jul 2007 16:32:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757919AbXGNOcg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Jul 2007 10:32:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757204AbXGNOcg
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jul 2007 10:32:36 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:30694 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755485AbXGNOcf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jul 2007 10:32:35 -0400
Received: from tigra.home (Fc894.f.strato-dslnet.de [195.4.200.148])
	by post.webmailer.de (fruni mo13) (RZmta 8.3)
	with ESMTP id y00089j6EDwRYm ; Sat, 14 Jul 2007 16:32:34 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id E5776277BD;
	Sat, 14 Jul 2007 16:32:33 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id C14B2C164; Sat, 14 Jul 2007 16:32:33 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070714123754.GA29622@piper.oerlikon.madduck.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaEWo+by+8=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52484>

martin f krafft, Sat, Jul 14, 2007 14:37:54 +0200:
> also sprach Nikodemus Siivola <nikodemus@random-state.net> [2007.07.14.1409 +0200]:
> > What is the recommended way to restore individual files
> > (or directories) in the working tree to the content they
> > had in a given commit?
> 
> As per my comment on IRC, I think
> 
>   git checkout <tree-ish> <path>
> 
> is the way.

It does not work for directories, though. On can use

    $ git ls-tree -r -z <tree-ish> -- <path> | git update-index -z --index-info
    $ git ls-tree -r --name-only -z <tree-ish> -- <path> | git checkout-index -f -z --stdin

for a more generic way to do this.

P.S. Martin, would you please stop removing people from address lists
and stop using that Mail-Followup-To? People miss their mails when
they are not addressed to them anymore and you doing exactly that.
