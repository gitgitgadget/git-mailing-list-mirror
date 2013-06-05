From: Jeff King <peff@peff.net>
Subject: Re: git archive --worktree-attributes doesn't exclude .gitattributes
 anymore
Date: Wed, 5 Jun 2013 03:10:55 -0400
Message-ID: <20130605071055.GB14427@sigill.intra.peff.net>
References: <20130605031349.GA6727@sigill.intra.peff.net>
 <1370412601.77980.YahooMailAndroidMobile@web172702.mail.ir2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Gianfranco Costamagna <costamagnagianfranco@yahoo.it>
X-From: git-owner@vger.kernel.org Wed Jun 05 09:11:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uk7sE-0004MQ-Be
	for gcvg-git-2@plane.gmane.org; Wed, 05 Jun 2013 09:11:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752521Ab3FEHLB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Jun 2013 03:11:01 -0400
Received: from cloud.peff.net ([50.56.180.127]:48185 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752509Ab3FEHK7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Jun 2013 03:10:59 -0400
Received: (qmail 5732 invoked by uid 102); 5 Jun 2013 07:11:45 -0000
Received: from c-71-62-74-146.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.62.74.146)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 05 Jun 2013 02:11:45 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 05 Jun 2013 03:10:55 -0400
Content-Disposition: inline
In-Reply-To: <1370412601.77980.YahooMailAndroidMobile@web172702.mail.ir2.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226436>

On Wed, Jun 05, 2013 at 07:10:01AM +0100, Gianfranco Costamagna wrote:

> Just a question, is it possible to add a new test for handling this
> kind of regressions?

Yes, I added one in commit efa5f825.

> And second, is it possible to have a patch for this problem? I'll be
> glad to backport in debian, or to take care of updating the whole git
> package (it is already in experimental BTW)

The fix took a fair bit of refactoring; it's in commits
9db9eec..efa5f825. You can either cherry-pick that range, or just use
"git diff" to generate a patch.

However, for Debian, I don't see much point. Everything up through
unstable does not have the bug (it is all 1.7.10.x or older), and the
version in experimental is already 1.8.3. So as far as I can tell, no
Debian release is currently shipping a buggy version.

-Peff
