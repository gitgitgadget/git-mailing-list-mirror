From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Add the GIT_SENTINEL macro
Date: Thu, 18 Jul 2013 16:31:51 -0400
Message-ID: <20130718203150.GA15735@sigill.intra.peff.net>
References: <51E849C4.7020305@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Thu Jul 18 22:32:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uzuro-0005rq-F6
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jul 2013 22:32:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759238Ab3GRUb4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jul 2013 16:31:56 -0400
Received: from cloud.peff.net ([50.56.180.127]:42462 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755103Ab3GRUb4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jul 2013 16:31:56 -0400
Received: (qmail 26484 invoked by uid 102); 18 Jul 2013 20:31:56 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 18 Jul 2013 15:31:56 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 18 Jul 2013 16:31:51 -0400
Content-Disposition: inline
In-Reply-To: <51E849C4.7020305@ramsay1.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230739>

On Thu, Jul 18, 2013 at 09:02:12PM +0100, Ramsay Jones wrote:

> The sentinel function attribute is not understood by versions of
> the gcc compiler prior to v4.0. At present, for earlier versions
> of gcc, the build issues 108 warnings related to the unknown
> attribute. In order to suppress the warnings, we conditionally
> define the GIT_SENTINEL macro to provide the sentinel attribute
> for gcc v4.0 and newer.
> 
> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
> ---

Acked-by: Jeff King <peff@peff.net>

> -__attribute__((sentinel))
> +GIT_SENTINEL(0)
>  void argv_array_pushl(struct argv_array *, ...);

We could also add GIT_SENTINEL to handle the default-zero case, but I do
not think it is worth the trouble.

-Peff
