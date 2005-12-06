From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Initial AIX portability fixes.
Date: Wed, 7 Dec 2005 00:58:28 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0512070055430.5888@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20493.1133907616@lotus.CS.Berkeley.EDU>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 07 01:00:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ejmhr-0003c4-6j
	for gcvg-git@gmane.org; Wed, 07 Dec 2005 00:58:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932659AbVLFX6c (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Dec 2005 18:58:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932661AbVLFX6c
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Dec 2005 18:58:32 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:54945 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932659AbVLFX6c (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Dec 2005 18:58:32 -0500
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id E46FC13F879; Wed,  7 Dec 2005 00:58:28 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id CC3469DC28; Wed,  7 Dec 2005 00:58:28 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 9D39256D2B; Wed,  7 Dec 2005 00:58:28 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 5242413F879; Wed,  7 Dec 2005 00:58:28 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Jason Riedy <ejr@EECS.Berkeley.EDU>
In-Reply-To: <20493.1133907616@lotus.CS.Berkeley.EDU>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13305>

Hi,

On Tue, 6 Dec 2005, Jason Riedy wrote:

> -#define _XOPEN_SOURCE /* glibc2 needs this */
> +#define _XOPEN_SOURCE 500 /* glibc2 and AIX 5.3L need this */
> +#define _XOPEN_SOURCE_EXTENDED 1 /* AIX 5.3L needs this */

Why not enclose the #define in #ifndef/#endif, and do the real magic in 
the Makefile? Within the AIX clause:

	ALL_CFLAGS += -D_XOPEN_SOURCE=500 -XOPEN_SOURCE_EXTENDED=1

This way the source does not get cluttered with platform dependent 
defines.

Hth,
Dscho
