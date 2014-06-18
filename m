From: Jeff King <peff@peff.net>
Subject: [PATCH 0/2] dropping manual malloc calculations
Date: Wed, 18 Jun 2014 16:00:01 -0400
Message-ID: <20140618200000.GA22994@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 18 22:00:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxM1h-00080h-U3
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jun 2014 22:00:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755115AbaFRUAD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2014 16:00:03 -0400
Received: from cloud.peff.net ([50.56.180.127]:46976 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754664AbaFRUAC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2014 16:00:02 -0400
Received: (qmail 31080 invoked by uid 102); 18 Jun 2014 20:00:02 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 18 Jun 2014 15:00:02 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Jun 2014 16:00:01 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252050>

While working on the skip_prefix series, I ended up grepping for:

  + strlen("

to find spots in need of skip_prefix. Of course, it turns up many other
nasty ad-hoc calculations. Here's a short series that addresses a few.
There are many more, but hopefully the first patch provides a tool that
can help us in the future.

  [1/2]: strbuf: add xstrdup_fmt helper
  [2/2]: use xstrdup_fmt in favor of manual size calculations

-Peff
