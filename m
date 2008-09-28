From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Implement a textconv filter for "git diff"
Date: Sun, 28 Sep 2008 00:15:26 -0400
Message-ID: <20080928041526.GB24214@coredump.intra.peff.net>
References: <1222567618-22156-1-git-send-email-Matthieu.Moy@imag.fr> <1222567618-22156-2-git-send-email-Matthieu.Moy@imag.fr> <1222567618-22156-3-git-send-email-Matthieu.Moy@imag.fr> <1222567618-22156-4-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Sun Sep 28 06:18:07 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KjnjS-0005xp-Qq
	for gcvg-git-2@gmane.org; Sun, 28 Sep 2008 06:18:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750824AbYI1EP2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Sep 2008 00:15:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750819AbYI1EP2
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Sep 2008 00:15:28 -0400
Received: from peff.net ([208.65.91.99]:3388 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750787AbYI1EP2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Sep 2008 00:15:28 -0400
Received: (qmail 3201 invoked by uid 111); 28 Sep 2008 04:15:27 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 28 Sep 2008 00:15:27 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 28 Sep 2008 00:15:26 -0400
Content-Disposition: inline
In-Reply-To: <1222567618-22156-4-git-send-email-Matthieu.Moy@imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96942>

On Sun, Sep 28, 2008 at 04:06:56AM +0200, Matthieu Moy wrote:

> +static int textconv_two_files(const char *textconv,
> +			      const char *name_a,
> +			      const char *name_b,
> +			      mmfile_t *mf1,
> +			      mmfile_t *mf2,
> +			      struct diff_filespec *one,
> +			      struct diff_filespec *two)
> +{

Must we always be textconv'ing two files? What if I am comparing
"v1.5:foo.odf" to "foo.txt" in the working tree?

In my implementation, I textconv one at a time. I just did so from
fill_mmfile, so all of diff automagically just sees the converted text.

-Peff
