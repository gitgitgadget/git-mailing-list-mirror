From: Len Brown <lenb@kernel.org>
Subject: Re: warning: no common commits - slow pull
Date: Sun, 10 Feb 2008 21:39:21 -0500
Organization: Intel Open Source Technology Center
Message-ID: <200802102139.21645.lenb@kernel.org>
References: <200802102007.38838.lenb@kernel.org> <20080211015342.GA26205@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Mon Feb 11 03:40:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOOas-0004w1-Qd
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 03:40:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751963AbYBKCj5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2008 21:39:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751946AbYBKCj5
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 21:39:57 -0500
Received: from hera.kernel.org ([140.211.167.34]:55627 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751941AbYBKCj4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2008 21:39:56 -0500
Received: from d975xbx2 (c-65-96-213-102.hsd1.ma.comcast.net [65.96.213.102])
	(authenticated bits=0)
	by hera.kernel.org (8.13.8/8.13.8) with ESMTP id m1B2dRIi013857
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 11 Feb 2008 02:39:28 GMT
User-Agent: KMail/1.9.5
In-Reply-To: <20080211015342.GA26205@mit.edu>
Content-Disposition: inline
X-Virus-Scanned: ClamAV version 0.88.7, clamav-milter version 0.88.7 on hera.kernel.org
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.0 required=5.0 tests=AWL,BAYES_00,RCVD_IN_PBL,
	RCVD_IN_SORBS_DUL,RDNS_DYNAMIC autolearn=no version=3.2.3
X-Spam-Checker-Version: SpamAssassin 3.2.3 (2007-08-08) on hera.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73460>

On Sunday 10 February 2008 20:53, Theodore Tso wrote:
> On Sun, Feb 10, 2008 at 08:07:38PM -0500, Len Brown wrote:
> > A couple of hours ago I pulled my reference copy of Linux tree,
> > which brought the tip here:
> > 
> > commit 7cf712db6087342e5e7e259d3883a7b5ac3212d1
> > Merge: 58a14ee... 30ddb15...
> > Author: Linus Torvalds <torvalds@woody.linux-foundation.org>
> > Date:   Sun Feb 10 12:03:57 2008 -0800
> > 
> >     Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-2.6
> > 
> > Then, 10 minutes ago I did a pull to bring the head here:
> > 
> > commit 19af35546de68c872dcb687613e0902a602cb20e
> > Author: Linus Torvalds <torvalds@woody.linux-foundation.org>
> > Date:   Sun Feb 10 14:18:14 2008 -0800
> > 
> >     Linux 2.6.25-rc1
> > 
> > But this second pull seems to have re-downloaded 172MB,
> > when it should have only needed the last few commits.
> 
> Yeah, I have this problem very often when I push to the ext4 tree on
> master.kernel.org.  Apparently the push/pull logic isn't smart about
> objects are found via objects/info/alterntaes, so it will needlessly
> transfer objects that it doesn't need to.
> 
> What I do to deal with this problem is I'll manually log into
> master.kernel.org, and then use the command "git-update-ref
> refs/heads/origin 19af35546de68c872dcb687613e0902a602cb20e", and then
> go back and do the push/pull.  Once there is a head which points to the
> latest from Linus, then the push/pull logic is smart and will only
> download the few commitments that aren't in the local git repository
> and aren't found in a shared repository.
> 
> Annoying, but as long as you have shell access on the machine with the
> destination repository, you can work around it.

yeah, I think I have see this with pushes onto kernel.org also,
but unlike Ted, I simply wait.

-Len
