From: Jeff King <peff@peff.net>
Subject: Re: Wishlist: git fetch --reference
Date: Fri, 22 Aug 2014 00:20:57 -0400
Message-ID: <20140822042057.GD27992@peff.net>
References: <53F6B1AB.3030706@symas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Howard Chu <hyc@symas.com>
X-From: git-owner@vger.kernel.org Fri Aug 22 06:21:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XKgLW-0004lZ-QU
	for gcvg-git-2@plane.gmane.org; Fri, 22 Aug 2014 06:21:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751314AbaHVEU7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2014 00:20:59 -0400
Received: from cloud.peff.net ([50.56.180.127]:56575 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750827AbaHVEU6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2014 00:20:58 -0400
Received: (qmail 1285 invoked by uid 102); 22 Aug 2014 04:20:59 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 21 Aug 2014 23:20:59 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 22 Aug 2014 00:20:57 -0400
Content-Disposition: inline
In-Reply-To: <53F6B1AB.3030706@symas.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255656>

On Thu, Aug 21, 2014 at 07:57:47PM -0700, Howard Chu wrote:

> I maintain multiple copies of the same repo because I keep each one checked
> out to different branch/rev levels. It would be nice if, similar to clone
> --reference, we could also use git fetch --reference to reference a local
> repo when doing a fetch to pull in updates.

I think it is just spelled:

  echo $reference_repo >>.git/objects/info/alternates
  git fetch

We need "--reference" with clone because that first line needs to happen
after clone runs "git init" but before it runs "git fetch". And if you
cloned with --reference, of course, the alternates file remains and
further fetches will automatically use it.

-Peff
