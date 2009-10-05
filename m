From: Johan Herland <johan@herland.net>
Subject: Re: [RFCv4 3/5] 2/2: Add Python support library for CVS remote helper
Date: Mon, 5 Oct 2009 16:41:42 +0200
Message-ID: <200910051641.43136.johan@herland.net>
References: <1250480161-21933-1-git-send-email-johan@herland.net> <1250480161-21933-4-git-send-email-johan@herland.net> <fabb9a1e0910050631j73bf7288w65da92806332d051@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	David Aguilar <davvid@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 05 16:50:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Muot6-00063W-Nu
	for gcvg-git-2@lo.gmane.org; Mon, 05 Oct 2009 16:50:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752427AbZJEOrm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Oct 2009 10:47:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751077AbZJEOrm
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Oct 2009 10:47:42 -0400
Received: from sam.opera.com ([213.236.208.81]:50466 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751090AbZJEOrl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Oct 2009 10:47:41 -0400
Received: from pc107.coreteam.oslo.opera.com (pat-tdc.opera.com [213.236.208.22])
	(authenticated bits=0)
	by smtp.opera.com (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id n95Efh8a028632
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 5 Oct 2009 14:41:48 GMT
User-Agent: KMail/1.9.9
In-Reply-To: <fabb9a1e0910050631j73bf7288w65da92806332d051@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129563>

On Monday 05 October 2009, Sverre Rabbelier wrote:
> On Mon, Aug 17, 2009, Johan Herland <johan@herland.net> wrote:
> > This patch introduces the rest of a Python package called
> > "git_remote_cvs" containing the building blocks of the CVS remote
> > helper. The CVS remote helper itself is NOT part of this patch.
>
> Might I suggest that we pool our efforts and instead create a
> structure like:
>
> git_remote_helpers/
> git_remote_helpers/__init__.py
> git_remote_helpers/Makefile
> git_remote_helpers/setup.py
> git_remote_helpers/util.py
> git_remote_helpers/git
> git_remote_helpers/git/__init__.py
> git_remote_helpers/git/
> git_remote_helpers/cvs
> git_remote_helpers/cvs/__init__.py
> git_remote_helpers/cvs/changeset.py
> git_remote_helpers/cvs/commit_states.py
> git_remote_helpers/cvs/cvs.py
> git_remote_helpers/cvs/revision_map.py
> git_remote_helpers/cvs/symbol_cache.py
> git_remote_helpers/hg
> git_remote_helpers/hg/__init__.py
> git_remote_helpers/hg/hg.py
> git_remote_helpers/hg/export.py

I like this. One couple of questions (for now):

- Are you planning to share directory structure only, or some of the 
Python code as well? From the above structure it seems like you want to 
make use of e.g. util.py and git.py. I'd be delighted if the code is 
reusable by other remote helpers.

- Do you plan to put the remote helpers into this structure as well, or 
keep them separate? (currently the cvs remote helper lives separately 
in git-remote-cvs.py in the project root directory)


> I'm willing to spend some time to do the needed refactoring, but IIUC
> Daniel said that you need to reroll the cvs series anyway?

Yeah, a re-roll was planned once the sr/gfi-options work was finalized. 
(right now I'm mostly focused on the jh/notes work). Feel free to post 
the hg-specific and/or common parts as a separate patch, and I can 
rebase the CVS series on top of that before I submit the next 
iteration.

Nice to see people starting to pick up the foreign-vcs work. :)


Have fun! :)

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
