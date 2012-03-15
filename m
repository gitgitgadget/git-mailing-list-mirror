From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/3] help: Fix help message for aliases
Date: Thu, 15 Mar 2012 09:19:04 -0400
Message-ID: <20120315131903.GA8467@sigill.intra.peff.net>
References: <1331779969-8641-1-git-send-email-namhyung.kim@lge.com>
 <20120315041734.GD4149@sigill.intra.peff.net>
 <4F617AE2.9050700@lge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?utf-8?B?6rmA64Ko7ZiV?= <namhyung.kim@lge.com>
X-From: git-owner@vger.kernel.org Thu Mar 15 14:19:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S8AaH-0005i4-V5
	for gcvg-git-2@plane.gmane.org; Thu, 15 Mar 2012 14:19:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761904Ab2CONTL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 Mar 2012 09:19:11 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:49856
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932313Ab2CONTG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Mar 2012 09:19:06 -0400
Received: (qmail 21646 invoked by uid 107); 15 Mar 2012 13:19:18 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 15 Mar 2012 09:19:18 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 Mar 2012 09:19:04 -0400
Content-Disposition: inline
In-Reply-To: <4F617AE2.9050700@lge.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193213>

On Thu, Mar 15, 2012 at 02:15:14PM +0900, =EA=B9=80=EB=82=A8=ED=98=95 w=
rote:

> >What output does this produce for:
> >
> >   $ git config alias.foo '!f() { git log $1@{u}..$1; }; f'
> >   $ git help foo
> >
> >?
> >
>=20
> Oh, I didn't think of such a complicated case. Hmm, how about
> checking whether the first word is a git command or not:
>=20
> 		printf("`git %s' is aliased to `%s%s'\n", argv[0],
> 			is_git_command(first_word) ? "git " : "", alias);

I think the right solution is to just look for "!", which is what tells
git it is a shell command.

-Peff
