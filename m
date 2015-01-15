From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] init-db: remove unused #includes
Date: Thu, 15 Jan 2015 17:31:12 -0500
Message-ID: <20150115223112.GB19021@peff.net>
References: <1421258367-8483-1-git-send-email-kuleshovmail@gmail.com>
 <xmqq61c99o25.fsf@gitster.dls.corp.google.com>
 <xmqqwq4p86i6.fsf@gitster.dls.corp.google.com>
 <CANCZXo5UY80327pvjzYkJXroH_WZdW36LhSANK0O7GGVQLF=AA@mail.gmail.com>
 <20150115105558.GA13536@peff.net>
 <xmqqsifb6atr.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Alexander Kuleshov <kuleshovmail@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 15 23:31:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBswh-0006On-4V
	for gcvg-git-2@plane.gmane.org; Thu, 15 Jan 2015 23:31:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753029AbbAOWbP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2015 17:31:15 -0500
Received: from cloud.peff.net ([50.56.180.127]:35188 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752328AbbAOWbO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2015 17:31:14 -0500
Received: (qmail 5602 invoked by uid 102); 15 Jan 2015 22:31:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 15 Jan 2015 16:31:14 -0600
Received: (qmail 17046 invoked by uid 107); 15 Jan 2015 22:31:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 15 Jan 2015 17:31:36 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 Jan 2015 17:31:12 -0500
Content-Disposition: inline
In-Reply-To: <xmqqsifb6atr.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262514>

On Thu, Jan 15, 2015 at 12:36:00PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > FWIW, the full set of CFLAGS I use (which I specify in config.mak) is:
> >
> >     CFLAGS += -Wall -Werror
> >     CFLAGS += -Wno-format-zero-length
> >     CFLAGS += -Wdeclaration-after-statement
> >     CFLAGS += -Wpointer-arith
> >     CFLAGS += -Wstrict-prototypes
> >     CFLAGS += -Wold-style-declaration
> 
> I think I have no-pointer-to-int-cast, old-style-definition and vla
> in addition to the above.

Thanks, I added the latter two to my setup. But what is the purpose of
turning off pointer-to-int warnings? It seems like those are a good
indication of a sloppy construct (and AFAICT, we do not have any code
which triggers on it).

-Peff
