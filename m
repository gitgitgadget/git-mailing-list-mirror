From: Jeff King <peff@peff.net>
Subject: [PATCH 0/8] minor import/export remote helper fixes
Date: Tue, 7 Jun 2011 13:18:39 -0400
Message-ID: <20110607171838.GA21685@sigill.intra.peff.net>
References: <20110603050901.GA883@sigill.intra.peff.net>
 <20110603051805.GC1008@sigill.intra.peff.net>
 <BANLkTim03_3DLdDkc3QgFrcUa0Fqhhqnbw@mail.gmail.com>
 <20110603181052.GA17538@sigill.intra.peff.net>
 <7vei37bxbp.fsf@alter.siamese.dyndns.org>
 <7vaadvbwpw.fsf@alter.siamese.dyndns.org>
 <20110606161143.GC11485@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 07 19:18:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTzvd-000073-6Q
	for gcvg-git-2@lo.gmane.org; Tue, 07 Jun 2011 19:18:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751130Ab1FGRSn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2011 13:18:43 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:50713
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755210Ab1FGRSm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2011 13:18:42 -0400
Received: (qmail 16825 invoked by uid 107); 7 Jun 2011 17:18:49 -0000
Received: from c-76-21-13-32.hsd1.ca.comcast.net (HELO sigill.intra.peff.net) (76.21.13.32)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 07 Jun 2011 13:18:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Jun 2011 13:18:39 -0400
Content-Disposition: inline
In-Reply-To: <20110606161143.GC11485@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175217>

On Mon, Jun 06, 2011 at 12:11:43PM -0400, Jeff King wrote:

> I'll try the nicer fix Sverre mentioned and post a real patch. I wanted
> to add a test for multiple refs to the test suite, but I got bogged down
> by other breakages. Some of which I think are the fault of testgit, but
> one of which I think may be a problem in the transport-helper code.
> 
> I gave up in frustration after many hours of dealing with it on Friday,
> but I'll give it another go today. :)

OK, I finally hit a point where I think all of my patches are doing sane
things. There are a few cleanups at the beginning, and then 4/8
demonstrates five different bugs. All but the last one are fixed by the
remaining patches (see the comments in 4/8 for why the fifth bug is
tricky).

  [1/8]: transport-helper: fix minor leak in push_refs_with_export
  [2/8]: git-remote-testgit: exit gracefully after push
  [3/8]: t5800: factor out some ref tests
  [4/8]: t5800: document some non-functional parts of remote helpers
  [5/8]: teach remote-testgit to import non-HEAD refs
  [6/8]: teach remote-testgit to import multiple refs
  [7/8]: transport-helper: don't feed bogus refs to export push
  [8/8]: git_remote_helpers: push all refs during a non-local export

-Peff
