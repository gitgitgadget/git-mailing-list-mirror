From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: Where should git-prompt.sh be installed?
Date: Thu, 25 Oct 2012 17:11:20 +0200
Message-ID: <20121025151120.GA14740@goldbirke>
References: <1337719600-7361-1-git-send-email-felipe.contreras@gmail.com>
 <1337719600-7361-3-git-send-email-felipe.contreras@gmail.com>
 <20121025005106.GA9112@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Anders Kaseorg <andersk@MIT.EDU>,
	Danny Yates <mail4danny@googlemail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Ted Pavlic <ted@tedpavlic.com>, Dan McGee <dan@archlinux.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 25 17:11:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRP5v-0004Yo-Ai
	for gcvg-git-2@plane.gmane.org; Thu, 25 Oct 2012 17:11:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965463Ab2JYPLZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Oct 2012 11:11:25 -0400
Received: from moutng.kundenserver.de ([212.227.17.10]:58028 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934530Ab2JYPLW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2012 11:11:22 -0400
Received: from localhost6.localdomain6 (goldbirke.fzi.de [141.21.50.31])
	by mrelayeu.kundenserver.de (node=mrbap0) with ESMTP (Nemesis)
	id 0MYcDK-1TwhMA3wJ8-00Vt7g; Thu, 25 Oct 2012 17:11:21 +0200
Content-Disposition: inline
In-Reply-To: <20121025005106.GA9112@elie.Belkin>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:gOPrPAcRnyfzeP9qSQAsR+2EVh8S7lWRG+Db604orp1
 mgfqmWEUkg+sh9ey3SMJhC9LBIgCVhmUK0dvthv3OLUylzMy/s
 gJOD5RqihRJJnQai9oPNoWfPkqBlYWP04Ekwg3QAijYCkIsjtr
 Ffn1tJr+wolYMMBxzVSErKtN96aZzhuilP0lmRrhv3pjoo0Lss
 K53Q0ugiHQuZ1jimvYOfN+RSQVFHbwnmqjsJhSG2c6zVnRE0Vi
 tof2w0REhxfLQm0c+x5dJ2Gb2OODvVdEJxMIxU71E0f/deEWza
 dI2pwLKsa1jOp/hCXrCM9newYxwEreNc3Rd/ccVrxlUi8+Z+mg
 yghpBlFAcRi90N2WmLkgRXYMn3zVTVmNsXhBMYTJN
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208401>

On Wed, Oct 24, 2012 at 05:51:06PM -0700, Jonathan Nieder wrote:
> Hi,
>=20
> In olden days the admin would copy contrib/completion/git-completion.=
sh
> to
>=20
>         /etc/bash_completion.d/git
>=20
> and mortals could source /etc/bash_completion or
> /etc/bash_completion.d/git in their ~/.bashrc (possibly shared among
> multiple machines) so that the bash completion and __git_ps1 helpers
> could work.

Ah, the good old days!  I even modified 'make install' to copy the
completion script to /etc/bash_completion.d/.  And I was happy.

> With Git 1.7.12 __git_ps1 has been split into a separate file, to hel=
p
> users who only want __git_ps1 to avoid the overhead of loading the
> entire completion script (and allow the completion script to be loade=
d
> by bash-completion magic on the fly!).  Now the sysadmin should copy
> contrib/completion/git-completion.sh to
>=20
> 	/usr/share/bash-completion/completions/git
>=20
> and contrib/completion/git-prompt.sh to
>=20
> 	/usr/share/git-core/contrib/?? (somewhere?)
>=20
> Mortals source /etc/bash_completion in their ~/.bashrc (possibly
> shared among multiple machines) and expect bash completion to work.
> For __git_ps1, users should source that ?? path.
>=20
> Questions:
>=20
>  1) what path is appropriate for ?? above?
>  2) is this documented anywhere?

Don't know what is appropriate, and it's not documented.  I for one
copy it manually to ~/.git-prompt.sh every once in a while.  And I'm
not all that happy with that.

> Possible answers:
>=20
>  1) Fedora uses /etc/profile.d/git-prompt.sh.  Gentoo uses
>     /usr/share/bash-completion/git-prompt.  Maybe others use
>     some other path.
>=20
>  2) The scripts themselves suggest copying to ~/.git-completion.sh
>     and ~/.git-prompt.sh.
>=20
> Proposal:
>=20
>   1) /usr/lib/git-core/git-sh-prompt
>   2) git-sh-prompt(1)

Not sure about the "sh" part.  The prompt function is very
Bash-specific, it won't work under a plain POSIX shell.

Do other VCSes have similar prompt scripts?  Where do they install
theirs?


G=E1bor
