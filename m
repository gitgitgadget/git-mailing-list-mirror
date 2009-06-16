From: Jeff King <peff@peff.net>
Subject: Re: git diff looping?
Date: Tue, 16 Jun 2009 13:41:59 -0400
Message-ID: <20090616174159.GA18479@coredump.intra.peff.net>
References: <3ae83b000906151837r186221f2q1f8a670f13841877@mail.gmail.com> <20090616114726.GA4343@coredump.intra.peff.net> <7v3aa0dsvn.fsf@alter.siamese.dyndns.org> <20090616171531.GA17538@coredump.intra.peff.net> <RFQLUdKWnVWgwwX0qsqUhC-pl9v39aFOKMpTbbABiCEXczTo26fVow@cipher.nrlssc.navy.mil> <3ae83b000906161039s1cd540a9k3506a09a5e616c67@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Brandon Casey <casey@nrlssc.navy.mil>,
	Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: John Bito <jwbito@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 16 19:42:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGcfh-0000m5-KQ
	for gcvg-git-2@gmane.org; Tue, 16 Jun 2009 19:42:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757621AbZFPRmA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jun 2009 13:42:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756163AbZFPRmA
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Jun 2009 13:42:00 -0400
Received: from peff.net ([208.65.91.99]:37057 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753299AbZFPRl7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jun 2009 13:41:59 -0400
Received: (qmail 5448 invoked by uid 107); 16 Jun 2009 17:43:45 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 16 Jun 2009 13:43:45 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 16 Jun 2009 13:41:59 -0400
Content-Disposition: inline
In-Reply-To: <3ae83b000906161039s1cd540a9k3506a09a5e616c67@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121695>

On Tue, Jun 16, 2009 at 10:39:39AM -0700, John Bito wrote:

> I believe the issue is that Solaris implements 'extended' regular
> expressions only in regcomp/regexec.  The implementation of
> regcmp/regex seems to be from SysV and supports only 'basic' regular
> expressions.

The regexps in question end up being compiled by regcomp (see
xdiff-interface.c:xdiff_set_find_func), so I don't think that is the
issue.

-Peff
