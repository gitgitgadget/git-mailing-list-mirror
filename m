From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 3/3] fetch: reduce duplicate in ref update status lines
Date: Fri, 3 Jun 2016 13:06:21 -0400
Message-ID: <20160603170621.GA3858@sigill.intra.peff.net>
References: <20160522112019.26516-1-pclouds@gmail.com>
 <20160603110843.15434-1-pclouds@gmail.com>
 <20160603110843.15434-4-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 03 19:10:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8sYH-0000rH-6N
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 19:06:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932676AbcFCRGZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Jun 2016 13:06:25 -0400
Received: from cloud.peff.net ([50.56.180.127]:48646 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932349AbcFCRGY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2016 13:06:24 -0400
Received: (qmail 23545 invoked by uid 102); 3 Jun 2016 17:06:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Jun 2016 13:06:24 -0400
Received: (qmail 23980 invoked by uid 107); 3 Jun 2016 17:06:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Jun 2016 13:06:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Jun 2016 13:06:21 -0400
Content-Disposition: inline
In-Reply-To: <20160603110843.15434-4-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296349>

On Fri, Jun 03, 2016 at 06:08:43PM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=
=BB=8Dc Duy wrote:

> When there are lots of ref updates, each has different name length, t=
his
> will make it easier to look because the variable part is at the end.

Is it worth handling more complicated cases, where there is a similar
"middle", but different beginning?

One of my common refspecs is:

  +refs/pull/*/head:refs/remotes/pull/*

That still shows as:

  refs/pull/123/head -> pull/123

but could be:

  {refs -> }/pull/123{head -> }

I actually think that _isn't_ an improvement, but I wonder if there is =
a
format that would be.

-Peff
