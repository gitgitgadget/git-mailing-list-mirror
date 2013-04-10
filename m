From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] test-lint-duplicates: consider only numbered test cases
Date: Wed, 10 Apr 2013 12:03:50 -0400
Message-ID: <20130410160350.GC10749@sigill.intra.peff.net>
References: <201304101622.58688.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Wed Apr 10 18:04:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPxVA-0000Sf-CY
	for gcvg-git-2@plane.gmane.org; Wed, 10 Apr 2013 18:04:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936978Ab3DJQD6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Apr 2013 12:03:58 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:38821 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751558Ab3DJQD5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Apr 2013 12:03:57 -0400
Received: (qmail 3521 invoked by uid 107); 10 Apr 2013 16:05:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 10 Apr 2013 12:05:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Apr 2013 12:03:50 -0400
Content-Disposition: inline
In-Reply-To: <201304101622.58688.tboegi@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220699>

On Wed, Apr 10, 2013 at 04:22:57PM +0200, Torsten B=C3=B6gershausen wro=
te:

> Running make inside contrib/remote-helpers may fail in "test-lint-dup=
licates"
>=20
> This was because the regexp checking for duplicate numbers strips eve=
rything
> after the first "-" in the filename, including the prefix.
>=20
> As a result, 2 pathnames like
> "xxxx/contrib/remote-helpers/test-XX.sh" and
> "xxxx/contrib/remote-helpers/test-YY.sh"
>=20
> are both converted into
> "xxxx/contrib/remote", and reported as duplicate.
>=20
> Improve the regexp:
> - strip the leading path and look only at the basename
> - only look at files which have tNNNN- (where N stand for a digit) in=
 the name
>=20
> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
> ---

Yeah, I think this is fine. Though note that we already have Felipe's
patch to just set TEST_LINT explicitly, so I think it is a non-issue
now.

-Peff
