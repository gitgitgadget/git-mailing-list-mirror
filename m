From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] tests: print failed test numbers at the end of the
 test run
Date: Sun, 24 Jul 2011 09:39:51 -0600
Message-ID: <20110724153950.GB7805@sigill.intra.peff.net>
References: <4E2B1DF2.4000003@web.de>
 <7vmxg4w2fm.fsf@alter.siamese.dyndns.org>
 <4E2C1FBA.3010606@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Sun Jul 24 17:40:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ql0mj-0002qn-F9
	for gcvg-git-2@lo.gmane.org; Sun, 24 Jul 2011 17:40:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752839Ab1GXPj5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jul 2011 11:39:57 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:42626
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752802Ab1GXPj4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jul 2011 11:39:56 -0400
Received: (qmail 3513 invoked by uid 107); 24 Jul 2011 15:40:25 -0000
Received: from S010690840de80b38.ss.shawcable.net (HELO sigill.intra.peff.net) (70.64.172.81)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 24 Jul 2011 11:40:25 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 24 Jul 2011 09:39:51 -0600
Content-Disposition: inline
In-Reply-To: <4E2C1FBA.3010606@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177765>

On Sun, Jul 24, 2011 at 03:35:54PM +0200, Jens Lehmann wrote:

> Am 24.07.2011 09:41, schrieb Junio C Hamano:
> > Jens Lehmann <Jens.Lehmann@web.de> writes:
> > 
> >> Maybe I'm missing something completely obvious, but I always have a hard
> >> time finding out which test scripts did fail in a test run with -j30.
> > 
> > I run "ls -d t/trash*" for that ;-)
> 
> Yup. But that won't work when you use "-i" to continue to run all tests
> even when some fail, as all trash directories get deleted in the end. Or
> did I manage to overlook an option which stops that? ;-)

I used to use:

  make -k -j30
  grep 'failed [^0]' test-results/*

but these days I use the "prove" tool, which has much nicer output. You
can get Makefile support for it with:

  GIT_PROVE_OPTS = -j30
  DEFAULT_TEST_TARGET = prove

in your config.mak.

-Peff
