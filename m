From: Jeff King <peff@peff.net>
Subject: [PATCH 0/2] cat-file --batch-check='%(deltabase)'
Date: Sat, 21 Dec 2013 09:23:37 -0500
Message-ID: <20131221142336.GA28649@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 21 15:23:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VuNSw-0005ME-VA
	for gcvg-git-2@plane.gmane.org; Sat, 21 Dec 2013 15:23:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755186Ab3LUOXj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Dec 2013 09:23:39 -0500
Received: from cloud.peff.net ([50.56.180.127]:48531 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754887Ab3LUOXi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Dec 2013 09:23:38 -0500
Received: (qmail 9121 invoked by uid 102); 21 Dec 2013 14:23:38 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 21 Dec 2013 08:23:38 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 21 Dec 2013 09:23:37 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239620>

This series lets you query the delta base for a particular object (or
set of objects), like:

  $ git rev-list --objects --all |
    git cat-file --batch-check='%(objectname) %(deltabase) %(rest)'

The only other way I know of to get this information is using
verify-pack (or index-pack), which is much slower (and less convenient
to parse).

I needed this recently to write tests for another (not yet published)
series. But I think it stands on its own as a debugging / introspection
tool.

  [1/2]: sha1_object_info_extended: provide delta base sha1s
  [2/2]: cat-file: provide %(deltabase) batch format

-Peff
