From: Jeff King <peff@peff.net>
Subject: Re: git fails: segfault at 0 ip 00000000004076d5 sp 00007fff7806ebc0
Date: Fri, 12 Oct 2012 13:12:56 -0400
Message-ID: <20121012171256.GA21409@sigill.intra.peff.net>
References: <CAJa+X0OkzAX9E2SnDmU=on0yzzVZ9OMa2dJZgKMK=gQu2Rhf_Q@mail.gmail.com>
 <CAJa+X0MefHXTu_D7-SN8itQVO4sMyc4O7=bK=-sUP+W4GHOu9g@mail.gmail.com>
 <CABPQNSYyh-gk8aD9SKLzo0MDBkGECthdGZiT1mB1pA0ajdB8Cw@mail.gmail.com>
 <CABPQNSbRYq43rADP6BaQ_Q2SB+M76rHdX3hOSpGQk2c5UNR5hg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Brad Hein <linuxbrad@gmail.com>, git@vger.kernel.org
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 12 19:13:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TMinW-0001H6-Jm
	for gcvg-git-2@plane.gmane.org; Fri, 12 Oct 2012 19:13:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946004Ab2JLRNE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Oct 2012 13:13:04 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:51119 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946029Ab2JLRND (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Oct 2012 13:13:03 -0400
Received: (qmail 4828 invoked by uid 107); 12 Oct 2012 17:13:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 12 Oct 2012 13:13:37 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 12 Oct 2012 13:12:56 -0400
Content-Disposition: inline
In-Reply-To: <CABPQNSbRYq43rADP6BaQ_Q2SB+M76rHdX3hOSpGQk2c5UNR5hg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207559>

On Fri, Oct 12, 2012 at 06:34:30PM +0200, Erik Faye-Lund wrote:

> > Thanks for reporting. I gave it a quick go, and the issue seems to
> > also be present in the current 'master'.
> >
> > The problem is a NULL-pointer dereferencing introduced in 8809703
> > ("http: factor out http error code handling"), where the code assume
> > that slot->results still points to http_request::results. This
> > assumption seems to be wrong.
> >
> > This seems to step around the issue, but I don't know if
> > http_request::results should be set to NULL in the first place. Jeff?
> 
> OK, it seems I jumped the gun, and Jeff already sent out a patch for
> it. Nevermind me, then :)

Independent verification is never a bad thing. :)

-Peff
