From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: git rebase -i without altering the committer date
Date: Wed, 20 Apr 2016 23:47:13 +0200
Message-ID: <87ega0eyvy.fsf@linux-m68k.org>
References: <etPan.5717e605.4004d424.12d1@sjackman03-imac.phage.bcgsc.ca>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Shaun Jackman <sjackman@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 20 23:47:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aszxy-0005h1-8m
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 23:47:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751371AbcDTVrU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Apr 2016 17:47:20 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:45790 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751308AbcDTVrT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2016 17:47:19 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 3qqwTH0bXfz3hjjj;
	Wed, 20 Apr 2016 23:47:15 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3qqwTH0MWrzvhNT;
	Wed, 20 Apr 2016 23:47:15 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id wJ4d77XWlOeT; Wed, 20 Apr 2016 23:47:14 +0200 (CEST)
X-Auth-Info: lqIJcCUtm/34XGqBzrJywChrejmEkg0TqWQ7HNKqbfSNYj6/yz8ji2W1q4uXspDM
Received: from igel.home (ppp-88-217-31-255.dynamic.mnet-online.de [88.217.31.255])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Wed, 20 Apr 2016 23:47:14 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
	id D42872C1F62; Wed, 20 Apr 2016 23:47:13 +0200 (CEST)
X-Yow: YOW!!
In-Reply-To: <etPan.5717e605.4004d424.12d1@sjackman03-imac.phage.bcgsc.ca>
	(Shaun Jackman's message of "Wed, 20 Apr 2016 13:24:45 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.0.92 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292085>

Shaun Jackman <sjackman@gmail.com> writes:

> I'd like to insert a commit between two commits without changing the committer date or author date of that commit or the subsequent commits. I'd planned on using `git rebase -i` to insert the commit. I believe it retains the author date, but changes the committer date to the current time. I've seen the options `--committer-date-is-author-date` and `--ignore-date`, but I don't believe either of those options does what I want. If no such option currently exists to leave the committer and author date unchanged, is there any chance that this functionality could please be implemented?

The easiest way to implement that is to add a graft to redirect the
parent of the second commit to the inserted commit, then use git
filter-branch to make the graft permanent.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
