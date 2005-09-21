From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH 6/8] cogito: Don't ever assume object type in cg-object-id
Date: Wed, 21 Sep 2005 12:00:40 +0200
Message-ID: <20050921100040.GE24902@pasky.or.cz>
References: <1127183120.31115.34.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 21 12:02:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EI1PB-0005I4-3e
	for gcvg-git@gmane.org; Wed, 21 Sep 2005 12:00:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750806AbVIUKAm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Sep 2005 06:00:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750807AbVIUKAm
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Sep 2005 06:00:42 -0400
Received: from w241.dkm.cz ([62.24.88.241]:29113 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750806AbVIUKAm (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Sep 2005 06:00:42 -0400
Received: (qmail 3019 invoked by uid 2001); 21 Sep 2005 12:00:40 +0200
To: Pavel Roskin <proski@gnu.org>
Content-Disposition: inline
In-Reply-To: <1127183120.31115.34.camel@dv>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9037>

Dear diary, on Tue, Sep 20, 2005 at 04:25:20AM CEST, I got a letter
where Pavel Roskin <proski@gnu.org> told me that...
> Don't ever assume object type in cg-object-id.
> 
> If type is unknown in normalize_id(), make it empty so it's checked
> later.  Check parent ID that it's a commit.

Why? In most of the cases, you have one pointless fork() more, and we
"assume" only if it was in a parent line, and if that's not a commit,
you've got a *serious* problem with your database. fsck should yell you
to death, and I don't think you could even normally commit such a
commit, so this should never happen. There's no point in wasting time
trying to handle seriously messed up database.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
