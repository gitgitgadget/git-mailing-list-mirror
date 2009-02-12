From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/3] builtin-remote: move duplicated cleanup code its
	own function
Date: Wed, 11 Feb 2009 19:18:36 -0500
Message-ID: <20090212001836.GB30231@coredump.intra.peff.net>
References: <1234332083-45147-1-git-send-email-jaysoffian@gmail.com> <1234332083-45147-2-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 12 01:20:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXPJG-000089-Fm
	for gcvg-git-2@gmane.org; Thu, 12 Feb 2009 01:20:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754984AbZBLASi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 19:18:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754820AbZBLASi
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 19:18:38 -0500
Received: from peff.net ([208.65.91.99]:44657 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754813AbZBLASh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 19:18:37 -0500
Received: (qmail 4240 invoked by uid 107); 12 Feb 2009 00:18:55 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 11 Feb 2009 19:18:55 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 11 Feb 2009 19:18:36 -0500
Content-Disposition: inline
In-Reply-To: <1234332083-45147-2-git-send-email-jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109549>

On Wed, Feb 11, 2009 at 01:01:21AM -0500, Jay Soffian wrote:

> +static void free_remote_ref_states(struct ref_states *states)
> +{
> +	/* NEEDSWORK: free remote */
> +	string_list_clear(&states->new, 0);
> +	string_list_clear(&states->stale, 0);
> +	string_list_clear(&states->tracked, 0);
> +}

Hmm. I don't know anything about this code, so maybe it is not trivial.
But anytime you are touching an area that NEEDSWORK, I think it is worth
looking at whether you can fix that problem (since you have already
spent a few brain cycles understanding what is going on in general).

-Peff
