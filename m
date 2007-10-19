From: Andreas Ericsson <ae@op5.se>
Subject: Re: [RFC/PATCH] git-fetch: mega-terse fetch output
Date: Fri, 19 Oct 2007 12:51:06 +0200
Message-ID: <47188C1A.2090600@op5.se>
References: <20071019062219.GA28499@coredump.intra.peff.net> <ee77f5c20710182339g30d025f0tfe74479d672ae36e@mail.gmail.com> <20071019073938.GN14735@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: David Symonds <dsymonds@gmail.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Oct 19 12:54:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1IipVG-0004Nx-4A
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 12:54:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754533AbXJSKvN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2007 06:51:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755555AbXJSKvN
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Oct 2007 06:51:13 -0400
Received: from mail.op5.se ([193.201.96.20]:47760 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753892AbXJSKvM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Oct 2007 06:51:12 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 81FAD173067C;
	Fri, 19 Oct 2007 12:51:00 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8k5zMHZ1t1Ly; Fri, 19 Oct 2007 12:50:59 +0200 (CEST)
Received: from nox.op5.se (unknown [172.27.77.30])
	by mail.op5.se (Postfix) with ESMTP id 89336173067B;
	Fri, 19 Oct 2007 12:50:58 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <20071019073938.GN14735@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61687>

Shawn O. Pearce wrote:
>  
> +static void determine_window_size(void)
> +{
> +	struct winsize ws;
> +	if (!ioctl(2, TIOCGWINSZ, &ws))
> +		ws_cols = ws.ws_col;
> +}
> +

I'd suggest re-using term_columns() from help.c instead. It's been in there
since the git wrapper was rewritten in C, so it's had a bit of testing and
seems to work fairly well.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
