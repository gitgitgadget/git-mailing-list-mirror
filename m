From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv2] add Android support
Date: Thu, 19 May 2011 13:38:51 -0400
Message-ID: <20110519173851.GA12295@sigill.intra.peff.net>
References: <B22B44EF-0AFB-44E3-93E3-61FA730431B9@gieschke.de>
 <7vaaej9pt3.fsf@alter.siamese.dyndns.org>
 <2218C353-80FC-4540-A60E-608385384FB5@gieschke.de>
 <20110519122026.GA30240@sigill.intra.peff.net>
 <AE42113D-8D2F-4B24-A800-D49183152911@gieschke.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Rafael Gieschke <rafael@gieschke.de>
X-From: git-owner@vger.kernel.org Thu May 19 19:39:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QN7Bd-0001h3-HB
	for gcvg-git-2@lo.gmane.org; Thu, 19 May 2011 19:39:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933712Ab1ESRiy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2011 13:38:54 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:58475
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933649Ab1ESRiy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2011 13:38:54 -0400
Received: (qmail 18219 invoked by uid 107); 19 May 2011 17:40:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 19 May 2011 13:40:55 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 May 2011 13:38:51 -0400
Content-Disposition: inline
In-Reply-To: <AE42113D-8D2F-4B24-A800-D49183152911@gieschke.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173978>

On Thu, May 19, 2011 at 07:30:49PM +0200, Rafael Gieschke wrote:

> > The point of uname_S is that it would be found automatically. Sadly,
> > There is nothing helpful in uname to tell us that we are on android:
> 
> Actually, you can't even call uname as I suspect that you would
> normally not compile on Android (I don't think that gcc runs on
> Android) but always cross-compile.

Good point. Whatever support we provide will need to be user-configured,
then.

> > So I think we are probably stuck either with the user setting an ANDROID
> > meta-flag that sets the other flags appropriately, or leaving it up to
> > the user to provide a sane config.mak.
> 
> Yes, I agree that leaving it up completely to the user to provide a
> config.mak is a very good option too, especially as build environments
> might be different and some might want to try building with Perl and
> libcurl, which would require a config.mak anyhow.

I don't know enough about Android development to know how much
commonality there is between devices and builds. AFAIK, the Android spec
itself only provides the Java-callable API. So for Unix-y stuff like
this, I have no idea what is on stock Android versus Cyanogen for
instance, or even if what is on stock varies from handset to handset.

So yeah, we are probably better not even trying to provide a default set
of flags for Android; we can support specific hacks (like your patches 1
and 2) but leave it up to individual build environments to enable them
as appropriate.

-Peff
