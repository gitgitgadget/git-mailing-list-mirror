From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 12/22] delete_ref_loose(): don't muck around in the
 lock_file's filename
Date: Wed, 2 Apr 2014 02:55:58 -0400
Message-ID: <20140402065558.GA2395@sigill.intra.peff.net>
References: <1396367910-7299-1-git-send-email-mhagger@alum.mit.edu>
 <1396367910-7299-13-git-send-email-mhagger@alum.mit.edu>
 <533BB3A1.1080203@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Thu Apr 03 12:34:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WVeJ4-0006sp-GP
	for gcvg-git-2@plane.gmane.org; Thu, 03 Apr 2014 11:51:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757952AbaDBG4D convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Apr 2014 02:56:03 -0400
Received: from cloud.peff.net ([50.56.180.127]:52370 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757453AbaDBG4A (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Apr 2014 02:56:00 -0400
Received: (qmail 22183 invoked by uid 102); 2 Apr 2014 06:56:00 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 02 Apr 2014 01:56:00 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 02 Apr 2014 02:55:58 -0400
Content-Disposition: inline
In-Reply-To: <533BB3A1.1080203@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245682>

On Wed, Apr 02, 2014 at 08:52:17AM +0200, Torsten B=C3=B6gershausen wro=
te:

> +		/*
> +		 * loose.  The loose file name is the same as the
> +		 * lockfile name, minus ".lock":
> +		 */
> +		char *loose_filename =3D xmemdupz(lock->lk->filename,
> +						strlen(lock->lk->filename) - 5);
>=20
> At other places (lockfile.c) we use this
>=20
> +#define LOCK_SUFFIX_LEN 5
>=20
> I think it makes sense to move this definition to an include file (lo=
ckfile.h ??)
> and use it here.

I had the same comment, but if you read through to patch 18, this manua=
l
munging goes away entirely, and the end result is much cleaner.

-Peff
