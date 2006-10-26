X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Petr Baudis <pasky@suse.cz>
Subject: git-shortlog mailmap
Date: Thu, 26 Oct 2006 14:34:24 +0200
Message-ID: <20061026123424.GQ20017@pasky.or.cz>
References: <7vk62npipb.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0610261114520.3286@wbgn013.biozentrum.uni-wuerzburg.de> <ehputm$ch2$3@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 26 Oct 2006 12:35:36 +0000 (UTC)
Cc: torvalds@osdl.org, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <ehputm$ch2$3@sea.gmane.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30205>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gd4Rv-00079t-DS for gcvg-git@gmane.org; Thu, 26 Oct
 2006 14:35:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1423464AbWJZMe1 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 26 Oct 2006
 08:34:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423466AbWJZMe1
 (ORCPT <rfc822;git-outgoing>); Thu, 26 Oct 2006 08:34:27 -0400
Received: from w241.dkm.cz ([62.24.88.241]:28906 "EHLO machine.or.cz") by
 vger.kernel.org with ESMTP id S1423464AbWJZMe0 (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 26 Oct 2006 08:34:26 -0400
Received: (qmail 10797 invoked by uid 2001); 26 Oct 2006 14:34:24 +0200
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

I think I've complained about this in the past, but can't find the mail.

Dear diary, on Thu, Oct 26, 2006 at 11:25:50AM CEST, I got a letter
where Jakub Narebski <jnareb@gmail.com> said that...
> Johannes Schindelin wrote:
> 
> > BTW what happened to the builtin shortlog? It is the last Perl script I 
> > use regularly... (should make people happy who are stuck with Activision 
> > Perl...)
> 
> BTW. both Perl version and builtin shorlog have email->real name translation
> table built in. In Perl script version it is in __DATA__ section, and we
> could update it using Inline::Files module, in C version it was in table.
> But in fact this list is project specific. Shouldn't we make it customizable
> (::sigh::, yet another file in $GIT_DIR...).

I really dislike the fact that we _do_ this mapping at all, this seems
so much a totally wrong point at which to do it. The information tracked
in Git is still wrong and all the tools except shortlog still display it
wrong - why should shortlog in particular be special? Why don't we do
this at the git-am time instead?

And overally, things would be simpler if people would just require the
author name to be recorded in the mail properly when applying the patch;
AIUI at least in case of the kernel this mapping shouldn't really be
needed anymore anyway since with the signoff protocol, you already
require all the contributors to reveal their realnames in signoffs?
People can then as well just write that in their from headers as well.
Linus?

So what about making git-am by default refuse to apply patches with
missing author realnames?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
