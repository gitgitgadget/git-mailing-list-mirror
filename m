From: Jeff King <peff@peff.net>
Subject: [PATCH 0/2] minor cat-file optimizations
Date: Wed, 18 May 2016 12:52:53 -0400
Message-ID: <20160518165253.GA5379@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 18 18:53:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b34iX-0004DA-IH
	for gcvg-git-2@plane.gmane.org; Wed, 18 May 2016 18:53:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932365AbcERQw7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2016 12:52:59 -0400
Received: from cloud.peff.net ([50.56.180.127]:41317 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932118AbcERQw5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2016 12:52:57 -0400
Received: (qmail 11919 invoked by uid 102); 18 May 2016 16:52:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 18 May 2016 12:52:56 -0400
Received: (qmail 24251 invoked by uid 107); 18 May 2016 16:52:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 18 May 2016 12:52:58 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 May 2016 12:52:53 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294975>

At Git Merge, Charles suggested that "--buffer" should be the default
for "--batch-all-objects". This bit me again yesterday, so I thought I'd
actually implement it. :)

That's in the second patch. The first one is another micro-optimization
that happens to help the use case I was working on (the speedup there is
"only" 40%, but the case I was looking at had a pathological number of
packs, and so was even slower).

  [1/2]: cat-file: avoid noop calls to sha1_object_info_extended
  [2/2]: cat-file: default to --buffer when --batch-all-objects is used

-Peff
