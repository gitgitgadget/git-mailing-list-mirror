From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC/PATCH 1/2] remote tracking: return the tracking branch for
 the given branches
Date: Thu, 18 Jun 2009 14:35:08 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0906181433330.4297@intel-tinevez-2-302>
References: <1245311834-5290-1-git-send-email-santi@agolina.net> <1245311834-5290-2-git-send-email-santi@agolina.net>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1729695868-1245328509=:4297"
Cc: git@vger.kernel.org
To: =?ISO-8859-15?Q?Santi_B=E9jar?= <santi@agolina.net>
X-From: git-owner@vger.kernel.org Thu Jun 18 14:35:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MHGpt-0005Wn-MW
	for gcvg-git-2@gmane.org; Thu, 18 Jun 2009 14:35:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759245AbZFRMfK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2009 08:35:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758198AbZFRMfJ
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jun 2009 08:35:09 -0400
Received: from mail.gmx.net ([213.165.64.20]:34248 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755326AbZFRMfI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2009 08:35:08 -0400
Received: (qmail invoked by alias); 18 Jun 2009 12:35:09 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp046) with SMTP; 18 Jun 2009 14:35:09 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/AoUlHQBDAAbLjSDzTGTF7rh4TIdsB7GujJ2SIOr
	oCEMRtC56pjx5e
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <1245311834-5290-2-git-send-email-santi@agolina.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121835>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1729695868-1245328509=:4297
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi,

On Thu, 18 Jun 2009, Santi Béjar wrote:

> diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
> index 9e2b4ea..e444899 100644
> --- a/Documentation/git-remote.txt
> +++ b/Documentation/git-remote.txt
> @@ -17,6 +17,7 @@ SYNOPSIS
>  'git remote show' [-n] <name>
>  'git remote prune' [-n | --dry-run] <name>
>  'git remote update' [-p | --prune] [group | remote]...
> +'git remote tracking' <name> <branch>...
>  
>  DESCRIPTION
>  -----------
> @@ -128,6 +129,12 @@ be updated.  (See linkgit:git-config[1]).
>  +
>  With `--prune` option, prune all the remotes that are updated.
>  
> +'tracking'::
> +
> +Returns the tracking branch for the given remote (<name>) and branch
> +(<branch>). Note that <branch> must exactly match the left hand side of
> +the refspec of the given remote.
> +

>From that description, it is not clear to me if the branch is the _remote_ 
branch, the branch _on_ the remote, or the local branch.

If it is the remote branch (or the branch on the remote), I wonder how you 
deal with ambiguities, as I can easily create hundreds of branches 
tracking the same remote branch.

If it is the local branch I wonder why I have to pass the name of the 
remote.

Ciao,
Dscho
--8323329-1729695868-1245328509=:4297--
