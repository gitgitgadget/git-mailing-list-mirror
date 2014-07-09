From: Jeff King <peff@peff.net>
Subject: Re: t3200-branch.sh number 102 fails when run under make test
Date: Wed, 9 Jul 2014 16:54:07 -0400
Message-ID: <20140709205407.GA25854@sigill.intra.peff.net>
References: <1404938270.23510.13.camel@jekeller-desk1.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "Keller, Jacob E" <jacob.e.keller@intel.com>
X-From: git-owner@vger.kernel.org Wed Jul 09 22:54:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4ysa-0002N9-BF
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jul 2014 22:54:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751472AbaGIUyK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2014 16:54:10 -0400
Received: from cloud.peff.net ([50.56.180.127]:58951 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750889AbaGIUyJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2014 16:54:09 -0400
Received: (qmail 6544 invoked by uid 102); 9 Jul 2014 20:54:09 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 09 Jul 2014 15:54:09 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 09 Jul 2014 16:54:07 -0400
Content-Disposition: inline
In-Reply-To: <1404938270.23510.13.camel@jekeller-desk1.amr.corp.intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253148>

On Wed, Jul 09, 2014 at 08:37:51PM +0000, Keller, Jacob E wrote:

> I recently cloned the master branch of the git repo, and when I ran make
> test, it fails on test 102 of the t3200-branch.sh test cases.

Just a guess, but try reverting 745224e (refs.c: SSE2 optimizations for
check_refname_component, 2014-06-18).

That commit causes some weird memory accesses that only show up under
certain conditions[1]. There's a possible fix that is not yet applied,
but reverting should be an easy way to test.

-Peff

[1] http://thread.gmane.org/gmane.comp.version-control.git/252881
