From: Konstantin Khomoutov <flatworm@users.sourceforge.net>
Subject: Re: git fetch vs push, git am questions
Date: Tue, 7 Dec 2010 03:21:04 +0300
Message-ID: <20101207002104.GG3264@localhost.localdomain>
References: <99351291667275@web152.yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Konstantin Kivi <kkivi@yandex.ru>
X-From: git-owner@vger.kernel.org Tue Dec 07 01:21:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PPlJ7-0002hi-LS
	for gcvg-git-2@lo.gmane.org; Tue, 07 Dec 2010 01:21:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754487Ab0LGAVK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Dec 2010 19:21:10 -0500
Received: from mailhub.007spb.ru ([84.204.203.130]:37750 "EHLO
	mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754427Ab0LGAVJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Dec 2010 19:21:09 -0500
Received: from proxysrv.domain007.com ([10.8.0.42])
	by mailhub.007spb.ru (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id oB70L5EG014288;
	Tue, 7 Dec 2010 03:21:06 +0300
Received: by proxysrv.domain007.com (Postfix, from userid 1000)
	id 4E5B1B20056; Tue,  7 Dec 2010 03:21:05 +0300 (MSK)
Content-Disposition: inline
In-Reply-To: <99351291667275@web152.yandex.ru>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Scanned-By: MIMEDefang 2.51 (www.roaringpenguin.com/mimedefang) on 192.168.2.20
X-Antivirus: Dr.Web (R) for Mail Servers on proxysrv host
X-Antivirus-Code: 100000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163063>

On Mon, Dec 06, 2010 at 11:27:55PM +0300, Konstantin Kivi wrote:

[...]
> 1) Is it possible to achieve the same result with git fetch, as I have
> with git push. I have cloned a bare repository (2) from my repository
> (1) and I want fetch made in (2) get all info contained in (1) . I
> talk only about 'master' here. git push from (1) to (2) does the job,
> but git fetch in (1) updates only origin/master, and not master.
`git pull` does exactly that: fetch + merge (which should result in
fast-forward in your case).

> I also found that there is a notions of current branch in bare
> repository (master in my case), that stops my experiments of deleting
> master and making new master out of origin/master.  How can I change
> current branch in bare repositry?
By re-writing the HEAD ref (this behaviour is documented in the man page
of the `git clone` command, see the "--branch" option for instance).
You can use the `git symbolic-ref` to update the HEAD ref.

[...]

P.S.
It's a bit strange you're playing with a bare repository in this way.
Usually a bare repository is supposed to be pushed to and pulled from,
not the other way round. Not that it's bad, but it may turn out you're
inventing a convoluted workflow when there may be a simpler solution.
