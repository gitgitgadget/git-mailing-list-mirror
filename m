From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] mingw: introduce the 'core.hideDotFiles' setting
Date: Fri, 6 May 2016 17:19:23 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1605061658580.2963@virtualbox>
References: <17d30bb680a0452efd7b3c4f42e2f94478a86273.1462372716.git.johannes.schindelin@gmx.de> <xmqqr3dhhcd7.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Erik Faye-Lund <kusmabite@googlemail.com>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 06 17:19:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayhXj-0005wD-BY
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 17:19:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758446AbcEFPTq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2016 11:19:46 -0400
Received: from mout.gmx.net ([212.227.15.19]:51835 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758040AbcEFPTo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2016 11:19:44 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0LqzEB-1bcyAC30i3-00eaiw; Fri, 06 May 2016 17:19:23
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <xmqqr3dhhcd7.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:p2yi1kIo82OzmR3pMUu3YW+N6x24SsnTIQjxD6aafNnu3v93uSC
 CyIPq6cWvCCXJUaG7Iilz511LbS0MF0rg+g3/H5VtbyknW2J5tuP8/X2iD78by3eSzqnX4d
 zdihp9kz0+5dOz3qMIgC571cv7UtRtpvKhR3T59bRByeXHccVPoVGYjMifDngHI6ZYh9LRJ
 5bguS+egeV/99wGmQRLBg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:HSFGJ5MjtRA=:+qXyJT1cCO5BlfXv1rur6i
 0r2H9AuXl2KMI0fsekRBBKfLs/zU+U751+vMIMnDbe6hHYLDijAZ89LjeACiK4PEfifKBh9o1
 a4hHQ5sJI8VgP6uiQ7l/6amWFayx0LtKmHaugm2RofDJvxtPL4ltqMsOob9iyLmhhng1o41iM
 rGjAZ7+nrobRVX4iu8E3NcIYVABfVTi4aGHOLKyYUvzfe+ZEV13nCBYNbKjFW2lf8ysVC+3vS
 Z0G+hsp13SBR02x6l7H7jAmLbMTt+Ne9IOlpJpE6c6yn6kUL1cSe6yDxxWgzvhl1bTsIsGSAo
 ReMv1DvIAsTgZ/nZQUbx1gPxdRs25CKTV6ZJ2w8tDcb3bIL0UmR+aHNi97Duor4cLphqUKrOJ
 lXhJs6NQmnHEFehTx2+l9Niq7/nPvugfFlULbMr/LJaRa144uIoQ6TWLOuhCnllTCOEsgxRoo
 P3A8Rk4wOV0+HXNOZqt25WdYGIURO1agCwfgntpojPq+LDFCtrDxrInwoNGl+uQBWBsZHyc8W
 rnKXxOaFiw3c4Z8goFPPfqesJUA/eWKtEJTLmUSoIzp4RtJGaJaAsM7IPUmRVdrAFYXjYH3a9
 oXB35pdEBj0Qpig/lC0YYsxYg/hcXBRjlLCiAbOsFc7JQEPeGu5Kr8r/4nxgnA9Jb8iiBFZ7D
 zeLb4B2ICdMN1i8bW7wb6qKJKSa/mRTjlSLg4qo9Dw/knJqTQteSnuq6ybJbW6nhhJfU8vwfE
 2Ck588UWhSEz8OCe59m83ffm2ay50JCEbsil0UXPGkCC8xJ0rX3e61lfkirakZwJTCGj389k 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293788>

Hi Junio,

On Wed, 4 May 2016, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > diff --git a/builtin/init-db.c b/builtin/init-db.c
> > index b2d8d40..c4269ac 100644
> > --- a/builtin/init-db.c
> > +++ b/builtin/init-db.c
> > @@ -370,6 +370,7 @@ int init_db(const char *template_dir, unsigned int flags)
> >  	check_repository_format();
> >  
> >  	reinit = create_default_files(template_dir);
> > +	mark_as_git_dir(get_git_dir());
> >  
> >  	create_object_directory();
> >  
> 
> I agree with the goal of the change, but I am having a hard time
> justifying this addition.  Primarily because I do not understand the
> need for this.
> 
> In order to be prepared to handle HIDE_DOTFILES_TRUE case,
> mingw_mkdir() needs to be taught about needs_hiding() and
> make_hidden() already.  Why isn't it sufficient to teach
> needs_hiding() to check with !strcmp(basename(path, ".git"))
> under HIDE_DOTFILES_DOTGITONLY?

The reason was that I wanted to avoid to compare a name unnecessarily when
I already had a code path that knew perfectly well that a given directory
is the .git/ directory.

I made the change. It was more painful than I expected, as two bugs were
uncovered, both introduced after the original patch by Erik.

First bug: basename() on Windows used to not remove the trailing slashes.
Since we adjusted it, to conform with the POSIX specs, the implicit
mkdir() in copy_templates() could replace the trailing slash by a NUL,
breaking the template copying (it truncated pretty much all paths). I did
not catch this earlier because basename() was only called with
HIDE_DOTFILES_TRUE, and that case was never thoroughly tested.

So I had to reroll a non-modifying basename(). It's not elegant to have
this, but it is better than strdup()ing each and every path, just to
determine whether the basename starts with a dot (or is equal to ".git")
or not.

Second bug: when we switched to override open()/fopen()/freopen() using
Windows' UTF-16 functions, we lost the ability to open hidden files
(internally, _wopen() uses CreateFile(), which allows the equivalent of
O_CREAT only if the attributes match any existing files' attributes
*exactly*, and there is no way to tell _wopen() that we want to create a
hidden file).

Again, this was only exercised with HIDE_DOTFILES_TRUE until the change
proposed by you: needs_hiding() now also triggers for .git *files* in
HIDE_DOTFILES_DOTGITONLY mode.

It worries me slightly that the new code is so different from the code
that was tried and tested through all those years (although admittedly it
is unlikely anybody ever ran with core.hideDotFiles = true, given above
findings). But I guess that cannot be helped. Not unless we reintroduce
those two bugs.

> I do not understand why core.hideDotFiles needs to be explicitly
> copied to the config file in the resulting repository, either.
> 
> Once you created a repository, Git won't unhide the hidden .git of
> that reposiotry, so the idea must be to propagate the setting to a
> new repository that will further be created, but wouldn't that get
> the "please hide" preference from the same place as we have got the
> preference to hide .git when the current repository was created
> anyway?

I had a look in the mail archives, and it looks as if I wanted to support
`git clone -c core.hideDotFiles...`. I introduced a new regression test
and verified that we no longer need to write that config setting
explicitly.

I will send out v2 as soon as the test suite passed (which is hopefully
30-45 minutes from now).

Ciao,
Dscho
