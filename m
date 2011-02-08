From: Marc Weber <marco-oweber@gmx.de>
Subject: Re: rebase planning: determining blobs changed by multiple branches
Date: Tue, 08 Feb 2011 01:59:11 +0100
Message-ID: <1297126350-sup-6606@localhost.localdomain>
References: <iiq3kb$aiv$1@dough.gmane.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Feb 08 01:59:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmbvR-0002cA-GU
	for gcvg-git-2@lo.gmane.org; Tue, 08 Feb 2011 01:59:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754047Ab1BHA7Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Feb 2011 19:59:16 -0500
Received: from mailout-de.gmx.net ([213.165.64.22]:39796 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754036Ab1BHA7P (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Feb 2011 19:59:15 -0500
Received: (qmail invoked by alias); 08 Feb 2011 00:59:13 -0000
Received: from mawercer.at.xencon.net (EHLO mail.gmx.net) [83.246.111.127]
  by mail.gmx.net (mp048) with SMTP; 08 Feb 2011 01:59:13 +0100
X-Authenticated: #9006135
X-Provags-ID: V01U2FsdGVkX18On5QtdAEO73HxFfa04KdAGjkbYVN4OQC5yJ2xFi
	8oZuvYjPjpxc3p
Received: by mail.gmx.net (sSMTP sendmail emulation); Tue, 08 Feb 2011 01:59:11 +0100
In-reply-to: <iiq3kb$aiv$1@dough.gmane.org>
User-Agent: Sup/git
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166322>

Hi Neal,

I'm not quite sure what you want to do?
rebase all branches on top of commit l so that they are up to date?

Why do you want to find common blobs?
If the same conflict happens you could use gitrere and reuse a conflict
resolution.

git ls-files --with $HASH
gives you a list of files

git diff --name-only
should  give you a nice list of modified files.

So using the intersection of  ls-files of branch and tip should give you
common files. Substracting changed files using --name-only should yield
the files which were not modified.
Maybe there are nicer solutions though.

Rebasing is always bad. Have you considered using top-git?
This way you can merge with tip and create the rebased patches using the
export function.

Marc Weber
