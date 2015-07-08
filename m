From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] pack-objects: rename the field "type" to "real_type"
Date: Wed, 8 Jul 2015 09:47:14 -0400
Message-ID: <20150708134713.GA5136@peff.net>
References: <20150707160630.GA4456@peff.net>
 <1436356591-8148-1-git-send-email-pclouds@gmail.com>
 <1436356591-8148-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 08 15:47:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCph4-0007oT-7I
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jul 2015 15:47:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933815AbbGHNrS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Jul 2015 09:47:18 -0400
Received: from cloud.peff.net ([50.56.180.127]:57517 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933739AbbGHNrR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jul 2015 09:47:17 -0400
Received: (qmail 9645 invoked by uid 102); 8 Jul 2015 13:47:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 08 Jul 2015 08:47:16 -0500
Received: (qmail 20386 invoked by uid 107); 8 Jul 2015 13:47:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 08 Jul 2015 09:47:24 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 08 Jul 2015 09:47:14 -0400
Content-Disposition: inline
In-Reply-To: <1436356591-8148-2-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273684>

On Wed, Jul 08, 2015 at 06:56:31PM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=
=BB=8Dc Duy wrote:

> This is to avoid the too generic name "type" and harmonize with the
> naming in index-pack. There's a subtle difference though: real_type i=
n
> index-pack is what the upper level see, no delta types (after delta
> resolution). But real_type in pack-objects is the type to be written =
in
> the pack, delta types are fine (it's actually markers for reused delt=
as)

Hrm, now I'm confused about whether this change is a good idea.

The definition of in_pack_type says:

>  	enum object_type in_pack_type;	/* could be delta */

so now I am confused about what exactly "type" (and now "real_type")
means.

-Peff
