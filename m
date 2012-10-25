From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Move try_merge_command and checkout_fast_forward to
 libgit.a
Date: Thu, 25 Oct 2012 05:45:01 -0400
Message-ID: <20121025094500.GJ8390@sigill.intra.peff.net>
References: <1350959091-30030-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 25 11:45:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRK0Q-0004Zi-SC
	for gcvg-git-2@plane.gmane.org; Thu, 25 Oct 2012 11:45:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935153Ab2JYJpF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Oct 2012 05:45:05 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:56040 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935050Ab2JYJpD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2012 05:45:03 -0400
Received: (qmail 7000 invoked by uid 107); 25 Oct 2012 09:45:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 25 Oct 2012 05:45:43 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 25 Oct 2012 05:45:01 -0400
Content-Disposition: inline
In-Reply-To: <1350959091-30030-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208377>

On Tue, Oct 23, 2012 at 09:24:51AM +0700, Nguyen Thai Ngoc Duy wrote:

> These functions are called in sequencer.c, which is part of
> libgit.a. This makes libgit.a potentially require builtin/merge.c for
> external git commands.
>=20
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  I made some unrelated changes in sequencer.c and this problem shown
>  up. merge-recursive.c is probably not the best place for these
>  functions. I just don't want to create merge.c for them.

I'm fine with this conceptually, but merge-recursive really is the wron=
g
place. I'd much rather see a new merge.c to collect merge-related helpe=
r
functions that are not strategy-specific.

-Peff
