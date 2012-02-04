From: Zeki Mokhtarzada <zeki@webs.com>
Subject: Re: Git performance results on a large repository
Date: Sat, 4 Feb 2012 00:01:18 +0000 (UTC)
Message-ID: <loom.20120204T004543-798@post.gmane.org>
References: <CB5074CF.3AD7A%joshua.redstone@fb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 04 01:10:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtTDA-0004JQ-8F
	for gcvg-git-2@plane.gmane.org; Sat, 04 Feb 2012 01:10:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754084Ab2BDAKH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Feb 2012 19:10:07 -0500
Received: from plane.gmane.org ([80.91.229.3]:48408 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753130Ab2BDAKG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Feb 2012 19:10:06 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1RtTCc-000409-VL
	for git@vger.kernel.org; Sat, 04 Feb 2012 01:10:03 +0100
Received: from mail.fsainvest.com ([68.163.71.42])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 04 Feb 2012 01:10:02 +0100
Received: from zeki by mail.fsainvest.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 04 Feb 2012 01:10:02 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 68.167.196.92 (Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:9.0.1) Gecko/20100101 Firefox/9.0.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189833>

 
> The test repo has 4 million commits, linear history and about 1.3 million
> files.  The size of the .git directory is about 15GB, and has been
> repacked with 'git repack -a -d -f --max-pack-size=10g --depth=100
> --window=250'.  This repack took about 2 days on a beefy machine (I.e.,
> lots of ram and flash).  The size of the index file is 191 MB. I can share


Are you willing to give up all or part of your history in your working
repository?  I've heard of larger projects starting from scratch (i.e. copy all
of your files into a brand new repo.)  You can keep your old repo around for
archival purposes.  Also, how much of your repo is code, versus static assets. 
You could move all of your static assets (images, css, maybe some js?) into
another repo, and then merge the two repo's together at build time if you
absolutely need them deployed together.

Here are a couple strategies for doing a partial truncate:

http://stackoverflow.com/questions/4515580/how-do-i-remove-the-old-history-from-a-git-repository
http://bogdan.org.ua/2011/03/28/how-to-truncate-git-history-sample-script-included.html


-Zeki
