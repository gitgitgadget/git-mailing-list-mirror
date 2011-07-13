From: Jeff King <peff@peff.net>
Subject: [RFC/PATCHv2 0/6] generation numbers for faster traversals
Date: Wed, 13 Jul 2011 02:47:09 -0400
Message-ID: <20110713064709.GA18499@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>, Ted Ts'o <tytso@mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Clemens Buchacher <drizzd@aon.at>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 13 08:47:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QgtE5-000073-1r
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jul 2011 08:47:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758672Ab1GMGrM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jul 2011 02:47:12 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:39328
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758127Ab1GMGrL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2011 02:47:11 -0400
Received: (qmail 20950 invoked by uid 107); 13 Jul 2011 06:47:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 13 Jul 2011 02:47:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Jul 2011 02:47:09 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176997>

Here's an updated version of the series posted here:

  http://article.gmane.org/gmane.comp.version-control.git/176861

I'll discuss specific changes in each patch, but the summary is:

  1. object-cache is now called metadata-cache.

  2. The interface to "decorate" and "metadata-cache" is a little
     cleaner, and it's harder to break it by changing the "width" field
     at runtime.

  3. Cache files have a header with a version for future-proofing.

  4. Cache files on disk are automatically invalidated if grafts or
     replace refs change.

The patches are:

  [1/6]: decorate: allow storing values instead of pointers
  [2/6]: add metadata-cache infrastructure
  [3/6]: commit: add commit_generation function
  [4/6]: pretty: support %G to show the generation number of a commit
  [5/6]: check commit generation cache validity against grafts
  [6/6]: limit "contains" traversals based on commit generation

-Peff
