From: David Kastrup <dak@gnu.org>
Subject: Re: Stupid quoting...
Date: Thu, 14 Jun 2007 08:12:16 +0200
Message-ID: <86wsy76p4v.fsf@lola.quinscape.zz>
References: <86ir9sw0pi.fsf@lola.quinscape.zz> <Pine.LNX.4.64.0706131316390.4059@racer.site> <86ejkgvxmb.fsf@lola.quinscape.zz> <Pine.LNX.4.64.0706140145450.4059@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 14 08:12:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyiZc-0003Pc-FI
	for gcvg-git@gmane.org; Thu, 14 Jun 2007 08:12:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751635AbXFNGMr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 14 Jun 2007 02:12:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751477AbXFNGMr
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jun 2007 02:12:47 -0400
Received: from main.gmane.org ([80.91.229.2]:46187 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751360AbXFNGMq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jun 2007 02:12:46 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HyiZM-0000GP-1n
	for git@vger.kernel.org; Thu, 14 Jun 2007 08:12:32 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 14 Jun 2007 08:12:32 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 14 Jun 2007 08:12:32 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.51 (gnu/linux)
Cancel-Lock: sha1:a6BAx6JsQx5QnUM0ZQkyN/ep+gw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50169>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> [somehow I got the impression your mail did not make it to the list]
>
> On Wed, 13 Jun 2007, David Kastrup wrote:
>
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>>=20
>> > On Wed, 13 Jun 2007, David Kastrup wrote:
>> >
>> >> what is the point in quoting file names and their characters in
>> >> git-diff's output?  And what is the recommended way of undoing th=
e
>> >> damage?
>> >
>> > The recommended way is not using spaces to begin with.
>>=20
>> Who is talking about spaces?
>
> That is the common reason for quoting. I mean, really, how many files=
 do=20
> you have which contain newlines or backslashes or tabs? Huh?

I am talking about non-ASCII characters.

>
>> > I mean, does "David" contain spaces?
>>=20
>> "G=FCnter" contains non-ASCII characters.
>
> And "Guenther" (sorry, have problems with my mailer, so I simulate
> it in plain ASCII" does not need quotes, _even_ if containing
> non-ASCII characters.
>
> So what exactly was your point again?

You _are_ aware that git writes out \303\274 (8 characters: 2
backslashes and 6 digits) instead of =FC in a file name?  And I am
talking about a pure utf-8 locale.

LANG=3Den_US.UTF-8
LC_CTYPE=3D"en_US.UTF-8"
LC_NUMERIC=3D"en_US.UTF-8"
LC_TIME=3D"en_US.UTF-8"
LC_COLLATE=3D"en_US.UTF-8"
LC_MONETARY=3D"en_US.UTF-8"
LC_MESSAGES=3D"en_US.UTF-8"
LC_PAPER=3D"en_US.UTF-8"
LC_NAME=3D"en_US.UTF-8"
LC_ADDRESS=3D"en_US.UTF-8"
LC_TELEPHONE=3D"en_US.UTF-8"
LC_MEASUREMENT=3D"en_US.UTF-8"
LC_IDENTIFICATION=3D"en_US.UTF-8"
LC_ALL=3D

My point was that these octal escape sequences are utterly pointless.

>> > People seem not to see the problem, and fail to blame Microsoft fo=
r=20
>> > all the damage they have done, introducing that stupid, stupid con=
cept=20
>> > of filenames containing spaces, and _enforcing_ it.
>>=20
>> The concept of UNIX file names is _any_ byte sequence not
>> containing "/" or an ASCII NUL.  Microsoft actually prohibits quite
>> a few more characters.  Filenames with spaces first came into
>> serious use under MacOS, the first graphical user interface where
>> no shell and metacharacters interfered with the choice of file
>> names.
>>=20
>> Blaming Microsoft here is completely ridiculous.
>
> It is completely unridiculous. Before Microsoft -- in its infinite
> wisdom -- decided to create folders like "Program Files", and
> "Documents and Settings", and made it the _default_ (of all things)
> to save its ridiculous Word documents as "New Document", _nobody_ on
> this planet even _thought_ about including stupid whitespace in a
> filename.
>
> You can tell that this is true by looking at now-ancient Unix
> scripts.

You are making a spectacle of yourself.  Do you even read what you are
replying to?  When spaces became commonplace in _MacOS_, _MacOS_ was
by no means Unix-based.  Microsoft only followed the trend (with a
delay of several years, by the way) when imitating the MacOS GUI.

>> >> I have something like
>> >>=20
>> >> git-diff -M -C --name-status -r master^ master | {
>> >>     while read -r flag name
>> >>     do
>> >> 	case "$name" in *\\[0-3][0-7][0-7]*)
>> >> 		name=3D$(echo -e $(echo "$name"|sed 's/\\\([0-3][0-7][0-7]\)/\\=
0\1/g;s/\\\([^0]\)/\\\\\1/g'))
>> >> 	esac
>> >>         [...]
>> >>=20
>> >> in order to get through the worst with utf-8 file names, and it i=
s a
>> >> complete nuisance (double quotemarks are treated later).
>> >
>> > Please understand that the quotes are not there for you, but for=20
>> > processing by other programs.
>> >
>> > However, I _suspect_ that you want to do something like
>> >
>> > 	name=3D"$(echo $name)"
>> >
>> > because "echo" is exactly one of the programs this quoting was inv=
ented=20
>> > for.
>>=20
>> Only that it does not work with echo.  echo requires \0NNN for
>> octal escapes, not \NNN, and then only when "echo -e" is used.
>
> Um. How does that apply here? Git only does quoting so that programs
> like echo get it right, when passed the name? No funny \0NNN or \NNN
> or whatever?

git puts out funny \NNN quotes.  That's what I am complaining about.

>> You are really haphazard in distributing your blame.
>>=20
>> Can you actually name a program that would work with the default
>> output of git here?
>
> echo.

It doesn't, since it does not interpret the \NNN escape sequences that
git chooses to output.

--=20
David Kastrup
