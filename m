From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: git-svn commit count vs- revision count
Date: Mon, 27 Jul 2009 11:59:08 +0200
Message-ID: <4A6D7A6C.7020909@drmicha.warpmail.net>
References: <4A6D6916.2040509@e-tobi.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Tobi <listaccount@e-tobi.net>
X-From: git-owner@vger.kernel.org Mon Jul 27 11:59:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MVMzX-000231-QK
	for gcvg-git-2@gmane.org; Mon, 27 Jul 2009 11:59:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755953AbZG0J70 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jul 2009 05:59:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755926AbZG0J70
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Jul 2009 05:59:26 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:52600 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755916AbZG0J7Z (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Jul 2009 05:59:25 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 864963B0B12;
	Mon, 27 Jul 2009 05:59:24 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Mon, 27 Jul 2009 05:59:24 -0400
X-Sasl-enc: G1VrQ8w/WnTAKlCLJG5o2a2IwCq2pR0eCAD41fC8agF5 1248688758
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 49EAA998F;
	Mon, 27 Jul 2009 05:59:18 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.1pre) Gecko/20090718 Lightning/1.0pre Shredder/3.0b4pre
In-Reply-To: <4A6D6916.2040509@e-tobi.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124158>

Tobi venit, vidit, dixit 27.07.2009 10:45:
> Hi!
> 
> I've `git-svn clone`ed a pretty large repository, which took about 3 days
> even with with local access to the SVN repository. To check that
> everything went ok, I listed the root commits with `git fsck --root
> --full` and verfied, that these are indeed root commits with no branch point.
> 
> So far so good... what's puzzling me is, that `git rev-list --all | wc -l`
> says I have 40731 commits, but the SVN repository only has 21875 revisons.
> 
> Shouldn't these numbers be the same? The only explanation I have, is, that
> git-svn imported one or more branches or tags, where it failed to find the
> correct branch point in the history. Is there a way to figure out, if
> there went something wrong and possibly fix it?

With svn, it is possible to commit to (or create) several branches or
tags in one go (i.e. revision), whereas with git those would be
individual commits. For example, some people always create a commit and
a tag "pointing" to it in one go in svn (commit to trunk and tags/foo).
(The same is true for "svn style subprojects", i.e. subdirs used as
subprojects.)

If that has been used to a large extent then it may explain the
difference, although it is very large. Have you checked whether git-svn
produced the (number of) branches and tags that you expect?

Michael
