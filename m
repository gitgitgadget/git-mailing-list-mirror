From: Petr Baudis <pasky@suse.cz>
Subject: Re: [RFC] cg-log -r order:matters
Date: Wed, 21 Sep 2005 15:46:38 +0200
Message-ID: <20050921134638.GA17981@pasky.or.cz>
References: <46a038f905082304126e8ecd65@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 21 15:50:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EI4vz-0002Pa-4A
	for gcvg-git@gmane.org; Wed, 21 Sep 2005 15:46:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750923AbVIUNql (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Sep 2005 09:46:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750930AbVIUNql
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Sep 2005 09:46:41 -0400
Received: from w241.dkm.cz ([62.24.88.241]:5352 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750923AbVIUNqk (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Sep 2005 09:46:40 -0400
Received: (qmail 19221 invoked by uid 2001); 21 Sep 2005 15:46:38 +0200
To: Martin Langhoff <martin.langhoff@gmail.com>
Content-Disposition: inline
In-Reply-To: <46a038f905082304126e8ecd65@mail.gmail.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9044>

Dear diary, on Tue, Aug 23, 2005 at 01:12:58PM CEST, I got a letter
where Martin Langhoff <martin.langhoff@gmail.com> told me that...
> It's sometimes unclear which head is "ahead" of the other. If I get
> the order wrong, cg-log shows no log output. Is this expected?
> 
> I was expecting a warning, or a reverse-ordered log. Or both. ;)

The thing is, how cg-log -r from:to is implemented is really "show me
all the ancestors of $to excepts ancestors of $from". So if $to is
an ancestor of $from, it will logically show nothing. But checking that
condition separately would take _very_ long time. And just producing a
warning when log output would be empty, that seems too noisy to me.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
