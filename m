From: Samuel Abels <newsgroups@debain.org>
Subject: Re: Performance impact of a large number of commits
Date: Fri, 24 Oct 2008 21:56:42 +0200
Message-ID: <1224878202.7566.25.camel@localhost>
References: <1224874946.7566.13.camel@localhost>
	 <alpine.DEB.1.10.0810241240100.27333@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: david@lang.hm
X-From: git-owner@vger.kernel.org Fri Oct 24 21:58:23 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KtSnP-0001bE-Fn
	for gcvg-git-2@gmane.org; Fri, 24 Oct 2008 21:58:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753035AbYJXT4p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Oct 2008 15:56:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753557AbYJXT4p
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Oct 2008 15:56:45 -0400
Received: from mail.speedpartner.de ([91.184.32.3]:43289 "EHLO
	mail.speedpartner.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752928AbYJXT4o (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Oct 2008 15:56:44 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.speedpartner.de (Postfix) with ESMTP id 3F2E5B3CA2;
	Fri, 24 Oct 2008 21:56:43 +0200 (CEST)
Received: from mail.speedpartner.de ([127.0.0.1])
	by localhost (mail.speedpartner.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eU0GYEBJhCLk; Fri, 24 Oct 2008 21:56:43 +0200 (CEST)
Received: from [192.168.0.3] (stgt-4d02e380.pool.mediaWays.net [77.2.227.128])
	by mail.speedpartner.de (Postfix) with ESMTP id EC87DB3AAA;
	Fri, 24 Oct 2008 21:56:42 +0200 (CEST)
In-Reply-To: <alpine.DEB.1.10.0810241240100.27333@asgard.lang.hm>
X-Mailer: Evolution 2.22.3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99059>

On Fri, 2008-10-24 at 12:43 -0700, david@lang.hm wrote:
> 100,000 commits per day??
> 
> that's 1.5 commits/second. what is updating files that quickly?

This is an automated process taking snapshots of rapidly changing files
containing statistical data. Unfortunately, our needs go beyond what a
versioning file system has to offer, and the data is an unstructured
text file (in other words, using a relational database is not a good
option).

> I suspect that you will have some issues here, but it's going to depend on 
> how many files get updated each 3/4 of a second.

That would be 5 to 10 changed files per commit, and those are passed to
git commit explicitly (i.e., walking the tree to stat files for finding
changes is not necessary).

-Samuel
