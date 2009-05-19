From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit PATCH] Add a --tree flag to stg push
Date: Tue, 19 May 2009 09:25:12 +0200
Message-ID: <20090519072512.GA8451@diana.vm.bytemark.co.uk>
References: <20090518144754.30487.84132.stgit@krank>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: catalin.marinas@gmail.com, git@vger.kernel.org
To: David =?iso-8859-1?Q?K=E5gedal?= <davidk@lysator.liu.se>
X-From: git-owner@vger.kernel.org Tue May 19 09:25:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6JhY-0002nl-Am
	for gcvg-git-2@gmane.org; Tue, 19 May 2009 09:25:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753916AbZESHZU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 May 2009 03:25:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752892AbZESHZT
	(ORCPT <rfc822;git-outgoing>); Tue, 19 May 2009 03:25:19 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:38818 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752796AbZESHZS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2009 03:25:18 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1M6JhI-0002GX-00; Tue, 19 May 2009 08:25:12 +0100
Content-Disposition: inline
In-Reply-To: <20090518144754.30487.84132.stgit@krank>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119500>

On 2009-05-18 16:50:18 +0200, David K=E5gedal wrote:

> This scratches a long-time itch for me. The typical use case is when
> you want to break up a larg patch inte smaller ones. You back out
> the orignal patch, apply a small set of changes from it and then
> push the patch back again. But then you don't want to do a merge,
> with the possibility of conflict. You simply want to restore to the
> tree that the patch had before so you can see what's left to create
> cleaned-up patches of. The command "stg push --tree" does just that.

Thanks!

There's no sign-off.

> The naming of flags and functions isn't very obvious, and
> suggestions for improvements are welcome.

--set-tree maybe?

>  t/t1207-push-tree.sh     |   64 ++++++++++++++++++++++++++++++++++++=
++++++++++

A test! Very good.

> +    opt('--tree', action =3D 'store_true',
> +        short =3D 'Push the patch with the original tree')

This probably deserves a long description as well. (That most existing
options lack them is unfortunate---the support for long descriptions
was added rather recently.)

> +        if any(getattr(cd, a) !=3D getattr(orig_cd, a) for a in
> +               ['parent', 'tree', 'author', 'message']):
> +            comm =3D self.__stack.repository.commit(cd)
> +            self.head =3D comm
> +        else:
> +            comm =3D None
> +            s =3D ' (unmodified)'

Shouldn't self.head be set in both cases?

> +# Copyright (c) 2006 David K=E5gedal

Been sitting on this patch long? :-)

> +# don't need this repo, but better not drop it, see t1100
> +#rm -rf .git
> +
> +# Need a repo to clone
> +test_create_repo foo

Umm, your test doesn't seem to depend on using this separate repo
instead of the default one.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
