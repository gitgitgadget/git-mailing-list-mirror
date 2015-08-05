From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v4] clone: simplify string handling in guess_dir_name()
Date: Wed, 5 Aug 2015 04:41:48 -0400
Message-ID: <20150805084147.GC28212@sigill.intra.peff.net>
References: <CAHGBnuNLoNsxPK4YQ+HnT_q8F-HrVC_y9pZwB4G88jCq0-wCPg@mail.gmail.com>
 <0000014e740f7a8a-2c988a36-633e-4b30-8024-cb4a1de1a8a2-000000@eu-west-1.amazonses.com>
 <20150804043401.4494.43725@typhoon>
 <CAHGBnuMXkqhFUhen9tPfEsfFAHhbqMeFUxvePS_6A-TtMfZpzg@mail.gmail.com>
 <20150804224246.GA29051@sigill.intra.peff.net>
 <20150805060852.GA1103@pks-pc.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sebastian Schuberth <sschuberth@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Lukas Fleischer <lfleischer@lfos.de>,
	Git Mailing List <git@vger.kernel.org>
To: Patrick Steinhardt <ps@pks.im>
X-From: git-owner@vger.kernel.org Wed Aug 05 10:42:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMuGt-00013E-Is
	for gcvg-git-2@plane.gmane.org; Wed, 05 Aug 2015 10:41:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751484AbbHEIlz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2015 04:41:55 -0400
Received: from cloud.peff.net ([50.56.180.127]:41006 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750809AbbHEIlx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2015 04:41:53 -0400
Received: (qmail 21580 invoked by uid 102); 5 Aug 2015 08:41:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 05 Aug 2015 03:41:53 -0500
Received: (qmail 27301 invoked by uid 107); 5 Aug 2015 08:42:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 05 Aug 2015 04:42:01 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 05 Aug 2015 04:41:48 -0400
Content-Disposition: inline
In-Reply-To: <20150805060852.GA1103@pks-pc.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275356>

On Wed, Aug 05, 2015 at 08:08:52AM +0200, Patrick Steinhardt wrote:

> > Sadly we cannot just `strip_suffix_mem(repo, &len, "/.git"))` in the
> > earlier code, as we have to account for multiple directory separators. I
> > believe the above code does the right thing, though. I haven't looked at
> > how badly it interacts with the other guess_dir_name work from Patrick
> > Steinhardt that has been going on, though.
> 
> It shouldn't be hard rebasing my work onto this. If it's being
> applied I'll come up with a new version.

Thanks, it is always nice when contributors are flexible and easy to
work with. :)

Hopefully the new tests I've added can help you out, as well.

-Peff
