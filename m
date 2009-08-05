From: Shaun Cutts <shaun@cuttshome.net>
Subject: git index: how does it work?
Date: Wed, 5 Aug 2009 16:21:38 +0000 (UTC)
Message-ID: <loom.20090805T160528-69@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 05 19:11:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYk1G-0005Xo-Uk
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 19:11:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934756AbZHERKF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 13:10:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934741AbZHERKE
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 13:10:04 -0400
Received: from main.gmane.org ([80.91.229.2]:52413 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934694AbZHERKD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2009 13:10:03 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1MYk02-0004PH-F8
	for git@vger.kernel.org; Wed, 05 Aug 2009 17:10:02 +0000
Received: from apn-95-40-13-37.dynamic.gprs.plus.pl ([95.40.13.37])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 05 Aug 2009 17:10:02 +0000
Received: from shaun by apn-95-40-13-37.dynamic.gprs.plus.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 05 Aug 2009 17:10:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 95.40.13.37 (Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.5; en-US; rv:1.9.0.13) Gecko/2009073021 Firefox/3.0.13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124924>

Hello,

I am wondering if someone could explain and/or point me to an explanation of how
the git index works.

For instance, suppose I have a tracked file: "foo.c"

1) [I modify "foo.c"]
2) git add foo.c
3) [modify again]
4) git commit -m "blah blah"

Since I don't include the "-a" switch, the version I added on step 2 is
committed. But how does the index keep track of these changes? Does the index
file actually contain the hunks of "foo.c" that have been modified? Or is there
a "temporary" blob created, which the index points to? 

In either case, is there some interface to access these hunks and/or get a
reference to the blob?

Thanks,

-- Shaun

PS I'm considering writing an extension to git where the "diff" understands the
semantics of certain types of files: hunks wouldn't just be textual blobs but
would try to represent a minimal change from one version to the next based on an
edit distance, so that, e.g. changing the location of a function would be
represented by a "move" edit, rather than two text changes.

I have been building a prototype as a wrapper around git, intervening to store
extra information, etc before passing commands on to git. Blobs, commits, etc
are nice abstractions I can leave as is, but the index seems sort of foggy to
me. Any advice appreciated!
