From: Scott Chacon <schacon@gmail.com>
Subject: EasyGit Integration
Date: Tue, 9 Jun 2009 11:59:08 -0700
Message-ID: <d411cc4a0906091159r51e7d16t4d66c6225322fb60@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 09 20:59:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ME6XX-0000Z7-CY
	for gcvg-git-2@gmane.org; Tue, 09 Jun 2009 20:59:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752720AbZFIS7L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2009 14:59:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751847AbZFIS7I
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jun 2009 14:59:08 -0400
Received: from an-out-0708.google.com ([209.85.132.242]:52811 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751042AbZFIS7I (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jun 2009 14:59:08 -0400
Received: by an-out-0708.google.com with SMTP id d40so233108and.1
        for <git@vger.kernel.org>; Tue, 09 Jun 2009 11:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=69LGDntOiClKbzKp1I/ZqDdv4Ppdmg+vQy52lEHJ1hI=;
        b=X+0Or2rmvxOa7YLhXVLCJBqrj0OU3/JZpCboxtU3qBgmWVKf2GDjvPHIzptYtZHFjw
         lShmGylRIp/KxeWLBpawjqEz0BibPL0SFTqiHghaUi5+mJ7Br4L5NhI0FGCvZ9/FlGaJ
         sBVUSy4KYZMcEnWP6+oIR/fklLlEK5BRhR2pc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=p08pZHSxlTuM1sCCH0iD+U8CgTdJpHBHTVJAXKchJGx9FimAkTkCOH5OQIvLVhIce6
         Q8QeyNC+9PA1cnO3GKP8BSlSIhEGopxDOpsU6gyK+hS/p3dr+5aY1rQJOLSneybJ1sIY
         kMU0GMrgx8TMT3Xg+3C74a6csYeLwX9al/A5Q=
Received: by 10.100.227.18 with SMTP id z18mr446374ang.67.1244573949393; Tue, 
	09 Jun 2009 11:59:09 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121206>

Hey all,

I have been playing with the EasyGit project lately and I have been
really impressed.  I looked back to the last announcement here and the
conversation didn't really go anywhere, sadly.  I thought it might be
nice to adopt or at least consider a number of the design decisions
they made in modifying the defaults and commands available.  Perhaps
as a 1.7 goal or something?  I like it because it addresses a lot of
the issues that I hear from beginning users:

* breaks the various things that 'checkout' does into separate
commands - moves 'revert' to doing what 'checkout -- path' does, moves
current 'revert' to 'cherry-pick --revert' (which someone mentioned
was a good idea at the last GitTogether), and adds 'unstage' for
'reset HEAD file'.  also adds a '-s' option to 'branch' to switch to
the branch after you create it, which many people expect rather than
'checkout -b'.

* adds 'git resolved' for 'git add', which I hear all the time as
being confusing

* adds 'git publish' for creating a bare repo from your current repo
and scp/rsync-ing it to a server (which is nice if you're not using
GitHub/repo.or.cz where remote repo seeding is easier)

* adds 'git info' which shows a bunch of basic information about the
repo, which is actually pretty cool

* more verbose and easily scannable default help output - groups the
commands into categories, etc.

Some other things that might be nice:

* 'git backout' for 'git reset HEAD^'

* 'git push origin --delete <branch>' for 'git push origin :branch'

These things may seem pretty simple and even sort of stupid if you're
used to Git as we are - most of them you can just setup an alias
pretty easily, but you would be amazed at how many people go nuts
because of this stuff.  If these simple things were in as defaults,
sooo many of the remaining 'git is hard and obtuse' arguments would
become obsolete.  'checkout', 'add' and 'reset' seem to be where
people have the most difficulty, due to their overloading.

Does this resonate with anyone else?  Does 1.7 seem like a good goal
for amending some of these things?  Completely redefining 'revert'
seems like the only backward incompatible change - everything else is
just wrappers and whatnot, I think.

Thanks,
Scott
