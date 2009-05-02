From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [doc] User Manual Suggestion
Date: Sat, 2 May 2009 17:53:48 +0200
Message-ID: <20090502155348.GB6135@atjola.homenet>
References: <m24owgqy0j.fsf@boostpro.com> <200904240051.46233.johan@herland.net> <b4087cc50904231730i1e8a005cpaf1921e23df11da6@mail.gmail.com> <200904242230.13239.johan@herland.net> <alpine.LNX.2.00.0904241655090.2147@iabervon.org> <20090424213848.GA14493@coredump.intra.peff.net> <b4087cc50904241518w625a9890vecdd36bb937e76d5@mail.gmail.com> <20090424231632.GB10155@atjola.homenet> <b4087cc50904241701jb78ce50m122fef475b0f1de7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Daniel Barkalow <barkalow@iabervon.org>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	David Abrahams <dave@boostpro.com>,
	"J. Bruce Fields" <bfields@fieldses.org>
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 02 17:54:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M0HXv-0000yw-Iq
	for gcvg-git-2@gmane.org; Sat, 02 May 2009 17:54:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755364AbZEBPxz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 2 May 2009 11:53:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754590AbZEBPxz
	(ORCPT <rfc822;git-outgoing>); Sat, 2 May 2009 11:53:55 -0400
Received: from mail.gmx.net ([213.165.64.20]:45099 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754568AbZEBPxz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 May 2009 11:53:55 -0400
Received: (qmail invoked by alias); 02 May 2009 15:53:50 -0000
Received: from i59F56FEA.versanet.de (EHLO atjola.local) [89.245.111.234]
  by mail.gmx.net (mp062) with SMTP; 02 May 2009 17:53:50 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1+LOx5WRTCLV82LokHNtGLmubjR7ceYXhlcDOIDif
	O1ufray0xitmSW
Content-Disposition: inline
In-Reply-To: <b4087cc50904241701jb78ce50m122fef475b0f1de7@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.59
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118139>

On 2009.04.24 19:01:48 -0500, Michael Witten wrote:
> 2009/4/24 Bj=F6rn Steinbrink <B.Steinbrink@gmx.de>:
> >> In fact, I think it's important to note that the notation:
> >>
> >> =A0 =A0 git show master:Makefile
> >>
> >> actually involves a translation from a Unix filesystem address to =
a
> >> git object address that is then used to find the relevant data.
> >
> > Hm? Resolving master:Makefile means to first find what master is, m=
ost
> > likely the shortname for refs/heads/master. That usually references=
 a
> > commit object (by its name). The "<tree-ish>:<path>" syntax then ca=
uses
> > git to lookup the tree referenced by that commit (again, by its nam=
e).
> > And then the tree entry for "Makefile" is looked up, leading to the=
 name
> > for the object identified by "master:Makefile".
>=20
> Firstly, your head is too bound to low-level implementation.
>=20
> Secondly, you've basically just expounded upon what I said. The
> Makefile part is for humans to write using a filesystem path (address=
)
> that is mapped into what I call a git address. The point is that the
> user is interfacing between two theories of content storage.

Sorry, that part missed a few sentences I thought I had written. It was
meant to show where the term "reference" is used. I just walked along
your example, as that was right there, and I didn't have to come up wit=
h
something else ;-)

Of course there are two "parts", just like scp uses <host>:<path>.

> >> Rather than being hidden, it should be exposed: I think it would b=
e
> >> beneficial to use the word 'address' rather than 'reference' when
> >> talking about the SHA-1 names. Then HEAD could be called a pointer
> >> variable, etc.
> >
> > What's wrong with just calling the object name "object name"?
>=20
> What's wrong with calling the object address "object address"?

The term "object name" is already used in the docs, so you'll have to
prove that it's bad and needs to be replaced.

> As I've stated: "address", "pointer", and "handle" are an analogy to
> terminology that has been around for ages. In fact, another name for
> "pointer" is "reference".

AFAIK a pointer is just one kind of reference. C++ references are
another kind, file descriptors are yet another. A reference is one piec=
e
of data that lets me access a different piece of data.

And there are probably plenty of examples where you could apply that
analogy, yet nobody (I know) does. Arrays, database tables, ...

And "memory" usually means "RAM" to me, not "WORM"-memory (well,
actually, you can also delete and then rewrite, but not modify). So the
analogy would even hurt my mental model (just like the "commit --amend"
command might be consider harmful, because it actually creates a new
commit, but some users actually think the original commit is modified).

> >> So, a pointer variable's value is an object address that is the
> >> location of an object in git 'memory'. I think using this approach
> >> would make things significantly more transparent.
> >
> > But then HEAD would be a pointer pointer variable (symbolic ref), u=
nless
> > you have a detached HEAD.
>=20
> We call those handles.

Isn't a handle basically an opaque/abstract reference, at least in
"modern" usage? Symvolic references aren't. The user is free to create
and manipulate them, and gets full access to the things referenced by
them. And saying that HEAD is a reference, that might be symbolic is
IMHO by far easier to understand than saying that HEAD might be a
pointer or a handle.

Bj=F6rn
