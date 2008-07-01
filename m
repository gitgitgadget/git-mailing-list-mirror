From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit PATCH 03/14] Write to a stack log when stack is modified
Date: Tue, 1 Jul 2008 22:13:55 +0200
Message-ID: <20080701201355.GA19096@diana.vm.bytemark.co.uk>
References: <20080612052913.23549.69687.stgit@yoghurt> <20080612053424.23549.64457.stgit@yoghurt> <b0943d9e0806170324j12605a55m41b582ad09925cce@mail.gmail.com> <20080617123138.GA6932@diana.vm.bytemark.co.uk> <b0943d9e0806170711w6da8e841p3ac83a59a81f6577@mail.gmail.com> <20080617153247.GA12520@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 01 22:15:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDmFl-0001WM-QQ
	for gcvg-git-2@gmane.org; Tue, 01 Jul 2008 22:15:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754517AbYGAUOH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Jul 2008 16:14:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755367AbYGAUOF
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Jul 2008 16:14:05 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3149 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754355AbYGAUOE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jul 2008 16:14:04 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1KDmEd-0004yP-00; Tue, 01 Jul 2008 21:13:55 +0100
Content-Disposition: inline
In-Reply-To: <20080617153247.GA12520@diana.vm.bytemark.co.uk>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87064>

On 2008-06-17 17:32:47 +0200, Karl Hasselstr=F6m wrote:

> On 2008-06-17 15:11:42 +0100, Catalin Marinas wrote:
>
> > 2008/6/17 Karl Hasselstr=F6m <kha@treskal.com>:
> >
> > > On 2008-06-17 11:24:53 +0100, Catalin Marinas wrote:
> > >
> > > > 2008/6/12 Karl Hasselstr=F6m <kha@treskal.com>:
> > > >
> > > > >  class _Directory(object):
> > > > > -    def __init__(self, needs_current_series =3D True):
> > > > > +    def __init__(self, needs_current_series =3D True, log =3D=
 True):
> > > >
> > > > i.e. we make log =3D False here by default.
> > >
> > > I might not have understood precisely what you meant; but I
> > > don't think API backwards compatibilty should be an issue here?
> > > I simply fix all callers. If log should default to true or false
> > > is immaterial -- it just means some extra text in one or the
> > > other of two equally common cases.
> >
> > Not an issue, I just favour the existing one when the two cases
> > are almost equal.
>
> Fair enough. I'll change it.

I had an even better idea: no default value. Every caller gets to say
either log =3D True or log =3D False, which makes it immediately obviou=
s
to the reader. (That is, every caller still using the old
infrastructure; with the new infrastructure, we log if and only if a
transaction is run.)

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
