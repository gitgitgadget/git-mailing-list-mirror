From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: GIT_DIR=. for hooks?
Date: Wed, 06 Jan 2010 14:55:43 +0100
Message-ID: <4B44965F.8040803@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jan 06 14:58:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSWOX-0000wJ-Vb
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jan 2010 14:57:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755732Ab0AFN5U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jan 2010 08:57:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755683Ab0AFN5U
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jan 2010 08:57:20 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:41606 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755629Ab0AFN5T (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Jan 2010 08:57:19 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 822C4C9A25
	for <git@vger.kernel.org>; Wed,  6 Jan 2010 08:57:18 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Wed, 06 Jan 2010 08:57:18 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:subject:content-type:content-transfer-encoding; s=smtpout; bh=yTenqmN6wtyb/Sb+G8c2pfaQ7Qo=; b=PQbWMruHBa6uKCSUBdPAgNc0J6fIilYh+vEKq6KpPGs8/S2qxo5jHzLk++s915WrFFVdgSo0+CGOXQJR8Pjqd9bY4pB7Nff7kjGxfzjy+vYpnU1ZZeEj6vP6blvR+1A1iYeiqF3Y9qoMVNLx3ofbmd4rdBRrNmhxaBjJE4tSO9c=
X-Sasl-enc: m2hBsS8G0RT8izvD8rfIwEzNoIrnr3OWxazWReXfunc5 1262786238
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 1464E4ED3
	for <git@vger.kernel.org>; Wed,  6 Jan 2010 08:57:17 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.7pre) Gecko/20091209 Lightning/1.0b2pre Shredder/3.0.1pre
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136267>

Hi there,

as it seems hooks (at least post-receive) are called with a $PWD in the
.git dir and GIT_DIR=. exported.

Now, that leads to problems when, say, diffing between the index and the
worktree ("Don't do that!", I know). Without cd'ing around, the worktree
is not found, and after "cd ..", the git-dir is not found.

I can unset GIT_DIR or set WORK_TREE, of course, but I'm wondering
whether GIT_DIR=. is a sane setting at all: a git-dir in $PWD is always
found, and when cd'ing away that setting does not help either.

Michael
