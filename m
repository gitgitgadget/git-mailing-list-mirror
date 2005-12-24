From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/4] short circuit out of a few places where we would
 allocate zero bytes
Date: Sat, 24 Dec 2005 13:44:13 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0512241342100.5891@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20051224121007.GA19136@mail.yhbt.net> <20051224121243.GA3963@mail.yhbt.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Dec 25 15:42:49 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EqX5B-0005Fn-Rg
	for gcvg-git@gmane.org; Sun, 25 Dec 2005 15:42:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750830AbVLYOmb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Dec 2005 09:42:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750829AbVLYOmb
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Dec 2005 09:42:31 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:18132 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1750830AbVLYOma (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Dec 2005 09:42:30 -0500
Received: by wrzx28.rz.uni-wuerzburg.de (Postfix, from userid 51)
	id 96D2013F838; Sun, 25 Dec 2005 15:42:27 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 4D1E5140B72; Sat, 24 Dec 2005 13:44:13 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Eric Wong <normalperson@yhbt.net>
In-Reply-To: <20051224121243.GA3963@mail.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14045>

Hi,

On Sat, 24 Dec 2005, Eric Wong wrote:

> dietlibc versions of malloc, calloc and realloc all return NULL if
> they're told to allocate 0 bytes, causes the x* wrappers to die().
> 
> There are several more places where these calls could end up asking
> for 0 bytes, too...
> 
> Maybe simply not die()-ing in the x* wrappers if 0/NULL is returned
> when the requested size is zero is a safer and easier way to go.

I would prefer that, too. But the cleanest way would be to prevent calls 
to *alloc if the size is 0...

Ciao,
Dscho
