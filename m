From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] upload-pack: avoid parsing objects during ref
 advertisement
Date: Tue, 29 Jan 2013 03:14:10 -0500
Message-ID: <20130129081409.GA5350@sigill.intra.peff.net>
References: <7vipkpn87d.fsf@alter.siamese.dyndns.org>
 <20120106191740.GA12903@sigill.intra.peff.net>
 <CAJo=hJubUF2mmkzXU77kQ5uj1cbBZrnLcw2u736wMqxhs39jdQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
	git-dev@github.com
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Jan 29 09:14:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U06Kx-0002Zu-K2
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jan 2013 09:14:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754546Ab3A2IOP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jan 2013 03:14:15 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:53203 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754487Ab3A2ION (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jan 2013 03:14:13 -0500
Received: (qmail 19544 invoked by uid 107); 29 Jan 2013 08:15:36 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 29 Jan 2013 03:15:36 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Jan 2013 03:14:10 -0500
Content-Disposition: inline
In-Reply-To: <CAJo=hJubUF2mmkzXU77kQ5uj1cbBZrnLcw2u736wMqxhs39jdQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214912>

On Tue, Jan 29, 2013 at 12:10:59AM -0800, Shawn O. Pearce wrote:

> > On a repository with 120K refs, the advertisement portion of
> > upload-pack goes from ~3.4s to 3.2s (the failure to speed up
> > more is largely due to the fact that most of these refs are
> > tags, which need dereferenced to find the tag destination
> > anyway).
> 
> Why aren't we using the peeled information from the packed-refs file?
> JGit does this and it saves a lot of time on advertisements from a
> well packed repository.

The patch you are replying to is a year old. Since then, I did:

  435c833 (upload-pack: use peel_ref for ref advertisements, 2012-10-04)

-Peff
