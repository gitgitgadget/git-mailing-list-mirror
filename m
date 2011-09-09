From: Andreas Krey <a.krey@gmx.de>
Subject: Re: git repository size / compression
Date: Fri, 9 Sep 2011 19:49:37 +0200
Message-ID: <20110909174937.GA6057@inner.h.iocl.org>
References: <CALFxCvzVjC+u=RDkDCQp0QqPETsv8ROE8tY=37tmMWxmQoJOEw@mail.gmail.com> <1315556595.2019.11.camel@bee.lab.cmartin.tk> <CAEBDL5U5-1nBGbWtb6+CfBrESoy8+p0Qqw1t1n_5EKFmpq9NhA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Carlos =?iso-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>,
	neubyr <neubyr@gmail.com>, git@vger.kernel.org
To: John Szakmeister <john@szakmeister.net>
X-From: git-owner@vger.kernel.org Fri Sep 09 19:50:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R25DE-00045g-4A
	for gcvg-git-2@lo.gmane.org; Fri, 09 Sep 2011 19:50:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759590Ab1IIRtz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Sep 2011 13:49:55 -0400
Received: from continuum.iocl.org ([217.140.74.2]:56950 "EHLO
	continuum.iocl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758672Ab1IIRtz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Sep 2011 13:49:55 -0400
Received: (from krey@localhost)
	by continuum.iocl.org (8.11.3/8.9.3) id p89HncV06452;
	Fri, 9 Sep 2011 19:49:38 +0200
Content-Disposition: inline
In-Reply-To: <CAEBDL5U5-1nBGbWtb6+CfBrESoy8+p0Qqw1t1n_5EKFmpq9NhA@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
X-message-flag: What did you expect to see here?
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181098>

On Fri, 09 Sep 2011 12:05:03 +0000, John Szakmeister wrote:
...
> will at times choose to self-compress the file, instead of doing a
> delta and compressing.  IIRC, there is some heuristics in there for
> determining when to do that, but I forget the exact method.

Don't know about the compression part, but subversion does a delta of the nth
version of a file (not the global revision number n) against the version m, where
m is (n & (n-1)), or the least significant '1' bit flipped to '0'. That way, there
are only O(log(n)) instead of O(n) deltas to apply to get at a specific version.

[Was on the svn users list just then. They described it differently,
 but in essence it's that.]

Andreas

-- 
"Totally trivial. Famous last words."
From: Linus Torvalds <torvalds@*.org>
Date: Fri, 22 Jan 2010 07:29:21 -0800
