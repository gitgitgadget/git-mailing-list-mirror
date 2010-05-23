From: Jeff King <peff@peff.net>
Subject: Re: Possible bug with argument parsing in git blame
Date: Sun, 23 May 2010 04:00:02 -0400
Message-ID: <20100523080002.GB24598@coredump.intra.peff.net>
References: <AANLkTikn1-Ua6G7eAc8UD8DJx0vpc-5-BOoxsi2mx2BC@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Debayan Banerjee <debayanin@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 23 10:00:16 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OG66Y-0001Xo-1C
	for gcvg-git-2@lo.gmane.org; Sun, 23 May 2010 10:00:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752896Ab0EWIAI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 May 2010 04:00:08 -0400
Received: from peff.net ([208.65.91.99]:50612 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751900Ab0EWIAH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 May 2010 04:00:07 -0400
Received: (qmail 20884 invoked by uid 107); 23 May 2010 08:00:08 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 23 May 2010 04:00:08 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 23 May 2010 04:00:02 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTikn1-Ua6G7eAc8UD8DJx0vpc-5-BOoxsi2mx2BC@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147557>

On Mon, May 17, 2010 at 03:51:18PM +0530, Debayan Banerjee wrote:

> debayan@deep-blur:~/testrepo$ git blame 22621a32..8486802f --
> dir/subdir/newsubdir/b
> 
> 81531975 b                      (debayan 2010-05-13 15:32:17 +0530  1) four
> 81531975 b                      (debayan 2010-05-13 15:32:17 +0530  2) five
> d700ac9c b                      (debayan 2010-05-13 15:33:27 +0530  3) blah
> 2656ab56 b                      (debayan 2010-05-13 15:33:34 +0530  4) bleh
> d0c6e851 b                      (debayan 2010-05-13 15:42:21 +0530  5) foo
> 7bf5510e b                      (debayan 2010-05-13 15:42:53 +0530  6) yo
> c4515289 b                      (debayan 2010-05-13 15:43:10 +0530  7) lala
> a257c7e4 b                      (debayan 2010-05-13 16:03:46 +0530  8) yes
> ed8e4601 b                      (debayan 2010-05-13 16:03:55 +0530  9) np
> e96d14bf dir/subdir/newsubdir/b (debayan 2010-05-13 16:05:05 +0530 10) yo
> dace00d1 dir/subdir/newsubdir/b (debayan 2010-05-13 16:05:11 +0530 11) boye
> 8486802f dir/subdir/newsubdir/b (debayan 2010-05-13 16:07:51 +0530 12) what?
> 
> debayan@deep-blur:~/testrepo$ git blame 22621a32..8486802f
> dir/subdir/newsubdir/b
> fatal: cannot stat path 22621a32..8486802f: No such file or directory
> 
> The only difference between the first and the second command is the
> "--" separator.  Is this normal behaviour?

I can't reproduce the problem here. For example, in git.git, both of the
following produce the same output:

  git blame HEAD~5..HEAD~3 alloc.c
  git blame HEAD~5..HEAD~3 -- alloc.c

Can you provide the exact set of commands to replicate your repository
state and show the failure?

Also, I tested with the current 'master'. Are you using an older version
of git?

-Peff
