From: Jeff King <peff@peff.net>
Subject: [RFC/PATCH 0/4] config include directives
Date: Thu, 26 Jan 2012 02:35:47 -0500
Message-ID: <20120126073547.GA28689@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 26 08:36:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RqJsL-00061V-2v
	for gcvg-git-2@lo.gmane.org; Thu, 26 Jan 2012 08:36:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751524Ab2AZHfy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jan 2012 02:35:54 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:44997
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751242Ab2AZHfx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jan 2012 02:35:53 -0500
Received: (qmail 23877 invoked by uid 107); 26 Jan 2012 07:42:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 26 Jan 2012 02:42:51 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 26 Jan 2012 02:35:47 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189140>

This series provides a way for config files to include other config
files in two ways:

  1. From other files in the filesystem. This is implemented by patch 1
     below, and is hopefully straightforward and uncontroversial.  See
     that patch for more rationale.

  2. From blobs in the repo. This is implemented by patch 4, with
     patches 2 and 3 providing the necessary refactoring. This
     is one way of implementing the often asked-for "respect shared
     config inside the repo" feature, but attempts to mitigate some of
     the security concerns. The interface for using it safely is a bit
     raw, but I think it's a sane building block, and somebody could
     write a fancier shared-config updater on top of it if they wanted
     to.

  [1/4]: config: add include directive
  [2/4]: config: factor out config file stack management
  [3/4]: config: support parsing config data from buffers
  [4/4]: config: allow including config from repository blobs

-Peff
