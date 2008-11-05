From: Jeff King <peff@peff.net>
Subject: Re: Intensive rename detection
Date: Tue, 4 Nov 2008 22:22:21 -0500
Message-ID: <20081105032220.GE20907@coredump.intra.peff.net>
References: <216e54900811031717j70669868p3c7503357ceb5138@mail.gmail.com> <216e54900811031718o4cc81294sc0c32be1e71b9372@mail.gmail.com> <alpine.LFD.2.00.0811032021210.3419@nehalem.linux-foundation.org> <216e54900811032107p159e98ecn8958f0a78efde8f2@mail.gmail.com> <216e54900811032119h4cb51327v2d85712acc444185@mail.gmail.com> <216e54900811032202h5c82e3a9j30100e5b82f6a16a@mail.gmail.com> <20081104061647.GA18297@coredump.intra.peff.net> <216e54900811032236l5ae4bde5v16ab6519962e428f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Andrew Arnott <andrewarnott@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 05 04:23:55 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxYzn-0005kP-QD
	for gcvg-git-2@gmane.org; Wed, 05 Nov 2008 04:23:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754124AbYKEDWZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Nov 2008 22:22:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754092AbYKEDWZ
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Nov 2008 22:22:25 -0500
Received: from peff.net ([208.65.91.99]:1100 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754087AbYKEDWY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Nov 2008 22:22:24 -0500
Received: (qmail 11616 invoked by uid 111); 5 Nov 2008 03:22:22 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 04 Nov 2008 22:22:22 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 04 Nov 2008 22:22:21 -0500
Content-Disposition: inline
In-Reply-To: <216e54900811032236l5ae4bde5v16ab6519962e428f@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100139>

On Mon, Nov 03, 2008 at 10:36:42PM -0800, Andrew Arnott wrote:

> Yes, on git status.  I'm afraid I don't know how to look up the
> reference you gave.

Sorry, gmane is back up, so the link is:

  http://article.gmane.org/gmane.comp.version-control.git/99147

With that patch, and this one on top, "git status" should respect your
rename limits (though I haven't tested it).

---
diff --git a/wt-status.c b/wt-status.c
index c3a9cab..0b92ac3 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -214,7 +214,6 @@ static void wt_status_print_updated(struct wt_status *s)
 	rev.diffopt.format_callback = wt_status_print_updated_cb;
 	rev.diffopt.format_callback_data = s;
 	rev.diffopt.detect_rename = 1;
-	rev.diffopt.rename_limit = 200;
 	rev.diffopt.break_opt = 0;
 	run_diff_index(&rev, 1);
 }

-Peff
