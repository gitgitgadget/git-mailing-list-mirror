From: worley@alum.mit.edu (Dale R. Worley)
Subject: Re: Difficulty adding a symbolic link, part 3
Date: Thu, 1 Aug 2013 09:56:20 -0400
Message-ID: <201308011356.r71DuKUK007167@freeze.ariadne.com>
References: <201307312029.r6VKT4vC023100@hobgoblin.ariadne.com> <CACsJy8DZ11zFEgL_vZ-kG2tuwodU=vBJZqZxUPWtYh9u8o-_Tg@mail.gmail.com>
Cc: git@vger.kernel.org
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 01 16:05:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V4tTZ-0007fi-QA
	for gcvg-git-2@plane.gmane.org; Thu, 01 Aug 2013 16:03:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756121Ab3HAOD3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Aug 2013 10:03:29 -0400
Received: from qmta13.westchester.pa.mail.comcast.net ([76.96.59.243]:49455
	"EHLO qmta13.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755010Ab3HAOD2 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Aug 2013 10:03:28 -0400
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Thu, 01 Aug 2013 10:03:28 EDT
Received: from omta20.westchester.pa.mail.comcast.net ([76.96.62.71])
	by qmta13.westchester.pa.mail.comcast.net with comcast
	id 7PVc1m0021YDfWL5DRwMcs; Thu, 01 Aug 2013 13:56:21 +0000
Received: from freeze.ariadne.com ([24.34.72.61])
	by omta20.westchester.pa.mail.comcast.net with comcast
	id 7RwM1m0071KKtkw3gRwMEQ; Thu, 01 Aug 2013 13:56:21 +0000
Received: from freeze.ariadne.com (freeze.ariadne.com [127.0.0.1])
	by freeze.ariadne.com (8.14.5/8.14.5) with ESMTP id r71DuKob007168;
	Thu, 1 Aug 2013 09:56:20 -0400
Received: (from worley@localhost)
	by freeze.ariadne.com (8.14.5/8.14.5/Submit) id r71DuKUK007167;
	Thu, 1 Aug 2013 09:56:20 -0400
In-reply-to: <CACsJy8DZ11zFEgL_vZ-kG2tuwodU=vBJZqZxUPWtYh9u8o-_Tg@mail.gmail.com>
	(pclouds@gmail.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1375365381;
	bh=QMhpIFkfatCi1yvRTq+Ql0sWVNrPF7hLmvXrauxYvRY=;
	h=Received:Received:Received:Received:Date:Message-Id:From:To:
	 Subject;
	b=MYFoViShdPzTlaD87fONOxoiXCJwDd0t8a80zEgUuhzAAQkXDMSnir0yj8l1S9ITR
	 3ODmJikdpH4ROQ7+ddh8clxc29heRBZ7rCJ3TAg02YH0bMZPk2k3pOYIAftKj+6m+w
	 SqNK8ddqvXt5UzDVhNlHZvRNwHjP0Fv5MpnsFwonehF6BYjuiete71JJ9VnuvmqOYq
	 5Nyx23N7Bdd5IEpLuc7KIZzgMD4xP+BoVBVVFFCuWEdlkrGAZrl75/TrUvQM7qWo23
	 EzgYc59zEupyNe2iMoBOY8zG9zV8t8PXUtNA9gZE63McK0gjTrbY+CdRne1sgWWmgB
	 +NuDTt0aPDelw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231486>

> From: Duy Nguyen <pclouds@gmail.com>

> > With the above change, the test suite runs with zero failures, so it
> > doesn't affect any common Git usage.
> 
> It means the test suite is incomplete. As you can see, the commit
> introducing this change does not come with a test case to catch people
> changing this.

Who should be blamed for omitting the test?

> > Can someone give me advice on what this code *should* do?
> 
> It does as the function name says: given cwd, a prefix (i.e. a
> relative path with no ".." components) and a path relative to
> cwd+prefix, convert 'path' to something relative to cwd. In the
> simplest case, prepending the prefix to 'path' is enough. cwd is also
> get_git_work_tree().

But as you can see, the exact behavior that the function is intended
to exhibit regarding symlinks is not clear from the function name;
there should have been a real explanation in the comment above the
function.

Dale
