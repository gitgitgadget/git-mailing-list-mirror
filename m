From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Trying to use git-filter-branch to compress history by removing large, obsolete binary files
Date: Mon, 8 Oct 2007 00:08:53 +0200
Message-ID: <20071007220853.GE2765@steel.home>
References: <51419b2c0710071423y1b194f22gb6ccaa57303029d1@mail.gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 08 00:09:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IeeJ7-0002RJ-6y
	for gcvg-git-2@gmane.org; Mon, 08 Oct 2007 00:09:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753550AbXJGWI5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Oct 2007 18:08:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753762AbXJGWI5
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Oct 2007 18:08:57 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:38399 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752388AbXJGWI4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Oct 2007 18:08:56 -0400
Received: from tigra.home (Fc872.f.strato-dslnet.de [195.4.200.114])
	by post.webmailer.de (klopstock mo12) (RZmta 13.4)
	with ESMTP id N03319j97KNqEp ; Mon, 8 Oct 2007 00:08:54 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 2D403277AE;
	Mon,  8 Oct 2007 00:08:54 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 8E67FC502; Mon,  8 Oct 2007 00:08:53 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <51419b2c0710071423y1b194f22gb6ccaa57303029d1@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaEWo+ecrQ=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60229>

Elijah Newren, Sun, Oct 07, 2007 23:23:59 +0200:
> # Try to recompress and clean up, then check the new size
> git gc --aggressive --prune
> du -ks .                       # 10580K !?!?!?
> du -ks .git                    # 10564K

git-filter-branch makes a backup of your original references:

$ git filter-branch --help
...
       Always verify that the rewritten version is correct: The original refs,
       if different from the rewritten ones, will be stored in the namespace
       refs/original/.
...

These will keep your big files in repository.
