From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH 3/3] Use stringbuf to clean up some string handling code.
Date: Sun, 20 May 2007 11:56:23 +0200
Message-ID: <20070520095623.GA3106@steel.home>
References: <1179627942.32181.1288.camel@hurina>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Timo Sirainen <tss@iki.fi>
X-From: git-owner@vger.kernel.org Sun May 20 11:56:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hpi9Q-0001j9-80
	for gcvg-git@gmane.org; Sun, 20 May 2007 11:56:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754338AbXETJ41 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 May 2007 05:56:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755691AbXETJ41
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 05:56:27 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:16228 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754338AbXETJ40 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2007 05:56:26 -0400
Received: from tigra.home (Fc9f0.f.strato-dslnet.de [195.4.201.240])
	by post.webmailer.de (fruni mo60) (RZmta 6.5)
	with ESMTP id C0264fj4K7FBEY ; Sun, 20 May 2007 11:56:24 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 5C68D277BD;
	Sun, 20 May 2007 11:56:24 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id C7C16D195; Sun, 20 May 2007 11:56:23 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1179627942.32181.1288.camel@hurina>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaFzAcjYFg=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47808>

Timo Sirainen, Sun, May 20, 2007 04:25:42 +0200:
> ---
>  commit.c      |   30 +++++++++++++-----------------
>  local-fetch.c |   34 ++++++++++++++++------------------
>  2 files changed, 29 insertions(+), 35 deletions(-)

I find it hard to believe that it actually was a cleanup.

It is a nicer code, but... it is bigger, heavier on stack, and it does
not actually fix anything.

In my experience, such changes are seldom worth the effort. It may be
a nice code (and I actually like str.[hc]), but its use _must_ be
justified. I.e. it must simplify a complex formatting routine, or fix
a bug, which otherwise would be too hard or ugly to fix. It is
definitely not the case in this patch.
