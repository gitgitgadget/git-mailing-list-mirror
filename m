From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/2] don't add duplicate paths to info/alternates
Date: Mon, 1 Jun 2015 06:53:48 -0400
Message-ID: <20150601105348.GD31792@peff.net>
References: <1433096123-14420-1-git-send-email-gjthill@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jim Hill <gjthill@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 01 12:53:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzNLw-0005BN-EO
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jun 2015 12:53:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751380AbbFAKxw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2015 06:53:52 -0400
Received: from cloud.peff.net ([50.56.180.127]:38719 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751154AbbFAKxv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jun 2015 06:53:51 -0400
Received: (qmail 30023 invoked by uid 102); 1 Jun 2015 10:53:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 01 Jun 2015 05:53:51 -0500
Received: (qmail 28357 invoked by uid 107); 1 Jun 2015 10:53:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 01 Jun 2015 06:53:51 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 01 Jun 2015 06:53:48 -0400
Content-Disposition: inline
In-Reply-To: <1433096123-14420-1-git-send-email-gjthill@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270398>

On Sun, May 31, 2015 at 11:15:21AM -0700, Jim Hill wrote:

> These patches address
> http://thread.gmane.org/gmane.comp.version-control.git/269050/focus=269415
> linked from the git blame page, avoiding adding duplicates to info/alternates
> and removing hold_lock_file_for_append which is too heavyweight for logging and
> too limited for anything else.

Thanks. Mentioning that I would like something done and then having it
unexpectedly arrive in my mailbox is like getting a present. :)

I had a few comments on the first patch, and the second looks obviously
correct.

> There's an argument to be made that since a-t-a-f is only used by clone, it
> shouldn't even bother taking a lock -- but then it should be moved to
> builtin/clone.c and reduced to a single write of the pre-deduped list, followed
> by a single read_info_alternates call. One thing at a time.  Taking out the
> locking in the incremental version here doesn't really simplify the code much
> anyway.

Yeah, I agree with all of the reasoning here.

-Peff
