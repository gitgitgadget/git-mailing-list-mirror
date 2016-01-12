From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 2/2] lock_ref_sha1_basic: handle REF_NODEREF with
 invalid refs
Date: Tue, 12 Jan 2016 08:26:28 -0500
Message-ID: <20160112132628.GA31854@sigill.intra.peff.net>
References: <20160112095638.GA4773@sigill.intra.peff.net>
 <20160112095804.GB16501@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 12 14:26:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aIyy3-0002bP-ON
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jan 2016 14:26:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752922AbcALN0c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2016 08:26:32 -0500
Received: from cloud.peff.net ([50.56.180.127]:52177 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752865AbcALN0b (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2016 08:26:31 -0500
Received: (qmail 30130 invoked by uid 102); 12 Jan 2016 13:26:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 12 Jan 2016 08:26:30 -0500
Received: (qmail 13828 invoked by uid 107); 12 Jan 2016 13:26:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 12 Jan 2016 08:26:48 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 12 Jan 2016 08:26:28 -0500
Content-Disposition: inline
In-Reply-To: <20160112095804.GB16501@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283815>

On Tue, Jan 12, 2016 at 04:58:04AM -0500, Jeff King wrote:

> +test_expect_failure 'checkout away from d/f HEAD (to branch)' '
> +	reset_to_df &&
> +	git checkout master
> +'
> +
> +test_expect_failure 'checkout away from d/f HEAD (to detached)' '
> +	reset_to_df &&
> +	git checkout --detach master
> +'

These should be expect_success, of course (I had originally planned to
introduce the tests and then fix them later, but it all ended up in the
same patch).

Unfortunately, I think there is a case we're missing. I'm still digging,
but hope to have something soon. In the meantime, don't bother with v2.
:)

-Peff
