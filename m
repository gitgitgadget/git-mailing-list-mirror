From: Madhu <enometh@meer.net>
Subject: Re: git-rebase --abort eats files
Date: Tue, 29 Jun 2010 06:53:53 +0530 (IST)
Message-ID: <20100629012412.7FDBD1F212@leonis4.robolove.meer.net>
References: <20100626125924.160F11F212@leonis4.robolove.meer.net>
 <201006262009.30380.j6t@kdbg.org> <20100628090517.GA8091@debian>
Reply-To: Madhu <enometh@meer.net>
Cc: j6t@kdbg.org, git@vger.kernel.org
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 29 04:02:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTQ9g-00045M-Jz
	for gcvg-git-2@lo.gmane.org; Tue, 29 Jun 2010 04:02:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753160Ab0F2CC0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jun 2010 22:02:26 -0400
Received: from vps.hungerhost.com ([216.38.53.176]:48409 "EHLO
	vps.hungerhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752470Ab0F2CCZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jun 2010 22:02:25 -0400
X-Greylist: delayed 2273 seconds by postgrey-1.27 at vger.kernel.org; Mon, 28 Jun 2010 22:02:25 EDT
Received: from [59.92.61.135] (helo=leonis4.robolove.meer.net ident=Diebold)
	by vps.hungerhost.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <enometh@meer.net>)
	id 1OTPYp-00043B-Pv; Mon, 28 Jun 2010 21:24:28 -0400
Received: by leonis4.robolove.meer.net (Postfix, from userid 500)
	id 7FDBD1F212; Tue, 29 Jun 2010 06:53:53 +0530 (IST)
In-reply-to: <20100628090517.GA8091@debian> (message from Ramkumar Ramachandra
	on Mon, 28 Jun 2010 11:05:17 +0200)
X-Url: http://www.meer.net/~enometh/
X-Attribution: Madhu
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vps.hungerhost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - meer.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149881>

  |Date: Mon, 28 Jun 2010 11:05:17 +0200
  |From: Ramkumar Ramachandra <artagnon@gmail.com>
  |Cc: Madhu <enometh@meer.net>, git@vger.kernel.org
  |Content-Type: text/plain; charset=us-ascii
  |Content-Disposition: inline
  |
  |> No, it can't be that simple. If rebase stopped due to a conflict
  |> on a commit that added new files, then your version of rebase
  |> --abort will leave these new files behind as untracked.
  |
  |Right. The interactive rebase has to be able to differentiate
  |between files that you added to resolve a conflict and files that
  |you added to retain at the end of the rebase -- and the interactive
  |rebase has no information about this. Hence, this problem can't be
  |fixed without explicitly finding out the intent of the user.

Wrong.  Rebase has to be able to differentaiate between two cases

1. when there is a conflict, and the user is prompted to fix it, and
 then continue with a git-add, git-commit, and git-rebase --continue

and 

2. when the user is given a commit, which he is asked to git-commit
  --amend, and then git-rebase --continue

Rebase is already aware of when each situation occurs.

  |In my opinion, you should simply stash your changes before aborting
  |the rebase instead of adding files and figuring out some complex
  |way of expressing intent.

This does not make sense.

--
Madhu
