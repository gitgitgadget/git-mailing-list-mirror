From: Jeff King <peff@peff.net>
Subject: Re: a bug about format-patch of multibyte characters comment
Date: Sun, 13 Feb 2011 05:26:27 -0500
Message-ID: <20110213102627.GB7735@sigill.intra.peff.net>
References: <4D565D3B.7060808@gmail.com>
 <20110213075337.GA12112@sigill.intra.peff.net>
 <20110213083137.GB12112@sigill.intra.peff.net>
 <4D579A35.1000007@gmail.com>
 <20110213085236.GA2251@sigill.intra.peff.net>
 <4D57AEFC.10608@gmail.com>
 <AANLkTi=Ty22nzd6ja=XmMzMu+YzDKDSBMCOGRfKenhR4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: xzer <xiaozhu@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 13 11:26:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PoZA4-0007xo-N1
	for gcvg-git-2@lo.gmane.org; Sun, 13 Feb 2011 11:26:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754506Ab1BMK0c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Feb 2011 05:26:32 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:53773 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754448Ab1BMK0a (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Feb 2011 05:26:30 -0500
Received: (qmail 13074 invoked by uid 111); 13 Feb 2011 10:26:29 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Sun, 13 Feb 2011 10:26:29 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 13 Feb 2011 05:26:27 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTi=Ty22nzd6ja=XmMzMu+YzDKDSBMCOGRfKenhR4@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166659>

On Sun, Feb 13, 2011 at 07:22:14PM +0900, xzer wrote:

> > A sample of rfc2047 show us a legal line broken subject mail, like
> > following:
> > ------------------------------------------------------------------
> >  Subject: =?ISO-8859-1?B?SWYgeW91IGNhbiByZWFkIHRoaXMgeW8=?=
> >    =?ISO-8859-2?B?dSB1bmRlcnN0YW5kIHRoZSBleGFtcGxlLg==?=
> > ------------------------------------------------------------------
> >
> > I understand that the current format-patch is not not valid to
> > rfc2822/rfc2047,
> > but even a valid one just like above, most of the mail client will can not
> > show it
> > correctly, they show the first line only, I think that's a problem of user
> > friendliness.
> 
> I am sorry I made a mistake, there is no problem of mail client, I just
> create a wrong format to test. So now I think if we can generate a valid
> rfc2047 patch file, and then make the am also analyze the patch file
> correctly, there is no problem. Isn't it?

Ah, OK, our mails just crossed paths. git-am already parses this
correctly (actually, it is git-mailinfo that parses on behalf of
git-am). We just need format-patch to generate it (and it should also
probably be folding long lines in general).

-Peff
