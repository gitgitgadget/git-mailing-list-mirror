From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] mailinfo: do not treat ">From" lines as in-body
 headers
Date: Sat, 13 Sep 2014 20:47:26 -0400
Message-ID: <20140914004725.GA28010@peff.net>
References: <1410472786-14552-1-git-send-email-mark.einon@gmail.com>
 <1410472786-14552-5-git-send-email-mark.einon@gmail.com>
 <20140913093746.GD6600@mwanda>
 <20140913154556.GA12361@kroah.com>
 <20140913203645.GB24854@peff.net>
 <20140913204745.GA12291@msilap.einon.net>
 <20140913205751.GA17875@mwanda>
 <20140913210908.GG6549@mwanda>
 <20140913212504.GA25190@peff.net>
 <20140913225713.GB189120@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Dan Carpenter <dan.carpenter@oracle.com>,
	Mark Einon <mark.einon@gmail.com>,
	Greg KH <gregkh@linuxfoundation.org>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 14 02:47:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XSxyY-0004mQ-3y
	for gcvg-git-2@plane.gmane.org; Sun, 14 Sep 2014 02:47:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752249AbaINAra (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Sep 2014 20:47:30 -0400
Received: from cloud.peff.net ([50.56.180.127]:47872 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752235AbaINAr3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Sep 2014 20:47:29 -0400
Received: (qmail 20174 invoked by uid 102); 14 Sep 2014 00:47:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 13 Sep 2014 19:47:29 -0500
Received: (qmail 11450 invoked by uid 107); 14 Sep 2014 00:47:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 13 Sep 2014 20:47:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 13 Sep 2014 20:47:26 -0400
Content-Disposition: inline
In-Reply-To: <20140913225713.GB189120@vauxhall.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256985>

On Sat, Sep 13, 2014 at 10:57:14PM +0000, brian m. carlson wrote:

> On Sat, Sep 13, 2014 at 05:25:05PM -0400, Jeff King wrote:
> > Thanks both of you for following up. I did confirm that git-send-email
> > does not add such quoting. From your findings above, I'd agree that it's
> > the list-archive software munging it, and they are buggy IMHO (they
> > should de-quote on display).
> 
> I wonder if git send-email should do what mutt does in this case, which
> is use quoted-printable encoding and encode the first F as =46 (as well
> as any equals signs as =3D).  It looks like mailinfo.c already is
> capable of handling that, and that would avoid the entire issue.

That's not an unreasonable tactic. However, I think we'd still want to
do something with mailinfo on the receiving end, similar to the patch I
sent. We don't know that the sending side is necessarily send-email.

-Peff
