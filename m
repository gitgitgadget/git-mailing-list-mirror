From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 00/11] Make "local" orthogonal to date format
Date: Tue, 8 Sep 2015 03:53:43 -0400
Message-ID: <20150908075343.GA2991@sigill.intra.peff.net>
References: <cover.1441144343.git.john@keeping.me.uk>
 <cover.1441316394.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Tue Sep 08 09:53:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZZDj2-00056G-3I
	for gcvg-git-2@plane.gmane.org; Tue, 08 Sep 2015 09:53:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753632AbbIHHxq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Sep 2015 03:53:46 -0400
Received: from cloud.peff.net ([50.56.180.127]:56151 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753042AbbIHHxq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Sep 2015 03:53:46 -0400
Received: (qmail 26749 invoked by uid 102); 8 Sep 2015 07:53:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 08 Sep 2015 02:53:46 -0500
Received: (qmail 19674 invoked by uid 107); 8 Sep 2015 07:53:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 08 Sep 2015 03:53:51 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 08 Sep 2015 03:53:43 -0400
Content-Disposition: inline
In-Reply-To: <cover.1441316394.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277494>

On Thu, Sep 03, 2015 at 10:48:50PM +0100, John Keeping wrote:

> Since version 2 there are four new preparatory patches which remove
> lists of date formats from documentation in favour of referring to the
> detailed list in git-rev-list(1) or git-log(1) (both generated from
> Documentation/rev-list-options.txt) depending on whether the page in
> question is plumbing/porcelain.

This version looks good to me. It turned out to be a bigger job than we
expected at first; thanks for seeing it through.

> In patch 7 (date: check for "local" before anything else), we no longer
> reject "relative-local" and "raw-local" now prints the user's local
> timezone offset.  The error message for invalid formats that are
> prefixed with a valid format name is now the same as that if there is no
> valid prefix.

That sounds OK. We have enough information in our parsing state to say
"I understood the 'iso8601', but '-foobar' did not make any sense to
me". But it's doubtful that would ever come up in practice.

-Peff
