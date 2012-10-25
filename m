From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] fix 'make test' for HP NonStop
Date: Thu, 25 Oct 2012 05:58:26 -0400
Message-ID: <20121025095826.GM8390@sigill.intra.peff.net>
References: <001e01cdb061$c25f6380$471e2a80$@schmitz-digital.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Joachim Schmitz <jojo@schmitz-digital.de>
X-From: git-owner@vger.kernel.org Thu Oct 25 11:58:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRKD5-00048S-6t
	for gcvg-git-2@plane.gmane.org; Thu, 25 Oct 2012 11:58:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422887Ab2JYJ6b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2012 05:58:31 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:56068 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422844Ab2JYJ63 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2012 05:58:29 -0400
Received: (qmail 7251 invoked by uid 107); 25 Oct 2012 09:59:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 25 Oct 2012 05:59:09 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 25 Oct 2012 05:58:26 -0400
Content-Disposition: inline
In-Reply-To: <001e01cdb061$c25f6380$471e2a80$@schmitz-digital.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208380>

On Mon, Oct 22, 2012 at 04:30:17PM +0200, Joachim Schmitz wrote:

> +	# for 'make test'
> +	# some test don't work with /bin/diff, some fail with /bin/tar
> +	# some need bash, and some need ${prefix}/bin in PATH first
> +	SHELL_PATH=${prefix}/bin/bash
> +	SANE_TOOL_PATH=${prefix}/bin

This feels a little too specific to go in our Makefile. Do we have any
reason to think that where you are installing git is going to be the
same place you have bash and other sane tools? Wouldn't this mean that
things work when you run "make" but mysteriously break when you run
"make prefix=/my/local/install/of/git"?

-Peff
