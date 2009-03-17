From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Tests: use test_cmp instead of diff where possible
Date: Tue, 17 Mar 2009 04:28:45 -0400
Message-ID: <20090317082845.GH18475@coredump.intra.peff.net>
References: <1237124036-1348-1-git-send-email-vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Tue Mar 17 09:30:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjUgx-0007s9-JL
	for gcvg-git-2@gmane.org; Tue, 17 Mar 2009 09:30:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761704AbZCQI24 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2009 04:28:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761232AbZCQI2y
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Mar 2009 04:28:54 -0400
Received: from peff.net ([208.65.91.99]:36857 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758966AbZCQI2x (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2009 04:28:53 -0400
Received: (qmail 2910 invoked by uid 107); 17 Mar 2009 08:28:59 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 17 Mar 2009 04:28:59 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 17 Mar 2009 04:28:45 -0400
Content-Disposition: inline
In-Reply-To: <1237124036-1348-1-git-send-email-vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113438>

On Sun, Mar 15, 2009 at 02:33:56PM +0100, Miklos Vajna wrote:

> I intentionally did not touch t5000 - using test_cmp -r works for me,
> since the default is diff -u, but that would break the setup of users
> where GIT_TEST_CMP is set to cmp.

Definitely "test_cmp -r" is a bad idea since we don't know what
underlies it. But I wonder how portable "diff -r" is. Wasn't it a point
of contention in the recent cvsimport tests that were added (and Michael
ended up writing a mini recursive differ using some shell commands)?

OTOH, I haven't seen any complaints about it, so perhaps it is fine to
leave it.

-Peff
