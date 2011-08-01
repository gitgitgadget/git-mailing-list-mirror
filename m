From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] For Real - Fixed pluralization in diff reports
Date: Mon, 1 Aug 2011 12:38:12 -0600
Message-ID: <20110801183812.GA16438@sigill.intra.peff.net>
References: <4E362F8E.1050105@gmail.com>
 <CAGdFq_iwEvD_-hD63KeF45WuRhWrK6JuWWqzDpjHcZ+0gHDaqg@mail.gmail.com>
 <4E36B8E4.5080900@gmail.com>
 <20110801180603.GB10636@sigill.intra.peff.net>
 <4E36F025.9040100@gmail.com>
 <CAGdFq_j0Hr4LMaFC3irS8rhv2N0ePz_t8xpNTDCA-arC-E2UDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jon Forrest <nobozo@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 01 20:38:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QnxNc-0006Fp-I2
	for gcvg-git-2@lo.gmane.org; Mon, 01 Aug 2011 20:38:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752793Ab1HASiQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Aug 2011 14:38:16 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:58462
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752780Ab1HASiP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2011 14:38:15 -0400
Received: (qmail 22630 invoked by uid 107); 1 Aug 2011 18:38:48 -0000
Received: from S010690840de80b38.ss.shawcable.net (HELO sigill.intra.peff.net) (70.64.172.81)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 01 Aug 2011 14:38:48 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 01 Aug 2011 12:38:12 -0600
Content-Disposition: inline
In-Reply-To: <CAGdFq_j0Hr4LMaFC3irS8rhv2N0ePz_t8xpNTDCA-arC-E2UDA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178401>

On Mon, Aug 01, 2011 at 08:32:51PM +0200, Sverre Rabbelier wrote:

> On Mon, Aug 1, 2011 at 20:27, Jon Forrest <nobozo@gmail.com> wrote:
> > I entirely agree. My point is only that the various tests
> > that expect the current behavior will have to be changed
> > whether the implementation of correct plurals uses my
> > inferior method or the way more correct i18n method.
> 
> Wouldn't it be a nice hack if we just solved problem through i18n
> then? Have all the plumbing see the current wording, but through i18n
> change it to something grammatically correct for the porcelain.
> Probably not possible, but a nice daydream :).

I thought there was still some question of whether this text was
something that should be script-parseable. If it is, then it shouldn't
be i18n'd at all, nor should we lightly change the format with
pluralization magic. And if it isn't, then we should definitely go the
full i18n route. So in either case, the original patch isn't
appropriate.

I don't have a strong opinion myself. I tend to lean towards i18n-ing
it, because any scripts should be using --numstat to parse, anyway.
OTOH, as Junio pointed out, we are matching the output of much older
tools, so pre-git scripts might be written to read the --stat format.
I've never seen such a script, and I have no idea how many there really
are.

-Peff
