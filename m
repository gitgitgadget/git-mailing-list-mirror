From: Jeff King <peff@peff.net>
Subject: Re: [RFC PATCHv2 09/16] t4026 (color): add missing &&
Date: Sat, 25 Sep 2010 00:02:27 -0400
Message-ID: <20100925040227.GA21416@sigill.intra.peff.net>
References: <1285366976-22216-1-git-send-email-newren@gmail.com>
 <1285366976-22216-10-git-send-email-newren@gmail.com>
 <AANLkTi=SyN6H7RAuDW2zPekMdxwWkY+__v4df2Lj_Z3O@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elijah Newren <newren@gmail.com>, git@vger.kernel.org
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 25 06:02:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzLyK-0003tu-9i
	for gcvg-git-2@lo.gmane.org; Sat, 25 Sep 2010 06:02:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750787Ab0IYEC3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 25 Sep 2010 00:02:29 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:53253 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750722Ab0IYEC3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Sep 2010 00:02:29 -0400
Received: (qmail 25642 invoked by uid 111); 25 Sep 2010 04:02:28 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Sat, 25 Sep 2010 04:02:28 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 25 Sep 2010 00:02:27 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTi=SyN6H7RAuDW2zPekMdxwWkY+__v4df2Lj_Z3O@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157114>

On Fri, Sep 24, 2010 at 10:55:08PM +0000, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:

> On Fri, Sep 24, 2010 at 22:22, Elijah Newren <newren@gmail.com> wrote=
:
> > FIXME: Is it intended that this git config --unset fail? =C2=A0I ha=
d to add a
> > test_might_fail as well.
>=20
> Presumably this is to work around the user having diff.color in his
> config or something? Should we be leaking like that?

No, it was to clean up from previous tests, which set diff.color.new, t=
o
make sure we had a clean environment.  So it should have been might_fai=
l
(but it predated might_fail, which is why it wasn't).

But look at 8b124135, which came later. It changed the color() and
invalid_color() helpers to no longer use diff.color.new, so that cleanu=
p
is now obsolete. So that line can simply be removed now.

-Peff
