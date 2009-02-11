From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] fast-export: ensure we traverse commits in topological
 order
Date: Wed, 11 Feb 2009 11:25:53 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902111125410.10279@pacific.mpi-cbg.de>
References: <1234332233-10017-1-git-send-email-newren@gmail.com> <1234332233-10017-2-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 11 11:27:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXCIf-0005Wv-A8
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 11:26:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754551AbZBKKZL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 05:25:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753288AbZBKKZK
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 05:25:10 -0500
Received: from mail.gmx.net ([213.165.64.20]:51164 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751215AbZBKKZJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 05:25:09 -0500
Received: (qmail invoked by alias); 11 Feb 2009 10:25:05 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp019) with SMTP; 11 Feb 2009 11:25:05 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+0oA0UFFK0qLLLtp1pGWCOz+BwC9ZmhxkOIFQjs8
	qQJ30G51Ijch2N
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <1234332233-10017-2-git-send-email-newren@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109400>

Hi,

On Tue, 10 Feb 2009, newren@gmail.com wrote:

> From: Elijah Newren <newren@gmail.com>
> 
> fast-export will only list as parents those commits which have already
> been traversed (making it appear as if merges have been squashed if not
> all parents have been traversed).  To avoid this silent squashing of
> merge commits, we request commits in topological order.
> 
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  builtin-fast-export.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/builtin-fast-export.c b/builtin-fast-export.c
> index e9ee2c7..fdf4ae9 100644
> --- a/builtin-fast-export.c
> +++ b/builtin-fast-export.c
> @@ -514,6 +514,7 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
>  
>  	get_tags_and_duplicates(&revs.pending, &extra_refs);
>  
> +	revs.topo_order = 1;

ACK.

Ciao,
Dscho
