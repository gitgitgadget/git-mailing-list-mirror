From: Kris Shannon <kris@shannon.id.au>
Subject: Re: merge smart enough to adapt to renames?
Date: Sat, 21 Feb 2009 15:48:01 +1100
Message-ID: <e51f4f550902202048g9a210f0t8fefaee4d8376f6c@mail.gmail.com>
References: <81bfc67a0902182212h578e677ck6029c56cb86f7bce@mail.gmail.com>
	 <slrngpqquq.j03.sitaramc@sitaramc.homelinux.net>
	 <81bfc67a0902191158x5f0f92d1p7e4af2f9cda50a12@mail.gmail.com>
	 <slrngprunn.hbo.sitaramc@sitaramc.homelinux.net>
	 <81bfc67a0902191817u11361d0bw1f2215a53e284f8f@mail.gmail.com>
	 <499E5A9C.6090900@dawes.za.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Caleb Cushing <xenoterracide@gmail.com>,
	Sitaram Chamarty <sitaramc@gmail.com>, git@vger.kernel.org
To: Rogan Dawes <lists@dawes.za.net>
X-From: git-owner@vger.kernel.org Sat Feb 21 05:49:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lajnx-0007Uc-T4
	for gcvg-git-2@gmane.org; Sat, 21 Feb 2009 05:49:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752003AbZBUEsG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2009 23:48:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751214AbZBUEsF
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Feb 2009 23:48:05 -0500
Received: from wf-out-1314.google.com ([209.85.200.173]:50361 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751032AbZBUEsD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2009 23:48:03 -0500
Received: by wf-out-1314.google.com with SMTP id 28so1530965wfa.4
        for <git@vger.kernel.org>; Fri, 20 Feb 2009 20:48:01 -0800 (PST)
Received: by 10.142.223.4 with SMTP id v4mr773190wfg.11.1235191681597; Fri, 20 
	Feb 2009 20:48:01 -0800 (PST)
In-Reply-To: <499E5A9C.6090900@dawes.za.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110925>

Rogan Dawes wrote:
> It seems to me that git is smart enough to figure out where contents get
> moved to, once. Of course, if you have conflicting moves in the same
> repo, git's automation falls down. So, if you need to move the "same"
> file in different repositories to different places, you need to do it
> via an intermediate repo that will be able to "remember" which movement
> you chose.

You don't need a whole different repo,  branches are good enough.

git checkout gentoo-integration
git pull gentoo

git checkout sunrise-integration
git pull sunrise

git checkout master
git merge gentoo
git merge sunrise

The integration branches can remember your local changes to
the remotes (like the move of packages.mask)
