From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] diff: respect textconv in rewrite diffs
Date: Wed, 10 Dec 2008 04:02:22 -0500
Message-ID: <20081210090221.GA11367@coredump.intra.peff.net>
References: <20081209081227.GA19626@coredump.intra.peff.net> <20081209081321.GA19707@coredump.intra.peff.net> <7v3agw2zu5.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 10 10:03:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAKz1-0002US-CO
	for gcvg-git-2@gmane.org; Wed, 10 Dec 2008 10:03:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754051AbYLJJC0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2008 04:02:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754142AbYLJJC0
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Dec 2008 04:02:26 -0500
Received: from peff.net ([208.65.91.99]:4005 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753731AbYLJJCZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2008 04:02:25 -0500
Received: (qmail 7495 invoked by uid 111); 10 Dec 2008 09:02:23 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 10 Dec 2008 04:02:23 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Dec 2008 04:02:22 -0500
Content-Disposition: inline
In-Reply-To: <7v3agw2zu5.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102676>

On Wed, Dec 10, 2008 at 12:34:26AM -0800, Junio C Hamano wrote:

> > +cat >dump <<'EOF'
> > +#!/bin/sh
> > +perl -e '$/ = undef; $_ = <>; s/./ord($&)/ge; print $_' < "$1"
> > +EOF
> 
> I'll squash in a change to make this part use $SHELL_PATH for
> consistency.  Thanks.

It was cut-and-paste from t4030, so if we care, it might be worth
changing there, too (and naming it "dump" instead of "hexdump", because
it actually dumps in decimal :) ).

But more importantly, the fixup you just pushed seems to have an extra
">dump":

> +{
> +       echo "#!$SHELL_PATH"
> +       cat >dump <<'EOF'
> +perl -e '$/ = undef; $_ = <>; s/./ord($&)/ge; print $_' < "$1"
> +EOF
> +} >dump
> +chmod +x dump

-Peff
