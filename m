From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH 1/2] send-pack: cluster ref status reporting
Date: Tue, 20 Nov 2007 19:22:33 +0100
Message-ID: <20071120182233.GA3461@steel.home>
References: <20071120111317.GA4120@sigill.intra.peff.net> <20071120111801.GA7814@sigill.intra.peff.net>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Nov 20 19:23:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IuXkq-0008Ub-5E
	for gcvg-git-2@gmane.org; Tue, 20 Nov 2007 19:23:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754170AbXKTSWi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Nov 2007 13:22:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756996AbXKTSWi
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Nov 2007 13:22:38 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:50532 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755840AbXKTSWh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Nov 2007 13:22:37 -0500
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gQVF2k5XWuW3CculzyClJ8+A==
Received: from tigra.home (Fad1d.f.strato-dslnet.de [195.4.173.29])
	by post.webmailer.de (klopstock mo5) (RZmta 14.3)
	with ESMTP id Y06b28jAKH0OsY ; Tue, 20 Nov 2007 19:22:34 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id EAB0A277AE;
	Tue, 20 Nov 2007 19:22:33 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id 3A79256D22; Tue, 20 Nov 2007 19:22:33 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20071120111801.GA7814@sigill.intra.peff.net>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65557>

Jeff King, Tue, Nov 20, 2007 12:18:01 +0100:
> Instead of intermingling success and failure, we now print:
> 
>   1. all uptodate refs (if args.verbose is enabled)
>   2. successfully pushed refs
>   3. failed refs

I vote for this. The non-ff refs clustered together was the real
reason behind my beautification patch.

> I am somewhat ambivalent on this patch. In most cases, it won't make a
> difference, since the output is small enough. For large pushes, it might
> be better to have errors at the end. OTOH, you do still get "error:
> failed to push to ..." at the end, and you can scroll up and see the
> errors if you like. And it's not like preserving the original ref output
> order was all that interesting.

It is just simplier to distinguish visually: non-ff's are formatted
significantly different. You don't even have to read what is written
to immediately notice if there are problems.
