From: Prem <prem.muthedath@gmail.com>
Subject: git push --repo option not working as described in git manual.
Date: Mon, 26 Jan 2015 08:21:50 +0000 (UTC)
Message-ID: <loom.20150126T091917-791@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 26 09:25:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YFeyv-0007TZ-L8
	for gcvg-git-2@plane.gmane.org; Mon, 26 Jan 2015 09:25:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752288AbbAZIZJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2015 03:25:09 -0500
Received: from plane.gmane.org ([80.91.229.3]:39978 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751517AbbAZIZI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jan 2015 03:25:08 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1YFeym-0007LU-5m
	for git@vger.kernel.org; Mon, 26 Jan 2015 09:25:04 +0100
Received: from yash-static-187.233.21.103.yashtel.co.in ([yash-static-187.233.21.103.yashtel.co.in])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 26 Jan 2015 09:25:04 +0100
Received: from prem.muthedath by yash-static-187.233.21.103.yashtel.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 26 Jan 2015 09:25:04 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 103.21.233.187 (Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_1) AppleWebKit/600.2.5 (KHTML, like Gecko) Version/8.0.2 Safari/600.2.5)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263028>

I am using git 2.2.2 and want to report an issue with git push --repo option.

git 2.2.2 manual says that git push --repo=public will push to public
only if the current branch does not track a remote branch.  See
http://git-scm.com/docs/git-push

However, I see that git pushes even when the current branch is
tracking a remote branch.

Here is the test case (push default setting is simple, git version
2.2.2, Mac OS X 10.10.1):
1. I have a local branch "master".
2. "master" tracks remote branch "blah/master".  Here "blah" is the
remote repository.
3. While I am on my local master branch, I run git push --repo=silver
4. git pushes the local master branch to silver repository.
5. But per git manual, it shouldn't push to silver, as the local
branch is tracking "blah/master". So is this broken or am I missing something?


Here is another test case (push default setting is simple, git version
2.2.2, Mac OS X 10.10.1):
1. I have a local branch "whoa".
2. "whoa" tracks remote branch "origin/whoa".  Here "origin" is the
remote repository.
3. While I am on my local whoa branch, I run git push --repo=blah
4. git pushes the local whoa branch to blah repository.
5. But per git manual, it shouldn't push to blah, as the local branch
is tracking "origin/whoa".  So is this broken or am I missing something?


Appreciate your help.
