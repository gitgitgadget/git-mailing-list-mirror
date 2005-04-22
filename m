From: Klaus Robert Suetterlin <robert@mpe.mpg.de>
Subject: (anal) Q: Are there any coding styles or development guidelines?
Date: Fri, 22 Apr 2005 17:58:45 +0200
Message-ID: <20050422155845.GC52771@xdt04.mpe-garching.mpg.de>
References: <87hdi5oet6.dancerj@netfort.gr.jp> <Pine.LNX.4.58.0504171039460.7211@ppc970.osdl.org> <20050418055824.42d621b8.froese@gmx.de> <Pine.LNX.4.58.0504211238150.2344@ppc970.osdl.org> <17000.43340.760901.175004@cargo.ozlabs.ibm.com> <Pine.LNX.4.58.0504220824480.2344@ppc970.osdl.org> <Pine.LNX.4.58.0504220838340.2344@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 22 17:58:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DP0X6-0008DI-MP
	for gcvg-git@gmane.org; Fri, 22 Apr 2005 17:57:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262042AbVDVQB3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Apr 2005 12:01:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262043AbVDVQAo
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Apr 2005 12:00:44 -0400
Received: from mpehp1.mpe-garching.mpg.de ([130.183.70.10]:37642 "EHLO
	mpehp1.mpe-garching.mpg.de") by vger.kernel.org with ESMTP
	id S262042AbVDVP6s (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2005 11:58:48 -0400
Received: from xdt04.mpe-garching.mpg.de (xdt04.mpe-garching.mpg.de [130.183.136.164])
	by mpehp1.mpe-garching.mpg.de (8.9.3 (PHNE_25183+JAGae58098)/8.9.3) with ESMTP id RAA20045;
	Fri, 22 Apr 2005 17:58:46 +0200 (METDST)
Received: (from krs@localhost)
	by xdt04.mpe-garching.mpg.de (8.13.3/8.13.1/Submit) id j3MFwjPK059805;
	Fri, 22 Apr 2005 17:58:45 +0200 (CEST)
	(envelope-from krs)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504220838340.2344@ppc970.osdl.org>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I'm currently doing a source audit of the git core components.
Mainly I want to check if I can spot some left over memory leaks.

Unfortunately ;) I didn't find any so far (after reading five files).

Still I did find quite a lot of stuff that lint would most likely
complain about.  Like not checking return values.  Should this be
fixed now or isn't it time to do the cleanup, yet?

I also found several literal copies of the same function including
function name, parameter list, etc.  Wouldn't it be better do clean
those up and put them in a utility.{c,h} file?  A similar problem
is the continous reimplementation of linked lists, dynamic memory,
smart strings / vectors, etc.  And then there are some stale files
(i.e. revision.*) that the Changelog already mentions as removed,
but which are still active in HEAD.

I am a little reluctant to do the work, as the code still changes
so fast I do not really know if code I fix will still be there
tomorrow.

Also I do not know if there is any notion of coding style published
somewhere.  I only noticed, that the code does not look like anything
I'd have written and seems to follow some general principle.

Kind regards,

--Robert Suetterlin (robert@mpe.mpg.de)
phone: (+49)89 / 30000-3546   fax: (+49)89 / 30000-3950
