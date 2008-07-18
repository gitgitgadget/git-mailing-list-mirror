From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Teach git submodule update to use distributed
	repositories
Date: Fri, 18 Jul 2008 17:49:59 +0200
Message-ID: <20080718154959.GS10151@machine.or.cz>
References: <alpine.DEB.1.00.0807171513560.8986@racer> <320075ff0807170807l1537e34ev510deda537e4d11e@mail.gmail.com> <20080717182253.GZ32184@machine.or.cz> <320075ff0807180111q4ca55cc4v15487af35f6fa63c@mail.gmail.com> <20080718091608.GL10151@machine.or.cz> <320075ff0807180236u4e7f5f9bm81b702d14c052de8@mail.gmail.com> <20080718100048.GN10151@machine.or.cz> <320075ff0807180420k4b28c317mc026713b22c44839@mail.gmail.com> <20080718144325.GR10151@machine.or.cz> <320075ff0807180809x599aefafw2c7fe88fea2691d2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Nigel Magnay <nigel.magnay@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 18 17:51:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJsEb-0005Mb-Hq
	for gcvg-git-2@gmane.org; Fri, 18 Jul 2008 17:51:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757552AbYGRPuF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jul 2008 11:50:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751753AbYGRPuE
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jul 2008 11:50:04 -0400
Received: from w241.dkm.cz ([62.24.88.241]:56172 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758522AbYGRPuD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2008 11:50:03 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 04DE3393B31F; Fri, 18 Jul 2008 17:50:00 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <320075ff0807180809x599aefafw2c7fe88fea2691d2@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89049>

On Fri, Jul 18, 2008 at 04:09:40PM +0100, Nigel Magnay wrote:
> Hmm. Locally modifying my .gitmodules still feels bad because I don't
> like either of those tradeoffs (but I don't have any sensible
> suggestion yet).
> 
> As a bit of background (as to why I'd dislike (a) and (b)), we had a
> team switch to git, and one of the really nice things is the ability
> to share stuff around and branch freely - but the flipside of that is
> that we tend to push to a central repo more rarely, so the advantages
> of an continuous integration server become less. What we did is to
> tell a centralised CI server the URLs of all the team's git
> repositories, and it would periodically pull from them, speculatively
> compile anything new, and run the big suite of tests - finishing up by
> emailling them a heads-up that a particular state in their repo is
> 'bad'.
> 
> This was really popular as it was demonstrably better than anything we
> could do with svn, and best of all, it's pretty much transparent - as
> a user you don't have to do anything at all.
> 
> I could do it now by hacking about with files; it'd just be nice to
> keep it transparent and make it a directly supported feature.

In that case you would need the "URL mappings", perhaps as a per-remote
attribute. That is, you could configure:

	"When I am doing git pull fred, do git submodule update but
	apply remote.fred.subrewrite sed script on each URL before
	fetching the submodule."

Still, that feels quite hackish to me, and I'm not convinced that your
workflow cannot be adjusted so that users merge only the next-to-last
commit of a branch instead of the last one.

-- 
				Petr "Pasky" Baudis
As in certain cults it is possible to kill a process if you know
its true name.  -- Ken Thompson and Dennis M. Ritchie
