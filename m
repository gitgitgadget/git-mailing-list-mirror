From: Andrew Keller <andrew@kellerfarm.com>
Subject: Re: [PATCH/RFC] Documentation: Say that submodule clones use a separate gitdirs.
Date: Sun, 9 Mar 2014 19:24:04 -0400
Message-ID: <B2A4F350-1F20-4ABA-80A6-CF244DD7FAFD@kellerfarm.com>
References: <1394178834.7891.38.camel@Naugrim> <BEB30FB8-204C-4272-8F94-6210D96FB2CB@kellerfarm.com> <1394231714.7891.39.camel@Naugrim> <xmqqvbvpshqn.fsf@gitster.dls.corp.google.com> <1394239852.7891.40.camel@Naugrim>
Mime-Version: 1.0 (Apple Message framework v1085)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Henri GEIST <geist.henri@laposte.net>
X-From: git-owner@vger.kernel.org Mon Mar 10 00:24:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WMn4o-0007pV-Gw
	for gcvg-git-2@plane.gmane.org; Mon, 10 Mar 2014 00:24:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752051AbaCIXYJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Mar 2014 19:24:09 -0400
Received: from atl4mhob10.myregisteredsite.com ([209.17.115.48]:54809 "EHLO
	atl4mhob10.myregisteredsite.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751073AbaCIXYI convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 9 Mar 2014 19:24:08 -0400
Received: from mailpod.hostingplatform.com ([10.30.71.205])
	by atl4mhob10.myregisteredsite.com (8.14.4/8.14.4) with ESMTP id s29NO5sG026531
	for <git@vger.kernel.org>; Sun, 9 Mar 2014 19:24:05 -0400
Received: (qmail 22595 invoked by uid 0); 9 Mar 2014 23:24:05 -0000
X-TCPREMOTEIP: 23.28.12.255
X-Authenticated-UID: andrew@kellerfarm.com
Received: from unknown (HELO ?192.168.0.103?) (andrew@kellerfarm.com@23.28.12.255)
  by 0 with ESMTPA; 9 Mar 2014 23:24:05 -0000
In-Reply-To: <1394239852.7891.40.camel@Naugrim>
X-Mailer: Apple Mail (2.1085)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243702>

On Mar 7, 2014, at 7:50 PM, Henri GEIST wrote:
> Le vendredi 07 mars 2014 =E0 15:37 -0800, Junio C Hamano a =E9crit :
>> Henri GEIST <geist.henri@laposte.net> writes:
>>=20
>>> This information is technical in nature but has some importance for=
 general users.
>>> As this kind of clone have a separate gitdir, you will have a surpr=
ise if you
>>> copy past the worktree as the gitdir will not come together.
>>=20
>> I am not sure if I understand exactly what you are trying to say.
>> Are you saying that you had a submodule at "sub/dir" in your working
>> tree, and then "mkdir ../another && cp -R sub/dir ../another" did
>> not result in a usable Git working tree in ../another directory?
>>=20
>> It is almost like complaining that "mkdir ../newone && cp -R * ../ne=
wone/"
>> did not result in a usable git repository in ../newone directory and
>> honestly speaking, that sounds borderline insane, I'd have to say.
>>=20
>> Yes, if a user knows what she is doing, she should be able to make
>> something like that work, without running "git clone" (which is
>> probably the way most users would do it).  And yes, it would be good
>> to let the user learn from the documentation enough so that she
>> "knows what she is doing".  But no, I do not think end-user facing
>> documentation for "git-submodule" subcommand is the way to do that.
>>=20
>> That is why I suggested repository-layout as potentially a better
>> alternative location.
>>=20
>> But perhaps I am mis-reading your rationale.
>>=20
>>=20
>=20
> Let me rephrase my example :
>=20
> To give one of my project to someone else I have copied it on a USB k=
ey.
> By a simple drag and drop with the mouse.
> And I am quite sure I am not alone doing this way.
>=20
> I have done those kind of things lot of time without any problem.
> But that day 'the_project' happened to be a submodule cloned by
> 'git submodule update' then on the USB key the $GIT_DIR of 'the_proje=
ct'
> was missing.
>=20
> If 'man git-submodule' have made me aware of the particularities of s=
ubmodules
> clone I had write in a terminal:
>=20
> git clone the_project /media/usb/the_project
>=20
> Or at least I had understand what happened quicker.
>=20
> I have nothing against also adding something in repository-layout but=
 I am
> pretty sure normal users never read repository-layout as it is not a =
command
> they use. And it is not mentioned in most tutorials.

How about something like this:

"The git directory of a submodule lives inside the git directory of the=
 parent repository instead of within the working directory."

I'm not sure where to put it, though.

 - Andrew Keller
