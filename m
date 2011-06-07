From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/8] t5800: document some non-functional parts of remote
 helpers
Date: Tue, 7 Jun 2011 13:28:32 -0400
Message-ID: <20110607172832.GA23224@sigill.intra.peff.net>
References: <20110607171838.GA21685@sigill.intra.peff.net>
 <20110607172030.GC22111@sigill.intra.peff.net>
 <BANLkTinx0F7nfpmqx7AWChab3g-4MNnswQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Dmitry Ivankov <divanorama@gmail.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 07 19:28:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QU053-0004sv-CJ
	for gcvg-git-2@lo.gmane.org; Tue, 07 Jun 2011 19:28:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755866Ab1FGR2g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2011 13:28:36 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:41337
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754413Ab1FGR2g (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2011 13:28:36 -0400
Received: (qmail 17517 invoked by uid 107); 7 Jun 2011 17:28:43 -0000
Received: from c-76-21-13-32.hsd1.ca.comcast.net (HELO sigill.intra.peff.net) (76.21.13.32)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 07 Jun 2011 13:28:43 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Jun 2011 13:28:32 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTinx0F7nfpmqx7AWChab3g-4MNnswQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175230>

On Tue, Jun 07, 2011 at 07:25:49PM +0200, Sverre Rabbelier wrote:

> Heya,
> 
> On Tue, Jun 7, 2011 at 19:20, Jeff King <peff@peff.net> wrote:
> > There are two possible solutions:
> 
> 3. As mentioned in a different series, I feel it would be preferable
> if fast-import/fast-export did not actually modify any refs, rather
> the remote-helper should specify which refs should be updated to what
> value explicitly. I think the same should/could apply in this case.
> Does that make sense?

Isn't that the case already with import? The helper writes into a
staging area (like refs/testgit), and then we let git pick the results
out of there.

For export, that would be the same as my (2). The problem is that we
don't feed the helper _any_ information about which refs were desired.
All it gets is the fast-export stream.

-Peff
