From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Improve documentation of git-filter-branch rev-list
 specification.
Date: Tue, 20 Nov 2007 22:28:01 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711202223150.27959@racer.site>
References: <877ikc3gzc.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Carl Worth <cworth@cworth.org>
X-From: git-owner@vger.kernel.org Tue Nov 20 23:29:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IubaK-00016k-AX
	for gcvg-git-2@gmane.org; Tue, 20 Nov 2007 23:28:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757908AbXKTW2a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Nov 2007 17:28:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756318AbXKTW2a
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Nov 2007 17:28:30 -0500
Received: from mail.gmx.net ([213.165.64.20]:48000 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751506AbXKTW23 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Nov 2007 17:28:29 -0500
Received: (qmail invoked by alias); 20 Nov 2007 22:28:27 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp047) with SMTP; 20 Nov 2007 23:28:27 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+vtud0Jsmvqj51r9RKZN1U1KywSqA/TzVDGWodMr
	lfxojTMFEg8emu
X-X-Sender: gene099@racer.site
In-Reply-To: <877ikc3gzc.wl%cworth@cworth.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65578>

Hi,

On Tue, 20 Nov 2007, Carl Worth wrote:

> diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
> index ba9b4fb..985d7d5 100644
> --- a/Documentation/git-filter-branch.txt
> +++ b/Documentation/git-filter-branch.txt
> @@ -13,23 +13,29 @@ SYNOPSIS
>  	[--msg-filter <command>] [--commit-filter <command>]
>  	[--tag-name-filter <command>] [--subdirectory-filter <directory>]
>  	[--original <namespace>] [-d <directory>] [-f | --force]
> -	[<rev-list options>...]
> +	<rev-list options>...

This is correct AFAICT.

>  DESCRIPTION
>  -----------
> -Lets you rewrite git revision history by rewriting the branches mentioned
> -in the <rev-list options>, applying custom filters on each revision.
> -Those filters can modify each tree (e.g. removing a file or running
> -a perl rewrite on all files) or information about each commit.
> -Otherwise, all information (including original commit times or merge
> -information) will be preserved.
> -
> -The command will only rewrite the _positive_ refs mentioned in the
> -command line (i.e. if you pass 'a..b', only 'b' will be rewritten).
> -If you specify no filters, the commits will be recommitted without any
> -changes, which would normally have no effect.  Nevertheless, this may be
> -useful in the future for compensating for some git bugs or such,
> -therefore such a usage is permitted.
> +Rewrites git revision history by applying one or more filters to a set
> +of commits. The set of commits to be rewritten is supplied in
> +<rev-list options> and can be as simple as one or more branch names,
> +(in which case all commits reachable from those branch names will be
> +rewritten).

I do not particularly like that you say "commits to be rewritten".  
Because not the commits, but the branches are rewritten.  For example, if 
you have branch A and B pointing to the same commit and you call 
filter-branch on A, B will be left untouched _along with its commits_.

IMHO the old version -- while maybe not as eloquent as yours -- made that 
very clear.

This was probably the reason you confused the comment about a..b earlier.

So I would appreciate rewriting the documentation in such a way that the 
distinction between a commit and a ref is maintained clearly.

Ciao,
Dscho
