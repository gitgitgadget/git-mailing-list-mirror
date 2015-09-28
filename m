From: "George Spelvin" <linux@horizon.com>
Subject: Why not git reset --hard <path>?
Date: 28 Sep 2015 16:34:49 -0400
Message-ID: <20150928203449.29024.qmail@ns.horizon.com>
Cc: linux@horizon.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 28 22:34:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zgf8S-0000pf-5P
	for gcvg-git-2@plane.gmane.org; Mon, 28 Sep 2015 22:34:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752789AbbI1Uew (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Sep 2015 16:34:52 -0400
Received: from ns.horizon.com ([71.41.210.147]:38351 "HELO ns.horizon.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752751AbbI1Uev (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Sep 2015 16:34:51 -0400
Received: (qmail 29025 invoked by uid 1000); 28 Sep 2015 16:34:49 -0400
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278750>

I was applying an old forgotten stash to see if there were any edits in
it I wanted to preserve, and my old changes to one file made no sense
any more.  I wanted to drop then all and keep the version in HEAD.

I'd been using git reset <path> after resolving conflicts, to leave
the changes in the same un-staged state they were before the stash,
so I tried using "git reset --hard crypto/842.c" to throw away
my local changes.

And I got
fatal: Cannot do hard reset with paths.

So I did "git reset <path>" followed by "git checkout <path>", which
achieved what I wanted.

But what I don't understand is why git reset couldn't do it for me in one
step.

I understand that "git reset --soft" makes no sense with a path, but
why not --hard?
