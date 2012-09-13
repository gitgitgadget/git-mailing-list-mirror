From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: CRLF, LF ... CR ?
Date: Thu, 13 Sep 2012 20:34:08 +0200
Message-ID: <50522720.50204@kdbg.org>
References: <20120913170943725232.01d717ef@gpio.dk> <1347550490.24469.54.camel@drew-northup.unet.maine.edu> <20120913154309.GB726@sigill.intra.peff.net> <20120913175300953765.9ccf790f@gpio.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Drew Northup <drew.northup@maine.edu>,
	git@vger.kernel.org
To: Jens Bauer <jens-lists@gpio.dk>
X-From: git-owner@vger.kernel.org Thu Sep 13 20:34:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCEF5-0003dh-IZ
	for gcvg-git-2@plane.gmane.org; Thu, 13 Sep 2012 20:34:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752470Ab2IMSeP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Sep 2012 14:34:15 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:34437 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752268Ab2IMSeO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Sep 2012 14:34:14 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id D93DE10017;
	Thu, 13 Sep 2012 20:34:10 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id BF16A30AE20;
	Thu, 13 Sep 2012 20:34:09 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120825 Thunderbird/15.0
In-Reply-To: <20120913175300953765.9ccf790f@gpio.dk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205406>

Am 13.09.2012 17:53, schrieb Jens Bauer:
> Hi Jeff and Drew.
> 
> Thank you for your quick replies! :)
> 
> The diffs look nasty yes; that's my main issue.
> It can be worked around in many ways; eg a simple (but time consuming) way:
> $ git diff mypcb.osm >mypcb.diff && nano mypcb.diff
> 
> -It'd be better to just pipe it into a regex, which changes CR to LF on the fly.
> 
> OsmondPCB is able to read files that has mixed LF and CR. (By mixed, I do not talk about CRLF)

That is good news. Just write a 'clean' filter that amounts to

   tr '\015' '\012'

You don't need a 'smudge' filter that reverts this conversion.

-- Hannes
