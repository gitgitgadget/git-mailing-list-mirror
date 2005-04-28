From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: How to get bash to shut up about SIGPIPE?
Date: Thu, 28 Apr 2005 12:21:26 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504281217100.18901@ppc970.osdl.org>
References: <Pine.LNX.4.58.0504281121430.18901@ppc970.osdl.org>
 <42713379.7080107@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>, Petr Baudis <pasky@ucw.cz>
X-From: git-owner@vger.kernel.org Thu Apr 28 21:14:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRESo-00049J-IL
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 21:14:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262232AbVD1TTr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Apr 2005 15:19:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262238AbVD1TTr
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Apr 2005 15:19:47 -0400
Received: from fire.osdl.org ([65.172.181.4]:21972 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262232AbVD1TTd (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Apr 2005 15:19:33 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3SJJSs4031914
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 28 Apr 2005 12:19:28 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3SJJRKW003259;
	Thu, 28 Apr 2005 12:19:27 -0700
To: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
In-Reply-To: <42713379.7080107@lsrfire.ath.cx>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Thu, 28 Apr 2005, Rene Scharfe wrote:
> 
> I think you misspelled "cg-log". :-D

My fingers have a hard time learning new patterns, so I've got:

	torvalds@ppc970:~/git> cat ~/bin/git   
	#!/bin/sh
	cmd="cg-$1"
	shift
	$cmd "$@"

until my fingers learn the new thing.

> Doing "cg-log | head" gives me 10 lines of log and nothing else.  Maybe
> the problem has been fixed between 0.7 and the current version I'm using
> (commit ID 49612c471eebd26efe926a71752e254c1cdc382d)?

no, this is current as of an hour ago, same head you have.

It's a bash-specific thing, and depends on how you compiled bash.

Defining "DONT_REPORT_SIGPIPE" in config-top.h when building bash gets rid 
of it, but I really don't want to rebuild bash just because of this ;)

		Linus
