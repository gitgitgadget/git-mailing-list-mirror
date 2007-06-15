From: Kevin Green <Kevin.T.Green@morganstanley.com>
Subject: Re: [RFC][PATCH] Fix assumption that git is installed in a standard place on the remote end ssh
Date: Fri, 15 Jun 2007 11:40:00 -0400
Message-ID: <20070615154000.GK14677@menevado.ms.com>
References: <20070615150351.GH14677@menevado.ms.com> <Pine.LNX.4.64.0706151628180.31972@reaper.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Fri Jun 15 17:40:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HzDuB-0002Nk-7x
	for gcvg-git@gmane.org; Fri, 15 Jun 2007 17:40:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754033AbXFOPkF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Jun 2007 11:40:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753612AbXFOPkF
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jun 2007 11:40:05 -0400
Received: from hqmtabh4.ms.com ([205.228.12.104]:55622 "EHLO hqmtabh4.ms.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752396AbXFOPkD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jun 2007 11:40:03 -0400
Received: from hqmtabh4 (localhost.ms.com [127.0.0.1])
	by hqmtabh4.ms.com (output Postfix) with ESMTP id 8AF5848582;
	Fri, 15 Jun 2007 11:40:01 -0400 (EDT)
Received: from ny37im02.ms.com (unknown [144.14.31.41])
	by pivsbh2.ms.com (internal Postfix) with ESMTP id 6A9A7895;
	Fri, 15 Jun 2007 11:40:01 -0400 (EDT)
Received: from menevado.ms.com (menevado [144.14.26.134])
	by ny37im02.ms.com (Sendmail MTA Hub) with ESMTP id l5FFe0U21122;
	Fri, 15 Jun 2007 11:40:01 -0400 (EDT)
Received: (kgreen@localhost) by menevado.ms.com (8.12.11.20060308/sendmail.cf.client v1.05) id l5FFe0fl020377; Fri, 15 Jun 2007 11:40:00 -0400
X-Authentication-Warning: menevado.ms.com: kgreen set sender to Kevin.T.Green@morganstanley.com using -f
Mail-Followup-To: Julian Phillips <julian@quantumfyre.co.uk>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0706151628180.31972@reaper.quantumfyre.co.uk>
User-Agent: Mutt/1.5.6i
X-Anti-Virus: Kaspersky Anti-Virus for MailServers 5.5.15/RELEASE, bases: 15062007 #325705, status: clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50269>

On 06/15/07 11:30:12, Julian Phillips wrote:
> On Fri, 15 Jun 2007, Kevin Green wrote:
> 
> >
> > Hi,
> >
> > I've run into a problem pushing/pulling where we don't (READ: can't) have git installed in the
> > standard location.  This leads to a failure on trying to find the git binaries
> > on the remote end.  I've looked through the archives and didn't come across
> > any similar discussions.  Please point me there if I've missed something...
> 
> from the git-pull manpage:
> 
>         --upload-pack <upload-pack>
>                When given, and the repository to fetch from is handled by
>                git-fetch-pack, --exec=<upload-pack> is passed to the command
>                to specify non-default path for the command run on the other
>                end.
> 
> and git-pull:
> 
>         --receive-pack=<git-receive-pack>
>                Path to the git-receive-pack program on the remote end.
>                Sometimes useful when pushing to a remote repository over ssh,
>                and you do not have the program in a directory on the default
>                $PATH.

Thanks!

I did completely miss this when I went through the manpage...

I'm thinking I like the env var idea much more though.  I can just export it
in my shell and it works in both cases.  I could of course alias the commands
so I don't have to keep typing it everytime, but that's more painful still...

--Kevin
