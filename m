From: Hagen Paul Pfeifer <hagen@jauu.net>
Subject: Bisect limited to Merge Commits
Date: Wed, 27 Apr 2016 22:45:51 +0200
Message-ID: <20160427204551.GB4613@virgo.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 27 22:46:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avWLQ-0007c8-Ai
	for gcvg-git-2@plane.gmane.org; Wed, 27 Apr 2016 22:46:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753288AbcD0Up4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2016 16:45:56 -0400
Received: from mx1.mailbox.org ([80.241.60.212]:57501 "EHLO mx1.mailbox.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752280AbcD0Upz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2016 16:45:55 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.mailbox.org (Postfix) with ESMTPS id 16FF742016
	for <git@vger.kernel.org>; Wed, 27 Apr 2016 22:45:53 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
	by hefe.heinlein-support.de (hefe.heinlein-support.de [91.198.250.172]) (amavisd-new, port 10030)
	with ESMTP id JESEM6zFKJEk for <git@vger.kernel.org>;
	Wed, 27 Apr 2016 22:45:52 +0200 (CEST)
Content-Disposition: inline
X-Key-Id: 98350C22
X-Key-Fingerprint: 490F 557B 6C48 6D7E 5706 2EA2 4A22 8D45 9835 0C22
X-GPG-Key: gpg --recv-keys --keyserver wwwkeys.eu.pgp.net 98350C22
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292821>

Hey,

are there any plans to add an option to skip all non-merge commits via
bisecting?

git bisect start --merges-only

Imagine a "rebase feature branch" style of development. All features are
developed on separate features branch which are rebased on master and
immediately merged into the upstream master. Now think about lazy programmers
who miss to check the build process at each commit - leading to many
unbuildable commits. The only guaranteed buildable commit is often the merge
commit.

Bisecting only merge commits will reduce the amount of skip commands (think
about many unbuildable commits) and reduce the number of tests.

Any comments on this idea? What about extending bisect.c:do_find_bisection()


	hgn
