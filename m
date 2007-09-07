From: Russ Brown <pickscrape@gmail.com>
Subject: git-svn: Branching clarifications
Date: Fri, 07 Sep 2007 11:47:17 -0500
Message-ID: <46E18095.60501@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 07 18:47:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITgzU-0005kb-Mw
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 18:47:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757931AbXIGQr2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Sep 2007 12:47:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757939AbXIGQr2
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Sep 2007 12:47:28 -0400
Received: from an-out-0708.google.com ([209.85.132.243]:24018 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757914AbXIGQr1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2007 12:47:27 -0400
Received: by an-out-0708.google.com with SMTP id d31so87818and
        for <git@vger.kernel.org>; Fri, 07 Sep 2007 09:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        bh=VNLzlRdHqg7McgwLX3q+MpQdZt+BQ99CuX01uTeh6TE=;
        b=D6CzvJIURKVXa115qihqxdJjjCsh3qabxOb7THdau4FkFGgoWL2gRhV/FngdVYG+CkC0+A3PJF9iQr/xXC4fTOatwBiivSObDouSQNZ/Zr378woewwRbZBNGymOOabysag1TEJ+Rgk/Rc9P+d72sy7RraLOpJrADZQ5C0mQUs8c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=BLXFWcqN5OArBeEc/n8IhTMPG7rpyft61pkN6jx1WAhcPGfxzJSJmSedsY7x4bbdwUjFNdr+GPDIQeAAJJUoqv3gcXt+uDmN3jUO4UiVXdXxIR4b6V+zzDGp4ft8R5jNzN7ZnDJotZwZGkUk8GMjGW16VzJ6ShKURbsBbh1hDkk=
Received: by 10.100.134.2 with SMTP id h2mr2385267and.1189183645540;
        Fri, 07 Sep 2007 09:47:25 -0700 (PDT)
Received: from ?192.168.0.100? ( [71.252.150.112])
        by mx.google.com with ESMTPS id d24sm1454383and.2007.09.07.09.47.23
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 07 Sep 2007 09:47:24 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.6 (X11/20070807)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58050>

I have a few questions about how/when to use git branches when using
git-svn (I'm a tad confused...)

Say I've initialised and fetched a git repo involving trunk and one
branch (say branch1) from an svn repository.

If I do git branch -a, I see similar to the following:

* master
  branch1
  trunk

(branch1 and trunk are in red for me, which I figure means they're
remotely tracked or something like that?)

OK, so that's telling me that I currently have master checked out into
my working copy. My question is: where did master come from? Is it a
local branch of trunk?

Moving on, say I want to work on branch1. Can I simply issue git
checkout branch1? If I do so I get this:

$ git branch -a
* (no branch)
  master
  branch1
  trunk

Which is a bit scary. It seems my working copy is orphaned...

OK, so let's assume I'm supposed to create a local branch of each remote
branch I want to work on. So:

$ git branch local/branch1 branch1
$ git checkout local/branch1

$ git-branch -a
* local/branch1
  master
  branch1
  trunk

Am I supposed to have used --track when creating  this branch? What are
the implications for specifying or not specifying that flag when using
git-svn?

So I do some editing on this branch, commit and dcommit. The changes
appear as expected in the repo.

At this point if I checkout master, the contents look like
local/branch1, which isn't what I'd suspected (that it would be a branch
of trunk). What does master represent?

So I checkout local/trunk, and create a new file, commit and dcommit.
Umm, it's been committed to branch1 on the repo: not trunk,

So I figure I'm quite obviously doing something wrong here. Could
someone give me a hand and tell me what it is I'm getting wrong?

Thanks!

-- 

Russ
