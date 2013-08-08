From: Greg Troxel <gdt@ir.bbn.com>
Subject: Re: Feature Request: Support logic or shell execution to control values in .gitconfig
Date: Thu, 08 Aug 2013 11:47:56 -0400
Message-ID: <rmieha46v6b.fsf@fnord.ir.bbn.com>
References: <CANY-LFJZazieg-7gLq1=pv=nkED81Gck4=95ffgZ6tGVgX5ffg@mail.gmail.com>
	<vpq1u64dx63.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Cc: Morgan McClure <mcclure.morgan@gmail.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Aug 08 17:48:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7SRV-0006Oz-Jw
	for gcvg-git-2@plane.gmane.org; Thu, 08 Aug 2013 17:48:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965864Ab3HHPr6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Aug 2013 11:47:58 -0400
Received: from fnord.ir.bbn.com ([192.1.100.210]:59173 "EHLO fnord.ir.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757906Ab3HHPr5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Aug 2013 11:47:57 -0400
Received: by fnord.ir.bbn.com (Postfix, from userid 10853)
	id 5B495C128; Thu,  8 Aug 2013 11:47:56 -0400 (EDT)
OpenPGP: id=32611E25
X-Hashcash: 1:20:130808:git@vger.kernel.org::pZ9kiWOpAj5ieFtF:0000000000000000000000000000000000000000000qOb
X-Hashcash: 1:20:130808:mcclure.morgan@gmail.com::ublHQSD3X1700Hre:000000000000000000000000000000000000015C9
X-Hashcash: 1:20:130808:matthieu.moy@grenoble-inp.fr::1Q22rF4tAZv1h4Gy:0000000000000000000000000000000000V4O
In-Reply-To: <vpq1u64dx63.fsf@anie.imag.fr> (Matthieu Moy's message of "Thu,
	08 Aug 2013 17:23:00 +0200")
User-Agent: Gnus/5.130006 (Ma Gnus v0.6) Emacs/23.4 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231899>

--=-=-=
Content-Type: text/plain


Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> What I suggest instead is to edit/track/share template configuration
> files like
>
> ~/.gitconfig.in
> email = me@HOSTNAME@
>
> and then script something like sed -e "s/@HOSTNAME@/$(hostname)/" <
> ~/.gitconfig.in > ~/.gitconfig.
>
> You may also use the include.path functionality to share most of your
> configuration, and include a small file which is different on each host.

For what it's worth, I

  keep dotfiles checked in as m4 sources, which is more or less
  equivalent to Matthieu's suggestion of sed

  don't try to keep .gitconfig under source control, but instead have a
  "git-config" alias that executes a lot of "git config --global"
  commands.

The downsides to the git-config shell function approach are:

  unwanted configurations are not removed

  one has to source (e.g.) .bash_aliases and then rerun git-config after
  updating the dotfile repo,


I suspect what's really needed is some sort of two-way macro
preprocessor that can take changes in an output file an back them into
the source.

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (NetBSD)

iEYEARECAAYFAlIDvawACgkQ+vesoDJhHiUzFACfTMk9j9mhF5gqUWMcn3SiuWJu
k2YAoLDP7Lgx81MXmOH/XoOZY024U300
=3MrG
-----END PGP SIGNATURE-----
--=-=-=--
