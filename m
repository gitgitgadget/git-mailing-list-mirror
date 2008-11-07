From: Jeff King <peff@peff.net>
Subject: [RFC PATCH 0/4] deny push to current branch of non-bare repo
Date: Fri, 7 Nov 2008 17:07:30 -0500
Message-ID: <20081107220730.GA15942@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Sam Vilain <sam@vilain.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 07 23:08:49 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KyZVY-00088o-O9
	for gcvg-git-2@gmane.org; Fri, 07 Nov 2008 23:08:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751525AbYKGWHe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Nov 2008 17:07:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751279AbYKGWHe
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Nov 2008 17:07:34 -0500
Received: from peff.net ([208.65.91.99]:4571 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751016AbYKGWHd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Nov 2008 17:07:33 -0500
Received: (qmail 2646 invoked by uid 111); 7 Nov 2008 22:07:31 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 07 Nov 2008 17:07:31 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 07 Nov 2008 17:07:30 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100339>

The short of it is that it's dangerous, we see people confused by it
(there was another one just yesterday), and it's a FAQ:

  http://git.or.cz/gitwiki/GitFaq#head-b96f48bc9c925074be9f95c0fce69bcece5f6e73

The FAQ even says "don't do this until you know what you are doing." So
the safety valve is configurable, so that those who know what they are
doing can switch it off.

And it's even on Sam's "UI improvements" list. :)

Patch 4/4 is the interesting one. 1/4 is a cleanup I saw while fixing
tests. 2/4 is a cleanup to prepare for 3/4. And 3/4 fixes a bunch of
tests which were inadvertently doing such a push (but didn't care
because they didn't look at the working directory).

-Peff
