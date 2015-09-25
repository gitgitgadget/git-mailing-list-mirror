From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH v1] Add Travis CI support
Date: Fri, 25 Sep 2015 12:26:16 -0400
Message-ID: <20150925162615.GF8417@sigill.intra.peff.net>
References: <1443131004-39284-1-git-send-email-larsxschneider@gmail.com>
 <xmqqeghnuy8t.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: larsxschneider@gmail.com, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 25 18:26:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZfVpH-0005zm-JE
	for gcvg-git-2@plane.gmane.org; Fri, 25 Sep 2015 18:26:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932583AbbIYQ0T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Sep 2015 12:26:19 -0400
Received: from cloud.peff.net ([50.56.180.127]:36481 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932263AbbIYQ0S (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Sep 2015 12:26:18 -0400
Received: (qmail 21135 invoked by uid 102); 25 Sep 2015 16:26:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 25 Sep 2015 11:26:18 -0500
Received: (qmail 5797 invoked by uid 107); 25 Sep 2015 16:26:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 25 Sep 2015 12:26:31 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 25 Sep 2015 12:26:16 -0400
Content-Disposition: inline
In-Reply-To: <xmqqeghnuy8t.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278665>

On Thu, Sep 24, 2015 at 05:41:06PM -0700, Junio C Hamano wrote:

> Of course, this can be improved if we start using signed push into
> GitHub.  It is a separate issue in the sense that it would help
> GitHub to make that assurance stronger---those who fetch/clone can
> be assured that the tips of branches are what I pushed, without even
> trusting GitHub.

It's been on my todo list to investigate this further, but I just
haven't gotten around to it. My understanding is that GitHub would need
to store your signed-push certificate somewhere (e.g., in a git tree
that records all of the push certs).

If the point is for clients not to trust GitHub, though, it doesn't
really matter what GitHub does with the cert, as long as it is put
somewhere that clients know to get it.  So I wonder if it would be
helpful to have a microformat that the client would use to look at this.
E.g., it would fetch the cert tree, then confirm that the current ref
values match the latest cert.

-Peff
