From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/6] refs.c: replace write_str_in_full by write_in_full
Date: Wed, 21 Jan 2015 18:38:43 -0500
Message-ID: <20150121233843.GB11115@peff.net>
References: <1421882625-916-1-git-send-email-sbeller@google.com>
 <1421882625-916-4-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com, mhagger@alum.mit.edu,
	loic@dachary.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Jan 22 00:38:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YE4rI-00025k-Vl
	for gcvg-git-2@plane.gmane.org; Thu, 22 Jan 2015 00:38:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752166AbbAUXip (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2015 18:38:45 -0500
Received: from cloud.peff.net ([50.56.180.127]:37094 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751924AbbAUXio (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2015 18:38:44 -0500
Received: (qmail 2346 invoked by uid 102); 21 Jan 2015 23:38:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 21 Jan 2015 17:38:44 -0600
Received: (qmail 1899 invoked by uid 107); 21 Jan 2015 23:39:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 21 Jan 2015 18:39:09 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 21 Jan 2015 18:38:43 -0500
Content-Disposition: inline
In-Reply-To: <1421882625-916-4-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262784>

On Wed, Jan 21, 2015 at 03:23:42PM -0800, Stefan Beller wrote:

> There is another occurrence where we could have used write_str_in_full
> (line 3107: write_in_full(lock->lk->fd, &term, 1)), so the current state
> is inconsistent. This replaces the only occurrence of write_str_in_full
> by write_in_full, so we only need to wrap write_in_full in the next patch.

I had to read the first sentence a few times to figure out what you
meant. But I am not sure it is even relevant. We do not care about the
inconsistency. It is just "we are about to change how callers of
write_in_full in this file behave, the wrapper gets in the way, and it
does not add enough value by itself to merit making our future changes
in two places".

-Peff
