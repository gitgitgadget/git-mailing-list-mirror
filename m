From: David Abrahams <dave@boostpro.com>
Subject: Re: [doc] User Manual Suggestion
Date: Mon, 27 Apr 2009 12:30:58 -0400
Message-ID: <33614929-B5B2-4B54-BF18-81ADBBCC4925@boostpro.com>
References: <alpine.LNX.2.00.0904241852500.2147@iabervon.org> <b4087cc50904241626h166c6b3bqa4ec714d4cb5662a@mail.gmail.com> <alpine.LNX.2.00.0904251445030.2147@iabervon.org> <b4087cc50904251216p617e347bmdc70e109298fa9b2@mail.gmail.com> <94a0d4530904251224g6b228448q276436f17f7e5cc3@mail.gmail.com> <E85677CA-FA7E-4777-97DF-9B295E89B83A@boostpro.com> <20090426112802.GC10155@atjola.homenet> <FA5C0FFA-2DCD-4DF1-9A94-C2A26A9DCAE9@boostpro.com> <20090426175613.GA4942@atjola.homenet> <F2B2D447-57B4-459C-8A0D-A94C12AE791C@boostpro.com> <20090426222532.GA12338@atjola.homenet>
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
X-From: git-owner@vger.kernel.org Mon Apr 27 18:31:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LyTjh-0004NN-QK
	for gcvg-git-2@gmane.org; Mon, 27 Apr 2009 18:31:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756018AbZD0QbF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Apr 2009 12:31:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751527AbZD0QbD
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Apr 2009 12:31:03 -0400
Received: from boost-consulting.com ([206.71.190.141]:62507 "EHLO
	boost-consulting.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754918AbZD0QbB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Apr 2009 12:31:01 -0400
Received: from [192.168.188.150] (207-172-223-249.c3-0.smr-ubr3.sbo-smr.ma.static.cable.rcn.com [207.172.223.249])
	(Authenticated sender: dave)
	by boost-consulting.com (Postfix) with ESMTPSA id A22DB1CC23;
	Mon, 27 Apr 2009 09:28:23 -0700 (PDT)
In-Reply-To: <20090426222532.GA12338@atjola.homenet>
X-Mailer: Apple Mail (2.930.4)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117688>


On Apr 26, 2009, at 6:25 PM, Bj=F6rn Steinbrink wrote:

> On 2009.04.26 16:17:43 -0400, David Abrahams wrote:
>>

>> I'm telling you, many new users who aren't already versed in Git wil=
l
>> naturally associate the SHA1 codes exposed by the interface with the
>> files they've checked in without understand that they actually
>> identify object files (another poorly chosen Git name, if I've manag=
e
>> to deduce what it means)
>
> Hm, not sure if that name is really important. The way objects are
> stored is an implementation detail. Usually, we're just talking about
> "objects" not the files the loose objects are stored in (loose =20
> object =3D
> an object stored in its own file, not in a pack file). But as you
> complained about it, how would you call a file in which an object is
> stored?

"Object" is OK. "Object file" is overloaded and confusing.  I'd just =20
say there are "Git data files" or "files in Git's object store", some =20
of which store single objects whose id is the same as the filename, =20
and some of which store multiple objects.

>> rather than directly corresponding to states
>> of their files. And anyway, if you want to get into implementation
>> details, SHA1s don't always identify object files because blobs get
>> delta-compressed.
>
> True, they identify the object, it's not even necessesary to mention
> delta compression, just having the object in a pack file causes the
> object name to no longer identify the file in which the object can be
> found.

Right.

> Heck, the object might be in a different repo when you use
> alternates ;-). And I think I never explicitly said that they
> identify a file storing an object, but implied that by "accepting" =20
> your
> example and assuming that you meant two object files having the same =
=20
> id.

Yes, that assumption was wrong, and then when you responded using the =20
term "object file" I didn't know what it meant.

> I should have said that your "two distinct files have the same id" =20
> makes
> no sense and should have asked what you mean.
>
>>>>> And why would your implementation save the same object twice, in
>>>>> two distinct files?
>>>>
>>>> One could easily have the expectation that contents can be
>>>> duplicated because there are numerous precedents in everyone's
>>>> experience of computing, for example in filesystems and in any
>>>> programming language that is not pure-functional.
>>>
>>> That's not answering my question. I asked why you come up with an
>>> implementation that is "broken" enough to save the same object twic=
e
>>> with different file names.
>>
>> I don't know what you mean by "come up with an implementation."  I'm
>> not inventing an implementation.
>
> Sorry, "come up with" is clearly wrong. "Assume" or "expect" or so =20
> might
> have been more correct.

I think I explained why one might make that assumption.

> But I think we could agree that you misused the
> "id" term by using it for files, and what ensued confused both of =20
> us? If
> you didn't mean the stored objects by "files", then that part of the
> discussion was just based on a misunderstanding and can be ignored.

I meant what the user thinks of as files stored in the repository.

>> I'm saying, new users inevitably and inexorably develop a mental =20
>> model
>> of the system they're learning about, and they don't always develop
>> the right mental model, and I'm saying that it's easy to see how the=
y
>> can fall into incorrect assumptions.  The word "hash" helps a bit =20
>> with
>> avoiding one of those assumptions.
>
> I've not met a lot of people that were actually confused about the =20
> fact
> that the same object might be "reused" for tree entries with differen=
t
> names. But most (all?) of those that were confused knew that the =20
> objects
> are identified by hashes, but expected the filenames to be part of th=
e
> object and didn't know about tree objects.

Well, there's certainly precedent for the idea that the filenames are =20
distinct from file contents.

>>> And anyway, when the user notices something, that's a discovery, no=
t
>>> an expectation.
>>
>> It's better to give people something to connect their discoveries to
>> (e.g. "oh, I see, they call those things hashes, so it makes sense
>> that these two identical things are stored once")
>
> We're talking about seeing, for example,  the same object name more =20
> than
> once, for different "files", in e.g. gitweb, right? Then the "Hu? =20
> Isn't
> the filename part of the object?" thing might still apply. The user =20
> can
> still very easily make a wrong guess.
>
> As Michael said in another mail, the important point is probably =20
> rather
> to teach people to make a distinction between files and directories i=
n
> the working tree and the contents stored in the git objects. And =20
> that's
> not accomplished by saying that the id is a hash, when the user =20
> doesn't
> know what the hash is based upon.
>
> Somewhat related: I'm trying to remember if I ever had problems
> explaining the concept of hardlinks to someone, but I don't remember =
=20
> any
> such situation anymore. There are no hashes involved there, and I fee=
l
> like that was quite easy to grasp for most people I talked to. It's
> pretty similar, separating content from names.

The difference is that hardlinks are only generated explicitly.  You'd =
=20
need something like a hash to generate them automatically and =20
implicitly.

>>>>> You can't have two objects with the same contents to begin with,
>>>>> same content =3D> same object.
>>>>
>>>> In the Git world, I agree.  In general, I disagree.
>>>
>>> I don't think were discussing a term to describe something that
>>> identifies an object in general. So, "in general" you can disagree =
=20
>>> as
>>> much as you want, but for git that doesn't matter at all.
>>
>> You don't think the general rules of the computing world and existin=
g
>> meanings of terms have an impact on a new user's ability to grok Git=
?
>> If not, we don't have much to discuss.
>
> This was probably also based on the files+id misunderstanding combine=
d
> with the fact that you used the term "object" where I thought that yo=
u
> meant a "git object" (you probably didn't, right?).

I didn't.  I meant the general notion of "object" in computing.  I'm =20
trying to talk about how the language used by Git's docs can bias =20
people toward correct or incorrect understandings of Git as they're =20
learning.

> Because when talking
> about "git objects" you actually can't have two different ones with =20
> the
> same "value" (I guess you mean type, size and content when you say
> "value", right?)

Yes.  Size is a function of content, so that adds nothing, and whether =
=20
it even makes sense to say that two things of different type have =20
identical content is debatable.

> And admittedly, for this one, the "hash" term _would_ help to get the
> user to understand that in git you cannot have two different objects
> with the same contents and that this makes git different and =20
> efficient.
> But I still don't buy that this is important for understanding the =20
> basic
> data model. It's a nice hint why git can always quickly tell that two
> things are equal and why the repository size doesn't explode. But the
> important part is the separation of names and content, that trees giv=
e
> names to the contents stored in blobs.

But there's nothing unique about that; it's not distinct from what =20
filesystems do.

> The "hash" name would only help
> to understand its efficiency once you already understood the data =20
> model.

It would help to reinforce that an object's id is a function of its =20
contents.  It would help to make clear why the same object can be =20
identified in the same way across all repos.

>>>> Another way to express what you wrote above:
>>>>
>>>>  same same id =3D> same hash ?=3D> same contents =3D> same object
>>>>
>>>> where ?=3D> means "almost certainly implies."
>>>
>>> No, that chain shows how git could be "unreliable" when you get has=
h
>>> collisions. You could put that into a chapter that explains the
>>> implications of the way git generates its object ids. But it's not
>>> very interesting when you use git and (implicitly) trust the
>>> assumption  that no collisions happen.
>>
>> My point in mentioning that it's not certain was to point out that =20
>> you
>> left out the implication that actually /is/ certain, even across
>> repos.
>
> And my point is that this is not important for understanding the basi=
c
> data model, but only how git efficiently implements it, and which
> assumptions it has to make.

Look, you're talking to someone who has just had to go through the =20
process of learning all this stuff.  What I'm telling you is based on =20
my experiences.  Just one datapoint, to be sure, but knowing that it's =
=20
a hash was crucial for me.

>> If you think there's a right order, you haven't understood that all
>> the arrows are bidirectional.
>
> There's one that is not truly bidirectional.
>
> id <=3D> hash <?=3D> contents <=3D> object
>
> I can't go from id/hash to contents/object without hitting the "hash =
=20
> =3D>
> content" assumption.

Quite right.  You can't derive contents from the hash.

>> But that's a strawman.  I'm not claiming that it magically explains
>> all the other things.  I'm just claiming that it helps in avoiding
>> some possible misunderstandings.
>
> And I think that it doesn't help much at all and might confuse users,
> because they expect the hash to be based on the wrong stuff. It's jus=
t
> important that the "thing" is used to identify an object.


OK, I give up.  *I* now understand the system, and it's starting to =20
look like too much of a struggle to improve things for others, so they =
=20
can fend for themselves I guess.

Thanks for the lively discussion, anyway.

--
David Abrahams
BoostPro Computing
http://boostpro.com
