From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 1/4] apply: reject input that touches outside $cwd
Date: Tue, 3 Feb 2015 16:24:50 -0500
Message-ID: <20150203212450.GC20594@peff.net>
References: <1422919650-13346-1-git-send-email-gitster@pobox.com>
 <1422919650-13346-2-git-send-email-gitster@pobox.com>
 <20150203005005.GB31946@peff.net>
 <xmqqpp9qrbgf.fsf@gitster.dls.corp.google.com>
 <20150203210140.GA20594@peff.net>
 <xmqqtwz2pu4c.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 03 22:25:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YIky2-0004aM-At
	for gcvg-git-2@plane.gmane.org; Tue, 03 Feb 2015 22:25:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161189AbbBCVYz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2015 16:24:55 -0500
Received: from cloud.peff.net ([50.56.180.127]:44813 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1161164AbbBCVYw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2015 16:24:52 -0500
Received: (qmail 16031 invoked by uid 102); 3 Feb 2015 21:24:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 03 Feb 2015 15:24:52 -0600
Received: (qmail 14521 invoked by uid 107); 3 Feb 2015 21:24:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 03 Feb 2015 16:24:52 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Feb 2015 16:24:50 -0500
Content-Disposition: inline
In-Reply-To: <xmqqtwz2pu4c.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263335>

On Tue, Feb 03, 2015 at 01:23:15PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Right, I do not think these tests will _fail_ when the filesystem does
> > not support symlinks. But nor are they actually testing anything
> > interesting. They would pass on such a system even without your patch,
> > as we would fail to apply even the symlink creation part of the patch.
> 
> I thought we write out the contents of the symbolic link as a
> regular file on such a filesystem, and as long as we do not expect
> "test -h expected-to-be-symlink-we-just-created" to succeed we would
> be fine.

But wouldn't we still fail writing "foo/bar" at that point if "foo" is a
regular file (again, we should never do this, but that is the point of
the test).

-Peff
