From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] pack-objects: rename the field "type" to "real_type"
Date: Wed, 8 Jul 2015 10:11:11 -0400
Message-ID: <20150708141110.GA5555@peff.net>
References: <20150707160630.GA4456@peff.net>
 <1436356591-8148-1-git-send-email-pclouds@gmail.com>
 <1436356591-8148-2-git-send-email-pclouds@gmail.com>
 <20150708134713.GA5136@peff.net>
 <CACsJy8B0OCu3-TKVztj+wCmtqXdeh6iNK5ir4Xi2BXWW14wdOQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 08 16:11:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCq4E-0005mK-Nm
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jul 2015 16:11:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932599AbbGHOLO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jul 2015 10:11:14 -0400
Received: from cloud.peff.net ([50.56.180.127]:57538 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933769AbbGHOLO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jul 2015 10:11:14 -0400
Received: (qmail 11594 invoked by uid 102); 8 Jul 2015 14:11:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 08 Jul 2015 09:11:13 -0500
Received: (qmail 20615 invoked by uid 107); 8 Jul 2015 14:11:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 08 Jul 2015 10:11:20 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 08 Jul 2015 10:11:11 -0400
Content-Disposition: inline
In-Reply-To: <CACsJy8B0OCu3-TKVztj+wCmtqXdeh6iNK5ir4Xi2BXWW14wdOQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273688>

On Wed, Jul 08, 2015 at 08:57:35PM +0700, Duy Nguyen wrote:

> > The definition of in_pack_type says:
> >
> >>       enum object_type in_pack_type;  /* could be delta */
> >
> > so now I am confused about what exactly "type" (and now "real_type")
> > means.
> 
> I think we just overload "type" with "this delta is detected reusable
> already" in write_object(). It only means 'real type in the output
> pack' for canonical types. For generated deltas, we already know if
> it's ref-delta or ofs-delta, we don't rely on real_type

Ah. I think I'd be inclined to just leave it as "type" then.

-Peff
