From: Robert Dailey <rcdailey.lists@gmail.com>
Subject: Rewriting git history during git-svn conversion
Date: Mon, 3 Mar 2014 12:38:52 -0600
Message-ID: <CAHd499DqoUEKeu4uM5w7Y6Tm-tE-oJMUdz4RxP9s6CpN=LS9Bg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 03 19:39:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKXlT-0008TH-4Z
	for gcvg-git-2@plane.gmane.org; Mon, 03 Mar 2014 19:38:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753922AbaCCSiy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2014 13:38:54 -0500
Received: from mail-vc0-f177.google.com ([209.85.220.177]:48662 "EHLO
	mail-vc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753269AbaCCSix (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2014 13:38:53 -0500
Received: by mail-vc0-f177.google.com with SMTP id if11so3845969vcb.8
        for <git@vger.kernel.org>; Mon, 03 Mar 2014 10:38:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:date:message-id:subject:from:to:content-type;
        bh=pCW/zOXpz+VVFHqhXeuDGRwc9mFcQLeZe9GaffMjuVo=;
        b=Pe5FelQhoVBpPTfOPCP01qXWMvdNyVo1sjxkMosy5b6uTaUjFxYftt3iRFwTgiBJLA
         Jd5YBYmoqwG79ai0j6FmCZfh74T20wgeXI12qyky5JTGsso0zFAeCzqX7twLMP+/Z9rR
         WGZrTUKcmXlePgEe6zXJfEu/+RLT0T9ofd5/TdKNA7JXS15JD6e0AZXl15CZpezwQ2eQ
         B8borRHi4ZU/2REYLP92K/7ruh5UqXklkNgJe02plHccCDHPhBcgSWtFeGhdq87/SWsi
         oC9O0Mes+YSJOx1tRpKGa4ypKOY47Lj6/8wrNc2iSoxRbbjGXQTKE6vEvq6XLtSu6GQc
         sNAg==
X-Received: by 10.52.75.101 with SMTP id b5mr100466vdw.40.1393871932552; Mon,
 03 Mar 2014 10:38:52 -0800 (PST)
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.221.1.132 with HTTP; Mon, 3 Mar 2014 10:38:52 -0800 (PST)
X-Google-Sender-Auth: G-rLLWgTjoRDfAI-P85tc60gz50
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243249>

Hi,

I am converting my team's SVN server to GIT but they aren't ready to
transition yet. People are still working out of SVN, so I need to keep
the git-svn clone around to do 'git svn fetch' to continue to keep it
synchronized with SVN.

Once everyone is ready to switch, and after converting all of the
tag-branches to real GIT tags, I plan to push all branches & tags to
the new central git repository.

However, before pushing to the central GIT repo, I want to remove some
giant directories from the repository history. Specifically some third
party library directories. I have found a way to do this here:
http://stackoverflow.com/questions/10067848/remove-folder-and-its-contents-from-git-githubs-history

Is it safe to do this while still using git svn fetch? Will it
properly continue to convert SVN commits on top of my rewritten
history? If not, what changes can I make after I run the commands
linked by the URL above so that git svn continues to work normally?

Note that I plan to delete the third party libraries from SVN side and
then pull down the changes to git through git-svn, then at that point
clean it up (hopefully the git filter-branch command ignores the
commit that deleted the files and only hunts down the commits where
they were added or modified).

Any guidance on this would be much appreciated.
