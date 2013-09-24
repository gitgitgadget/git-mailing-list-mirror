From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3] build: add default aliases
Date: Tue, 24 Sep 2013 02:18:30 -0400
Message-ID: <20130924061830.GB6114@sigill.intra.peff.net>
References: <1379791221-29925-1-git-send-email-felipe.contreras@gmail.com>
 <20130924045325.GD2766@sigill.intra.peff.net>
 <CAMP44s1tirA5w91L2YomaduZVkqL3=n1j79eoueB6XeGuyY3Mw@mail.gmail.com>
 <20130924053712.GA6114@sigill.intra.peff.net>
 <CAMP44s1-AXKRz4pqQsyCMLZgnxmxTaoeBGt8aNDFM0ttDTmBRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 24 08:18:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VOLxG-0003aM-OL
	for gcvg-git-2@plane.gmane.org; Tue, 24 Sep 2013 08:18:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752216Ab3IXGSf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Sep 2013 02:18:35 -0400
Received: from cloud.peff.net ([50.56.180.127]:53459 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751600Ab3IXGSe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Sep 2013 02:18:34 -0400
Received: (qmail 2793 invoked by uid 102); 24 Sep 2013 06:18:33 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 24 Sep 2013 01:18:33 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Sep 2013 02:18:30 -0400
Content-Disposition: inline
In-Reply-To: <CAMP44s1-AXKRz4pqQsyCMLZgnxmxTaoeBGt8aNDFM0ttDTmBRQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235273>

On Tue, Sep 24, 2013 at 12:49:21AM -0500, Felipe Contreras wrote:

> Anyway, if you are so worried about this hypothetical user not
> noticing that 'git ci' didn't commit all the files, we could ma ci to
> 'git commit -v' so we are being straightforward to the user as to what
> is being committed.

I do not think that is a useful suggestion, as the output of "commit -v"
is typically too long for unsuspecting people to check carefully, and is
redundant with the filename summary we already put in the commit
template. And neither is shown with "-m", anyway.  I agree it's a
minority of cases where somebody will make a bogus commit because of it,
though.

But let's take a step back for a moment. What was the goal of the patch?
Who are we trying to help? People who already have identical aliases are
not helped on existing boxes; they already have them. They might be
helped on new boxes, where they will not have to copy over their custom
aliases (but they would probably end up wanting to copy the rest of
their config and aliases anyway).  People who have different aliases for
the same terms are unaffected on existing boxes, but slightly hindered
on new boxes as the aliases do something else.

People with no matching aliases now get these aliases. What do they
expect them to do? Do they expect "commit" or "commit -a"? Do they
expect "status" or "status -s" or "status -sb"? Are we trying for
consistency across git installations, or consistency with similar
aliases in systems like cvs (in which case, would that argue for "commit
-a")? Do people who have not bothered to configure the aliases even
care?

My original question was: are these the best definitions of those
shortcuts? I have not seen any answer to that.

-Peff
