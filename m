From: Paul Jackson <pj@sgi.com>
Subject: Re: How to get bash to shut up about SIGPIPE?
Date: Mon, 2 May 2005 09:10:27 -0700
Organization: SGI
Message-ID: <20050502091027.6753998e.pj@sgi.com>
References: <E1DSDER-0000kS-00@gondolin.me.apana.org.au>
	<4274FB10.6090600@dwheeler.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: herbert@gondor.apana.org.au, ryan@michonline.com,
	torvalds@osdl.org, rene.scharfe@lsrfire.ath.cx,
	git@vger.kernel.org, pasky@ucw.cz
X-From: git-owner@vger.kernel.org Mon May 02 18:06:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSdQJ-0004JR-1o
	for gcvg-git@gmane.org; Mon, 02 May 2005 18:05:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261371AbVEBQLa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 May 2005 12:11:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261383AbVEBQLa
	(ORCPT <rfc822;git-outgoing>); Mon, 2 May 2005 12:11:30 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:41416 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261371AbVEBQLZ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 May 2005 12:11:25 -0400
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2])
	by omx3.sgi.com (8.12.11/8.12.9/linux-outbound_gateway-1.1) with ESMTP id j42GaL3C027590;
	Mon, 2 May 2005 09:36:21 -0700
Received: from vpn2 (mtv-vpn-hw-pj-2.corp.sgi.com [134.15.25.219])
	by cthulhu.engr.sgi.com (SGI-8.12.5/8.12.5) with SMTP id j42GAT5w20643156;
	Mon, 2 May 2005 09:10:29 -0700 (PDT)
To: dwheeler@dwheeler.com
In-Reply-To: <4274FB10.6090600@dwheeler.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

David wrote:
> One approach is to install a trap for SIGPIPE in
> non-terminating command in a pipeline where the
> later items might not process all the data, e.g.:
>    (trap {} SIGPIPE; find .) | head -1

Both the versions of bash that I looked at (2.05 and 3.0) _still_
complain even if SIGPIPE is trapped - they just complain with
a more terse message, unless DONT_REPORT_SIGPIPE is not defined.

Linus's version apparently isn't even more terse with this trap.

What bash do you have that this trap silences?

> ... rant ...

agreed

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
