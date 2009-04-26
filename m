From: David Abrahams <dave@boostpro.com>
Subject: Re: [doc] User Manual Suggestion
Date: Sun, 26 Apr 2009 16:17:43 -0400
Message-ID: <F2B2D447-57B4-459C-8A0D-A94C12AE791C@boostpro.com>
References: <b4087cc50904241518w625a9890vecdd36bb937e76d5@mail.gmail.com> <b4087cc50904241525w7de597bfq7be89796947a14cc@mail.gmail.com> <alpine.LNX.2.00.0904241852500.2147@iabervon.org> <b4087cc50904241626h166c6b3bqa4ec714d4cb5662a@mail.gmail.com> <alpine.LNX.2.00.0904251445030.2147@iabervon.org> <b4087cc50904251216p617e347bmdc70e109298fa9b2@mail.gmail.com> <94a0d4530904251224g6b228448q276436f17f7e5cc3@mail.gmail.com> <E85677CA-FA7E-4777-97DF-9B295E89B83A@boostpro.com> <20090426112802.GC10155@atjola.homenet> <FA5C0FFA-2DCD-4DF1-9A94-C2A26A9DCAE9@boostpro.com> <20090426175613.GA4942@atjola.homenet>
Mime-Version: 1.0 (Apple Message framework v930.4)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Michael Witten <mfwitten@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>, Johan Herland <johan@herland.net>,
	git@vger.kernel.org, "J. Bruce Fields" <bfields@fieldses.org>
To: =?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Mon Apr 27 11:07:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LyAou-000631-Od
	for gcvg-git-2@gmane.org; Sun, 26 Apr 2009 22:19:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755600AbZDZURr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 26 Apr 2009 16:17:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755293AbZDZURr
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Apr 2009 16:17:47 -0400
Received: from boost-consulting.com ([206.71.190.141]:61312 "EHLO
	boost-consulting.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753585AbZDZURq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Apr 2009 16:17:46 -0400
Received: from [192.168.188.150] (207-172-223-249.c3-0.smr-ubr3.sbo-smr.ma.static.cable.rcn.com [207.172.223.249])
	(Authenticated sender: dave)
	by boost-consulting.com (Postfix) with ESMTPSA id A73A81CC24;
	Sun, 26 Apr 2009 13:15:10 -0700 (PDT)
In-Reply-To: <20090426175613.GA4942@atjola.homenet>
X-Mailer: Apple Mail (2.930.4)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117617>


On Apr 26, 2009, at 1:56 PM, Bj=F6rn Steinbrink wrote:

> On 2009.04.26 09:55:34 -0400, David Abrahams wrote:
>>
>> On Apr 26, 2009, at 7:28 AM, Bj=F6rn Steinbrink wrote:
>>
>>> On 2009.04.25 15:36:24 -0400, David Abrahams wrote:
>>>> Where it's relevant when the user notices that two distinct files
>>>> have the same id (because they happen to have the same contents) =20
>>>> and
>>>> wonders what's up.
>>>
>>> Why would the user have to care about the object files in the repo?
>>
>> What a strange question. I have no idea how to answer. It seems
>> self- evident to me that users of a VCS care that their files are
>> stored in it.
>
> _Their_ files. The files that come from/end up in the working tree. I
> cared about those when I used SVN, too. But I never went to the SVN =20
> repo
> to find out if there are two equal files in it. We're talking about
> object names, and those belong to objects, not files in the working
> tree.

I'm telling you, many new users who aren't already versed in Git will =20
naturally associate the SHA1 codes exposed by the interface with the =20
files they've checked in without understand that they actually =20
identify object files (another poorly chosen Git name, if I've manage =20
to deduce what it means) rather than directly corresponding to states =20
of their files. And anyway, if you want to get into implementation =20
details, SHA1s don't always identify object files because blobs get =20
delta-compressed.

>>> And why would your implementation save the same object twice, in tw=
o
>>> distinct files?
>>
>> One could easily have the expectation that contents can be duplicate=
d
>> because there are numerous precedents in everyone's experience of
>> computing, for example in filesystems and in any programming languag=
e
>> that is not pure-functional.
>
> That's not answering my question. I asked why you come up with an
> implementation that is "broken" enough to save the same object twice
> with different file names.

I don't know what you mean by "come up with an implementation."  I'm =20
not inventing an implementation.  I'm saying, new users inevitably and =
=20
inexorably develop a mental model of the system they're learning =20
about, and they don't always develop the right mental model, and I'm =20
saying that it's easy to see how they can fall into incorrect =20
assumptions.  The word "hash" helps a bit with avoiding one of those =20
assumptions.

> If the implementation does not do that, your
> "when the user notices that two distinct files has the same id" is
> immediately invalid. The user cannot come into that situation then.

I think this is why Git remains more opaque than it should be.  You =20
can't assume that people will naturally develop the smartest possible =20
mental model of a VCS, even with faced with some hints in the form of =20
a partial understanding of Git.

> And
> anyway, when the user notices something, that's a discovery, not an
> expectation.

It's better to give people something to connect their discoveries to =20
(e.g. "oh, I see, they call those things hashes, so it makes sense =20
that these two identical things are stored once")

>>> The SHA-1 hash is created from the object, that means
>>> the its type, size and data. It's not an id of a file in the workin=
g
>>> tree, but of an object
>>
>> All true.  All somewhat subtle distinctions that are not nearly as
>> apparent unless you actually use the word "hash" as I have been
>> advocating.
>
> Hu? How does saying "object hash" instead of "object id" make it any
> more apparent that a file in the working tree is something else than =
a
> git object?

It makes it apparent that two identical things can only have one ID, =20
and thus must correspond to one object.

>>> You can't have two objects with the same contents to begin with, =20
>>> same
>>> content =3D> same object.
>>
>> In the Git world, I agree.  In general, I disagree.
>
> I don't think were discussing a term to describe something that
> identifies an object in general. So, "in general" you can disagree as
> much as you want, but for git that doesn't matter at all.

You don't think the general rules of the computing world and existing =20
meanings of terms have an impact on a new user's ability to grok Git?  =
=20
If not, we don't have much to discuss.

>> The fact that is so in the Git world is reinforced by the notion tha=
t
>> the id of an object is a hash of its contents.
>>
>>> You can just have that one object stored multiple times in differen=
t
>>> places (for sane implementations this  likely means that you have
>>> more than one repo to look at, and each has its  own copy of that
>>> object, but that's nothing you as an user should have to care =20
>>> about).
>>
>>> It's an identity relation: same name/id =3D> same object. Unlike =20
>>> e.g. a
>>> hash-table where you are expected to deal with collisions, and =20
>>> having
>>> the same hash doesn't mean that you have identical data.  But that'=
s
>>> not true of git, it expects an identity relation, which is IMHO
>>> better expressed through "object name" or "object id".
>>
>> Yes, that's true in the Git world (though not necessarily =20
>> elsewhere), or
>> at least you hope it is.  In fact, there's no guarantee that SHA1
>> collisions won't occur; it's just exremely unlikely.  In fact, if yo=
u
>> google it you can find some interesting papers about SHA1 collision.
>
> Sure, it's an assumption that has been made and is required to hold =20
> true
> for git to work.
>
>> Another way to express what you wrote above:
>>
>>   same same id =3D> same hash ?=3D> same contents =3D> same object
>>
>> where ?=3D> means "almost certainly implies."
>
> No, that chain shows how git could be "unreliable" when you get hash
> collisions. You could put that into a chapter that explains the
> implications of the way git generates its object ids. But it's not =20
> very
> interesting when you use git and (implicitly) trust the assumption =20
> that
> no collisions happen.

My point in mentioning that it's not certain was to point out that you =
=20
left out the implication that actually /is/ certain, even across repos.

> Only when you want to explain how git manages to avoid duplicated
> storage of fully identical contents, then you need to mention that th=
e
> object names are the hashes of the full object contents. But that's =20
> not
> what you actually use the object names for.
>
> same content =3D=3D> same content hash =3D=3D> object name/id =3D=3D>=
 same object
>
> (Actually, you need an additional detail: "same
> file/symlink/directory/... contents =3D=3D> same object contents", wh=
ich
> can't be made explicit by just saying that you use a hash).
>
> Your chain was in the wrong order

If you think there's a right order, you haven't understood that all =20
the arrows are bidirectional.

> and explains neither the "a tree that
> has the same object name/id for two entries" case (because of the
> uncertainity of the "same hash ?=3D> same content" part), nor, when r=
ead
> in the other direction, where all implications are true, why same
> content leads to the same object (as it already starts at the object
> level).

>> I think the implication is important in both directions.  Neither =20
>> one is
>> self-evident to a new user.  Maybe the right answer is 'hash id'.
>
> git could work different. Just moving the storage of the filenames =20
> from
> the tree objects to the blobs would mean that you'd get different
> objects for files that have the same content but different names. =20
> You'd
> still have a hash of the object contents as the object name, but
> suddenly you get more objects. Just saying "hash" or "hash id" doesn'=
t
> magically explain all the other things.


But that's a strawman.  I'm not claiming that it magically explains =20
all the other things.  I'm just claiming that it helps in avoiding =20
some possible misunderstandings.

--
David Abrahams
BoostPro Computing
http://boostpro.com
