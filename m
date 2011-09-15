From: Jeff King <peff@peff.net>
Subject: Re: Problems with format-patch UTF-8 and a missing second empty line
Date: Thu, 15 Sep 2011 14:50:33 -0400
Message-ID: <20110915185033.GA17016@sigill.intra.peff.net>
References: <CAHz1FYgPuMHLC+f2mFqD73=NGXQSStRPDOsiCy-HtaWKbHu7NQ@mail.gmail.com>
 <20110915151734.GA18305@sigill.intra.peff.net>
 <20110915224456.14410ed8@zappedws>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ingo Ruhnke <grumbel@gmail.com>, git@vger.kernel.org
To: Alexey Shumkin <zapped@mail.ru>
X-From: git-owner@vger.kernel.org Thu Sep 15 20:50:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R4H1G-00084s-D4
	for gcvg-git-2@lo.gmane.org; Thu, 15 Sep 2011 20:50:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934436Ab1IOSuh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Sep 2011 14:50:37 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:52298
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934209Ab1IOSug (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Sep 2011 14:50:36 -0400
Received: (qmail 24674 invoked by uid 107); 15 Sep 2011 18:51:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 15 Sep 2011 14:51:29 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 Sep 2011 14:50:33 -0400
Content-Disposition: inline
In-Reply-To: <20110915224456.14410ed8@zappedws>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181486>

[resending with git@vger cc'd; please keep discussion on list]

On Thu, Sep 15, 2011 at 10:44:56PM +0400, Alexey Shumkin wrote:

> > On Thu, Sep 15, 2011 at 11:45:15AM +0200, Ingo Ruhnke wrote:
> > 
> > > Creating a patch of a commit including UTF-8 and no empty second
> > > line, like this:
> > > [...]
> > > Results in this:
> > > [...]
> > > Subject: [PATCH] =?UTF-8?q?=C3=84=C3=96=C3=9C
> > > =20=C3=84=C3=96=C3=9C?=
> > >[....]
> > > The problems happen with git version 1.7.4.1 (4b5eac7f0) on Ubuntu
> > > 11.04.
> > 
> > I'm pretty sure I fixed this in a1f6baa, which is in v1.7.4.4 and
> > later.
> 
> I reproduced this bug with the latest git (v1.7.6.3)
> It seems to me this is not the "git format-patch" bug
> but "git am"'s one. (But it is only the supposition)

Can you be more specific about what you tested? Running Ingo's snippet
with a more recent git produces:

  Subject: [PATCH] =?UTF-8?q?=C3=84=C3=96=C3=9C=20=C3=84=C3=96=C3=9C?=

which is right (and "git am", new or old, will apply it just fine).

But there may be a different, related bug lurking somewhere.

-Peff
