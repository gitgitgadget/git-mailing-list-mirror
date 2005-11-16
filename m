From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: stgit truncates binary files to zero length when applying patches
Date: Wed, 16 Nov 2005 12:54:49 +0100
Message-ID: <20051116115449.GA5933@diana.vm.bytemark.co.uk>
References: <20051115144223.GA18111@diana.vm.bytemark.co.uk> <b0943d9e0511160311k725526d8v@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 16 12:56:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcLsc-0004nI-Mh
	for gcvg-git@gmane.org; Wed, 16 Nov 2005 12:55:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030266AbVKPLyz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 16 Nov 2005 06:54:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030281AbVKPLyz
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Nov 2005 06:54:55 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2564 "EHLO
	diana.vm.bytemark.co.uk") by vger.kernel.org with ESMTP
	id S1030266AbVKPLyy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Nov 2005 06:54:54 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1EcLsH-0001aI-00; Wed, 16 Nov 2005 11:54:49 +0000
To: Catalin Marinas <catalin.marinas@gmail.com>
Content-Disposition: inline
In-Reply-To: <b0943d9e0511160311k725526d8v@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12021>

On 2005-11-16 11:11:56 +0000, Catalin Marinas wrote:

> On 15/11/05, Karl Hasselstr=F6m <kha@treskal.com> wrote:
>
> > When applying patches and not fast-forwarding, stgit truncates the
> > binary files to zero length:
>
> I've never tried binaries with StGIT before.

I don't blame you. Binary patches aren't something I normally create
either. It's just that I find stgit patches a good way to logically
structure a largeish change that I'm working on before committing it.
(I could probably accoplish the same thing with one branch instead of
each stgit patch, but then it would be quite a lot of work to manually
push updates through all the branches.)

> When pushing a patch, if a merge is needed (like in your case, the
> base of the foo patch has changed), StGIT first tries "git-diff-tree
> | git-apply" for speed reasons. If this fails, it falls back to a
> three-way merge.
>
> Unfortunately, git-apply doesn't fail for patches including binary
> files and simply creates an empty file. I think git-apply should be
> changed to fail to apply this kind of patches.

Yes, at least if stgit is going to continue to use it like this.
Refusing to handle binary files is somewhat disappointing, but still
OK; agreeing to handle them and then silently wiping them is a bit
less OK. (But don't worry; it is a perfect world, after all, so of
course I had backups. :-)

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
