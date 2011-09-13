From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH/RFC] bash: add --word-diff option to diff auto-completion
Date: Wed, 14 Sep 2011 01:29:41 +0200
Message-ID: <20110913232941.GC2078@goldbirke>
References: <4E6F720A.3020103@yahoo.com.br> <20110913165847.GB11076@elie>
	<4E6FA541.7000100@yahoo.com.br> <20110913191448.GC14917@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>,
	Rodrigo Rosenfeld Rosas <lbocseg@yahoo.com.br>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 14 01:29:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3cQF-0007Dd-TM
	for gcvg-git-2@lo.gmane.org; Wed, 14 Sep 2011 01:29:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933088Ab1IMX3o convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 Sep 2011 19:29:44 -0400
Received: from moutng.kundenserver.de ([212.227.17.10]:52266 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933048Ab1IMX3n (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Sep 2011 19:29:43 -0400
Received: from localhost6.localdomain6 (p5B130EED.dip0.t-ipconnect.de [91.19.14.237])
	by mrelayeu.kundenserver.de (node=mrbap0) with ESMTP (Nemesis)
	id 0M7DTa-1RNlwJ05aA-00wUOc; Wed, 14 Sep 2011 01:29:41 +0200
Content-Disposition: inline
In-Reply-To: <20110913191448.GC14917@elie>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Provags-ID: V02:K0:MUaOA2b28rF+QyjunexW4GROCj7XnYTO+N8fZGadaol
 k70qLT8cI9R55UbHjc3B3c0NapBb8pqE3MtcxtfQZfKL9SR9rp
 dnIFI5diaHaqvBboom10J7cup2BAhnAgxI6SkNcW2bJfnWUM9z
 zw3X/olswqSR9I4s6RlLR6+rLlK3kxr01l9uk1yDto3EW+nFhB
 0XUcUCWkwV9tcujpAg+sz58i9yf26HvYLIyq925Asa5G+pfMPt
 6mxCaRVMy5cOjApodU6XqiDKqMU9pv7okuHcvDWqrrqmg3OAVw
 ZHTggDRkUeKQzcbjUDMfaMF3V5MTSFt0jGyJVhjwUd8zEvPAI9
 jCSAtOZD2k9H9vNZRMBg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181326>

Hi,


On Tue, Sep 13, 2011 at 02:14:48PM -0500, Jonathan Nieder wrote:
> From: Rodrigo Rosenfeld Rosas <rr.rosas@gmail.com>
> Date: Tue, 13 Sep 2011 15:24:38 -0300
>=20
> Add "--word-diff" to diff completion, since this is a common
> desired option when looking at diffs.
>=20
> Signed-off-by: Rodrigo Rosenfeld Rosas <rr.rosas@gmail.com>
> ---
> Hi G=E1bor,
>=20
> Here's a patch.  What do you think?

Looks obviously good to me, ...

> I was thinking it would be nice to complete --word-diff-regex, too,
> and to be able to do
>=20
> 	git diff --color-words=3D<TAB>
> 	git diff --word-diff=3D<TAB>

=2E.. but yeah, there is room for while-at-its ;)

The completion script currently only offers --color-words but not
--color-words=3D.  This is sort of OK, because --color-words' parameter=
s
are optional.  However, in several cases the completion script offers
both --option and --option=3D to indicate that it takes an optional
parameter, see e.g.

  diff --dirstat --dirstat-by-file
  commit --untracked-files
  format-patch --thread
  init --shared
  log --decorate

(But we don't do this in all such cases, see e.g. diff --stat --color
or log --branches --tags --remotes.)

So I think it's fine to offer both --color-words and --color-words=3D,
and both --word-diff and --word-diff=3D.

> but I couldn't find any examples of the latter to crib from

I'm not sure what you mean by git diff --color-words=3D<TAB>, because i=
t
takes a regexp.  Or is it just too late here and I'm missing something
obvious?

Completing the mode for --word-diff=3D<TAB> is a good idea, but c'mon,
there are plenty of examples ;)  Have a look at _git_am(),
_git_format_patch(), or _git_init() for something easy, and
_git_commit(), _git_log(), or _git_notes() for something fancy.

Note that --word-diff=3D is also valid for log and shortlog, so the sam=
e
can be done there, too.


Best,
G=E1bor
