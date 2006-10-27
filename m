X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] cogito: Honor either post-commit script name; fail if both are executable
Date: Fri, 27 Oct 2006 04:05:49 +0200
Message-ID: <20061027020549.GY20017@pasky.or.cz>
References: <874ptzhsjs.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 27 Oct 2006 02:09:36 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <874ptzhsjs.fsf@rho.meyering.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30278>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GdH6X-0006ie-SQ for gcvg-git@gmane.org; Fri, 27 Oct
 2006 04:05:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1423743AbWJ0CFv (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 26 Oct 2006
 22:05:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423746AbWJ0CFv
 (ORCPT <rfc822;git-outgoing>); Thu, 26 Oct 2006 22:05:51 -0400
Received: from w241.dkm.cz ([62.24.88.241]:41959 "EHLO machine.or.cz") by
 vger.kernel.org with ESMTP id S1423743AbWJ0CFu (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 26 Oct 2006 22:05:50 -0400
Received: (qmail 9582 invoked by uid 2001); 27 Oct 2006 04:05:49 +0200
To: Jim Meyering <jim@meyering.net>
Sender: git-owner@vger.kernel.org

  Hi!

Dear diary, on Fri, Oct 20, 2006 at 06:15:51PM CEST, I got a letter
where Jim Meyering <jim@meyering.net> said that...
> I promised this patch some time ago, made the changes,
> and then never sent them.  This is slightly different
> from the current implementation in that it fails when both
> scripts are executable.  Also, it factors out the script names and
> adds tests.
> 
> Signed-off-by: Jim Meyering <jim@meyering.net>

  I'm not sure I like this (of course, I always like additional tests,
though). The problem is that this loses a smooth upgrade path, things
suddenly break and you can't commit without having to think about fixing
your environment. We should always give users enough time for that with
deprecation warnings. So if we want to get rid of commit-post, we should
rather start printing deprecation warnings if commit-post exists, and in
few months cut commit-post off.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
