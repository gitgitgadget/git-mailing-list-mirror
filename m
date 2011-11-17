From: Daniel Malone <dtp.malone@gmail.com>
Subject: squashed commit messages handled different w/ and w/o conflicts
Date: Thu, 17 Nov 2011 21:31:47 +0100
Message-ID: <CAOqtwH4vqQu=E9e5FLP0zFMa6jsDGt8rgojF489C11svY+g+bw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 17 21:31:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RR8co-0001TE-Lh
	for gcvg-git-2@lo.gmane.org; Thu, 17 Nov 2011 21:31:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756087Ab1KQUbu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Nov 2011 15:31:50 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:49495 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754920Ab1KQUbs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Nov 2011 15:31:48 -0500
Received: by ywt32 with SMTP id 32so1582174ywt.19
        for <git@vger.kernel.org>; Thu, 17 Nov 2011 12:31:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=I+c5rP/b8frNTaXQPj0mdyhZ9qGg+nFdzIqg1qNSVZk=;
        b=EwUWsetXu7ya/0VEr7Iqp5JgZrXexkSwfiOBukDqE0TD/SL/nG6yDzWmNqMyIZsZ9a
         /uzLoGBhaih1WmGvNg66sJkBciMlIwNwMtyg9MFb/YNvTcvBKOPGNmjdG4hvsUVvjTQE
         zFAmbsJKrZNvNXaaN+qdYZHzauj00Sr20smgw=
Received: by 10.224.116.144 with SMTP id m16mr96570qaq.19.1321561907694; Thu,
 17 Nov 2011 12:31:47 -0800 (PST)
Received: by 10.229.170.12 with HTTP; Thu, 17 Nov 2011 12:31:47 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185607>

Hi,

I was merging in a branch today and saw a (for me) unclear behavior.
So, what I did was:

git checkout master
git merge --squash _MY_BRANCH_

At this point I had a conflict. After fixing it I wanted to commit my
current state.

git add _CONFLICTED_FILE_
git commit

What happens now is that the squashed commit logs are replaced with the
Conflict
    some/file/with/a/path
message.

Just to be sure I created a test repo and merged in a branch with the
--squash option. For this test I made sure no conflict would pop up.
After committing the merged state, as expected, every commit message
of the branch was set as the current commit message.

I was expecting the conflict message to be pushed to the front of the
squashed commit messages.

- Daniel
