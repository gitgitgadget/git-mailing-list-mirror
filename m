From: worley@alum.mit.edu (Dale R. Worley)
Subject: the pager
Date: Mon, 26 Aug 2013 15:57:41 -0400
Message-ID: <201308261957.r7QJvfjF028935@freeze.ariadne.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 26 21:57:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VE2vA-0002JJ-Cm
	for gcvg-git-2@plane.gmane.org; Mon, 26 Aug 2013 21:57:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752303Ab3HZT5p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Aug 2013 15:57:45 -0400
Received: from qmta15.westchester.pa.mail.comcast.net ([76.96.59.228]:44351
	"EHLO qmta15.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752290Ab3HZT5o (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Aug 2013 15:57:44 -0400
Received: from omta17.westchester.pa.mail.comcast.net ([76.96.62.89])
	by qmta15.westchester.pa.mail.comcast.net with comcast
	id HPds1m0071vXlb85FXxjVJ; Mon, 26 Aug 2013 19:57:43 +0000
Received: from freeze.ariadne.com ([24.34.72.61])
	by omta17.westchester.pa.mail.comcast.net with comcast
	id HXxi1m00y1KKtkw3dXxiTv; Mon, 26 Aug 2013 19:57:43 +0000
Received: from freeze.ariadne.com (freeze.ariadne.com [127.0.0.1])
	by freeze.ariadne.com (8.14.5/8.14.5) with ESMTP id r7QJvfRN028936;
	Mon, 26 Aug 2013 15:57:42 -0400
Received: (from worley@localhost)
	by freeze.ariadne.com (8.14.5/8.14.5/Submit) id r7QJvfjF028935;
	Mon, 26 Aug 2013 15:57:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1377547063;
	bh=Z1NNwBXnisUh3DRPBPTnlYQEvrpac4YUoSl6TtwJYws=;
	h=Received:Received:Received:Received:Date:Message-Id:From:To:
	 Subject;
	b=WGecxW93qT2Tpr8EijILQPr/iEre28r40WNe1CgLf36NEdzPAyVNTGLbOhzDWCHAC
	 mGiQtNY8r63EYw1VZd9ZKXPFTi+AnQucD3UMpVRviOtk4BtkV2Ddl6rAczZLDiSk1t
	 kX8VaeN8RO844o2KH9o2SqjBIdHT7cqQLzNW3EjJvK/LOk3ycDuQMXYAiiVzzOJYT0
	 j+bGsVgeIyZES5kG/Nh/JZnqOKd1DtPRQLgG6QsRGRB3pfrQlvN01G+YiuH/My4i5m
	 VAdYhDkgxZoHaZYqJjBKjnajuUG3BTbCws54y/bRoyFNH4CwDdD1GfT5l/NFD7JDG0
	 VScKxfaft8cQw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233019>

I've noticed that Git by default puts long output through "less" as a
pager.  I don't like that, but this is not the time to change
established behavior.  But while tracking that down, I noticed that
the paging behavior is controlled by at least 5 things:

the -p/--paginate/--no-pager options
the GIT_PAGER environment variable
the PAGER environment variable
the core.pager Git configuration variable
the build-in default (which seems to usually be "less")

There is documentation in git.1 and git-config.1, and the two are not
coordinated to make it clear what happens in all cases.  And the
built-in default is not mentioned at all.

What is the (intended) order of precedence of specifiers of paging
behavior?  My guess is that it should be the order I've given above.

Dale
