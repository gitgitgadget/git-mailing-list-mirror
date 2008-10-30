From: Samuel Tardieu <sam@rfc1149.net>
Subject: Re: Using the --track option when creating a branch
Date: Thu, 30 Oct 2008 15:56:34 +0100
Organization: RFC 1149 (see http://www.rfc1149.net/)
Message-ID: <2008-10-30-15-56-34+trackit+sam@rfc1149.net>
References: <18696.32778.842933.486171@lisa.zopyra.com> <1225343538.10803.9.camel@maia.lan> <18697.41702.241183.408377@lisa.zopyra.com> <18697.42140.459170.891195@lisa.zopyra.com> <4909A7C4.30507@op5.se> <2008-10-30-14-52-52+trackit+sam@rfc1149.net> <4909BF58.9010500@op5.se> <2008-10-30-15-23-16+trackit+sam@rfc1149.net> <20081030144107.GE24098@artemis.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Cc: Andreas Ericsson <ae@op5.se>, Bill Lear <rael@zopyra.com>,
	git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Thu Oct 30 15:58:01 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvYyB-0006qt-EE
	for gcvg-git-2@gmane.org; Thu, 30 Oct 2008 15:57:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755384AbYJ3O4j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Oct 2008 10:56:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755378AbYJ3O4j
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Oct 2008 10:56:39 -0400
Received: from zoidberg.rfc1149.net ([91.121.19.179]:56601 "EHLO
	zoidberg.rfc1149.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754656AbYJ3O4i (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Oct 2008 10:56:38 -0400
Received: from localhost (localhost [127.0.0.1])
	by zoidberg.rfc1149.net (Postfix) with ESMTP id 4B59B1114AE;
	Thu, 30 Oct 2008 15:56:36 +0100 (CET)
X-Virus-Scanned: amavisd-new at rfc1149.net
Received: from zoidberg.rfc1149.net ([127.0.0.1])
	by localhost (zaphod.rfc1149.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mlt17kKB485t; Thu, 30 Oct 2008 15:56:35 +0100 (CET)
Received: from mail2.rfc1149.net (willow.rfc1149.net [IPv6:2001:6f8:37a:2::2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail2.rfc1149.net", Issuer "rfc1149.net" (verified OK))
	by zoidberg.rfc1149.net (Postfix) with ESMTPS id 3382111146B;
	Thu, 30 Oct 2008 15:56:35 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mail2.rfc1149.net (Postfix) with ESMTP id 84942C40BC;
	Thu, 30 Oct 2008 15:56:34 +0100 (CET)
Received: from mail2.rfc1149.net ([127.0.0.1])
	by localhost (localhost [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OxDRR7DmvvOl; Thu, 30 Oct 2008 15:56:34 +0100 (CET)
Received: by mail2.rfc1149.net (Postfix, from userid 1000)
	id 5D0BCC40BD; Thu, 30 Oct 2008 15:56:34 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20081030144107.GE24098@artemis.corp>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-WWW: http://www.rfc1149.net/sam
X-Jabber: <sam@rfc1149.net> (see http://www.jabber.org/)
X-OpenPGP-Fingerprint: 79C0 AE3C CEA8 F17B 0EF1  45A5 F133 2241 1B80 ADE6 (see http://www.gnupg.org/)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99478>

* Pierre Habouzit <madcoder@debian.org> [2008-10-30 15:41:07 +0100]

| On Thu, Oct 30, 2008 at 02:23:16PM +0000, Samuel Tardieu wrote:
| > I think it would be better to have :
| > 
| >   git push                <= push the current branch
| >   git push --all          <= push all matching refs
| >   git push --all --create <= push all matching refs, create if needed
| > 
| > The latest command is probably used so rarely (compared to the others)
| > that it wouldn't be a problem to make it longer. Of course, if a
| > refspec is given explicitely, it should be honored and remote refs
| > created if needed.
| 
| Fwiw I'm in favor of that, and it was what I advocated at the time.
| 
| Though I think than as soon as you add an explicit remote name, like:
| git push origin, pushing all matched references makes sense. Which is
| also what I advocated at the time.

Indeed, it makes sense. We could then have:

  git push                 <= push the current branch on default remote
                              (which is, at least in my case, the most
                               frequent use I want to make of "git push",
                               on all the projects [work or volunteer]
                               I work on)
  git push remote          <= push all matching refs on named remote
  git push --all [remote]  <= push and create all refs on remote (or default)

 Sam
