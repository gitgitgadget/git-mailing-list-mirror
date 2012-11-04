From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 5/5] string_list_add_refs_from_colon_sep(): use
 string_list_split()
Date: Sun, 4 Nov 2012 06:57:50 -0500
Message-ID: <20121104115750.GC336@sigill.intra.peff.net>
References: <1352012830-13591-1-git-send-email-mhagger@alum.mit.edu>
 <1352012830-13591-6-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sun Nov 04 12:58:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TUyq5-0001qc-S9
	for gcvg-git-2@plane.gmane.org; Sun, 04 Nov 2012 12:58:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753384Ab2KDL5x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2012 06:57:53 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:56513 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753003Ab2KDL5x (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2012 06:57:53 -0500
Received: (qmail 23152 invoked by uid 107); 4 Nov 2012 11:58:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 04 Nov 2012 06:58:37 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 04 Nov 2012 06:57:50 -0500
Content-Disposition: inline
In-Reply-To: <1352012830-13591-6-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209024>

On Sun, Nov 04, 2012 at 08:07:10AM +0100, Michael Haggerty wrote:

> It makes for simpler code than strbuf_split().

Agreed.

I wonder how useful the strbuf_split functions really are. Callers might
care about splitting content in a strbuf, but in general, getting a list
of strbufs out is just a hassle, and a string_list makes more sense.

It's probably not worth spending time converting them unless we happen
to be working in the area, though.

-Peff
