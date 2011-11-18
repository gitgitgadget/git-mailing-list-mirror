From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 8/8] Enable GIT_DEBUG_MEMCHECK on git_pathname()
Date: Thu, 17 Nov 2011 21:06:33 -0500
Message-ID: <20111118020633.GA9635@sigill.intra.peff.net>
References: <1321522335-24193-1-git-send-email-pclouds@gmail.com>
 <1321522335-24193-9-git-send-email-pclouds@gmail.com>
 <CALkWK0ndE1Q_jNSV7CBB5W2NyVhcy7kgNO5woWWOw6CXx3cxcA@mail.gmail.com>
 <20111117134201.GA30718@sigill.intra.peff.net>
 <CACsJy8A25SyLVKv8GwkYaHBJwU5tHqgdJK6L-upF9HWseFzCtQ@mail.gmail.com>
 <20111118012715.GA7826@sigill.intra.peff.net>
 <CACsJy8CB6VXjyC-M4C9qGm-n73Kuf1Q0SbH4Ync5Osts-uufQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 18 03:06:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RRDqi-000637-7d
	for gcvg-git-2@lo.gmane.org; Fri, 18 Nov 2011 03:06:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755398Ab1KRCGg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Nov 2011 21:06:36 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:44516
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755038Ab1KRCGf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Nov 2011 21:06:35 -0500
Received: (qmail 27387 invoked by uid 107); 18 Nov 2011 02:06:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 17 Nov 2011 21:06:41 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 17 Nov 2011 21:06:33 -0500
Content-Disposition: inline
In-Reply-To: <CACsJy8CB6VXjyC-M4C9qGm-n73Kuf1Q0SbH4Ync5Osts-uufQQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185624>

On Fri, Nov 18, 2011 at 08:50:20AM +0700, Nguyen Thai Ngoc Duy wrote:

> > Unless you really need macro-like behavior, you're probably better off
> > using a variadic function and making it a static inline on platforms
> > which can do so.
> 
> I need to save __FILE__ and __LINE__ of call site, inline functions
> probably don't help.

Yeah, you'd have to pass them in to the function. Which of course you
can't wrap with a macro, because the whole thing is variadic.

-Peff
