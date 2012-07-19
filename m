From: Jeff King <peff@peff.net>
Subject: [RFC/PATCH 0/3] reflog graveyard
Date: Thu, 19 Jul 2012 17:32:25 -0400
Message-ID: <20120719213225.GA20311@sigill.intra.peff.net>
References: <2C63E314-2EF5-4B8E-B96A-5306E317E045@gmail.com>
 <20120719115558.GC29774@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Alexey Muranov <alexey.muranov@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 19 23:32:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SryKo-0008Q1-C7
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jul 2012 23:32:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751507Ab2GSVc3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jul 2012 17:32:29 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:55595 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751014Ab2GSVc2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jul 2012 17:32:28 -0400
Received: (qmail 3121 invoked by uid 107); 19 Jul 2012 21:32:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 19 Jul 2012 17:32:27 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Jul 2012 17:32:25 -0400
Content-Disposition: inline
In-Reply-To: <20120719115558.GC29774@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201752>

On Thu, Jul 19, 2012 at 07:55:58AM -0400, Jeff King wrote:

> So I think it would be a lot more palatable if we kept reflogs on
> deleted branches. That, in turn, has a few open issues, such as how to
> manage namespace conflicts (e.g., the fact that a deleted "foo" branch
> can conflict with a new "foo/bar" branch).

Here is a patch series to address that. I think I have smoothed out most
of the rough edges, but I wouldn't be surprised if there are some other
corner cases. One that I notice is that "git log -g" will stop walking
when it hits a null sha1 in the reflog.

  [1/3]: retain reflogs for deleted refs
  [2/3]: teach sha1_name to look in graveyard reflogs
  [3/3]: add tests for reflogs of deleted refs

-Peff
