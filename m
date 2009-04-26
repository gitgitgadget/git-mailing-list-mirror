From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [doc] User Manual Suggestion
Date: Sun, 26 Apr 2009 19:56:13 +0200
Message-ID: <20090426175613.GA4942@atjola.homenet>
References: <b4087cc50904241518w625a9890vecdd36bb937e76d5@mail.gmail.com> <b4087cc50904241525w7de597bfq7be89796947a14cc@mail.gmail.com> <alpine.LNX.2.00.0904241852500.2147@iabervon.org> <b4087cc50904241626h166c6b3bqa4ec714d4cb5662a@mail.gmail.com> <alpine.LNX.2.00.0904251445030.2147@iabervon.org> <b4087cc50904251216p617e347bmdc70e109298fa9b2@mail.gmail.com> <94a0d4530904251224g6b228448q276436f17f7e5cc3@mail.gmail.com> <E85677CA-FA7E-4777-97DF-9B295E89B83A@boostpro.com> <20090426112802.GC10155@atjola.homenet> <FA5C0FFA-2DCD-4DF1-9A94-C2A26A9DCAE9@boostpro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Michael Witten <mfwitten@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>, Johan Herland <johan@herland.net>,
	git@vger.kernel.org, "J. Bruce Fields" <bfields@fieldses.org>
To: David Abrahams <dave@boostpro.com>
X-From: git-owner@vger.kernel.org Mon Apr 27 11:38:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ly8cR-0001Hb-NQ
	for gcvg-git-2@gmane.org; Sun, 26 Apr 2009 19:58:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755767AbZDZR4a convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 26 Apr 2009 13:56:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755340AbZDZR43
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Apr 2009 13:56:29 -0400
Received: from mail.gmx.net ([213.165.64.20]:49481 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754618AbZDZR42 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Apr 2009 13:56:28 -0400
Received: (qmail invoked by alias); 26 Apr 2009 17:56:26 -0000
Received: from i59F5A916.versanet.de (EHLO atjola.local) [89.245.169.22]
  by mail.gmx.net (mp009) with SMTP; 26 Apr 2009 19:56:26 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1/RyqETMdTR2lh8aiVhnGpcTQvsed0rVtu4CUyQhZ
	3qaTk5aX4RYw+b
Content-Disposition: inline
In-Reply-To: <FA5C0FFA-2DCD-4DF1-9A94-C2A26A9DCAE9@boostpro.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117629>

On 2009.04.26 09:55:34 -0400, David Abrahams wrote:
>
> On Apr 26, 2009, at 7:28 AM, Bj=F6rn Steinbrink wrote:
>
>> On 2009.04.25 15:36:24 -0400, David Abrahams wrote:
>>> Where it's relevant when the user notices that two distinct files
>>> have the same id (because they happen to have the same contents) an=
d
>>> wonders what's up.
>>
>> Why would the user have to care about the object files in the repo?
>
> What a strange question. I have no idea how to answer. It seems
> self- evident to me that users of a VCS care that their files are
> stored in it.

_Their_ files. The files that come from/end up in the working tree. I
cared about those when I used SVN, too. But I never went to the SVN rep=
o
to find out if there are two equal files in it. We're talking about
object names, and those belong to objects, not files in the working
tree.

>> And why would your implementation save the same object twice, in two
>> distinct files?
>
> One could easily have the expectation that contents can be duplicated=
 =20
> because there are numerous precedents in everyone's experience of =20
> computing, for example in filesystems and in any programming language=
 =20
> that is not pure-functional.

That's not answering my question. I asked why you come up with an
implementation that is "broken" enough to save the same object twice
with different file names.  If the implementation does not do that, you=
r
"when the user notices that two distinct files has the same id" is
immediately invalid. The user cannot come into that situation then. And
anyway, when the user notices something, that's a discovery, not an
expectation.

>> The SHA-1 hash is created from the object, that means
>> the its type, size and data. It's not an id of a file in the working
>> tree, but of an object
>
> All true.  All somewhat subtle distinctions that are not nearly as =20
> apparent unless you actually use the word "hash" as I have been =20
> advocating.

Hu? How does saying "object hash" instead of "object id" make it any
more apparent that a file in the working tree is something else than a
git object?

>>> It's not a foregone conclusion that objects with the same value hav=
e
>>> identical ids, but it's immediately apparent if the id is known to =
=20
>>> be a
>>> hash.
>>
>> You can't have two objects with the same contents to begin with, sam=
e
>> content =3D> same object.
>
> In the Git world, I agree.  In general, I disagree.

I don't think were discussing a term to describe something that
identifies an object in general. So, "in general" you can disagree as
much as you want, but for git that doesn't matter at all.

> The fact that is so in the Git world is reinforced by the notion that
> the id of an object is a hash of its contents.
>
>> You can just have that one object stored multiple times in different
>> places (for sane implementations this  likely means that you have
>> more than one repo to look at, and each has its  own copy of that
>> object, but that's nothing you as an user should have to care about)=
=2E
>
>> It's an identity relation: same name/id =3D> same object. Unlike e.g=
=2E a
>> hash-table where you are expected to deal with collisions, and havin=
g
>> the same hash doesn't mean that you have identical data.  But that's
>> not true of git, it expects an identity relation, which is IMHO
>> better expressed through "object name" or "object id".
>
> Yes, that's true in the Git world (though not necessarily elsewhere),=
 or=20
> at least you hope it is.  In fact, there's no guarantee that SHA1 =20
> collisions won't occur; it's just exremely unlikely.  In fact, if you=
 =20
> google it you can find some interesting papers about SHA1 collision.

Sure, it's an assumption that has been made and is required to hold tru=
e
for git to work.

> Another way to express what you wrote above:
>
>    same same id =3D> same hash ?=3D> same contents =3D> same object
>
> where ?=3D> means "almost certainly implies."

No, that chain shows how git could be "unreliable" when you get hash
collisions. You could put that into a chapter that explains the
implications of the way git generates its object ids. But it's not very
interesting when you use git and (implicitly) trust the assumption that
no collisions happen.

=46or that case, you need a different chain:

same name/id =3D=3D> same object =3D=3D> same content

That's interesting when you e.g. want to "access" some object or when
you look at a tree that references the same object twice. For example
when both references are for file entries, you know that those files
have the same content. That it is a hash doesn't matter, the id could b=
e
anything that uniquely identifies an object. The "same object =3D=3D> s=
ame
content" part should be pretty obvious, so you only need to know that
the "same name/id =3D=3D> same object" part is true, i.e. that the obje=
ct
name/id uniquely identifies the object. And that _is_ true, simply
because you cannot have two objects in the same repo that have the same
hash and thus the same id. Even if you get a collision, you'll still
have just one object.  And that's not something that a term that
contains the word "hash" is telling me, it would instead tell me that i=
t
is not something that really uniquely identifies an object, although gi=
t
uses it as such.


Only when you want to explain how git manages to avoid duplicated
storage of fully identical contents, then you need to mention that the
object names are the hashes of the full object contents. But that's not
what you actually use the object names for.

same content =3D=3D> same content hash =3D=3D> object name/id =3D=3D> s=
ame object

(Actually, you need an additional detail: "same
file/symlink/directory/... contents =3D=3D> same object contents", whic=
h
can't be made explicit by just saying that you use a hash).

Your chain was in the wrong order and explains neither the "a tree that
has the same object name/id for two entries" case (because of the
uncertainity of the "same hash ?=3D> same content" part), nor, when rea=
d
in the other direction, where all implications are true, why same
content leads to the same object (as it already starts at the object
level).

>> You can still say that the name/id is generated by using a hash
>> function, but the important part is that the name/id is used to
>> _uniquely_ identify an object,  which isn't apparent when you call i=
t
>> a hash.
>
> I think the implication is important in both directions.  Neither one=
 is=20
> self-evident to a new user.  Maybe the right answer is 'hash id'.

git could work different. Just moving the storage of the filenames from
the tree objects to the blobs would mean that you'd get different
objects for files that have the same content but different names. You'd
still have a hash of the object contents as the object name, but
suddenly you get more objects. Just saying "hash" or "hash id" doesn't
magically explain all the other things.


Bj=F6rn
