From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [doc] User Manual Suggestion
Date: Sat, 2 May 2009 23:11:10 +0200
Message-ID: <20090502211110.GC6135@atjola.homenet>
References: <200904240051.46233.johan@herland.net> <b4087cc50904231730i1e8a005cpaf1921e23df11da6@mail.gmail.com> <200904242230.13239.johan@herland.net> <alpine.LNX.2.00.0904241655090.2147@iabervon.org> <20090424213848.GA14493@coredump.intra.peff.net> <b4087cc50904241518w625a9890vecdd36bb937e76d5@mail.gmail.com> <20090424231632.GB10155@atjola.homenet> <b4087cc50904241701jb78ce50m122fef475b0f1de7@mail.gmail.com> <20090502155348.GB6135@atjola.homenet> <b4087cc50905021136l5209777bs2209bab385deeef6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Daniel Barkalow <barkalow@iabervon.org>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	David Abrahams <dave@boostpro.com>,
	"J. Bruce Fields" <bfields@fieldses.org>
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 02 23:11:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M0MUW-0001Fq-Hm
	for gcvg-git-2@gmane.org; Sat, 02 May 2009 23:11:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756701AbZEBVLQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 2 May 2009 17:11:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755804AbZEBVLP
	(ORCPT <rfc822;git-outgoing>); Sat, 2 May 2009 17:11:15 -0400
Received: from mail.gmx.net ([213.165.64.20]:54914 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755613AbZEBVLO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 May 2009 17:11:14 -0400
Received: (qmail invoked by alias); 02 May 2009 21:11:12 -0000
Received: from i59F5A4EE.versanet.de (EHLO atjola.local) [89.245.164.238]
  by mail.gmx.net (mp004) with SMTP; 02 May 2009 23:11:12 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX185vHlfj7854ErvIrlCMOs6YqqINA+jEZMJhZMhqj
	5NnVoALzHMxpKR
Content-Disposition: inline
In-Reply-To: <b4087cc50905021136l5209777bs2209bab385deeef6@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.53
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118145>

On 2009.05.02 13:36:35 -0500, Michael Witten wrote:
> 2009/5/2 Bj=C3=B6rn Steinbrink <B.Steinbrink@gmx.de>:
> >> As I've stated: "address", "pointer", and "handle" are an analogy =
to
> >> terminology that has been around for ages. In fact, another name f=
or
> >> "pointer" is "reference".
> >
> > AFAIK a pointer is just one kind of reference. C++ references are
> > another kind...
>=20
> Actually, a C++ reference is a pointer with restrictions (AFAIK).

I'm not really aware of what the C++ standard says about it, but from a
usage point of view, they're IMHO different enough to consider them as
truly different types of references.

> > And there are probably plenty of examples where you could apply tha=
t
> > analogy, yet nobody (I know) does. Arrays, database tables, ...
>=20
> Well, this terminology is certainly used with arrays in C, because
> array elements can be accessed with pointers.

But when you apply the analogy, then the array is the memory, and an
integer is an address and an index variable is a pointer.

> Also, databases use a much different scheme for addressing informatio=
n
> than does memory.

I don't see any inherent problem in saying that the primary key
determines the address of a row. (It just gets funny when you have a
table schema without a primary key *g*)

> > And "memory" usually means "RAM" to me, not "WORM"-memory (well,
> > actually, you can also delete and then rewrite, but not modify).
>=20
> Well, I don't see how Random Access Memory really conflicts. One
> certainly can access objects in the object memory/store randomly. The
> main difference is that the computer store is addressed by location,
> wheras the git store is addressed by content.

When I have a (non const) pointer in C I can write to the memory
location it references. With git, I can't do that. ("RWRAM" would have
been more correct, I'm damaged by the common usage of RAM as meaning
RWRAM).

> Also, I would say that conceptually deletion is an implementation
> detail.

Yeah, thus I put it in parentheses, just to show that, in practise, we
don't even have WORM-memory (but still taking the hash collision proble=
m
into account, so we need to write once).

> Because git's object store is content addressable, one could
> think of it as already containing all possible objects (of course, I'=
m
> assuming that the 160-bit hash is also an implementation detail; an
> infinite number of objects implies infinitely large addresses, though
> the nonsignificant zeros could be disregarded as with real numbers or
> something. I don't know, I'm making this up as I go :-D). That the gi=
t
> tools ever complain no such object exists is an implementation detail
> resulting from our finite storage in reality.

I prefer to take the hash collision into account when looking at things
like that, but yeah, one could look at it like that.

> > So the analogy would even hurt my mental model (just like the
> > "commit --amend" command might be consider harmful, because it
> > actually creates a new commit, but some users actually think the
> > original commit is modified).
>=20
> Actually, this is why it's so important to have the underlying
> concepts at hand. Understanding that objects are simply addressed by
> content (that is, objects are immutable) completely extirpates this
> kind of confusion.

I never disagreed with that, though I put more emphasis on the plain
object relationships and their immutability than on the fact that hashe=
s
are used. Having that part right (how objects work together to form
history) is a large part of what you need to understand all the rest.

> >> >> So, a pointer variable's value is an object address that is the
> >> >> location of an object in git 'memory'. I think using this appro=
ach
> >> >> would make things significantly more transparent.
> >> >
> >> > But then HEAD would be a pointer pointer variable (symbolic ref)=
, unless
> >> > you have a detached HEAD.
> >>
> >> We call those handles.
> >
> > Isn't a handle basically an opaque/abstract reference, at least in
> > "modern" usage? Symvolic references aren't. The user is free to cre=
ate
> > and manipulate them, and gets full access to the things referenced =
by
> > them. And saying that HEAD is a reference, that might be symbolic i=
s
> > IMHO by far easier to understand than saying that HEAD might be a
> > pointer or a handle.
>=20
> Fair enough. Call them symbolic pointers; however, I don't really see
> the problem with pointer pointers.

You called them handles anyway ;-) But seriously, it's that "pointer"
triggers C for me. And having an entity that can switch between being a
pointer and a pointer pointer needs casting or a union (or a struct if
you want to), not something I'd like to have to think about in my menta=
l
model of git.

> In any case, I *think* my point is that it's important to understand
> that git uses content addressing; at first I was emphatic about the
> idea of 'addressing', so I went with pointer terminology (which works
> quite well, in my opinion). However, I think the 'content' part is
> more important, which is why 'object hash' is loads better than
> 'object name' or 'object id'. Also, at least the documentation could
> say that 'objects are addressed by their hashes', which says a whole
> lot in one quick sentence about how git works.

Hm, like chapter 7 "Git concepts"?

>>>>>>
The Object Database

We already saw in the section called =E2=80=9CUnderstanding History: Co=
mmits=E2=80=9D
that all commits are stored under a 40-digit "object name". In fact, al=
l
the information needed to represent the history of a project is stored
in objects with such names. In each case the name is calculated by
taking the SHA-1 hash of the contents of the object. The SHA-1 hash is =
a
cryptographic hash function. What that means to us is that it is
impossible to find two different objects with the same name. This has a
number of advantages; among others:

    * Git can quickly determine whether two objects are identical or
      not, just by comparing names.
    * Since object names are computed the same way in every repository,
      the same content stored in two repositories will always be stored
      under the same name.
    * Git can detect errors when it reads an object, by checking that
      the object's name is still the SHA-1 hash of its contents.
<<<<<<

Bj=C3=B6rn
