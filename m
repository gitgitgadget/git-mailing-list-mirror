From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Git without morning coffee
Date: Wed, 07 Sep 2011 09:48:51 +0200
Message-ID: <4E6721E3.7000207@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 07 18:07:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1Kf9-0002Nb-Ns
	for gcvg-git-2@lo.gmane.org; Wed, 07 Sep 2011 18:07:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756161Ab1IGQHa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Sep 2011 12:07:30 -0400
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:36153 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756137Ab1IGQHP (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Sep 2011 12:07:15 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 4447C298E6
	for <git@vger.kernel.org>; Wed,  7 Sep 2011 03:48:54 -0400 (EDT)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute3.internal (MEProxy); Wed, 07 Sep 2011 03:48:54 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to
	:subject:content-type:content-transfer-encoding; s=smtpout; bh=J
	oD30I3Rv7rZIIXgDjzhw7HXJPM=; b=IMXv+OM/t70wzxv59nRQ5MkxjQA/brOvs
	t4G+wOHURCe1swO9zu+z45OsnHFfkZCBdTK4HdHjI40MlYLutfdVe3FBXyFJVpOl
	A6gx8bqEKhhveZblP1nx0SfACPNM0wZKZh4s2czCcL+aqdwhwkUWIP97RQNNVZbK
	wHAtFOonRA=
X-Sasl-enc: Nsl24C/8o7tx5jaW+BF1qgC5EuluFNHlT9967rPhrE4k 1315381733
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id D7B0878000B
	for <git@vger.kernel.org>; Wed,  7 Sep 2011 03:48:53 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:6.0) Gecko/20110816 Thunderbird/6.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180858>

Is this my lack of morning coffee, or git's:

git rev-parse origin/next origin/pu
7931f38a2fd882b0f75a4d6f0eb60c3b1b094178
edf014b39ded8ee8a67f2a0cd8d7926b33f3d578
# OK

git checkout origin/next
HEAD is now at 7931f38... Merge branch 'master' into next
# OK

git log --oneline --no-walk ":/Merge branch 'jk/generation-numbers' into pu"
0ac76f9 Merge branch 'jk/generation-numbers' into pu
# Sure it is.

git merge ":/Merge branch 'jk/generation-numbers' into pu"
fatal: ':/Merge branch 'jk/generation-numbers' into pu' does not point
to a commit
# Huh?

git rev-parse ":/Merge branch 'jk/generation-numbers' into pu"
0ac76f96a94a46bce7ec9dcc6c67abcf9d36adac
# It does point to a commit!

git merge $(git rev-parse ":/Merge branch 'jk/generation-numbers' into pu")
error: addinfo_cache failed for path 't/t7810-grep.sh'
Performing inexact rename detection: 100% (91476/91476), done.
error: addinfo_cache failed for path 't/t7810-grep.sh'
error: addinfo_cache failed for path 'gitweb/static/gitweb.js'
error: addinfo_cache failed for path 'gitweb/static/gitweb.css'

## hundreds more

error: addinfo_cache failed for path 't/t7810-grep.sh'
error: addinfo_cache failed for path 'gitweb/static/js/blame_incremental.js'
Auto-merging cache.h
Merge made by the 'recursive' strategy.


Double Huh? Finally, the merge succeeds, despite thy myriad of errors.

I mean, I'm merging a commit from origin/pu to origin/next when the
latter is basically contained in the former (except for some merge
commits). And what are these addinfo_cache errors?

git --version
git version 1.7.7.rc0.328.g9d6c7

which is last week's next with a few additions which I've been carrying
along for weeks. Stumped.

Michael
