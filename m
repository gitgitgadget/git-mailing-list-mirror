From: David Kastrup <dak@gnu.org>
Subject: Re: git-svn: Branching clarifications
Date: Sat, 08 Sep 2007 08:57:27 +0200
Message-ID: <85r6l9zlt4.fsf@lola.goethe.zz>
References: <46E18095.60501@gmail.com> <20070908052126.GB28855@soma>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Russ Brown <pickscrape@gmail.com>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sat Sep 08 08:57:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITuGI-0003fV-T8
	for gcvg-git@gmane.org; Sat, 08 Sep 2007 08:57:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751179AbXIHG5e (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 8 Sep 2007 02:57:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751154AbXIHG5e
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Sep 2007 02:57:34 -0400
Received: from mail-in-10.arcor-online.net ([151.189.21.50]:52000 "EHLO
	mail-in-10.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751172AbXIHG5d (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Sep 2007 02:57:33 -0400
Received: from mail-in-13-z2.arcor-online.net (mail-in-13-z2.arcor-online.net [151.189.8.30])
	by mail-in-10.arcor-online.net (Postfix) with ESMTP id 6853C1F533C;
	Sat,  8 Sep 2007 08:57:32 +0200 (CEST)
Received: from mail-in-07.arcor-online.net (mail-in-07.arcor-online.net [151.189.21.47])
	by mail-in-13-z2.arcor-online.net (Postfix) with ESMTP id 51C9C1B8E41;
	Sat,  8 Sep 2007 08:57:32 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-013-010.pools.arcor-ip.net [84.61.13.10])
	by mail-in-07.arcor-online.net (Postfix) with ESMTP id F36DD28ABA1;
	Sat,  8 Sep 2007 08:57:27 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 836771CAD71D; Sat,  8 Sep 2007 08:57:27 +0200 (CEST)
In-Reply-To: <20070908052126.GB28855@soma> (Eric Wong's message of "Fri\, 7 Sep 2007 22\:21\:26 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.2/4194/Sat Sep  8 06:33:29 2007 on mail-in-07.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58106>

Eric Wong <normalperson@yhbt.net> writes:

> git-svn sets "master" to the most recently committed-to branch
> in SVN the first time it fetches.  "git-log master" will tell
> you (look at the git-svn-id: lines).

Sigh.  Another "surprise the user by an arbitrary looking choice that
might possibly correspond to what he wants done because it something
obscure in the commit history suggests so" design decision.

I don't want my master set according to something that a coworker (or
even myself) happened to commit last to.

Please.  git-svn is told how to find the trunk on its command line.
Nothing makes sense (short of an _explicit_ wish otherwise for which
it might make sense to create a command line option) than to map
master to the trunk.

As a design rule: don't second-guess the user, _ever_, and
particularly not on decisions with large consequences.  A tool should
not have a mind of its own but do what it is told.  And if it can't
figure out what it is told, by simple, user-understandable criteria,
barf.  And of course have a way to _direct_ it when it can't figure it
out on its own, or if the simple and obvious default would not do the
right thing.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
