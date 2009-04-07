From: Jeff King <peff@peff.net>
Subject: Re: [PATCH RFC 6/6] send-email: Remove horrible mix of tabs and
	spaces
Date: Tue, 7 Apr 2009 18:00:49 -0400
Message-ID: <20090407220048.GB18144@coredump.intra.peff.net>
References: <1239139522-24118-1-git-send-email-mfwitten@gmail.com> <1239139522-24118-2-git-send-email-mfwitten@gmail.com> <1239139522-24118-3-git-send-email-mfwitten@gmail.com> <1239139522-24118-4-git-send-email-mfwitten@gmail.com> <1239139522-24118-5-git-send-email-mfwitten@gmail.com> <1239139522-24118-6-git-send-email-mfwitten@gmail.com> <9b18b3110904071435p320e5d1dh16061d04a3a8ab57@mail.gmail.com> <b4087cc50904071442ka298564x52112c1eac9ac284@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: demerphq <demerphq@gmail.com>, git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 08 00:03:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrJNu-00068U-NX
	for gcvg-git-2@gmane.org; Wed, 08 Apr 2009 00:03:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761428AbZDGWAx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Apr 2009 18:00:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761407AbZDGWAx
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Apr 2009 18:00:53 -0400
Received: from peff.net ([208.65.91.99]:59993 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761389AbZDGWAw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Apr 2009 18:00:52 -0400
Received: (qmail 9827 invoked by uid 107); 7 Apr 2009 22:00:51 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 07 Apr 2009 18:00:51 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Apr 2009 18:00:49 -0400
Content-Disposition: inline
In-Reply-To: <b4087cc50904071442ka298564x52112c1eac9ac284@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116001>

On Tue, Apr 07, 2009 at 04:42:36PM -0500, Michael Witten wrote:

> I'll have to give that a try. However, I've been entertaining the idea
> of rewriting the whole thing anyway; it's in need of much more than
> reformatting.

Just my two cents, but if you are considering re-writing send-email, I
would suggest two things:

  1. Make much heavier use of existing CPAN libraries. A lot of the ugly
     code is trying to handle corner cases in rfc2822 and mime parsing
     and generation. And I would not be surprised if there were still
     bugs in that ugly code.

  2. Make a new command to compete with send-email instead of using the
     same name. This means that people who are really put off by
     CPAN dependencies from (1) above won't be negatively impacted. And
     you can drop any historical interface warts if you want to.

-Peff
