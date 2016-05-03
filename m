From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t7300: mark test with SANITY
Date: Tue, 3 May 2016 15:04:17 -0400
Message-ID: <20160503190417.GD30530@sigill.intra.peff.net>
References: <1462301672-20866-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: gitster@pobox.com, git@vger.kernel.org, janx@linux.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue May 03 21:04:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axfcP-0000xC-19
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 21:04:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934594AbcECTEV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2016 15:04:21 -0400
Received: from cloud.peff.net ([50.56.180.127]:33297 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933291AbcECTEU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 15:04:20 -0400
Received: (qmail 21756 invoked by uid 102); 3 May 2016 19:04:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 03 May 2016 15:04:19 -0400
Received: (qmail 363 invoked by uid 107); 3 May 2016 19:04:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 03 May 2016 15:04:31 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 May 2016 15:04:17 -0400
Content-Disposition: inline
In-Reply-To: <1462301672-20866-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293438>

On Tue, May 03, 2016 at 11:54:32AM -0700, Stefan Beller wrote:

> As the test runs `chmod 0` on a file, we don't want to run that test
> as root.

This somehow misses the root (no pun intended) of the issue, to me.
Perhaps:

  We `chmod 0` a file and test a case where git is unable to read it.
  If the test is run as root, the permissions are ignored, and our
  simulated read failure does not happen.

The patch itself looks obviously correct. :)

-Peff
