From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] log: do not print ellipses with --abbrev-commit
Date: Fri, 13 Feb 2009 17:24:50 -0500
Message-ID: <20090213222450.GB7424@coredump.intra.peff.net>
References: <7vprhm81kk.fsf@gitster.siamese.dyndns.org> <1234563041-25061-1-git-send-email-trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Adeodato =?utf-8?B?U2ltw7M=?= <dato@net.com.org.es>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Feb 13 23:26:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LY6UG-0003uY-7L
	for gcvg-git-2@gmane.org; Fri, 13 Feb 2009 23:26:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753944AbZBMWYx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2009 17:24:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753297AbZBMWYw
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Feb 2009 17:24:52 -0500
Received: from peff.net ([208.65.91.99]:42532 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752632AbZBMWYw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2009 17:24:52 -0500
Received: (qmail 26504 invoked by uid 107); 13 Feb 2009 22:25:10 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 13 Feb 2009 17:25:10 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Feb 2009 17:24:50 -0500
Content-Disposition: inline
In-Reply-To: <1234563041-25061-1-git-send-email-trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109780>

On Fri, Feb 13, 2009 at 11:10:41PM +0100, Thomas Rast wrote:

> 'git log --abbrev-commit' added an ellipsis to all commit names that
> were abbreviated.  This was particularly annoying if you wanted to
> cut&paste the sha1 from the terminal, since selecting by word would
> pick up '...'  too.
> 
> So use find_unique_abbrev() instead of diff_unique_abbrev() in all
> log-related commit sha1 printing routines, and also change the
> formatting of the 'Merge: parent1 parent2' line output via
> pretty_print_commit().

I like this. I have always hated the dots, and even started typing extra
--pretty=tformat lines to get rid of them. I always just assumed we
didn't want to change the output, but I think Junio's reasoning that
scripts cannot be relying on this is sane.

-Peff
