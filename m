From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] pack-objects: Print a message describing the number of
	threads for packing
Date: Tue, 26 Feb 2008 02:49:33 -0500
Message-ID: <20080226074933.GA3485@coredump.intra.peff.net>
References: <47B1BEC6.6080906@nrlssc.navy.mil> <1203732369-30314-1-git-send-email-casey@nrlssc.navy.mil> <47BF812A.4020205@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Andreas Ericsson <ae@op5.se>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@cam.org>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Tue Feb 26 08:50:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTuZs-0006IE-1y
	for gcvg-git-2@gmane.org; Tue, 26 Feb 2008 08:50:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756923AbYBZHth (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Feb 2008 02:49:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756514AbYBZHth
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Feb 2008 02:49:37 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4137 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756466AbYBZHtg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Feb 2008 02:49:36 -0500
Received: (qmail 23893 invoked by uid 111); 26 Feb 2008 07:49:34 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 26 Feb 2008 02:49:34 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 26 Feb 2008 02:49:33 -0500
Content-Disposition: inline
In-Reply-To: <47BF812A.4020205@nrlssc.navy.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75107>

On Fri, Feb 22, 2008 at 08:12:58PM -0600, Brandon Casey wrote:

> +	if (progress)
> +		fprintf(stderr, "Using %d pack threads.\n",
> +			delta_search_threads);

I just noticed that this was in next. Do we really need to display this
message? A considerable amount of discussion went into reducing git's
chattiness and clutter during push and fetch, and I feel like this is a
step backwards (yes, I know most people won't see it if they don't build
with THREADED_DELTA_SEARCH).

Can we show it only if threads != 1? Only if we auto-detected the number
of threads and it wasn't 1?

-Peff
