X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn: File added multiple times?
Date: Sat, 2 Dec 2006 14:34:19 -0800
Message-ID: <20061202223419.GA7057@localdomain>
References: <87psb2ou6f.fsf@mid.deneb.enyo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 2 Dec 2006 22:34:34 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <87psb2ou6f.fsf@mid.deneb.enyo.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33063>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GqdRA-00007p-DU for gcvg-git@gmane.org; Sat, 02 Dec
 2006 23:34:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1424469AbWLBWeV (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 2 Dec 2006
 17:34:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424481AbWLBWeV
 (ORCPT <rfc822;git-outgoing>); Sat, 2 Dec 2006 17:34:21 -0500
Received: from hand.yhbt.net ([66.150.188.102]:21401 "EHLO hand.yhbt.net") by
 vger.kernel.org with ESMTP id S1424469AbWLBWeV (ORCPT
 <rfc822;git@vger.kernel.org>); Sat, 2 Dec 2006 17:34:21 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1]) by hand.yhbt.net
 (Postfix) with SMTP id C3B072DC035; Sat,  2 Dec 2006 14:34:19 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Sat, 02 Dec 2006
 14:34:19 -0800
To: Florian Weimer <fw@deneb.enyo.de>
Sender: git-owner@vger.kernel.org

Florian Weimer <fw@deneb.enyo.de> wrote:
> Is this expected?
> 
> $ sort /tmp/git-svn-output | uniq -c | sort -rn | head
>       4         A       mlton/trunk/doc/web/papers/index.html
>       4         A       mlton/trunk/doc/web/papers/01-icfp.ps.gz
>       4         A       mlton/trunk/doc/web/papers/00-esop.ps.gz
>       4         A       mlton/trunk/doc/examples/save-world/save-world.sml
>       4         A       mlton/trunk/doc/examples/save-world/Makefile
>       4         A       mlton/trunk/doc/examples/profiling/profiling.sml
>       4         A       mlton/trunk/doc/examples/profiling/Makefile
>       4         A       mlton/trunk/doc/examples/ffi/Makefile
>       4         A       mlton/trunk/doc/examples/ffi/main.sml
>       4         A       mlton/trunk/doc/examples/ffi/ffi.h
> $ 
> 
> It's somewhat counter-intuitive, at least.  This is with Debian's
> git-core 1.4.4.1-1 package, and the SVN:: Perl modules are installed.

No it's not expected.  Is this on a public SVN repo I can look at?
Thanks.

git-svn 1.4.4.1 always cat-ed the entire file (this code was stolen from
git-svnimport, the version in master can transfer deltas).

This is (or only seems to be) a UI reporting error and the actual data
imported should be correct.

-- 
