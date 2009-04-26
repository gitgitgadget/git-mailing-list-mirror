From: David Abrahams <dave@boostpro.com>
Subject: Re: [doc] User Manual Suggestion
Date: Sun, 26 Apr 2009 09:55:34 -0400
Message-ID: <FA5C0FFA-2DCD-4DF1-9A94-C2A26A9DCAE9@boostpro.com>
References: <alpine.LNX.2.00.0904241655090.2147@iabervon.org> <20090424213848.GA14493@coredump.intra.peff.net> <b4087cc50904241518w625a9890vecdd36bb937e76d5@mail.gmail.com> <b4087cc50904241525w7de597bfq7be89796947a14cc@mail.gmail.com> <alpine.LNX.2.00.0904241852500.2147@iabervon.org> <b4087cc50904241626h166c6b3bqa4ec714d4cb5662a@mail.gmail.com> <alpine.LNX.2.00.0904251445030.2147@iabervon.org> <b4087cc50904251216p617e347bmdc70e109298fa9b2@mail.gmail.com> <94a0d4530904251224g6b228448q276436f17f7e5cc3@mail.gmail.com> <E85677CA-FA7E-4777-97DF-9B295E89B83A@boostpro.com> <20090426112802.GC10155@atjola.homenet>
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
X-From: git-owner@vger.kernel.org Mon Apr 27 12:19:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ly4r2-0001Q3-Vq
	for gcvg-git-2@gmane.org; Sun, 26 Apr 2009 15:57:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752713AbZDZNzh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 26 Apr 2009 09:55:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752673AbZDZNzh
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Apr 2009 09:55:37 -0400
Received: from boost-consulting.com ([206.71.190.141]:49347 "EHLO
	boost-consulting.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750900AbZDZNzh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Apr 2009 09:55:37 -0400
Received: from [192.168.188.150] (207-172-223-249.c3-0.smr-ubr3.sbo-smr.ma.static.cable.rcn.com [207.172.223.249])
	(Authenticated sender: dave)
	by boost-consulting.com (Postfix) with ESMTPSA id 87E321CC1E;
	Sun, 26 Apr 2009 06:53:01 -0700 (PDT)
In-Reply-To: <20090426112802.GC10155@atjola.homenet>
X-Mailer: Apple Mail (2.930.4)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117642>


On Apr 26, 2009, at 7:28 AM, Bj=F6rn Steinbrink wrote:

> On 2009.04.25 15:36:24 -0400, David Abrahams wrote:
>> Where it's relevant when the user notices that two distinct files =20
>> have
>> the same id (because they happen to have the same contents) and =20
>> wonders
>> what's up.
>
> Why would the user have to care about the object files in the repo?

What a strange question.  I have no idea how to answer.  It seems self-=
=20
evident to me that users of a VCS care that their files are stored in =20
it.

> And
> why would your implementation save the same object twice, in two
> distinct files?

One could easily have the expectation that contents can be duplicated =20
because there are numerous precedents in everyone's experience of =20
computing, for example in filesystems and in any programming language =20
that is not pure-functional.

> The SHA-1 hash is created from the object, that means
> the its type, size and data. It's not an id of a file in the working
> tree, but of an object

All true.  All somewhat subtle distinctions that are not nearly as =20
apparent unless you actually use the word "hash" as I have been =20
advocating.

>> It's not a foregone conclusion that objects with the same value have
>> identical ids, but it's immediately apparent if the id is known to =20
>> be a
>> hash.
>
> You can't have two objects with the same contents to begin with, same
> content =3D> same object.

In the Git world, I agree.  In general, I disagree.  The fact that is =20
so in the Git world is reinforced by the notion that the id of an =20
object is a hash of its contents.

> You can just have that one object stored
> multiple times in different places (for sane implementations this =20
> likely
> means that you have more than one repo to look at, and each has its =20
> own
> copy of that object, but that's nothing you as an user should have to
> care about).

> It's an identity relation: same name/id =3D> same object. Unlike e.g.=
 a
> hash-table where you are expected to deal with collisions, and having
> the same hash doesn't mean that you have identical data.  But that's =
=20
> not
> true of git, it expects an identity relation, which is IMHO better
> expressed through "object name" or "object id".

Yes, that's true in the Git world (though not necessarily elsewhere), =20
or at least you hope it is.  In fact, there's no guarantee that SHA1 =20
collisions won't occur; it's just exremely unlikely.  In fact, if you =20
google it you can find some interesting papers about SHA1 collision.

Another way to express what you wrote above:

    same same id =3D> same hash ?=3D> same contents =3D> same object

where ?=3D> means "almost certainly implies."  What you left out was th=
e =20
implication in the other direction, which is a true guarantee at all =20
steps, and "hash" is well-understood to mean

    same contents =3D> same hash

> You can still say that
> the name/id is generated by using a hash function, but the important
> part is that the name/id is used to _uniquely_ identify an object, =20
> which
> isn't apparent when you call it a hash.


I think the implication is important in both directions.  Neither one =20
is self-evident to a new user.  Maybe the right answer is 'hash id'.

--
David Abrahams
BoostPro Computing
http://boostpro.com
