From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: t5505-remote fails on Windows
Date: Thu, 19 Mar 2009 11:36:50 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903191135530.10279@pacific.mpi-cbg.de>
References: <49C0DE23.8020809@viscovery.net> <20090319041837.GA32642@coredump.intra.peff.net> <20090319044313.GA341@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Jay Soffian <jaysoffian@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 19 11:36:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkFbx-0002m7-0Q
	for gcvg-git-2@gmane.org; Thu, 19 Mar 2009 11:36:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752209AbZCSKe6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2009 06:34:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751315AbZCSKe6
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 06:34:58 -0400
Received: from mail.gmx.net ([213.165.64.20]:53136 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751201AbZCSKe5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2009 06:34:57 -0400
Received: (qmail invoked by alias); 19 Mar 2009 10:34:54 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp008) with SMTP; 19 Mar 2009 11:34:54 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1815M9Khew15EGZ/4u3LkNu38VWixswTuX7Qk/OV1
	BniaXp5oyg1jKW
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20090319044313.GA341@coredump.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113751>

Hi,

On Thu, 19 Mar 2009, Jeff King wrote:

> @@ -163,9 +163,15 @@ static int cmp_items(const void *a, const void *b)
>  	return strcmp(one->string, two->string);
>  }
>  
> +void sort_string_list_with_fn(struct string_list *list,
> +			      int (*fn)(const void *, const void *))
> +{
> +	qsort(list->items, list->nr, sizeof(*list->items), fn);
> +}
> +

Do we really want an API for that?  Calling qsort() directly should be 
obvious enough, no?

Ciao,
Dscho
