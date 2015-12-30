From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 0/3] improve symbolic-ref robustness
Date: Wed, 30 Dec 2015 01:57:28 -0500
Message-ID: <20151230065728.GB26964@sigill.intra.peff.net>
References: <20151220072637.GA22102@sigill.intra.peff.net>
 <20151229055558.GA12848@sigill.intra.peff.net>
 <xmqqpoxpgd7p.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: David Turner <dturner@twopensource.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 30 07:57:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aEAhS-0002YF-Me
	for gcvg-git-2@plane.gmane.org; Wed, 30 Dec 2015 07:57:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751805AbbL3G5c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Dec 2015 01:57:32 -0500
Received: from cloud.peff.net ([50.56.180.127]:47039 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751216AbbL3G5a (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Dec 2015 01:57:30 -0500
Received: (qmail 16766 invoked by uid 102); 30 Dec 2015 06:57:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 30 Dec 2015 00:57:30 -0600
Received: (qmail 28428 invoked by uid 107); 30 Dec 2015 06:57:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 30 Dec 2015 01:57:43 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 30 Dec 2015 01:57:28 -0500
Content-Disposition: inline
In-Reply-To: <xmqqpoxpgd7p.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283165>

On Tue, Dec 29, 2015 at 01:24:42PM -0800, Junio C Hamano wrote:

> > The patches are:
> >
> >   [1/3]: create_symref: modernize variable names
> >   [2/3]: create_symref: use existing ref-lock code
> >   [3/3]: create_symref: write reflog while holding lock
> 
> This is queued as an early part of 'pu', and some refactoring in
> David's refs-backend-lmdb topic conflicts with it when merged to
> 'pu'.  I think I resolved the conflicts correctly, but please double
> check the result when I push it out later today.

Looks sane to me. It seems like the change was just the renaming of the
functions. We _could_ match the renaming of the static-local functions
(e.g., create_symref_locked would become files_create_symref_locked),
but I don't think it's necessary for file-local functions.

-Peff
