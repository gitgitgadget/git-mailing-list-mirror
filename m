From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/3] usage: refactor die-recursion checks
Date: Tue, 16 Apr 2013 09:01:54 -0400
Message-ID: <20130416130154.GA17976@sigill.intra.peff.net>
References: <20130415230651.GA16670@sigill.intra.peff.net>
 <20130415230802.GA11267@sigill.intra.peff.net>
 <CA+sFfMes99EepY4FCW32s1L3ywv_gyFb76=Y=35rvPbc2K1BWA@mail.gmail.com>
 <20130416004228.GA14995@sigill.intra.peff.net>
 <CA+sFfMdzTNjH10FKxhvJy+7hZg+0=1Wrqy9k8KaPoJg1DuDpmg@mail.gmail.com>
 <20130416025024.GA20932@sigill.intra.peff.net>
 <516CFB56.1090805@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Brandon Casey <drafnel@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Apr 16 15:02:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1US5WP-00085G-OJ
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 15:02:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932390Ab3DPNCA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Apr 2013 09:02:00 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:47969 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754519Ab3DPNB7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Apr 2013 09:01:59 -0400
Received: (qmail 4098 invoked by uid 107); 16 Apr 2013 13:03:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 16 Apr 2013 09:03:54 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 16 Apr 2013 09:01:54 -0400
Content-Disposition: inline
In-Reply-To: <516CFB56.1090805@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221413>

On Tue, Apr 16, 2013 at 09:18:46AM +0200, Johannes Sixt wrote:

> > Yeah, that seems sane; my biggest worry was that it would create
> > headaches for Windows folks, who would have to emulate pthread_key. But
> > it seems like we already added support in 9ba604a.
> 
> pthread_key is not a problem, but pthread_once is. It's certainly
> solvable, but do we really have to?

I'm not clear on what you are suggesting. That we protect only the main
thread from recursion, or that we drop the check entirely? Or that we
implement thread-local storage for this case without using pthread_once?

-Peff
