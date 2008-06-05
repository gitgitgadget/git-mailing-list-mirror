From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] use natural ordering to display list of branches.
Date: Thu, 5 Jun 2008 19:47:26 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806051946100.21190@racer>
References: <d45085aa0806051041y42ce467fq2e07371d225ccca3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Cedric Vivier <cedricv@neonux.com>
X-From: git-owner@vger.kernel.org Thu Jun 05 20:49:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4KWy-0002bi-RM
	for gcvg-git-2@gmane.org; Thu, 05 Jun 2008 20:49:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754100AbYFESs4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2008 14:48:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754020AbYFESs4
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 14:48:56 -0400
Received: from mail.gmx.net ([213.165.64.20]:58814 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754063AbYFESsz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2008 14:48:55 -0400
Received: (qmail invoked by alias); 05 Jun 2008 18:48:52 -0000
Received: from pacific.mpi-cbg.de (EHLO [10.8.0.10]) [141.5.10.38]
  by mail.gmx.net (mp008) with SMTP; 05 Jun 2008 20:48:52 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/QPyAGA1/QswMSShQyjUeVXOAYKu9vTAwKQl9+Pg
	NqnZ6+WPdT9563
X-X-Sender: gene099@racer
In-Reply-To: <d45085aa0806051041y42ce467fq2e07371d225ccca3@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83956>

Hi,

On Thu, 5 Jun 2008, Cedric Vivier wrote:

> Hi everyone,
> 
> This small patch makes git display list of branches in natural order.
> This way, when you name your branches against, for instance, a bug number from
> some bug-tracking tool, the list will show up in a natural/human/logical order.
> 
> Current behavior for "git branch":
> BUG-1040-doing-bar-is-too-slow
> BUG-84-calling-Z-with-null-segfaults
> BUG-900-program-freezes-when-user-click-on-button
> experimental-feature-X
> master
> 
> With the patch:
> BUG-84-calling-Z-with-null-segfaults
> BUG-900-program-freezes-when-user-click-on-button
> BUG-1040-doing-bar-takes-too-much-time
> experimental-feature-X
> master
> 
> 
> Signed-off-by: Cedric Vivier <cedricv@neonux.com>
> ---

This is not a good commit message.

> @@ -279,7 +280,7 @@ static int ref_cmp(const void *r1, const void *r2)
> 
>  	if (c1->kind != c2->kind)
>  		return c1->kind - c2->kind;
> -	return strcmp(c1->name, c2->name);
> +	return strnatcmp(c1->name, c2->name);
>  }
> 
>  static void print_ref_item(struct ref_item *item, int maxwidth, int verbose,

What about people preferring the status quo?  I think a command line 
option would be in order.

Also, you _might_ want to provide a test case, so that it does not get 
broken by accident.

Other than that: nice.

Ciao,
Dscho
