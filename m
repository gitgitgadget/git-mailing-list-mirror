From: Jeff King <peff@peff.net>
Subject: Re: [RFC PATCH] tests: print failed test numbers at the end of the
 test run
Date: Mon, 25 Jul 2011 23:42:36 -0600
Message-ID: <20110726054236.GC25046@sigill.intra.peff.net>
References: <4E2B1DF2.4000003@web.de>
 <CACsJy8CuqHSoG4PVMiT=5EUv2hn=42y5B+6Rhny2VkXW32WR8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 26 07:42:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QlaPl-0007SV-IL
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jul 2011 07:42:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751282Ab1GZFml (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jul 2011 01:42:41 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:33815
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751064Ab1GZFmj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2011 01:42:39 -0400
Received: (qmail 17041 invoked by uid 107); 26 Jul 2011 05:43:09 -0000
Received: from S010690840de80b38.ss.shawcable.net (HELO sigill.intra.peff.net) (70.64.172.81)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 26 Jul 2011 01:43:09 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 25 Jul 2011 23:42:36 -0600
Content-Disposition: inline
In-Reply-To: <CACsJy8CuqHSoG4PVMiT=5EUv2hn=42y5B+6Rhny2VkXW32WR8Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177842>

On Tue, Jul 26, 2011 at 11:25:21AM +0700, Nguyen Thai Ngoc Duy wrote:

> On Sun, Jul 24, 2011 at 2:16 AM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
> > On modern multi-core processors "make test" is often run in multiple jobs.
> > If one of them fails the test run does stop, but the concurrently running
> > tests finish their run.
> 
> Somewhat related (or not). I change something. I know it breaks things
> and want to know _all_ tests it breaks, but "make test" would stop
> early. Is there anyway to make it keep going through all tests even if
> some fails? "make -j<big number>" improves the situation but does not
> really solve it.

Try "make -k", which will keep running rules that don't have failed
dependencies (in this case, all of the tests are independent, so it will
run all of them).

Or use "prove", which can do fancy things like putting the last-failed
(so you can see the likely failures immediately and start to probe them
while the rest of the suite runs).

-Peff
