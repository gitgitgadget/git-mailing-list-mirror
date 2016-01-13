From: lists@haller-berlin.de (Stefan Haller)
Subject: Re: Adding a commit to the front of my branch?
Date: Wed, 13 Jan 2016 17:40:41 +0100
Message-ID: <1mgz4yx.94yt5g12q9hidM%lists@haller-berlin.de>
References: <CAHd499Adtc3qMgvXywONpgK0Z5NzGMnZ-=5akbLo+i6m2oJpYA@mail.gmail.com>
Cc: git@vger.kernel.org (Git)
To: rcdailey.lists@gmail.com (Robert Dailey)
X-From: git-owner@vger.kernel.org Wed Jan 13 17:40:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJOTc-0004i3-Iv
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jan 2016 17:40:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754437AbcAMQkn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2016 11:40:43 -0500
Received: from server90.greatnet.de ([178.254.50.90]:49334 "EHLO
	server90.greatnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754425AbcAMQkm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2016 11:40:42 -0500
Received: from [10.1.0.114] (nat1.ableton.net [217.110.199.117])
	by server90.greatnet.de (Postfix) with ESMTPA id 141CE60041;
	Wed, 13 Jan 2016 17:40:41 +0100 (CET)
In-Reply-To: <CAHd499Adtc3qMgvXywONpgK0Z5NzGMnZ-=5akbLo+i6m2oJpYA@mail.gmail.com>
User-Agent: MacSOUP/2.8.4 (Mac OS X version 10.11.2 (x86))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283929>

Robert Dailey <rcdailey.lists@gmail.com> wrote:

> On Mon, Jan 11, 2016 at 8:11 AM, Stefan Haller <lists@haller-berlin.de> wrote:
> > Robert Dailey <rcdailey.lists@gmail.com> wrote:
> >
> >> Normally to add commits on my branch, I perform an interactive rebase:
> >>
> >> $ git rebase -i origin/master
> >>
> >> I mark the commit I want to put the new commit on top of as 'edit'.
> >> However, if I want to add a commit to the front of my branch, I don't
> >> really have a commit to mark as "edit".
> >
> > Instead of marking commits as edit, I usually add "x false" at the place
> > where I want to add a commit. With this I find it easier to see where
> > the new commit goes, and it also works before the first commit.
> 
> What do you mean "x false"? I'm not familiar with this. Can you explain?

"x" is a shorthand for "exec" (just like "p" is a shorthand for "pick",
for instance). "exec" will execute an arbitrary shell command, and stop
when that shell command fails with an exit code not equal to zero.
"false" is a shell command that does nothing except return a non-zero
exit code, so "x false" just stops and waits for you to "fix" something.
At that point you can make additional commits, and then "git rebase
--continue" to go on.


-- 
Stefan Haller
Berlin, Germany
http://www.haller-berlin.de/
