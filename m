From: Kendall Shaw <kshaw@kendallshaw.com>
Subject: Setting of push.default or confusion about refspecs
Date: Mon, 03 Jun 2013 15:01:41 -0700
Message-ID: <51AD1245.9050202@kendallshaw.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 04 00:02:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjcpE-0004SW-84
	for gcvg-git-2@plane.gmane.org; Tue, 04 Jun 2013 00:02:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758630Ab3FCWB5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Jun 2013 18:01:57 -0400
Received: from a.mail.sonic.net ([64.142.16.245]:33576 "EHLO a.mail.sonic.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758711Ab3FCWBz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jun 2013 18:01:55 -0400
Received: from nekobasu.localdomain (c-67-161-38-155.hsd1.ca.comcast.net [67.161.38.155])
	(authenticated bits=0)
	by a.mail.sonic.net (8.13.8.Beta0-Sonic/8.13.7) with ESMTP id r53M1gv5002448
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Mon, 3 Jun 2013 15:01:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130311 Thunderbird/17.0.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226298>

I am setting up a git repository which I cloned using git svn. git 
ls-remote shows something like:

...
refs/remotes/trunk
refs/remotes/2.0.2a
...

To get the subversion branch names to appear as a local branch, I:

git remote add blah http://example.com/blah
git fetch blah +refs/remotes/*:refs/heads/*

I have made changes now that are okay to be in master in my local 
repository and I want to push them to the remote repository. The current 
branch is master.

git push

complains that push.default is not set. Now, I am confused by the 
documentation.

push.default settings refer to either "the upstream branch" or a branch 
with "the same name".

What is "the same name"? Are these the same name:

master
refs/remotes/origin/master

also, after the fetch above, are these the same name:

refs/heads/something
refs/remotes/something

Regarding the upstream branch, I have in .git/config

[remote "origin"]
url = http://example.com/blah
fetch = +refs/heads/*:refs/remotes/origin/*

[branch "master"]
remote = origin
merge = refs/heads/master

git config -l shows

branch.master.remote=origin
branch.master.merge=refs/heads/master

When in branch master, is the upstream branch refs/heads/master?

Then, I think I can get push to push to refs/remotes/origin/master by 
setting push.default to upstream, is that right?

In case "master" is not the same name as "refs/remotes/origin/master", 
can you give me an example of branches with the same name that push 
would push to when push.default is set to simple?

Kendall
