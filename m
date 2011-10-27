From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 00/22] Refactor to accept NUL in commit messages
Date: Thu, 27 Oct 2011 11:52:21 -0700
Message-ID: <20111027185220.GA26621@sigill.intra.peff.net>
References: <7vipng5k80.fsf@alter.siamese.dyndns.org>
 <CACsJy8CA2cqJqt7cUN1CdnOb3=qE6B2XTd1oQKZ7osVz09kSGg@mail.gmail.com>
 <7vehy459bg.fsf@alter.siamese.dyndns.org>
 <20111023160744.GA22444@sigill.intra.peff.net>
 <7v39ej5uqb.fsf@alter.siamese.dyndns.org>
 <7vy5wb3sto.fsf@alter.siamese.dyndns.org>
 <20111024224558.GB10481@sigill.intra.peff.net>
 <7vvcrd411x.fsf@alter.siamese.dyndns.org>
 <20111027181303.GF1967@sigill.intra.peff.net>
 <7v7h3qz2yo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 27 20:52:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJV41-0002YS-JW
	for gcvg-git-2@lo.gmane.org; Thu, 27 Oct 2011 20:52:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755016Ab1J0SwZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Oct 2011 14:52:25 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:56792
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754614Ab1J0SwY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Oct 2011 14:52:24 -0400
Received: (qmail 4541 invoked by uid 107); 27 Oct 2011 18:58:12 -0000
Received: from c-67-169-41-183.hsd1.ca.comcast.net (HELO sigill.intra.peff.net) (67.169.41.183)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 27 Oct 2011 14:58:12 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 27 Oct 2011 11:52:21 -0700
Content-Disposition: inline
In-Reply-To: <7v7h3qz2yo.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184316>

On Thu, Oct 27, 2011 at 11:47:27AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I'm tempted to detect the UTF-{16,32}{LE,BE} by their BOM, reencode them
> > to utf8, and then display them in utf8. Is that too gross for us to
> > consider?
> 
> I tend to think so; it is entirely a different matter if the user
> instructed us to clean/smudge UTF-16 payload into/outof UTF-8.

Minor nit, but this is just for diff, so it is not about clean/smudge
but rather about doing something like textconv.

The other option I mentioned would be something like detecting the BOM
and pretending as if the attribute "diff=utf-16" was set (which would do
nothing by default). Then people could set themselves up to handle
utf-16 if they wanted, but wouldn't have to go around marking each file
with .gitattributes.

But maybe that is too gross, too, and they should just use
.gitattributes.

-Peff
