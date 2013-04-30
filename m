From: Jeff King <peff@peff.net>
Subject: Re: "git grep" parallelism question
Date: Tue, 30 Apr 2013 12:14:45 -0400
Message-ID: <20130430161444.GA32748@sigill.intra.peff.net>
References: <7vip39w14d.fsf@alter.siamese.dyndns.org>
 <CA+55aFx1t_MT+20Bbkse-wHeLz8E06yqaOhbb12GzHNDrE2tWA@mail.gmail.com>
 <CALkWK0k6Gi_J6nDbrGPxDMmWC73CHXdj7a5ugC15YVrrycP=hA@mail.gmail.com>
 <20130429161814.GJ472@serenity.lan>
 <877gjldxid.fsf@hexa.v.cablecom.net>
 <20130429180857.GK472@serenity.lan>
 <7v1u9tgeov.fsf@alter.siamese.dyndns.org>
 <20130430080848.GP472@serenity.lan>
 <20130430155939.GA31881@sigill.intra.peff.net>
 <20130430161207.GQ472@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Tue Apr 30 18:14:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXDCe-0001aW-JW
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 18:14:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760946Ab3D3QOt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 12:14:49 -0400
Received: from cloud.peff.net ([50.56.180.127]:39319 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760865Ab3D3QOr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 12:14:47 -0400
Received: (qmail 9385 invoked by uid 102); 30 Apr 2013 16:15:02 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 30 Apr 2013 11:15:02 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 30 Apr 2013 12:14:45 -0400
Content-Disposition: inline
In-Reply-To: <20130430161207.GQ472@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222944>

On Tue, Apr 30, 2013 at 05:12:08PM +0100, John Keeping wrote:

> > So I'm not against TEST_OUTPUT_DIRECTORY as a concept, but I'm having
> > trouble seeing how it is more useful than "--root".
> 
> I think the original intent of TEST_OUTPUT_DIRECTORY was to allow other
> users of the test framework (in contrib/ or the performance tests) to
> put their output in a sensible place for those tests, like you describe
> below.
> 
> The patch being discussed here [1] just makes sure that it applies
> to everything - previously it was applied to test-results/
> inconsistently; test-lib.sh used TEST_OUTPUT_DIRECTORY but the makefile
> didn't.  So we haven't actually changed where test-results/ live as a
> result of this change, just where the makefile looks in order to display
> the aggregate results and clean them up.

Ah, I see. Thanks, that was the piece I was missing.

> This confirms to me that the patch as it currently stands is correct: we
> have made TEST_OUTPUT_DIRECTORY consistent and --root still works as
> before.
> 
> [1] http://article.gmane.org/gmane.comp.version-control.git/222555

Yeah, if it is about harmonizing the Makefile and the test scripts, that
is definitely a bug fix, and the right thing to do.

-Peff
