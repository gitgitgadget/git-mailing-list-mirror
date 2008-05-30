From: davetron5000 <davetron5000@gmail.com>
Subject: using git-push to backup repo...strange behavior
Date: Fri, 30 May 2008 05:42:20 -0700 (PDT)
Message-ID: <3a6159d2-e1ff-4aa8-bfeb-806af2bc82c8@8g2000hse.googlegroups.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 30 14:43:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K23xM-0006gw-6r
	for gcvg-git-2@gmane.org; Fri, 30 May 2008 14:43:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751160AbYE3MmX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2008 08:42:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751049AbYE3MmX
	(ORCPT <rfc822;git-outgoing>); Fri, 30 May 2008 08:42:23 -0400
Received: from wr-out-0708.google.com ([64.233.184.243]:33075 "EHLO
	wr-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751030AbYE3MmX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 May 2008 08:42:23 -0400
Received: by wr-out-0708.google.com with SMTP id 63so2161489wra.10
        for <git@vger.kernel.org>; Fri, 30 May 2008 05:42:20 -0700 (PDT)
Received: by 10.100.44.4 with SMTP id r4mr62775anr.9.1212151340426; Fri, 30 
	May 2008 05:42:20 -0700 (PDT)
X-IP: 98.218.223.189
User-Agent: G2/1.0
X-HTTP-UserAgent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X; en-US; 
	rv:1.8.1.14) Gecko/20080404 Firefox/2.0.0.14,gzip(gfe),gzip(gfe)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83292>

at least to me.

I have a git repo locally.  Want to essentially back it up on a remote
server using git.

First step was tar/gz the repo, scp it to my server and expand it.
Periodically throughout the day, I will do a

git push ssh://my.hostname.com/path/to/git/repo

There's a few issues:

1. Sometimes it doesn't work, saying a branch is "non fast forward".
--mirror or -f fixes this, but it seems wrong; I make no changes
remotely and clocks are in sync
2. --mirror doesn't like git stash, saying 'stash' is a "funny
refname"
3. On the remote side, I can find no way to update the working dir
with the changes other than git reset --hard.  Do I even need to do
this?  I'd like to be able to for automated builds/tests someday.
4. I made post-update executable, but it never runs (it echos a
message to a file)

I can't help feeling I'm doing everything wrong and just chancing on
things working under certain conditions.

Dave
