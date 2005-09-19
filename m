From: "Sean" <seanlkml@sympatico.ca>
Subject: Re: Strange dependency problem installing GIT 0.99.7
Date: Mon, 19 Sep 2005 03:16:31 -0400 (EDT)
Message-ID: <BAYC1-PASMTP01B5899CE20655464E3DDFAE920@CEZ.ICE>
References: <432E1F28.9060909@bigpond.net.au>   
    <7v8xxtzmtl.fsf@assigned-by-dhcp.cox.net>
    <53717.10.10.10.28.1127107066.squirrel@linux1>
    <432E598A.7020306@bigpond.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 19 09:17:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHFtK-0007RA-Lr
	for gcvg-git@gmane.org; Mon, 19 Sep 2005 09:16:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932348AbVISHQh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Sep 2005 03:16:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932354AbVISHQh
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Sep 2005 03:16:37 -0400
Received: from bayc1-pasmtp01.bayc1.hotmail.com ([65.54.191.161]:25867 "EHLO
	BAYC1-PASMTP01.hotmail.com") by vger.kernel.org with ESMTP
	id S932348AbVISHQg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Sep 2005 03:16:36 -0400
X-Originating-IP: [67.71.125.52]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([67.71.125.52]) by BAYC1-PASMTP01.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 19 Sep 2005 00:16:07 -0700
Received: by linux1.attic.local (Postfix, from userid 48)
	id 2C45A644BED; Mon, 19 Sep 2005 03:16:31 -0400 (EDT)
Received: from 10.10.10.28
        (SquirrelMail authenticated user sean)
        by linux1 with HTTP;
        Mon, 19 Sep 2005 03:16:31 -0400 (EDT)
Message-ID: <40363.10.10.10.28.1127114191.squirrel@linux1>
In-Reply-To: <432E598A.7020306@bigpond.net.au>
To: "Peter Williams" <pwil3058@bigpond.net.au>
User-Agent: SquirrelMail/1.4.4-2
X-Priority: 3 (Normal)
Importance: Normal
X-OriginalArrivalTime: 19 Sep 2005 07:16:08.0254 (UTC) FILETIME=[0171EDE0:01C5BCEA]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, September 19, 2005 2:24 am, Peter Williams said:

> IMHO rpm shouldn't care how ShellQuote got there unless it (how it got
> there) is stated as an explicit dependency in the spec file (which it
> isn't).  So I still think this is a bug in rpm's (automatic) dependency
> mechanism that needs fixing.

But rpm resolves dependencies by looking in the rpm database not by
checking the filesystem.   You can actually disable the automatic perl
dependency detection when creating the rpm, but that probably isn't
desirable.

At least on Red Hat/Fedora machines you can create your own rpms directly
from CPAN so it's not too big a restriction:

$ cpan2rpm String::ShellQuote
$ cd ~/rpm/RPMS/noarch
$ sudo rpm -ivh perl-String-ShellQuote-1.03-1.noarch.rpm

Which is all you need to download, package and install the perl module.

> PS I notice that perl isn't included in the explicit list of
> dependencies in the spec file even though other equally ubiquitous
> packages are.

There is special handling for perl detection within the rpmbuild
procedure, so perl will be added automatically where many others won't be.

Sean
