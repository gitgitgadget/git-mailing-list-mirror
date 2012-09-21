From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t/test-lib.sh: do not trust $SHELL
Date: Fri, 21 Sep 2012 16:58:34 -0400
Message-ID: <20120921205834.GC22977@sigill.intra.peff.net>
References: <505CCA55.6030609@gmail.com>
 <1348260766-25287-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 21 22:58:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TFAJC-0002Zg-8h
	for gcvg-git-2@plane.gmane.org; Fri, 21 Sep 2012 22:58:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756122Ab2IUU6h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2012 16:58:37 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:53707 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752152Ab2IUU6g (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Sep 2012 16:58:36 -0400
Received: (qmail 6941 invoked by uid 107); 21 Sep 2012 20:59:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 21 Sep 2012 16:59:02 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 21 Sep 2012 16:58:34 -0400
Content-Disposition: inline
In-Reply-To: <1348260766-25287-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206164>

On Sat, Sep 22, 2012 at 02:22:46AM +0530, Ramkumar Ramachandra wrote:

> Replace $SHELL with an explicit `/bin/sh`, as some shells do not
> support all the features used in the script.  For example, ZSH does
> not respect IFS, which is used in line 478.

I don't think that is the right thing to do. The point of SHELL is to
point at a bourne-compatible shell. On some systems, the main reason to
set it is that /bin/sh is _broken_, and we are trying to avoid it.

A bigger question is: why are you setting SHELL=zsh in the first place?

-Peff
