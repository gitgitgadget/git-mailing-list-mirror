From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/7] commit: provide a function to find a header in a
 buffer
Date: Mon, 23 Jun 2014 12:47:42 -0400
Message-ID: <20140623164742.GA4838@sigill.intra.peff.net>
References: <20140618201944.GA23238@sigill.intra.peff.net>
 <20140618202737.GA23896@sigill.intra.peff.net>
 <CAPig+cQuBg0sjZXfkB7c_L=PMJuaPbWZBz9UV2Jbtr3eqJuPcw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Jun 23 18:47:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wz7PJ-00038I-11
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jun 2014 18:47:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756308AbaFWQrp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2014 12:47:45 -0400
Received: from cloud.peff.net ([50.56.180.127]:49715 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754824AbaFWQro (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2014 12:47:44 -0400
Received: (qmail 535 invoked by uid 102); 23 Jun 2014 16:47:44 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 23 Jun 2014 11:47:44 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 23 Jun 2014 12:47:42 -0400
Content-Disposition: inline
In-Reply-To: <CAPig+cQuBg0sjZXfkB7c_L=PMJuaPbWZBz9UV2Jbtr3eqJuPcw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252351>

On Sun, Jun 22, 2014 at 09:26:44PM -0400, Eric Sunshine wrote:

> > +               if (line == eol)
> > +                       return NULL;
> > +               next = *eol ? eol + 1 : NULL;
> > +
> > +               if (eol - line > key_len &&
> > +                   !strncmp(line, key, key_len) &&
> > +                   line[key_len] == ' ') {
> > +                       *out_len = eol - line - key_len - 1;
> > +                       return line + key_len + 1;
> > +               }
> > +               line = next;
> 
> This is already simplified from the original implementation in
> get_header(), but it can be simplified further by dropping 'next',
> which is not otherwise used, and assigning 'line' directly:
> 
>     line = *eol ? eol + 1 : NULL;

Yeah, you're right. Squashed, thanks.

-Peff
