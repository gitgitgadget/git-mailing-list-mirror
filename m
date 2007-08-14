From: bdowning@lavos.net (Brian Downing)
Subject: Re: [PATCH] Add read_cache to builtin-check-attr
Date: Tue, 14 Aug 2007 09:24:29 -0500
Message-ID: <20070814142428.GK21692@lavos.net>
References: <11870975181798-git-send-email-bdowning@lavos.net> <20070814132209.GJ21692@lavos.net> <Pine.LNX.4.64.0708141506260.25989@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Marius Storm-Olsen <marius@trolltech.com>,
	Steffen Prohaska <prohaska@zib.de>, dmitry.kakurin@gmail.com,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Aug 14 16:24:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKxKC-0006HD-UV
	for gcvg-git@gmane.org; Tue, 14 Aug 2007 16:24:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756658AbXHNOYl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Aug 2007 10:24:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756806AbXHNOYl
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Aug 2007 10:24:41 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:25613 "EHLO
	asav02.insightbb.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750942AbXHNOYk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Aug 2007 10:24:40 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AtZjAKNXwUZKhvbzRmdsb2JhbACBVIUlhxUBAQE1AQ
Received: from 74-134-246-243.dhcp.insightbb.com (HELO mail.lavos.net) ([74.134.246.243])
  by asav02.insightbb.com with ESMTP; 14 Aug 2007 10:24:38 -0400
Received: by mail.lavos.net (Postfix, from userid 1000)
	id 37C29309F31; Tue, 14 Aug 2007 09:24:29 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0708141506260.25989@racer.site>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55835>

On Tue, Aug 14, 2007 at 03:08:52PM +0100, Johannes Schindelin wrote:
> Shouldn't read_cache() be _only_ called if
> 
> - it has not been read yet, and
> - .gitattributes was not found in the work tree?
> 
> IOW check-attr is the wrong place for your patch IMHO.

I admit I just cargo-culted what builtin-checkout-index did upon starting.
Off the cuff, though, I don't see how the cache could ever already be
loaded upon the start of cmd_check_attr, and the way the attr.c code is
written, the cache be loaded when we check attributes or it will default
to the old behavior (only checking the working directory.)

What would you suggest here?

-bcd
