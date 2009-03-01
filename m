From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: jgit and ignore
Date: Sun, 1 Mar 2009 09:49:41 -0800
Message-ID: <20090301174941.GD14365@spearce.org>
References: <9e4733910902280831j70448ce9h7239f14e13b92b76@mail.gmail.com> <20090228172622.GC26689@spearce.org> <49AA5F64.6070207@pelagic.nl> <9e4733910903010454u662eb5afob45f608321660500@mail.gmail.com> <49AA884D.1050806@pelagic.nl> <49AA8ECD.4090302@gmail.com> <49AA91F0.7050008@pelagic.nl> <49AAA2B3.40808@gmail.com> <20090301171648.GB14365@spearce.org> <49AAC91E.1000401@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Ferry Huberts (Pelagic)" <ferry.huberts@pelagic.nl>,
	Jon Smirl <jonsmirl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Tor Arne =?iso-8859-1?Q?Vestb=F8?= <torarnv@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 01 18:51:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ldpok-0002TK-H1
	for gcvg-git-2@gmane.org; Sun, 01 Mar 2009 18:51:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756307AbZCARtn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 Mar 2009 12:49:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756034AbZCARtn
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Mar 2009 12:49:43 -0500
Received: from george.spearce.org ([209.20.77.23]:40356 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753589AbZCARtm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Mar 2009 12:49:42 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 0D62838210; Sun,  1 Mar 2009 17:49:41 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <49AAC91E.1000401@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111862>

Tor Arne Vestb=F8 <torarnv@gmail.com> wrote:
> Shawn O. Pearce wrote:
> > IMHO, we should honor ignores in EGit as:
> >=20
> >   per-directory .gitignore
> >   per-repostiory GIT_DIR/info/exclude
> >=20
> >   per-repository core.excludesfile (yes, really, it can be per
> >   repository, which overrides ~/.gitconfig setting of same)
> >=20
> >   Eclipse global team ignore patterns
>=20
> Just to be clear, I noticed you left out the global core.excludesfile
> (from ~/.gitconfig) here. I guess this intentional?

No, I didn't.  core.excludesfile is read from the config, the config
is a union of /etc/gitconfig, ~/.gitconfig, and GIT_DIR/config.  The
last setting wins.
=20
> Or should we combine the ignores from the global team ignores and the
> ignores from the global core.excludesfile in ~/.gitconfig?
>
> Either way, I full agree that we should honor all repository ignores
> (whether they are in directory .gitignores, info/exclude, or given by
> repository-specific core.excludesfile).

Right.  See my reply to Ferry, we union all of them together, but in
the case of core.excludesfile we have to honor what the repository
is telling us is the correct setting for that one repository,
which may differ from other repositories if it has been overridden.

--=20
Shawn.
