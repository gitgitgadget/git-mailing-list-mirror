From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git not tracking changes
Date: Tue, 2 Jan 2007 00:59:37 -0500
Message-ID: <20070102055937.GD27690@spearce.org>
References: <b5a19cd20701012152n4f496198h93cab1b9b85a9a45@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 02 06:59:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H1cgg-0006fE-50
	for gcvg-git@gmane.org; Tue, 02 Jan 2007 06:59:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755270AbXABF7m (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 2 Jan 2007 00:59:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755273AbXABF7m
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jan 2007 00:59:42 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:47860 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755270AbXABF7l (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jan 2007 00:59:41 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1H1cgW-0002oj-Ab; Tue, 02 Jan 2007 00:59:40 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 0C0B420FB65; Tue,  2 Jan 2007 00:59:37 -0500 (EST)
To: Deepak Barua <dbbarua@gmail.com>
Content-Disposition: inline
In-Reply-To: <b5a19cd20701012152n4f496198h93cab1b9b85a9a45@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35772>

Deepak Barua <dbbarua@gmail.com> wrote:
> Hi,
>    When i do a git add of a config.h file then make some changes and
> then do git commit it does not reflect the changes..
> eg
> dep@zion:~/programs/elinks/elinks-0.11-20061220$ git add config.h

Here you told Git to take the current contents of config.h and
stage it into the index.  That content will be in the next
commit.

> dep@zion:~/programs/elinks/elinks-0.11-20061220$ vi config.h

Then you modify it.  Git doesn't know about those changes to
config.h, nor does it care at this point.

> dep@zion:~/programs/elinks/elinks-0.11-20061220$ git commit
> nothing to commit

This is occuring because the content staged in the index does not
differ from the content in HEAD (the last commit on this branch).
You need to run `git add config.h` again now that you have modified
it to restage the modified file.

Basically I'm assuming that when you ran `git add config.h` the
first time the content must have matched HEAD, which meant you
didn't actually stage anything.

-- 
Shawn.
