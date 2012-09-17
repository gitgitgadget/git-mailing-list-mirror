From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-jump: ignore (custom) prefix in diff mode
Date: Mon, 17 Sep 2012 13:39:45 -0400
Message-ID: <20120917173945.GA22000@sigill.intra.peff.net>
References: <1347844915-4130-1-git-send-email-git@shiar.nl>
 <7vtxuxw7bf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Mischa POSLAWSKY <git@shiar.nl>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 17 19:40:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDfIa-0005oK-Qk
	for gcvg-git-2@plane.gmane.org; Mon, 17 Sep 2012 19:39:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756751Ab2IQRju (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2012 13:39:50 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:46654 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756191Ab2IQRjs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2012 13:39:48 -0400
Received: (qmail 9359 invoked by uid 107); 17 Sep 2012 17:40:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 17 Sep 2012 13:40:12 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 17 Sep 2012 13:39:45 -0400
Content-Disposition: inline
In-Reply-To: <7vtxuxw7bf.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205721>

On Sun, Sep 16, 2012 at 10:24:04PM -0700, Junio C Hamano wrote:

> Mischa POSLAWSKY <git@shiar.nl> writes:
> 
> > Matching the default file prefix b/ does not yield any results if config
> > option diff.noprefix or diff.mnemonicprefix is enabled.
> >
> > Signed-off-by: Mischa POSLAWSKY <git@shiar.nl>
> > ---
> > Very useful script otherwise; thanks.
> >
> >  contrib/git-jump/git-jump | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git contrib/git-jump/git-jump contrib/git-jump/git-jump
> > index a33674e..dc90cd6 100755
> > --- contrib/git-jump/git-jump
> > +++ contrib/git-jump/git-jump
> > @@ -21,9 +21,9 @@ open_editor() {
> >  }
> >  
> >  mode_diff() {
> > -	git diff --relative "$@" |
> > +	git diff --no-prefix --relative "$@" |
> >  	perl -ne '
> > -	if (m{^\+\+\+ b/(.*)}) { $file = $1; next }
> > +	if (m{^\+\+\+ (.*)}) { $file = $1; next }
> >  	defined($file) or next;
> >  	if (m/^@@ .*\+(\d+)/) { $line = $1; next }
> >  	defined($line) or next;
> 
> Makes sense to me.  Peff?

Yes, looks obviously correct. Thanks.

Acked-by: Jeff King <peff@peff.net>

-Peff
