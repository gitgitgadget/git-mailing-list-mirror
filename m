From: sean <seanlkml@sympatico.ca>
Subject: Re: How to not download objects more than needed?
Date: Tue, 21 Feb 2006 16:13:40 -0500
Message-ID: <BAYC1-PASMTP03A58A4F389365AC85DA68AEFC0@CEZ.ICE>
References: <43FB6C42.5000208@gorzow.mm.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 21 22:14:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FBeqM-0007q0-BY
	for gcvg-git@gmane.org; Tue, 21 Feb 2006 22:14:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932787AbWBUVOn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Feb 2006 16:14:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932788AbWBUVOn
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Feb 2006 16:14:43 -0500
Received: from bayc1-pasmtp03.bayc1.hotmail.com ([65.54.191.163]:22727 "EHLO
	BAYC1-PASMTP03.bayc1.hotmail.com") by vger.kernel.org with ESMTP
	id S932787AbWBUVOm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Feb 2006 16:14:42 -0500
X-Originating-IP: [65.94.251.146]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([65.94.251.146]) by BAYC1-PASMTP03.bayc1.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 21 Feb 2006 13:14:41 -0800
Received: from guru.attic.local (guru.attic.local [10.10.10.28])
	by linux1.attic.local (Postfix) with ESMTP id BEC8D644C28;
	Tue, 21 Feb 2006 16:14:40 -0500 (EST)
To: Radoslaw Szkodzinski <astralstorm@gorzow.mm.pl>
Message-Id: <20060221161340.73a19228.seanlkml@sympatico.ca>
In-Reply-To: <43FB6C42.5000208@gorzow.mm.pl>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.12; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 21 Feb 2006 21:14:41.0839 (UTC) FILETIME=[D4B4FBF0:01C6372B]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, 21 Feb 2006 20:38:42 +0100
Radoslaw Szkodzinski <astralstorm@gorzow.mm.pl> wrote:

> I have a pecuilar, but common use case for git.

It's not really that peculiar.

> I have linux-2.6 repository pulled and I'd like to download some branch
> (say, netdev-2.6), which uses many of the same objects,
> but not to get all the objects from the git server.

Just make sure you're not using the rsync protocol.   Using the
native git protocol would be best.

> I've already tried certain commands, but still can't do it,
> and my bandwidth isn't too happy about it.

For instance, make sure your current linus repository is up to date 
with a "git pull" and then:

git fetch \
   git://git.kernel.org/pub/scm/linux/kernel/git/jgarzik/netdev-2.6.git \
   upstream:netdev

will take the "upstream" branch from the netdev repository and name it 
netdev in your local repository.

Sean
