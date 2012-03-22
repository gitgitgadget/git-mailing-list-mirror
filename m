From: Jeff King <peff@peff.net>
Subject: Re: Strange effect merging empty file
Date: Thu, 22 Mar 2012 14:52:46 -0400
Message-ID: <20120322185246.GA27037@sigill.intra.peff.net>
References: <4F69AD3C.4070203@ericsson.com>
 <4F69B375.5050205@in.waw.pl>
 <86iphwomnq.fsf@red.stonehenge.com>
 <4F6B1F48.3040007@in.waw.pl>
 <20120322140140.GA8803@sigill.intra.peff.net>
 <7vty1gy3eh.fsf@alter.siamese.dyndns.org>
 <20120322175952.GA13069@sigill.intra.peff.net>
 <20120322182533.GA20360@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>,
	Ralf Nyren <ralf.nyren@ericsson.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 22 19:52:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAn81-0007f5-QC
	for gcvg-git-2@plane.gmane.org; Thu, 22 Mar 2012 19:52:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759081Ab2CVSwt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Mar 2012 14:52:49 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:56818
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759069Ab2CVSws (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Mar 2012 14:52:48 -0400
Received: (qmail 3745 invoked by uid 107); 22 Mar 2012 18:53:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 22 Mar 2012 14:53:04 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 Mar 2012 14:52:46 -0400
Content-Disposition: inline
In-Reply-To: <20120322182533.GA20360@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193682>

On Thu, Mar 22, 2012 at 02:25:33PM -0400, Jeff King wrote:

> We can get around it by just checking for the empty-blob sha1. The patch
> below should do the right thing, and passes the whole test suite.

Here it is broken up properly into commits:

  [1/3]: drop casts from users EMPTY_TREE_SHA1_BIN
  [2/3]: make is_empty_blob_sha1 available everywhere
  [3/3]: merge-recursive: don't detect renames from empty files

The first one is just a cleanup I noticed while adding
EMPTY_BLOB_SHA1_BIN, and is not strictly related. The second one is the
refactoring bits, and the third one is the real change.

-Peff
