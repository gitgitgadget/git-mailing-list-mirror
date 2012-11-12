From: Jeff King <peff@peff.net>
Subject: Re: git log to use .mailmap by default?
Date: Mon, 12 Nov 2012 18:18:15 -0500
Message-ID: <20121112231815.GE10531@sigill.intra.peff.net>
References: <1352635999.79618.YahooMailNeo@web160306.mail.bf1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Jason Timrod <jtimrod@yahoo.com>
X-From: git-owner@vger.kernel.org Tue Nov 13 00:18:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TY3Gz-0003bi-NR
	for gcvg-git-2@plane.gmane.org; Tue, 13 Nov 2012 00:18:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754001Ab2KLXST convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Nov 2012 18:18:19 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:45181 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752718Ab2KLXST (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2012 18:18:19 -0500
Received: (qmail 15733 invoked by uid 107); 12 Nov 2012 23:19:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 12 Nov 2012 18:19:07 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Nov 2012 18:18:15 -0500
Content-Disposition: inline
In-Reply-To: <1352635999.79618.YahooMailNeo@web160306.mail.bf1.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209544>

On Sun, Nov 11, 2012 at 04:13:19AM -0800, Jason Timrod wrote:

> I note that when defining a .mailmap file, that it's honoured by
> git-shotlog(1) by default, but for git-log(1) I have to define an
> entirely new --pretty=3D formatting option to use it.
>=20
> Why is this? =C2=A0Why doesn't git-log honour this by default like
> git-shortlog does?
>=20
> Would there be a way of making .mailmap be the default without needin=
g
> a pretty option each time to redefine the default?

I think it's mostly hysterical raisins. Mailmap grew as a shortlog
feature, and then only later became available via custom format
specifiers like "%aN", in git-blame, etc. And nobody ever updated the
stock formats.

It would make sense to me to add an option to do so, and probably to
turn it on by default for normal human-consumed formats, but probably
not for "--pretty=3Draw".

-Peff
