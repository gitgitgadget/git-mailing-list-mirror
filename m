From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] clone: always fetch remote HEAD
Date: Mon, 6 Jun 2011 12:08:45 -0400
Message-ID: <20110606160845.GB11485@sigill.intra.peff.net>
References: <20110603050901.GA883@sigill.intra.peff.net>
 <20110603051805.GC1008@sigill.intra.peff.net>
 <BANLkTim03_3DLdDkc3QgFrcUa0Fqhhqnbw@mail.gmail.com>
 <20110603181052.GA17538@sigill.intra.peff.net>
 <BANLkTimuU6fxS+CoL=rpQbN4vfRyMNOMJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Dmitry Ivankov <divanorama@gmail.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 06 18:09:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTcMM-0006Rd-VX
	for gcvg-git-2@lo.gmane.org; Mon, 06 Jun 2011 18:08:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754915Ab1FFQIz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2011 12:08:55 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:37923
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751703Ab1FFQIy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2011 12:08:54 -0400
Received: (qmail 7083 invoked by uid 107); 6 Jun 2011 16:09:00 -0000
Received: from c-76-21-13-32.hsd1.ca.comcast.net (HELO sigill.intra.peff.net) (76.21.13.32)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 06 Jun 2011 12:09:00 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 06 Jun 2011 12:08:45 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTimuU6fxS+CoL=rpQbN4vfRyMNOMJQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175131>

On Fri, Jun 03, 2011 at 08:50:41PM -0500, Sverre Rabbelier wrote:

> > Does that make sense? If so, then I think the right fix is for testgit
> > ti ignore all imports after the first one (since the first one will have
> > done all available refs). And the patch is:
> 
> We can do that yes, although it would be even better if we could make
> testgit implement importing only a limited set of branches, as I
> assume that will be common. Nonetheless, this will do for now I think.

Yeah, I think that is a better model for showing people who are trying
to write their own helpers. We just have to read each "import" line,
saving the list of refs; when git disconnects from us, we know there are
no more, and we can start fast-import with the correct arguments.

-Peff
