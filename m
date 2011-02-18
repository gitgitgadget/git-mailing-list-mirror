From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv3 2/2] git-patch-id: do not trip over "no newline" markers
Date: Fri, 18 Feb 2011 05:41:51 -0500
Message-ID: <20110218104151.GB7262@sigill.intra.peff.net>
References: <26bc8a07f1b965a3022c3a1542f95422a8462e42.1298023827.git.git@drmicha.warpmail.net>
 <c0ee81b29d902e773dc851aaf86b99c9337079c9.1298023827.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Feb 18 11:42:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqNmv-0006aM-06
	for gcvg-git-2@lo.gmane.org; Fri, 18 Feb 2011 11:42:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753428Ab1BRKl5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Feb 2011 05:41:57 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:56723 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756846Ab1BRKly (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Feb 2011 05:41:54 -0500
Received: (qmail 30975 invoked by uid 111); 18 Feb 2011 10:41:53 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Fri, 18 Feb 2011 10:41:53 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 18 Feb 2011 05:41:51 -0500
Content-Disposition: inline
In-Reply-To: <c0ee81b29d902e773dc851aaf86b99c9337079c9.1298023827.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167195>

On Fri, Feb 18, 2011 at 11:12:42AM +0100, Michael J Gruber wrote:

> Currently, patch-id trips over the diff extension for marking
> the absence of newline at EOF.
> 
> Fix it. (Ignore it, it's whitespace.)
> 
> This uses the same detection rationale as in buitlin/apply.c, which was
> introduced in
> 
> 433ef8a ([PATCH] Make git-apply understand incomplete lines in non-C locales, 2005-09-04)

Thanks, this looks good to me, with one style nit:

> +		else if (!memcmp(line, "\\ ", 2) && strlen(line)>=12)
> +			continue;

Whitespace around relational operators.

-Peff
