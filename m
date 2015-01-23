From: Prem Muthedath <prem.muthedath@gmail.com>
Subject: git push --repo option not working as described in git manual.
Date: Fri, 23 Jan 2015 18:54:03 +0530
Message-ID: <CAHQ-GLAwo5QbM4mUQeUjU39o29F0JK7gK-Q-oHK4Jai=gy5Otg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 23 14:24:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEeDa-0002j5-1P
	for gcvg-git-2@plane.gmane.org; Fri, 23 Jan 2015 14:24:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753026AbbAWNYF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2015 08:24:05 -0500
Received: from mail-qg0-f52.google.com ([209.85.192.52]:59876 "EHLO
	mail-qg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750912AbbAWNYE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2015 08:24:04 -0500
Received: by mail-qg0-f52.google.com with SMTP id z107so5914977qgd.11
        for <git@vger.kernel.org>; Fri, 23 Jan 2015 05:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=0dnJbHj0pKsr9P9VUt1Im59Osnp63M6y5oBbptuZYIA=;
        b=poDivac3fCLVHnL45zExlbIPHijEJ6Tsn1L8Hx3GQzg6HX9IHvWZT4jQovS50SO6pW
         I5gnqMr4pdwihoqE4Nd9jSETZcZPYnCRRbzWFkdLZr4GHvpTrWE9V1f30Anmmq0i73VN
         OfPchT5or1KJ1uVceCvnxtZvbKu2T5P4jaS5bL2g81gW/S+20gmxH+2U3PKi7A7/vlUA
         bvZhhB8qLlZW6xsFOZFP/GIigVmy2HumQ2OKarJmm/e4QXuvaaWzC769qYRrwT5AkNbj
         tgLjfuhj8FlxYST3nIDa4t73S2fkaMR/0pNKdQg/5wuHkzy5l9bzPtbCTQT5SvHod3T2
         oihg==
X-Received: by 10.224.135.138 with SMTP id n10mr11609460qat.45.1422019443531;
 Fri, 23 Jan 2015 05:24:03 -0800 (PST)
Received: by 10.96.136.132 with HTTP; Fri, 23 Jan 2015 05:24:03 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262920>

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
branch is tracking "blah/master".


Here is another test case (push default setting is simple, git version
2.2.2, Mac OS X 10.10.1):
1. I have a local branch "whoa".
2. "whoa" tracks remote branch "origin/whoa".  Here "origin" is the
remote repository.
3. While I am on my local whoa branch, I run git push --repo=blah
4. git pushes the local whoa branch to blah repository.
5. But per git manual, it shouldn't push to blah, as the local branch
is tracking "origin/whoa".


Appreciate your help.
Prem
