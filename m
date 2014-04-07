From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 00/25] Lockfile correctness and refactoring
Date: Mon, 7 Apr 2014 15:40:44 -0400
Message-ID: <20140407194043.GE19342@sigill.intra.peff.net>
References: <1396827247-28465-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Apr 07 21:40:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WXFPX-0001zg-BV
	for gcvg-git-2@plane.gmane.org; Mon, 07 Apr 2014 21:40:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755384AbaDGTkq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Apr 2014 15:40:46 -0400
Received: from cloud.peff.net ([50.56.180.127]:55659 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754687AbaDGTkq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Apr 2014 15:40:46 -0400
Received: (qmail 15687 invoked by uid 102); 7 Apr 2014 19:40:45 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 07 Apr 2014 14:40:45 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 07 Apr 2014 15:40:44 -0400
Content-Disposition: inline
In-Reply-To: <1396827247-28465-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245899>

On Mon, Apr 07, 2014 at 01:33:42AM +0200, Michael Haggerty wrote:

> This is a second attempt at renovating the lock file code.  Thanks to
> Peff, Junio, Torsten, and Eric for their helpful reviews of v1.
> 
> v1 of this patch series [1] did some refactoring and then added a new
> feature to the lock_file API: the ability to activate a new version of
> a locked file while retaining the lock.
> 
> But the review of v1 turned up even more correctness issues in the
> existing implementation of lock files.  So this v2 dials back the
> scope of the changes (it omits the new feature) but does more work to
> fix problems with the current lock file implementation.
> 
> The main theme of this patch series is to better define the state
> diagram for lock_file objects and to fix code that left them in
> incorrect, indeterminate, or unexpected states.  There are also a few
> patches that convert several functions to use strbufs instead of
> limiting pathnames to a maximum length.

Looks OK to me, modulo the few comments I sent.

I still think resolve_symref should probably not be "best-effort", but
that can come later on top.

-Peff
