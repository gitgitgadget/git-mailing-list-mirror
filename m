From: Jeff King <peff@peff.net>
Subject: [PATCH 0/2] minor fast-export speedup
Date: Sun, 17 Mar 2013 04:32:35 -0400
Message-ID: <20130317083235.GA29907@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 17 09:33:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UH91f-0000Uy-VS
	for gcvg-git-2@plane.gmane.org; Sun, 17 Mar 2013 09:33:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756072Ab3CQIck (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Mar 2013 04:32:40 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:54191 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756046Ab3CQIci (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Mar 2013 04:32:38 -0400
Received: (qmail 7835 invoked by uid 107); 17 Mar 2013 08:34:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 17 Mar 2013 04:34:20 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 17 Mar 2013 04:32:35 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218350>

While grepping through all of the calls to parse_object (to see how they
handled error conditions, for the other series I just posted), I noticed
this opportunity for a small speedup in fast-export (5-15%). The first
patch is a cleanup, the second is the interesting bit.

  [1/2]: fast-export: rename handle_object function
  [2/2]: fast-export: do not load blob objects twice

A useful third patch on top might be to stream blobs out rather than
load them into memory, but I didn't want to go there tonight.

-Peff
