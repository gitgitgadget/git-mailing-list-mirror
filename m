From: John Keeping <john@keeping.me.uk>
Subject: Re: Moving commits from one branch to another
Date: Wed, 23 Jan 2013 12:12:03 +0000
Message-ID: <20130123121203.GM7498@serenity.lan>
References: <000a01cdf961$bcf773d0$36e65b70$@de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stefan Schulze <algroth@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 23 13:12:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxzC8-0002rZ-Km
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jan 2013 13:12:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755628Ab3AWMMO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2013 07:12:14 -0500
Received: from jackal.aluminati.org ([72.9.247.210]:43338 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755602Ab3AWMMK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2013 07:12:10 -0500
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 46F38CDA5C6;
	Wed, 23 Jan 2013 12:12:10 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sQhpb4fAgySq; Wed, 23 Jan 2013 12:12:09 +0000 (GMT)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by jackal.aluminati.org (Postfix) with ESMTP id 47570CDA598;
	Wed, 23 Jan 2013 12:12:09 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 39934161E583;
	Wed, 23 Jan 2013 12:12:09 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id E0zbC6PeBR2Q; Wed, 23 Jan 2013 12:12:09 +0000 (GMT)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 2F55E161E34E;
	Wed, 23 Jan 2013 12:12:05 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <000a01cdf961$bcf773d0$36e65b70$@de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214315>

On Wed, Jan 23, 2013 at 01:04:03PM +0100, Stefan Schulze wrote:
> my team uses a central git-repo since >1500 commits and now we have to sync
> (only one-way is necessary for now) our repository every three weeks with an
> external svn-repo.
> I created the new base-directory (incl. trunk/tags/branches) in svn and
> added it to my local repo using git svn init && git fetch.
> Now I have two branches in my local repository (master and "svnbranch") and
> cherry-picked the very first commit from master to svnbranch (it was
> probably not necessary), tagged this commit as "publishedToSvn". Now I want
> to add all commits publishedToSvn..master onto svnbranch. I didn't managed
> to succeed using git-rebase (probably because of the missing common
> commits?) and using git grafts / filter-branch modifies my already published
> master.
> 
> Is there any way to move/copy commits from one branch to another without a
> common base-commit and without a forced push of master?

Did you try "git rebase" with "--onto"?  You probably want something
like this:

    git rebase --onto svnbranch publishedToSvn master


John
