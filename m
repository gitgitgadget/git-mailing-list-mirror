From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: warning: too many files, skipping inexact rename detection
Date: Sat, 26 Apr 2008 07:06:56 -0700
Message-ID: <20080426070656.e7a01d91.akpm@linux-foundation.org>
References: <20080426063209.5615dd5e.akpm@linux-foundation.org>
	<20080426135737.GA382@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Apr 26 16:08:01 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jpl4I-00080W-UN
	for gcvg-git-2@gmane.org; Sat, 26 Apr 2008 16:07:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751870AbYDZOHL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Apr 2008 10:07:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751769AbYDZOHK
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Apr 2008 10:07:10 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:56442 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751359AbYDZOHJ (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 26 Apr 2008 10:07:09 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m3QE6uQ3012925
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 26 Apr 2008 07:06:57 -0700
Received: from y.localdomain (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with SMTP id m3QE6u1f025416;
	Sat, 26 Apr 2008 07:06:56 -0700
In-Reply-To: <20080426135737.GA382@sigill.intra.peff.net>
X-Mailer: Sylpheed 2.4.8 (GTK+ 2.12.5; x86_64-redhat-linux-gnu)
X-Spam-Status: No, hits=-2.806 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80377>

On Sat, 26 Apr 2008 09:57:37 -0400 Jeff King <peff@peff.net> wrote:

> On Sat, Apr 26, 2008 at 06:32:09AM -0700, Andrew Morton wrote:
> 
> > I get the above message all the time when pulling all the git trees.
> > 
> > I'm frightened!
> 
> Rename detection is O(n^2), so when it looks like it will take a really
> long time, we skip it. This has been happening for a while, but 1.5.5
> only recently started telling the user (based on some people wondering
> why renames weren't found during their enormous merges).
> 
> The default rename limit is 100, but you can bump it via the
> diff.renamelimit config option.

<wonders how to set that>

> A few tests that I did imply that
> 200-400 is reasonable for logging, and 800-1000 for a merge:
> 
>   http://article.gmane.org/gmane.comp.version-control.git/73519
> 
> Are you running into actual problems with rename detection, or is the
> message just too scary and confusing?

No observed problems, just scared!

I don't use rename detection anyway - I use git to extract plain old diffs
only.

Perhaps the default should be bumped up a bit based on your measurements,
dunno.
