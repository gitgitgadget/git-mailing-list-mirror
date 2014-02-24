From: Omar Othman <omar.m.othman@gmail.com>
Subject: `git stash pop` UX Problem
Date: Mon, 24 Feb 2014 09:33:18 +0100
Message-ID: <CAHvLNFtZpE5RbeMYL8ZRFc6JCDUxzZmxtsg13w=P8er8ki8mzg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 24 09:33:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WHqya-0002kV-2I
	for gcvg-git-2@plane.gmane.org; Mon, 24 Feb 2014 09:33:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751762AbaBXIdT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Feb 2014 03:33:19 -0500
Received: from mail-ve0-f180.google.com ([209.85.128.180]:64601 "EHLO
	mail-ve0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751672AbaBXIdT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Feb 2014 03:33:19 -0500
Received: by mail-ve0-f180.google.com with SMTP id cz12so4211431veb.11
        for <git@vger.kernel.org>; Mon, 24 Feb 2014 00:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=BJuAFhdivSxdwHU1JuOxTF36cHJ0HPK+e539PyK20Tg=;
        b=hug316PaF4sCrlCf7nhBIVMhEMvjEw+SjrDNI+H9Wxfetpab9KObAAyB4QeQp/nYZW
         6b7B4An+H8XXAj6qkrWzFaJeU7cLfZVrroe+72bYCaN0kSjK5j/9FLXEgtVvCwIja4UC
         wnBNca2mGZcn2e8AQHZ1XMuWPs3VFZV+DCrhzpqulPMHgNyzoaRb7cxoyDrB0QJ2IbKL
         tKpkz/0TvPqYVw+AGGuHZ8rLtW1hHRqxbIClEuh1iEexu1duUSuibahb70s1+MlXneil
         IjyG2CB0FzJV6+Sc7UUKu7CrMzVEGLKzYMcy40RO45w8n4eAMyDrHtzAGIRPF+LvA/5r
         QupQ==
X-Received: by 10.52.183.106 with SMTP id el10mr9726380vdc.73.1393230798352;
 Mon, 24 Feb 2014 00:33:18 -0800 (PST)
Received: by 10.220.161.4 with HTTP; Mon, 24 Feb 2014 00:33:18 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242578>

Hi there,

I'm fairly new to git and I wanted to ask about a certain behavior
that I want to fix myself (if you agree with me that it is a
misbehavior)... since I've never contributed to open source and it'll
be an important step for me to start and get something done.

In general, whenever something a user "should" do, git always tells.
So, for example, when things go wrong with a merge, you have the
option to abort. When you are doing a rebase, git tells you to do git
commit --amend, and then git rebase --continue... and so on.

The point is: Because of this, git is expected to always instruct you
on what to do next in a multilevel operation, or instructing you what
to do when an operation has gone wrong.

Now comes the problem. When you do a git stash pop, and a merge
conflict happens, git correctly tells you to fix the problems and then
git add to resolve the conflict. But once that happens, and the
internal status of git tells you that there are no more problems (I
have a prompt that tells me git's internal status), the operation is
not culminated by dropping the stash reference, which what normally
happens automatically after a git stash pop. This has actually
confused me for a lot of time, till I ran into a git committer and
asked him, and only then were I 100% confident that I did nothing
wrong and it is indeed a UX problem. I wasted a lot of time to know
why the operation is not completed as expected (since I trusted that
git just does the right thing), and it turned out that it is git's
fault.

If this is accepted, please reply to this email and tell me to start
working on it. I've read the Documenation/SubmittingPatches
guidelines, but I'll appreciate also telling me where to base my
change. My guess is maint, since it's a "bug" in the sense of UX.

Thanks and sorry for the long email.

-- 
Best Regards,

Omar Othman
