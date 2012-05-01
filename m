From: Vinnie Falco <vinnie.falco@gmail.com>
Subject: git-subtree split O(N)
Date: Mon, 30 Apr 2012 18:39:20 -0700
Message-ID: <CA+EzHGfiRg+w8FsvrXEi0Yr4oVzxaZA_1JT8cmRR0YrYG7m6AQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 01 03:39:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SP240-0006Ji-N8
	for gcvg-git-2@plane.gmane.org; Tue, 01 May 2012 03:39:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757772Ab2EABjY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Apr 2012 21:39:24 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:46910 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757648Ab2EABjV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Apr 2012 21:39:21 -0400
Received: by qcro28 with SMTP id o28so1720145qcr.19
        for <git@vger.kernel.org>; Mon, 30 Apr 2012 18:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=pv3paEMeADfDkgL566W+dNrw3WFffkm0IPJnJf55/+E=;
        b=H4Qm4LwtIw7UCV0ehXQP1Ao1wjtyot0OjpR+3NbmLDBPQ30QQm6qlh/Yl21RCF/OP3
         3ukdqPIr8d1xvx5ZdBwasfWww2tIfwcGUkKdYoJ73rxsuhQVrdmM/uTtsic3aQE1zAl7
         Yv8R4P3neNVBkWzD06g/QtiHtJp4FU5EhaU6oOvlYZDIf0jWYAbyPYqcWbzW/z+1Wg7Y
         Ndv9JPJ6rIYPWvyK64izTU2FbIRh23ANTbGiQhxsraEYWIStxIZStUirsWyzbT5mPfed
         tSPeYKbGKjj3STLRlUQ06TPYQa1RjWZnWvksNH5DhMdzcP/BwpIvNby7UOdmlHTaBDv3
         8bpg==
Received: by 10.224.87.67 with SMTP id v3mr11893639qal.32.1335836360799; Mon,
 30 Apr 2012 18:39:20 -0700 (PDT)
Received: by 10.229.74.212 with HTTP; Mon, 30 Apr 2012 18:39:20 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196644>

I'm using git-subtree split to extract changes to a directory
previously added with git-subtree add, in my local repository. The
split is going into its own branch, which I then push to the upstream.

The problem is that every time I split, git-subtree starts from the
very beginning of the commit log and works its way forward. I thought
that it was only supposed to do that once, and that subsequent splits
would start from the last commit in the destination branch (I keep the
split branch around).

What's going on?

-- 
Follow me on Github: https://github.com/vinniefalco
