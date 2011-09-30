From: Jeff King <peff@peff.net>
Subject: Re: Bug?: 'git log --find-copies' doesn't match 'git log --follow
 <rev> -- path/to/file'
Date: Fri, 30 Sep 2011 17:38:41 -0400
Message-ID: <20110930213841.GA9384@sigill.intra.peff.net>
References: <DBC73B3F-2703-4651-AADA-233A9CC38AFD@inf.fu-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Alexander Pepper <pepper@inf.fu-berlin.de>
X-From: git-owner@vger.kernel.org Fri Sep 30 23:38:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9knA-0007Nn-Of
	for gcvg-git-2@lo.gmane.org; Fri, 30 Sep 2011 23:38:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756667Ab1I3Vio (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Sep 2011 17:38:44 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:50426
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757013Ab1I3Vin (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Sep 2011 17:38:43 -0400
Received: (qmail 4675 invoked by uid 107); 30 Sep 2011 21:43:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 30 Sep 2011 17:43:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Sep 2011 17:38:41 -0400
Content-Disposition: inline
In-Reply-To: <DBC73B3F-2703-4651-AADA-233A9CC38AFD@inf.fu-berlin.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182511>

On Fri, Sep 30, 2011 at 05:32:38PM +0200, Alexander Pepper wrote:

> So git log with copy and rename detection on (--find-copies) tells me,
> that the file StopClusterException.java is copied to
> ClusterOperation.java. But If I ask git log for that specific file
> with --follow git claims a copy from Immutable.java to
> ClusterOperation.java!

I think that --follow uses --find-copies-harder. Did you try:

  git log --numstat --find-copies-harder dd4e90f9

? Does it find Immutable.java as the source?

-Peff
