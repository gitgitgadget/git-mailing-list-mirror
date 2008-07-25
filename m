From: James Pickens <jepicken@gmail.com>
Subject: Re: sparse fetch, was Re: [PATCH 08/12] git-clone: support =?utf-8?b?LS1wYXRoCXRv?= do sparse clone
Date: Fri, 25 Jul 2008 00:46:52 +0000 (UTC)
Message-ID: <loom.20080725T004541-298@post.gmane.org>
References: <20080723145718.GA29134@laptop> <20080724171952.GB21043@sigill.intra.peff.net> <alpine.DEB.1.00.0807241837441.8986@racer> <20080724182813.GA21186@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 25 02:48:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMBTa-0004ve-7g
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 02:48:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753166AbYGYArG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2008 20:47:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753120AbYGYArF
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 20:47:05 -0400
Received: from main.gmane.org ([80.91.229.2]:42896 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753000AbYGYArE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2008 20:47:04 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KMBSV-0005RE-Ry
	for git@vger.kernel.org; Fri, 25 Jul 2008 00:47:00 +0000
Received: from fmfwpr08.fm.intel.com ([192.55.52.7])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 25 Jul 2008 00:46:59 +0000
Received: from jepicken by fmfwpr08.fm.intel.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 25 Jul 2008 00:46:59 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 192.55.52.7 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.0.1) Gecko/2008070208 Firefox/3.0.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89984>

Jeff King <peff <at> peff.net> writes:

> I agree there are a lot of issues. I am just thinking of the person who
> said they had a >100G repository. But I am also not volunteering to do
> it, so I will let somebody who really cares about it try to defend the
> idea.

If you're referring to me (I mentioned a 144G CVS repo), then let me
clarify a couple of things:

1.  Probably more than 50% of the 144G is crud that should never have
been checked in, but I have some undisciplined coworkers who like to
blindly check in everything in their work trees.  If/when we moved to
git, I would get rid of all that crud.  I'm also thinking about throwing
out a lot of the history, since those same undisciplined coworkers like
to use empty and/or useless log messages, so a lot of the history isn't
very valuable anyways.

2.  Git of course will store the remaining ~70G much more efficiently
than CVS.  I think git will be especially better than CVS for this repo,
because it contains many instances of the same file(s) being checked in
in multiple directories.

I expect the git repo size to be less than 7G.  In addition, all our
work is done on site on nfs, so we can use clone -s to avoid copying the
whole 7G.

To sum it up, sparse cloning would not be important to me.

James
