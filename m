From: Jeff King <peff@peff.net>
Subject: [PATCH 0/10] cleaning up check_repository_format_gently
Date: Tue, 1 Mar 2016 09:35:46 -0500
Message-ID: <20160301143546.GA30806@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: David Turner <dturner@twopensource.com>, mhagger@alum.mit.edu,
	pclouds@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 01 15:35:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aalP1-0003Kx-3E
	for gcvg-git-2@plane.gmane.org; Tue, 01 Mar 2016 15:35:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753747AbcCAOfu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2016 09:35:50 -0500
Received: from cloud.peff.net ([50.56.180.127]:52398 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753469AbcCAOfu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2016 09:35:50 -0500
Received: (qmail 27391 invoked by uid 102); 1 Mar 2016 14:35:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 01 Mar 2016 09:35:49 -0500
Received: (qmail 8069 invoked by uid 107); 1 Mar 2016 14:36:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 01 Mar 2016 09:36:00 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 01 Mar 2016 09:35:46 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288017>

After the discussion in:

  http://thread.gmane.org/gmane.comp.version-control.git/287949/focus=288002

I came up with this series to try to address some of the warts in
check_repository_format_gently().

I had hoped to come up with something very small that could go at the
front of the refs-backend series, but as with any time I look at the
setup code, it managed to snowball into a potpourri of hidden
assumptions.

So I hope David isn't _too_ irritated to see this in his inbox. Rebasing
the refs-backend on top shouldn't be too bad, and the end result would
be cleaner and more correct. My bigger worry is just that changing the
setup code is inherently flaky, and I don't want to hold David's series
hostage.

  [01/10]: setup: document check_repository_format()
  [02/10]: wrap shared_repository global in get/set accessors
  [03/10]: lazily load core.sharedrepository
  [04/10]: check_repository_format_gently: stop using git_config_early
  [05/10]: config: drop git_config_early
  [06/10]: setup: refactor repo format reading and verification
  [07/10]: init: use setup.c's repo version verification
  [08/10]: setup: unify repository version callbacks
  [09/10]: setup: drop repository_format_version global
  [10/10]: setup: drop GIT_REPO_VERSION constants

-Peff
