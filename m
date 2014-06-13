From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/3] gpg-interface: provide access to the payload
Date: Fri, 13 Jun 2014 03:55:51 -0400
Message-ID: <20140613075550.GI7908@sigill.intra.peff.net>
References: <cover.1402063795.git.git@drmicha.warpmail.net>
 <558044a975c940d19370394900bb44bf4fb2387d.1402063796.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Jun 13 09:56:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvML7-0001OG-RC
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jun 2014 09:55:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752905AbaFMHzx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2014 03:55:53 -0400
Received: from cloud.peff.net ([50.56.180.127]:43261 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751988AbaFMHzw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2014 03:55:52 -0400
Received: (qmail 10858 invoked by uid 102); 13 Jun 2014 07:55:53 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 13 Jun 2014 02:55:52 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Jun 2014 03:55:51 -0400
Content-Disposition: inline
In-Reply-To: <558044a975c940d19370394900bb44bf4fb2387d.1402063796.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251530>

On Fri, Jun 06, 2014 at 04:15:27PM +0200, Michael J Gruber wrote:

> diff --git a/builtin/merge.c b/builtin/merge.c
> [...]
> +			free(signature_check.payload);
>  			free(signature_check.gpg_output);
>  			free(signature_check.gpg_status);
>  			free(signature_check.signer);
> [...]
> diff --git a/pretty.c b/pretty.c
> [...]
> +	free(context.signature_check.payload);
>  	free(context.signature_check.gpg_output);
>  	free(context.signature_check.gpg_status);
>  	free(context.signature_check.signer);

Perhaps this is a sign that we need a "signature_check_clear()" helper?

-Peff
