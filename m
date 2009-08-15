From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Simplify '--prett=xyz' options
Date: Sat, 15 Aug 2009 22:22:36 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908152220060.8306@pacific.mpi-cbg.de>
References: <alpine.LFD.2.01.0908151156510.3162@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Aug 15 22:22:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1McPlL-0006Aa-FI
	for gcvg-git-2@gmane.org; Sat, 15 Aug 2009 22:22:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752061AbZHOUVw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Aug 2009 16:21:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750743AbZHOUVw
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Aug 2009 16:21:52 -0400
Received: from mail.gmx.net ([213.165.64.20]:37585 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750726AbZHOUVv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Aug 2009 16:21:51 -0400
Received: (qmail invoked by alias); 15 Aug 2009 20:21:51 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp042) with SMTP; 15 Aug 2009 22:21:51 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+vZzUJioGvM6w6DcEKs3J5mAMj2O4lQBOT1lbbIO
	xAum8wZJgT02/y
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.LFD.2.01.0908151156510.3162@localhost.localdomain>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.54
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126025>

Hi,

On Sat, 15 Aug 2009, Linus Torvalds wrote:

> 
> I keep on thinking that I can write
> 
> 	git log --format:'%aN: %s'

You mean as opposed to "--format=%aN:\ %s" (which works)?

> Now I just need a patch to make me athletic and handsome.

I thought that already happened?  /me remembers seeing a youtube video 
with you in speedos.


> diff --git a/revision.c b/revision.c
> index 9f5dac5..181593f 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -1192,6 +1192,8 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
>  	} else if (!strcmp(arg, "--children")) {
>  		revs->children.name = "children";
>  		revs->limited = 1;
> +	} else if (!strncmp(arg, "--", 2) && try_get_commit_format(arg+2, revs)) {

prefixcmp?

Ciao,
Dscho
