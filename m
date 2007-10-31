From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/1] Add --first-parent support to interactive rebase.
Date: Wed, 31 Oct 2007 03:34:47 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0710310329520.4362@racer.site>
References: <1193797309-1161-1-git-send-email-B.Steinbrink@gmx.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-1617751480-1193801687=:4362"
Cc: git@vger.kernel.org
To: =?utf-8?q?Bj=C3=B6rn=20Steinbrink?= <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Wed Oct 31 04:36:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1In4N9-00044L-Uz
	for gcvg-git-2@gmane.org; Wed, 31 Oct 2007 04:36:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752287AbXJaDfv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2007 23:35:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752155AbXJaDfv
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Oct 2007 23:35:51 -0400
Received: from mail.gmx.net ([213.165.64.20]:42212 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752117AbXJaDfu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2007 23:35:50 -0400
Received: (qmail invoked by alias); 31 Oct 2007 03:35:48 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp054) with SMTP; 31 Oct 2007 04:35:48 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX185kixRAz45chzTcLlFQMCg69WSQ75ogzlqwyI2Cf
	424DAPpiNayOws
X-X-Sender: gene099@racer.site
In-Reply-To: <1193797309-1161-1-git-send-email-B.Steinbrink@gmx.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62788>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-1617751480-1193801687=:4362
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

Hi,

On Wed, 31 Oct 2007, Björn Steinbrink wrote:

> @@ -246,6 +292,13 @@ OPTIONS
>  	Instead of ignoring merges, try to recreate them.  This option
>  	only works in interactive mode.
>  
> +\--first-parent::
> +	Only follow the first parent commits in merge commits when looking
> +	for the commits that are to be rebased. This is most useful with -p
> +	as it will cause rebase to recreate the merges against the original
> +	branches instead of rebasing those branches as well. This option
> +	only works in interactive mode.
> +

Hmm.  I had to read this several times to understand it.  Maybe something 
like this instead?

\--first-parent::
	When you want to preserve merges, this option allows you to rebase 
	only the commits which were not merged in, i.e. which are in the
	first parent ancestry of the current HEAD.
+
This option only makes sense together with --preserve-merges.

Also, could you please add a test case to make sure that your patch works 
as advertised (and that this functionality will not be broken in future 
commits)?

Thanks,
Dscho

--8323584-1617751480-1193801687=:4362--
