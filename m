From: Brendan Miller <catphive@catphive.net>
Subject: obnoxious CLI complaints
Date: Wed, 9 Sep 2009 14:27:56 -0700
Message-ID: <ef38762f0909091427m5b8f3am72c88fd4dbfebc59@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 09 23:28:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MlUhx-0006Mq-IB
	for gcvg-git-2@lo.gmane.org; Wed, 09 Sep 2009 23:28:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754251AbZIIV1y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Sep 2009 17:27:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753830AbZIIV1y
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Sep 2009 17:27:54 -0400
Received: from mail-qy0-f181.google.com ([209.85.221.181]:40267 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753816AbZIIV1y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Sep 2009 17:27:54 -0400
Received: by qyk11 with SMTP id 11so4191180qyk.1
        for <git@vger.kernel.org>; Wed, 09 Sep 2009 14:27:57 -0700 (PDT)
Received: by 10.229.93.41 with SMTP id t41mr560394qcm.81.1252531676887; Wed, 
	09 Sep 2009 14:27:56 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128083>

Here are a bunch of really basic usability issues I have with git:

1. cloning from a new empty repo fails, and so do a lot of other
operations. This adds unnecessary steps to setting up a new shared
repo.

2. git --bare init. The flag goes before the operation unlike every other flag?

3. It's not obvious whether operations work on the working
directory/the "index"/the repository
e.g. get reset --soft, --mixed, --hard. git diff --cached

4. The index is inconsistently referred to as too many different
things (cache, index, staging area) and only the last one makes any
intuitive sense to a new user. This is partially a CLI issue, and
partially a documentation issue, but both add up to cause confusion.

5. Most commands require lots of flags, and don't have reasonable
defaults. e.g. archive.

git archive --format=tar --prefix=myproject/ HEAD | gzip >myproject.tar.gz

Should just be:
git archive
run from the root of the repo.

This is what I want to do 90% of the time, so it should just have the
proper defaults, and not make me look at the man page every time I
want to use it.

6. Where is the bug tracker? If people users can't find the bug
tracker, they can't report issues, and obnoxious bugs go unfixed, or
people have to whine on the mailing list. There should be a nice big
link on the front page of git-scm.com. A bug tracker is really the
only way for the vast majority of a community that use a tool can give
feedback on the problems the tool has.

7. Man pages: It's nice we have them, but we shouldn't need them to do
basic stuff. I rarely had to look at the man pages using svn, but
every single time I use git I have to dig into these things. Frankly,
I have better things to do than RTFM.

8. There's no obvious way to make a remote your default push pull
location without editing the git config file. Why not just something
like

git remote setdefault origin

or even

git remote add --default origin http://somegiturl.org/

This come up in the use case where I:
1. set up a remote bare repo
2. push from my local repo, and thence forth want to keep local and
remote in sink.

Right now I have to modify .git/config to do this.

It's ok to have kind of a weak UI on a new tool, when people are busy
adding basic functionality. However, at this point git already has way
more features than most of the competition, and the needless
complexity of the CLI is the biggest issue in day to day use.

Brendan
