From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/4] config: add include directive
Date: Thu, 26 Jan 2012 19:32:41 -0500
Message-ID: <20120127003241.GA15165@sigill.intra.peff.net>
References: <20120126073547.GA28689@sigill.intra.peff.net>
 <20120126073752.GA30474@sigill.intra.peff.net>
 <CACBZZX5_qjC6WZsZ9hKvSR5vQJPs=jgWn-R4EnWZGVq+RvjRyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 27 01:32:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RqZkJ-0003eW-0g
	for gcvg-git-2@lo.gmane.org; Fri, 27 Jan 2012 01:32:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754266Ab2A0Acq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 Jan 2012 19:32:46 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:46101
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752308Ab2A0Acp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jan 2012 19:32:45 -0500
Received: (qmail 31902 invoked by uid 107); 27 Jan 2012 00:39:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 26 Jan 2012 19:39:47 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 26 Jan 2012 19:32:41 -0500
Content-Disposition: inline
In-Reply-To: <CACBZZX5_qjC6WZsZ9hKvSR5vQJPs=jgWn-R4EnWZGVq+RvjRyg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189177>

On Fri, Jan 27, 2012 at 01:02:52AM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:

> On Thu, Jan 26, 2012 at 08:37, Jeff King <peff@peff.net> wrote:
> > This patch introduces an include directive for config files.
> > It looks like:
> >
> > =C2=A0[include]
> > =C2=A0 =C2=A0path =3D /path/to/file
>=20
> Very nice, I'd been meaning to resurrect my gitconfig.d series, and
> this series implements a lot of the structural changes needed for tha=
t
> sort of thing.

Yeah, that seems like a reasonable thing to do. It could make life
easier for package managers (I think the only reason it has not come up
much is that there simply isn't a lot of third-party git config).

> What do you think of an option (e.g. include.gitconfig_d =3D true) th=
at
> would cause git to look in:
>=20
>     /etc/gitconfig.d/*
>     ~/.gitconfig.d/*
>     .git/config.d/*

Hmm. Is that really worth having an option? I.e., why not just always
check those directories?

I could see having

  [include]
        dir =3D /path/to/gitconfig.d

for non-standard directories, though (or perhaps even simpler, the
"path" directive should auto-detect a file versus a directory. Similarl=
y
the "ref" form could detect and expand a tree).

-Peff
