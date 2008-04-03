From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/4] "log" and friends: --children option
Date: Thu, 3 Apr 2008 21:58:58 +0200 (CEST)
Message-ID: <alpine.LSU.1.00.0804032158040.4008@racer.site>
References: <7v4paj486a.fsf@gitster.siamese.dyndns.org> <7vlk3v2tg9.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 03 22:59:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JhWX7-0001px-0B
	for gcvg-git-2@gmane.org; Thu, 03 Apr 2008 22:59:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758417AbYDCU6t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Apr 2008 16:58:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758303AbYDCU6t
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Apr 2008 16:58:49 -0400
Received: from mail.gmx.net ([213.165.64.20]:54451 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756131AbYDCU6s (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Apr 2008 16:58:48 -0400
Received: (qmail invoked by alias); 03 Apr 2008 20:58:46 -0000
Received: from host86-165-92-90.range86-165.btcentralplus.com (EHLO racer.home) [86.165.92.90]
  by mail.gmx.net (mp021) with SMTP; 03 Apr 2008 22:58:46 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18MHqNxHV0MWij2jjbTGdDjiNxSqf56OTND4l/ibc
	u9G6LZpMvzBFyJ
X-X-Sender: gene099@racer.site
In-Reply-To: <7vlk3v2tg9.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78777>

Hi,

On Thu, 3 Apr 2008, Junio C Hamano wrote:

> @@ -1398,6 +1404,26 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
>  	return left;
>  }
>  
> +static void add_child(struct rev_info *revs, struct commit *parent, struct commit *child)
> +{
> +	struct commit_list *l = xcalloc(1, sizeof(*l));
> +
> +	l->item = child;
> +	l->next = add_decoration(&revs->children, &parent->object, l);
> +}
> +
> +static void set_children(struct rev_info *revs)

I'd call this add_children().

Other than that, nicely done!  I did not think it was possible with as few 
changes.

Ciao,
Dscho
