From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [TOY PATCH] git wrapper: show similar command names for an unknown command
Date: Fri, 6 Jun 2008 14:15:27 +0200
Message-ID: <200806061415.27507.robin.rosenberg.lists@dewire.com>
References: <alpine.DEB.1.00.0806050747000.21190@racer>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jun 06 14:19:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4auY-0005gr-P1
	for gcvg-git-2@gmane.org; Fri, 06 Jun 2008 14:19:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753272AbYFFMSV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2008 08:18:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753226AbYFFMSV
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jun 2008 08:18:21 -0400
Received: from [83.140.172.130] ([83.140.172.130]:21153 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1753269AbYFFMSV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2008 08:18:21 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id C95DD8006B6;
	Fri,  6 Jun 2008 14:18:19 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id m4RRoGCtLZYa; Fri,  6 Jun 2008 14:18:19 +0200 (CEST)
Received: from [10.9.0.2] (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 4C98B80019B;
	Fri,  6 Jun 2008 14:18:19 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <alpine.DEB.1.00.0806050747000.21190@racer>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84052>

torsdagen den 5 juni 2008 08.48.40 skrev Johannes Schindelin:
> 
> This patch introduces a modified Damerau-Levenshtein algorithm into
> Git's code base, and uses it with the following penalties to show some
> similar commands when an unknown command was encountered:
> 
> 	swap = 0, insertion = 1, substitution = 2, deletion = 4
> 
> A typical output would now look like this:
> 
> 	$ git reabse
> 	git: 'reabse' is not a git-command. See 'git --help'.
> 
> 	Did you mean one of these?
> 		rebase
> 		merge-base
> 		rev-parse
> 		remote
> 		rerere
> 
Sorry about my negativity here..

Doesn't this confuse more than it helps? Most people do not need to know about rerere, rev-parse or merge-base so it is very unlikely they actually meant those. That might be an issue of tuning than general principles, but I have my doubts. It won't hint that there are wildly different variants of rebase, which ctually might be much more important to know than rerere, not will it tell svn users that git revert isn't even close to svn revert.

Completion or git gui is a much better tool for solving this isssue

Some ancient LISP had a DWIM (do what I mean) and there might be a reason it has not become ery popular.

Despite not being useful, it's still cool :)

-- robin
