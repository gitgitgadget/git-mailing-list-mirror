From: Lars Noschinski <lars@public.noschinski.de>
Subject: Re: git grep --no-index and absolute paths don't work?
Date: Fri, 21 Oct 2011 13:49:52 +0200
Message-ID: <20111021114952.GA2797@lars.home.noschinski.de>
References: <CAKPyHN138OZRt_3PT5ChuTpSEuOdybnyAj8Baqr=3OD=y==jgw@mail.gmail.com>
 <1319180973.5352.8.camel@bee.lab.cmartin.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Bert Wesarg <bert.wesarg@googlemail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Carlos =?iso-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Fri Oct 21 13:55:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RHDhK-0004WP-UB
	for gcvg-git-2@lo.gmane.org; Fri, 21 Oct 2011 13:55:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754572Ab1JULze convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 21 Oct 2011 07:55:34 -0400
Received: from smtprelay05.ispgateway.de ([80.67.31.98]:59155 "EHLO
	smtprelay05.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754537Ab1JULze (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Oct 2011 07:55:34 -0400
X-Greylist: delayed 336 seconds by postgrey-1.27 at vger.kernel.org; Fri, 21 Oct 2011 07:55:33 EDT
Received: from [138.246.44.128] (helo=zwergkolibri.home.noschinski.de)
	by smtprelay05.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <lars@public.noschinski.de>)
	id 1RHDbj-0002WI-J1; Fri, 21 Oct 2011 13:49:51 +0200
Received: from lars by zwergkolibri.home.noschinski.de with local (Exim 4.76)
	(envelope-from <lars@public.noschinski.de>)
	id 1RHDbk-00010M-LQ; Fri, 21 Oct 2011 13:49:52 +0200
Content-Disposition: inline
In-Reply-To: <1319180973.5352.8.camel@bee.lab.cmartin.tk>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Df-Sender: bGFyc0Bub3NjaGluc2tpLmRl
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184056>

* Carlos Mart=EDn Nieto <cmn@elego.de> [11-10-21 09:09]:
> On Fri, 2011-10-21 at 08:34 +0200, Bert Wesarg wrote:
> > I'm currently  totally confused, that a
> >=20
> >     git grep --no-index foo /usr/include
> >=20
> > does not work. I know that the documentation says "in the current
> > directory" for the --no-index flag. But this does not work ether:
>=20
> The rest of the sentence reads ", not just those tracked by git" whic=
h
> implies that the files tracked by git are also searched. This require=
s a
> git repository.

git grep --no-index works outside of git repositories (at least with
relative paths).

> >     cd ~; git grep --no-index foo ~/.bashrc
> >=20
> > They all fail with 'is outside repository'. Which is for itself var=
y
> > misleading, because I intentionally said --no-index.
>=20
> Git is a tool that works on git repositories. Some commands may work
> outside of a repository, like ls-remote when given an URL or init (fo=
r
> obvious reasons) but it's not something that should be expected,
> especially for commands that read files from the working tree.
>=20
> Why are you trying to use git's grep command outside a repository? Wh=
y
> isn't 'grep -nr foo /usr/include/' good enough?

There are a few nice things about git's grep, which GNU grep does not
have:

  - automatic usage of pager
  - support for pathspecs (can be emulated with `find ...`)
  - support for boolean combinations of regular expressions

  -- Lars.
