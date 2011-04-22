From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-svn: Add a svn-remote.<name>.pushurl config key
Date: Fri, 22 Apr 2011 15:36:22 -0400
Message-ID: <20110422193621.GB3323@sigill.intra.peff.net>
References: <1302102336-8800-1-git-send-email-asedeno@mit.edu>
 <1302274674-4231-1-git-send-email-asedeno@mit.edu>
 <7vmxk033ic.fsf@alter.siamese.dyndns.org>
 <20110408205437.GB16540@sigill.intra.peff.net>
 <7v4o6830cc.fsf@alter.siamese.dyndns.org>
 <20110408213201.GA20348@sigill.intra.peff.net>
 <7vipuo1iuy.fsf@alter.siamese.dyndns.org>
 <20110408224035.GB7343@sigill.intra.peff.net>
 <4DB1D2F2.6040000@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Michael J Gruber <git@drmicha.warpmail.net>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Alejandro =?utf-8?Q?R=2E_Sede=C3=B1o?= <asedeno@MIT.EDU>
X-From: git-owner@vger.kernel.org Fri Apr 22 21:36:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QDM9W-0000NL-NG
	for gcvg-git-2@lo.gmane.org; Fri, 22 Apr 2011 21:36:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752923Ab1DVTgZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Apr 2011 15:36:25 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:51413
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752736Ab1DVTgZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2011 15:36:25 -0400
Received: (qmail 22268 invoked by uid 107); 22 Apr 2011 19:37:58 -0000
Received: from c-67-172-212-47.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (67.172.212.47)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 22 Apr 2011 15:37:58 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 22 Apr 2011 15:36:22 -0400
Content-Disposition: inline
In-Reply-To: <4DB1D2F2.6040000@mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171943>

On Fri, Apr 22, 2011 at 03:11:46PM -0400, "Alejandro R. Sede=C3=B1o" wr=
ote:

> I'd be happy to see something like this get in. I've often noticed
> git-send-email telling me that it couldn't parse an address out of my
> signed-of-by lines, but I never stopped and took the time to look int=
o it.

That is a separate issue. The patch I posted will make format-patch
properly quote rfc822 specials in actual email header lines. But
Signed-off-by lines will remain as they are, being part of the message
body. And I think that's what we want. You certainly wouldn't want to
rfc2047-encode them (they are already covered by the body's content-typ=
e
encoding).

And while you could quote rfc822 specials, people don't tend to do that=
=2E
There's no formal syntax defined, but people tend to treat them as:

  Signed-off-by: (.*) <(.*)>

i.e., everything inside <> is an address, and everything before that is
the name.

If there is an issue with send-email parsing signed-off-by lines or
formatting the addresses it pulls from them, that's a separate problem
that will need to be dealt with in send-email.

-Peff
