From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: Re: cg-clone not fetching all tags?
Date: Sat, 29 Apr 2006 23:42:16 +0200
Message-ID: <200604292342.16306.johannes.sixt@telecom.at>
References: <20060427105251.AA4B2353DAC@atlas.denx.de> <20060429140042.1FB37353DAC@atlas.denx.de> <20060429170542.GJ27689@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Apr 29 23:42:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FZxCw-0003Eg-UH
	for gcvg-git@gmane.org; Sat, 29 Apr 2006 23:42:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750811AbWD2VmV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 29 Apr 2006 17:42:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750812AbWD2VmV
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Apr 2006 17:42:21 -0400
Received: from mail.nextra.at ([195.170.70.86]:53901 "EHLO mail.nextra.at")
	by vger.kernel.org with ESMTP id S1750811AbWD2VmU (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 29 Apr 2006 17:42:20 -0400
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by mail.nextra.at (8.13.6/8.13.6) with ESMTP id k3TLgHWB009678
	for <git@vger.kernel.org>; Sat, 29 Apr 2006 23:42:18 +0200 (MEST)
X-Abuse-Info: Please report abuse to abuse@eunet.co.at, see http://www.eunet.at/support/service
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 9E24049E03
	for <git@vger.kernel.org>; Sat, 29 Apr 2006 23:42:16 +0200 (CEST)
To: git@vger.kernel.org
User-Agent: KMail/1.9.1
In-Reply-To: <20060429170542.GJ27689@pasky.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19319>

On Saturday 29 April 2006 19:05, Petr Baudis wrote:
>   Hi,
>
> Dear diary, on Sat, Apr 29, 2006 at 04:00:42PM CEST, I got a letter
> where Wolfgang Denk <wd@denx.de> said that...
>
> > it seems that "cg-clone" does not fetch all tags any more - only  the
> > most  recent ones (modiufied in the last N days?) seem to be fetched?
> > [Eventually the "N days"  might  correspond  to  "changing  tools  to
> > version X", but I have no way to find out.]
> >
> > This happens only when using HTTP; using ssh  or  rsync  works  fine.
> > Also,  if  we follow the "cg-clone" by a "git-fetch -t" command, this
> > will load the missing tags.
> >
> > Is this intentional, or am I doing anything wrong?
> >
> > [For testing, try "cg-clone http://www.denx.de/git/u-boot.git"]
>
>   you need to run git-update-server-info every time you add or update a
> tag (or best every time you push). See the NOTES section of
> cg-admin-setuprepo documentation for details on how to set it up to be
> called automagically at every push.

There are two types of tags: They can point to
1. a commit object
2. a proper tag object (which in turn references the commit)

git-update-server-info seems to generate info only for case 2, and so are the 
only ones that http can fetch.

-- Hannes
