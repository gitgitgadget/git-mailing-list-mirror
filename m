From: Petr Baudis <pasky@suse.cz>
Subject: Re: Git benchmarks at OpenOffice.org wiki
Date: Wed, 2 May 2007 18:48:21 +0200
Message-ID: <20070502164821.GE4489@pasky.or.cz>
References: <200705012346.14997.jnareb@gmail.com> <200705021624.25560.kendy@suse.cz> <20070502161515.GC4489@pasky.or.cz> <200705021827.51335.kendy@suse.cz> <20070502163715.GD4489@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	releases@openoffice.org, dev@tools.openoffice.org
To: Jan Holesovsky <kendy@suse.cz>
X-From: git-owner@vger.kernel.org Wed May 02 18:48:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HjI0N-0000ve-6c
	for gcvg-git@gmane.org; Wed, 02 May 2007 18:48:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1766741AbXEBQs2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 May 2007 12:48:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1766739AbXEBQs1
	(ORCPT <rfc822;git-outgoing>); Wed, 2 May 2007 12:48:27 -0400
Received: from w241.dkm.cz ([62.24.88.241]:40350 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1766727AbXEBQsY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 May 2007 12:48:24 -0400
Received: (qmail 21559 invoked by uid 2001); 2 May 2007 18:48:21 +0200
Content-Disposition: inline
In-Reply-To: <20070502163715.GD4489@pasky.or.cz>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46037>

  Hi,

On Wed, May 02, 2007 at 06:37:15PM CEST, Petr Baudis wrote:
>   you can see an example script at
> 
> 	http://repo.or.cz/w/elinks.git?a=blob;f=contrib/grafthistory.sh

  by the way, this script goes back to very ancient Git times, maybe by
now git-fetch could be convinced to do all the hard work for you.
Actually, maybe just something (totally untested) like

	git remote add -f historical {http,git}://historical_repository_url
	cat <<EOF >>.git/info/grafts
	... the graft specs go here ...
	EOF

might work prefectly fine nowadays that git keeps the remote refs in a
separate namespace tidily. This way you don't have to care about all the
manual wgetting, ls-remote magic etc. The downside is that this is
available only since git-1.5.0 (Debian stable has older version; maybe
even newer git version is required, I'm not sure).

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Ever try. Ever fail. No matter. // Try again. Fail again. Fail better.
		-- Samuel Beckett
