From: Omar Othman <omar.othman@booking.com>
Subject: `git stash pop` UX Problem
Date: Mon, 24 Feb 2014 09:32:21 +0100
Message-ID: <530B0395.5030407@booking.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 24 09:48:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WHrDK-000141-1g
	for gcvg-git-2@plane.gmane.org; Mon, 24 Feb 2014 09:48:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752426AbaBXIsd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Feb 2014 03:48:33 -0500
Received: from mail-out6.booking.com ([5.57.20.183]:38147 "EHLO
	mail-out6.booking.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751175AbaBXIsc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Feb 2014 03:48:32 -0500
X-Greylist: delayed 968 seconds by postgrey-1.27 at vger.kernel.org; Mon, 24 Feb 2014 03:48:32 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=booking.com; s=bk;
	h=Content-Transfer-Encoding:Content-Type:Subject:To:MIME-Version:From:Date:Message-ID; bh=m0lR6Wsi4Iodg+wL/J8sVzMhvwL8Vdy7WEt4zapk7SQ=;
	b=puF8/kt02EKkUK+gqwxOBDmzgHfkbCZTddBfXNqE2ozxbTwFJySTKIwoDGtD9Jb3FkFaj82AEhvyvfyniglqveD2lx4RvzTbXf7lFeypcHkWQHCbai/klWBXR2KcwstOxAzdKxkfMc75zaVONlCXTE0zPYKxW77b/gXYlfZ5Om8=;
Received: from corpds-202.lhr4.corp.booking.com ([10.186.68.14]:45673)
	by mtx-202.lhr4.prod.booking.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
	(Exim 4.80.1)
	(envelope-from <omar.othman@booking.com>)
	id 1WHqxa-000F1K-IL
	for git@vger.kernel.org; Mon, 24 Feb 2014 09:32:22 +0100
Received: from [10.155.74.57] (port=52382)
	by corpds-202.lhr4.corp.booking.com with esmtpsa (TLSv1:DHE-RSA-AES128-SHA:128)
	(Exim 4.80.1)
	(envelope-from <omar.othman@booking.com>)
	id 1WHqxa-0005VB-DI
	for git@vger.kernel.org; Mon, 24 Feb 2014 09:32:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242580>

Hi there,

I'm fairly new to git and I wanted to ask about a certain behavior that 
I want to fix myself (if you agree with me that it is a misbehavior)... 
since I've never contributed to open source and it'll be an important 
step for me to start and get something done.

In general, whenever something a user "should" do, git always tells. So, 
for example, when things go wrong with a merge, you have the option to 
abort. When you are doing a rebase, git tells you to do git commit 
--amend, and then git rebase --continue... and so on.

The point is: Because of this, git is expected to always instruct you on 
what to do next in a multilevel operation, or instructing you what to do 
when an operation has gone wrong.

Now comes the problem. When you do a git stash pop, and a merge conflict 
happens, git correctly tells you to fix the problems and then git add to 
resolve the conflict. But once that happens, and the internal status of 
git tells you that there are no more problems (I have a prompt that 
tells me git's internal status), the operation is not culminated by 
dropping the stash reference, which what normally happens automatically 
after a git stash pop. This has actually confused me for a lot of time, 
till I ran into a git committer and asked him, and only then were I 100% 
confident that I did nothing wrong and it is indeed a UX problem. I 
wasted a lot of time to know why the operation is not completed as 
expected (since I trusted that git just does the right thing), and it 
turned out that it is git's fault.

If this is accepted, please reply to this email and tell me to start 
working on it. I've read the Documenation/SubmittingPatches guidelines, 
but I'll appreciate also telling me where to base my change. My guess is 
maint, since it's a "bug" in the sense of UX.

Thanks and sorry for the long email.
