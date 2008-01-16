From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Wed, 16 Jan 2008 22:51:53 +0100
Message-ID: <200801162251.54219.jnareb@gmail.com>
References: <478E1FED.5010801@web.de> <m33asxn2gt.fsf@roke.D-201> <65026F2B-5CE8-4238-A9AB-D3545D336B41@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mark Junker <mjscod@web.de>, git@vger.kernel.org
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Wed Jan 16 22:53:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFGBZ-0005gq-HF
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 22:52:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751053AbYAPVwG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Jan 2008 16:52:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750994AbYAPVwF
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 16:52:05 -0500
Received: from fg-out-1718.google.com ([72.14.220.154]:14107 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750986AbYAPVwC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2008 16:52:02 -0500
Received: by fg-out-1718.google.com with SMTP id e21so422805fga.17
        for <git@vger.kernel.org>; Wed, 16 Jan 2008 13:52:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=hpauO6cRE6qZOODu91+08TGlByr8Q5v5CooHnW1l+sY=;
        b=J6yB24zhxzedC8OWPE/Vpn2Ev+Key4EGC3oTIy6qF3VBevuUrmHiYidxLi4OcCtAWFalp2kuXeZiREvxwe3zUrfNP3LVVa4URbflqugPjl0ymEcabbGEQRdVqJ/aolp3NOs7ReUrGzwLP4goFeADebKUAhmNK5ZHV+R9TB3xWLE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=K8r7HrzIxJb4qo0tRRL9ZlNX13TXnj1OWWFbY//tfDT/PdqhDxx6lsfczZiY2Wrd8CemjwrIP1QZbAz75uUqJtB0To8C99NmltHsMp9xRTJQapxTfA1mFgJktaFFz6VUfrSutLb/e+9dm4fVxGab4nmlHkPyYOnKPNS3VrdiLlA=
Received: by 10.82.152.16 with SMTP id z16mr2329446bud.17.1200520320875;
        Wed, 16 Jan 2008 13:52:00 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.213.34])
        by mx.google.com with ESMTPS id h6sm1876191nfh.30.2008.01.16.13.51.57
        (version=SSLv3 cipher=OTHER);
        Wed, 16 Jan 2008 13:51:59 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <65026F2B-5CE8-4238-A9AB-D3545D336B41@sb.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70750>

On Wed, 16 Jan 2008, Kevin Ballard wrote:
> On Jan 16, 2008, at 11:46 AM, Jakub Narebski wrote:
>>>> More like, Mac OS X has standardized on Unicode and the rest of th=
e
>>>> world hasn't caught up yet. Git is the only tool I've ever heard =20
>>>> which has a problem with OS X using Unicode.
>>>
>>> No.  That's not at all the problem.  Mac OS X insists on storing =20
>>> _another_  encoding of your filename.  Both are UTF-8.  Both encode
>>> the _same_ string.  Yet they are different, bytewise.  For no good
>>> reason.=20
>>
>> To be more exact encoding used to _create_ file differs from encodin=
g
>> returned when _reading directory_...
>>
>>> Stop spreading FUD.  Git can handle Unicode just fine.  In fact, =20
>>> Git does not _care_ how the filename is encoded, it _respects_ the
>>> user's choice, not only of the encoding _type_, but the _encoding_,
>>> too.=20
>>
>> ...which means that sequence of bytes differ. And Git by design is
>> (both for filenames and for blob contents) encoding agnostic.
>>
>> HFS+ is just _stupid_. And unfortunately Git doesn't support stupid
>> filesystems (e.g. case insensitive filesystems) well.

By the way, calling HFS+ stupid, or rather calling at least two=20
different normalizations of UTF-8 (two different encodings) used for=20
writing and reading filenames stupid is wrong _for me_. I have quoted=20
Linus here, when I think I should use other description.
=20
> There's two different ways to do filesystem encodings. One is to have=
 =20
> the fs simply not care about encoding, which is what the linux world =
=20
> seems to prefer. Sure, this is great in that what you create the file=
 =20
> with is what you get back, but on the other hand, given an arbitrary =
=20
> non-ASCII file on disk, you have absolutely no idea what the encoding=
 =20
> should be and you can't display it without making assumptions (yes yo=
u =20
> can use heuristics, but you're still making assumptions). Filesystems=
 =20
> like HFS+ that standardize the encoding, on the other hand, make it =20
> such that you always know what the encoding of a file should be, so =20
> you can always display and use the filename intelligently. It also =20
> means it plays much nicer in a non-ASCII world, since you don't have =
=20
> to worry about different normalizations of a given string referring t=
o =20
> different files (it's one thing to be case-sensitive, but claiming =20
> that "f=F6o" and "f=F6o" are different files just because one uses a =
=20
> composed character and the other doesn't is extremely user-=20
> unfriendly).

=46or me it looks like a layering violation... but my knowledge about=20
filesystem is cluse to nil. IMHO it is VFS and libc which should do the=
=20
translating.

> On the other hand, what you create the file with may not  =20
> be what you read back later, since the name has been standardized. =20
> It's hard to say one is better than the other, they're just different=
 =20
> ways of doing it.

But using one encoding to create file, and another when reding filename=
s=20
is strange. It is IMHO better to simply refuse creating filenames which=
=20
are outside chosen encoding / normalization. But having different=20
encodings used for reading and writing on the level of filesystem=20
access (not on level of UI) is strange.

> However, I have noticed that everybody who's voiced  =20
> an opinion on this list in favor of the encoding-agnostic approach =20
> seem to be unwilling to accept that any other approach might have =20
> validity, to the extent of calling an OS/filesystem that does things =
=20
> different stupid or insane. This strikes me as extremely elitist and =
=20
> risks alienating what I expect to be a fast-growing group of users =20
> (i.e. OS X users).

=46irst, it is Git philosophy and very core of design to be encoding=20
agnostic (to be "content tracker"). Second, using the same sequence of=20
bytes on filesystem, in the index, and in 'tree' objects ensures good=20
performance... this is something to think about if you want to add=20
patches which would deal with HFS+ API/UI quirks.

[cut]
--=20
Jakub Narebski
Poland
