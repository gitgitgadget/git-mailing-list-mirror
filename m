From: Patrick Doyle <wpdster@gmail.com>
Subject: How to do a fast-forward merge without a checkout?
Date: Mon, 18 Jul 2011 10:18:58 -0400
Message-ID: <CAF_dkJCvtVqoDmRXMy23ZnZL6iUAVX0nNA9Ev6e4zvBp9mfTpg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 18 16:19:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QiofN-00028Q-RO
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jul 2011 16:19:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752353Ab1GROTT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jul 2011 10:19:19 -0400
Received: from mail-fx0-f52.google.com ([209.85.161.52]:37311 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751298Ab1GROTT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2011 10:19:19 -0400
Received: by fxd18 with SMTP id 18so6760059fxd.11
        for <git@vger.kernel.org>; Mon, 18 Jul 2011 07:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=PkLfdCSAyeIa8S5xtN5LG0h7ZvHk0P2Dy4cv+odbW5o=;
        b=Y1dbcnxbqVsWd2gimv4reNHL5hxlclZWCexTXnS2uNz88zwcfYK5r/dj5pYw3J3Z8m
         AljxRaPSuZRPNfX3CJ/YUlV267rrpVaS6ZVgmvQ43OJfzOfw7CUyIVNBGIGVO5A7AqbZ
         WddyiliP7O/ER+KTQWeqBi+x2/f3hnxqwtQvc=
Received: by 10.223.51.67 with SMTP id c3mr10017349fag.132.1310998758206; Mon,
 18 Jul 2011 07:19:18 -0700 (PDT)
Received: by 10.223.144.203 with HTTP; Mon, 18 Jul 2011 07:18:58 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177373>

Huh?  What does he mean by that?

I have the following in my .git/config file:

[remote "origin"]
	fetch = +refs/heads/*:refs/remotes/origin/*
	url = somehost:path/to/repo
[branch "master"]
	remote = origin
	merge = refs/heads/master
[branch "wpd"]
	remote = origin
	merge = refs/heads/wpd

I have been working on my "wpd" branch on a couple of different
machines and have been happily committing, pushing, and pulling from
my "origin" host.  Recently, however, somebody committed a change on
the "master" branch.  Now, when I do a "git push", I get the following

$ git push
Counting objects: 11, done.
Delta compression using up to 2 threads.
Compressing objects: 100% (6/6), done.
Writing objects: 100% (6/6), 715 bytes, done.
Total 6 (delta 4), reused 0 (delta 0)
To somehost:path/to/repo
   e1004df..bad8767  wpd -> wpd
 ! [rejected]        master -> master (non-fast-forward)
error: failed to push some refs to 'somehost:path/to/repo'
To prevent you from losing history, non-fast-forward updates were rejected
Merge the remote changes (e.g. 'git pull') before pushing again.  See the
'Note about fast-forwards' section of 'git push --help' for details.

The last time I encountered this, I did a "get checkout master; git
merge origin/master; git checkout wpd; git push" and that worked.  I
happen to know that master is a direct descendent of origin/master and
that, if I do this again, I will (once again) do a fast-forward merge
to bring master up to origin/master.

This may have been fixed in a more recent git (I'm using git 1.7.2.5
on a Debian 6 box and 1.7.4.1 on an RHEL 5 box).

There has got to be an easier way to fix this than checking out the
master branch, performing the fast-forward merge, and then switching
back to my working branch.

One way would be if there were some way to do a fast-forward merge on
a branch without actually checking out that branch.  Hence my
question.

Another way would be to remove the "master" branch from my config file.

Or perhaps I set up something wrong.

--wpd
