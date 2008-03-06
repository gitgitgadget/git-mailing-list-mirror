From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] Add strbuf_initf()
Date: Thu, 6 Mar 2008 07:09:10 -0500
Message-ID: <20080306120909.GA7518@sigill.intra.peff.net>
References: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at> <1204138503-6126-4-git-send-email-johannes.sixt@telecom.at> <alpine.LSU.1.00.0802281159550.22527@racer.site> <200803052221.12495.johannes.sixt@telecom.at> <alpine.LSU.1.00.0803052317350.15786@racer.site> <7vir00lski.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0803052327570.15786@racer.site> <alpine.LSU.1.00.0803060212170.15786@racer.site> <20080306063331.GA7325@glandium.org> <alpine.LSU.1.00.0803061148180.15786@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Mike Hommey <mh@glandium.org>, Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Mar 06 13:10:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXEvo-0003qy-WE
	for gcvg-git-2@gmane.org; Thu, 06 Mar 2008 13:10:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933688AbYCFMJP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2008 07:09:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933681AbYCFMJO
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Mar 2008 07:09:14 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1026 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933669AbYCFMJM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2008 07:09:12 -0500
Received: (qmail 4694 invoked by uid 111); 6 Mar 2008 12:09:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 06 Mar 2008 07:09:10 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 06 Mar 2008 07:09:10 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LSU.1.00.0803061148180.15786@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76384>

On Thu, Mar 06, 2008 at 11:53:28AM +0100, Johannes Schindelin wrote:

> AFAIR it is unportable to have a macro
> 
> #define strbuf_initf(buf, fmt, ...) \
> 	(strbuf_init(buf, strlen(fmt) + 64), strbuf_addf(buf, fmt, args);) 
> 
> (GNU cpp groks it, but what about the others?)

C99 has variable-argument macros, but C89 does not. I have no idea in
practice how many of the compilers git targets support them (in one form
or another).

-Peff
