From: Pascal Obry <pascal@obry.net>
Subject: Re: git-svn problem with v1.6.5
Date: Wed, 11 Nov 2009 20:58:14 +0100
Organization: Home - http://www.obry.net
Message-ID: <4AFB1756.7090708@obry.net>
References: <4AF9E7FE.3060701@obry.net> <32541b130911101428t50038cfcsf37e3ea9edb26f64@mail.gmail.com> 	<4AFA91BB.7050402@obry.net> <32541b130911111141n7b029b1ep68656d2eb39be3c7@mail.gmail.com>
Reply-To: pascal@obry.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Eric Wong <normalperson@yhbt.net>, adambrewster@gmail.com,
	git list <git@vger.kernel.org>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 11 20:58:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8JKP-0005Ni-F6
	for gcvg-git-2@lo.gmane.org; Wed, 11 Nov 2009 20:58:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752795AbZKKT5y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2009 14:57:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751994AbZKKT5y
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Nov 2009 14:57:54 -0500
Received: from ey-out-2122.google.com ([74.125.78.25]:3853 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751831AbZKKT5x (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2009 14:57:53 -0500
Received: by ey-out-2122.google.com with SMTP id 9so352164eyd.19
        for <git@vger.kernel.org>; Wed, 11 Nov 2009 11:57:57 -0800 (PST)
Received: by 10.213.23.87 with SMTP id q23mr597000ebb.24.1257969477402;
        Wed, 11 Nov 2009 11:57:57 -0800 (PST)
Received: from ?192.168.0.100? (AVelizy-154-1-81-24.w86-205.abo.wanadoo.fr [86.205.111.24])
        by mx.google.com with ESMTPS id 28sm1213247eyg.22.2009.11.11.11.57.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 11 Nov 2009 11:57:56 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; fr-FR; rv:1.8.1.22) Gecko/20090605 Thunderbird/2.0.0.22 Mnenhy/0.7.5.0
In-Reply-To: <32541b130911111141n7b029b1ep68656d2eb39be3c7@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132695>

Avery,

> Well, that's bad news.  Does "git log --all --parents | grep
> d2cf08bb67e4b7da33a250127aab784f1f2f58d3" reveal any places that refer
> to it?

No.

> It sounds a bit like your git-svn thinks something maps on to that
> commit id, but a previous 'git gc' or something has thrown it away.
> However, that doesn't explain why earlier git versions don't have this
> problem.

Maybe, but that would be a quite annoying bug!

> If you retrieve the latest version of git and then git revert the
> above commit, does that fix the problem, at least?

I cannot, this does not revert cleanly and I don't know how to properly 
resolve this conflict. I'm no Perl expert!

But reverting using the version just before fixes this problem.

> Is it possible you have some weird branches outside of the
> refs/remotes tree (either in .git itself, or in .git/refs/*) that you
> forgot about, and which the new version of git-svn is finding somehow?

I do not see something under .git/refs/* (only empty directories).

The project has been imported using something like this:

  $ git svn clone --prefix=svn/ svn+ssh://server/path \
	--revision=580:HEAD \
	--trunk=trunk/project \
	--tags=tags/project \
	--branches=branches/project \
	--branches="branches/global/*/project" project

Nothing fancy. The git-svn mirrors is updated every night using Git 
1.6.4 without problem.

Pascal.

-- 

--|------------------------------------------------------
--| Pascal Obry                           Team-Ada Member
--| 45, rue Gabriel Peri - 78114 Magny Les Hameaux FRANCE
--|------------------------------------------------------
--|    http://www.obry.net  -  http://v2p.fr.eu.org
--| "The best way to travel is by means of imagination"
--|
--| gpg --keyserver keys.gnupg.net --recv-key F949BD3B
