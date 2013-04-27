From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/6] clone: Make the 'junk_mode' symbol a file static
Date: Sat, 27 Apr 2013 19:21:25 -0400
Message-ID: <20130427232124.GA13800@sigill.intra.peff.net>
References: <517C1B48.5090206@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Sun Apr 28 01:21:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWER3-0004HU-Ll
	for gcvg-git-2@plane.gmane.org; Sun, 28 Apr 2013 01:21:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753758Ab3D0XV1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Apr 2013 19:21:27 -0400
Received: from cloud.peff.net ([50.56.180.127]:50407 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752897Ab3D0XV1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Apr 2013 19:21:27 -0400
Received: (qmail 23614 invoked by uid 102); 27 Apr 2013 23:21:39 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 27 Apr 2013 18:21:39 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 27 Apr 2013 19:21:25 -0400
Content-Disposition: inline
In-Reply-To: <517C1B48.5090206@ramsay1.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222715>

On Sat, Apr 27, 2013 at 07:39:04PM +0100, Ramsay Jones wrote:

> Sparse issues an "'junk_mode' not declared. Should it be static?"
> warning. In order to suppress the warning, since this symbol does
> not need more than file visibility, we simply add the static
> modifier to it's declaration.
> [...]
> -enum {
> +static enum {
>  	JUNK_LEAVE_NONE,

Thanks. This one was done by me, and yes it should be static. I think it
is because I originally typed:

  enum junk_mode {
    ...
  };
  static enum junk_mode junk_mode;

and then later dropped the named type, but forgot to keep the static
keyword.

-Peff
