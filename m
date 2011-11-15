From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] upload-archive: use argv_array for sent parameters
Date: Tue, 15 Nov 2011 16:30:40 -0500
Message-ID: <20111115213040.GA20451@sigill.intra.peff.net>
References: <1319472131-3968-1-git-send-email-kusmabite@gmail.com>
 <201111151122.48378.trast@student.ethz.ch>
 <20111115102807.GA18649@sigill.intra.peff.net>
 <201111151311.46832.trast@student.ethz.ch>
 <20111115173715.GA4478@sigill.intra.peff.net>
 <7vobwdus7w.fsf@alter.siamese.dyndns.org>
 <20111115191832.GA16030@sigill.intra.peff.net>
 <20111115194958.GB19305@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Rast <trast@student.ethz.ch>,
	Franck Bui-Huu <vagabon.xyz@gmail.com>,
	Erik Faye-Lund <kusmabite@gmail.com>, git@vger.kernel.org,
	j6t@kdbg.org, rene.scharfe@lsrfire.ath.cx
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 15 22:30:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQQad-0001LC-O7
	for gcvg-git-2@lo.gmane.org; Tue, 15 Nov 2011 22:30:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932453Ab1KOVan (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Nov 2011 16:30:43 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:42799
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932432Ab1KOVam (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2011 16:30:42 -0500
Received: (qmail 10189 invoked by uid 107); 15 Nov 2011 21:30:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 15 Nov 2011 16:30:47 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 15 Nov 2011 16:30:40 -0500
Content-Disposition: inline
In-Reply-To: <20111115194958.GB19305@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185488>

On Tue, Nov 15, 2011 at 02:49:58PM -0500, Jeff King wrote:

> The existing prepare_argv uses a fixed-size static buffer to
> hold all of the arguments, and then puts pointers into the
> buffer into a fixed-size array. Using argv_array gets rid of
> all of the manual bookkeeping and makes the code more
> readable.
> 
> It also lifts the static limits on the size of the array.
> This is convenient, but is perhaps a security regression, as
> a malicious client can now ask us to create arbitrary-length
> argv arrays in memory.
> 
> Signed-off-by: Jeff King <peff@peff.net>

Sorry, I failed to mark the subject properly. If it was not obvious,
this is patch 2/2 of the cleanup.

-Peff
