From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: 'commit -a' safety (was: Re: Please default to 'commit -a' when no
 changes were added)
Date: Sat, 24 Apr 2010 14:35:17 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1004241430300.7232@xanadu.home>
References: <20100422151037.2310.2429.reportbug@frosties.localdomain>
 <20100422155806.GC4801@progeny.tock> <m3633hdw9u.fsf_-_@localhost.localdomain>
 <AC853FF9-6723-4824-BB2C-E7E8F79AA95E@wincent.com>
 <20100424164247.GM3563@machine.or.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_etDkPC+BCIiQAU5vygGYPQ)"
Cc: Wincent Colaiuta <win@wincent.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Goswin von Brederlow <goswin-v-b@web.de>,
	578764@bugs.debian.org, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Sat Apr 24 20:35:28 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5kCO-0004yU-A2
	for gcvg-git-2@lo.gmane.org; Sat, 24 Apr 2010 20:35:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752160Ab0DXSfT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Apr 2010 14:35:19 -0400
Received: from relais.videotron.ca ([24.201.245.36]:18264 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751179Ab0DXSfS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Apr 2010 14:35:18 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MH-MR003.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0L1E00DF78YTXH90@VL-MH-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 24 Apr 2010 14:35:18 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20100424164247.GM3563@machine.or.cz>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145694>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_etDkPC+BCIiQAU5vygGYPQ)
Content-type: TEXT/PLAIN; charset=iso-8859-2
Content-transfer-encoding: 8BIT

On Sat, 24 Apr 2010, Petr Baudis wrote:

> On Sat, Apr 24, 2010 at 01:10:24PM +0200, Wincent Colaiuta wrote:
> > El 24/04/2010, a las 11:40, Jakub Narebski escribió:
> > > I'd like for 'git commit -a' to *fail* if there are staged changes for
> > > tracked files, excluding added, removed and renamed files.
> 
> Thanks for this suggestion, this is exactly what I wanted to propose!
> +1 here.
> 
> I think this could even be made a default in some time, I don't see any
> useful workflows this could prevent and adding -f is trivial enough for
> those who really want to go forward.
> 
> > For me this is going to far. While we don't want to make it _easy_ for users to shoot themselves in the foot, neither do we want to make it difficult or impossible for them to get the tool to do things that _might_ be a mistake. And what's the risk here? Accidentally committing too much is not a destructive change, and can be easily undone.
> 
> Have you ever done this mistake? If you have done some extensive index
> editing, it is actually a major PITA to restore, and can be even
> destructive if your index and working tree are too much out-of-sync
> (this does happen to me not so seldom while I also use -a a lot for
> trivial commits).

In that case the deficiency is in the fact that no reflog preserves the 
intermediate state of the index, not the fact that you might be allowed 
to do it.  Strictly speaking there is no intermediate ref to log, but a 
synthetic commit could be created for this case just like a stash but 
stored in the current branch's reflog.


Nicolas

--Boundary_(ID_etDkPC+BCIiQAU5vygGYPQ)--
