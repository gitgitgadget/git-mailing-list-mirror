From: Jeff King <peff@peff.net>
Subject: Re: git config key bug or by design?
Date: Tue, 27 Nov 2012 22:34:09 -0500
Message-ID: <20121128033408.GE27772@sigill.intra.peff.net>
References: <20121127221446.7f2fbf71@Indy>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Peter van der Does <peter@avirtualhome.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 04:34:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdYPr-0006KB-HQ
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 04:34:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752089Ab2K1DeM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2012 22:34:12 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:58964 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751468Ab2K1DeL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2012 22:34:11 -0500
Received: (qmail 2306 invoked by uid 107); 28 Nov 2012 03:35:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 27 Nov 2012 22:35:07 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 27 Nov 2012 22:34:09 -0500
Content-Disposition: inline
In-Reply-To: <20121127221446.7f2fbf71@Indy>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210691>

On Tue, Nov 27, 2012 at 10:14:46PM -0500, Peter van der Does wrote:

> I noticed today I can't create a key starting with a number.
> 
> The source code[1] confirms this, but is this a bug or is it by design?

I don't recall ever discussing it. But what is it that you want to store
in a key starting with a number? Git does not respect any such config
values[1].

Are you writing a new tool that will store its config alongside git's?
Even if the behavior is loosened, you would probably want to avoid
starting your config keys with numbers, as older git versions would be
around for a while and would choke on it.

-Peff

[1] You can still store arbitrary bytes in the subsection name (e.g.,
    "foo.123.bar").
