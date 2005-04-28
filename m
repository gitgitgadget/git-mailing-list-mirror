From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: Re: How to get bash to shut up about SIGPIPE?
Date: Thu, 28 Apr 2005 22:13:25 +0200
Message-ID: <427143E5.4080505@lsrfire.ath.cx>
References: <Pine.LNX.4.58.0504281121430.18901@ppc970.osdl.org> <42713379.7080107@lsrfire.ath.cx> <Pine.LNX.4.58.0504281217100.18901@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>, Petr Baudis <pasky@ucw.cz>
X-From: git-owner@vger.kernel.org Thu Apr 28 22:10:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRFKL-000365-6I
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 22:09:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262263AbVD1UOj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Apr 2005 16:14:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262262AbVD1UO3
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Apr 2005 16:14:29 -0400
Received: from neapel230.server4you.de ([217.172.187.230]:37017 "EHLO
	neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S262259AbVD1UN2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2005 16:13:28 -0400
Received: from [10.0.1.3] (p508E4F7A.dip.t-dialin.net [80.142.79.122])
	by neapel230.server4you.de (Postfix) with ESMTP id A5011B4;
	Thu, 28 Apr 2005 22:13:26 +0200 (CEST)
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: de-DE, de, en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504281217100.18901@ppc970.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds schrieb:
> 
> On Thu, 28 Apr 2005, Rene Scharfe wrote:
> 
>>I think you misspelled "cg-log". :-D
> 
> 
> My fingers have a hard time learning new patterns, so I've got:
> 
> 	torvalds@ppc970:~/git> cat ~/bin/git   
> 	#!/bin/sh
> 	cmd="cg-$1"
> 	shift
> 	$cmd "$@"

As a workaround, add this line after the shift to suppress the ugly
messages:

	[ "$cmd" = cg-log ] && exec 2>/dev/null

> Defining "DONT_REPORT_SIGPIPE" in config-top.h when building bash gets rid
> of it, but I really don't want to rebuild bash just because of this ;)

Yes, I just compiled it and in the version from gnu.org this defaults to
not being defined.  Man, am I glad my distro uncommented that line. :-)

Looking briefly at the source there doesn't seem to be a way to turn it
off besides this compile time setting.  I really wonder why..

Rene
