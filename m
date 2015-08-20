From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] config: restructure format_config() for better control
 flow
Date: Thu, 20 Aug 2015 10:45:04 -0400
Message-ID: <20150820144504.GA22935@sigill.intra.peff.net>
References: <xmqqa8twj7b8.fsf@gitster.dls.corp.google.com>
 <1440080062-26811-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <christian.couder@gmail.com>,
	git@vger.kernel.org
To: SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Thu Aug 20 16:45:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZSR5m-0007TU-4v
	for gcvg-git-2@plane.gmane.org; Thu, 20 Aug 2015 16:45:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753286AbbHTOpK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 Aug 2015 10:45:10 -0400
Received: from cloud.peff.net ([50.56.180.127]:47555 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751738AbbHTOpH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Aug 2015 10:45:07 -0400
Received: (qmail 3266 invoked by uid 102); 20 Aug 2015 14:45:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 20 Aug 2015 09:45:06 -0500
Received: (qmail 23711 invoked by uid 107); 20 Aug 2015 14:45:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 20 Aug 2015 10:45:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Aug 2015 10:45:04 -0400
Content-Disposition: inline
In-Reply-To: <1440080062-26811-1-git-send-email-szeder@ira.uka.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276243>

On Thu, Aug 20, 2015 at 04:14:22PM +0200, SZEDER G=C3=A1bor wrote:

> Commit 578625fa91 (config: add '--name-only' option to list only
> variable names, 2015-08-10) modified format_config() such that it
> returned from the middle of the function when showing only keys,
> resulting in ugly code structure.
>=20
> Reorganize the if statements and dealing with the key-value delimiter=
 to
> make the function easier to read.

This looks good to me. What do you think of these on top?

  [1/3]: format_config: don't init strbuf
  [2/3]: format_config: simplify buffer handling
  [3/3]: get_urlmatch: avoid useless strbuf write

-Peff
