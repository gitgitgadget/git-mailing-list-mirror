From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: Help requested - trying to build a tool doing whole-tree commits
Date: Fri, 09 Nov 2012 22:50:17 +0100
Message-ID: <m2txsyqwdi.fsf@igel.home>
References: <20121109182024.81074BC66D4@golux>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Unknown <unknown@unknown.invalid>
X-From: git-owner@vger.kernel.org Fri Nov 09 22:50:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TWwTE-0003xc-CZ
	for gcvg-git-2@plane.gmane.org; Fri, 09 Nov 2012 22:50:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756238Ab2KIVuW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2012 16:50:22 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:55294 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753575Ab2KIVuV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2012 16:50:21 -0500
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3Xyw5Q2wT7z4KK7Z;
	Fri,  9 Nov 2012 22:50:18 +0100 (CET)
X-Auth-Info: oiffLGJVeOjfpxUZMnaPCfFokySD12XBEUvPdRogq/k=
Received: from igel.home (ppp-88-217-114-57.dynamic.mnet-online.de [88.217.114.57])
	by mail.mnet-online.de (Postfix) with ESMTPA id 3Xyw5Q2LfTzbbg7;
	Fri,  9 Nov 2012 22:50:18 +0100 (CET)
Received: by igel.home (Postfix, from userid 501)
	id E913ECA2A4; Fri,  9 Nov 2012 22:50:17 +0100 (CET)
X-Yow: ..  Do you like ``TENDER VITTLES?''?
In-Reply-To: <20121109182024.81074BC66D4@golux> (unknown@unknown.invalid's
	message of "Fri, 9 Nov 2012 13:20:24 -0500 (EST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209250>

Unknown <unknown@unknown.invalid> writes:

> I need a command or command sequence that will commit an entire file
> tree to a repository...
>
> (a) Allowing me to specify committer and author metadata, and
>
> (b) deleting paths not present in the previous commit on the current
> branch, and
>
> (c) allowing me to specify merge links from other previous commits.
>
> git commit -a passes (a) and (b) but not (c).

git commit -a won't add new files, so you probably want to use git add
-A && git commit.  I'm not quite sure what you mean with "merge links",
but if you want to create merge commits the you'll need to resort to
plumbing: git add -A && git write-tree && git commit-tree && git
update-ref.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
