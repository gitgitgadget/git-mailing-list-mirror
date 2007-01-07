From: "Chris Lee" <clee@kde.org>
Subject: Simple UI question...
Date: Sun, 7 Jan 2007 03:02:59 -0800
Message-ID: <204011cb0701070302y54837c5bp967e2cddd3fb655d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sun Jan 07 12:03:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3Vnt-0006Is-LI
	for gcvg-git@gmane.org; Sun, 07 Jan 2007 12:03:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932495AbXAGLDB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 Jan 2007 06:03:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932494AbXAGLDB
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jan 2007 06:03:01 -0500
Received: from wx-out-0506.google.com ([66.249.82.224]:1375 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932495AbXAGLDA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jan 2007 06:03:00 -0500
Received: by wx-out-0506.google.com with SMTP id h27so7671685wxd
        for <git@vger.kernel.org>; Sun, 07 Jan 2007 03:02:59 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=X6uGkt2tKr9hoXto7JodRqvjnImgDGs4jwEfa5Z1Myy2xzMA46x2DYpmz1JkYrjXWqihQS1Uo+dpKdXVjbhHQr+RFz5eir9VF3F4L/atr8v6lA8kPkEBa/sEYA/vzG+GOOIc4D76lHXzms9VECdSUtIExUwu1UcGLwhn/F2dqnA=
Received: by 10.90.66.9 with SMTP id o9mr1642492aga.1168167779907;
        Sun, 07 Jan 2007 03:02:59 -0800 (PST)
Received: by 10.90.81.19 with HTTP; Sun, 7 Jan 2007 03:02:59 -0800 (PST)
To: "Git Mailing List" <git@vger.kernel.org>
Content-Disposition: inline
X-Google-Sender-Auth: af9d0e135c7dbc9f
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36152>

Hey guys,

So I'm trying to figure out the best way to pull out a checkout of the
entire tree as of a given revision ID. I have a whole bunch of
revision IDs, and I'd like to know what the git equivalent of (say)
the following is:

svn co -r280600 file:///path/to/svn/repo

For the sake of argument, let's say that r280600 imported as
07058310db903317faa300b93004a5a2e0fc2dcc into my git tree.

How do I get a pristine checkout in my working copy of the entire tree
as the repository saw it at 07058310db903317faa300b93004a5a2e0fc2dcc?

Eric Anholt suggested 'git checkout -b temporary-branch-name
$sha1sum'; davej suggested 'git-read-tree $sha1sum &&
git-checkout-index -a -f' but for some reason, neither of these
commands seems to do exactly as I expect. davej's method seems to work
for some revision IDs, but not for others, and the other method seems
to work just about as well. (The problem I have seen is that, for some
revisions, the only files I get in the working copy are the files that
were changed in that commit; the rest of the files in the tree do not
get checked out.)
