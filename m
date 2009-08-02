From: demerphq <demerphq@gmail.com>
Subject: Re: [PATCHv5] Add Gitweb support for XZ compressed snapshots
Date: Mon, 3 Aug 2009 01:55:37 +0200
Message-ID: <9b18b3110908021655r18203816u2864ffb95aabb354@mail.gmail.com>
References: <B05AF655-7430-420A-A22E-389601558B0D@uwaterloo.ca>
	 <m3vdl7rjev.fsf@localhost.localdomain>
	 <9b18b3110908010313x38991dffx3e4a2f2a5c5fff9f@mail.gmail.com>
	 <200908030125.53534.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "J.H." <warthog19@eaglescrag.net>,
	Mark A Rada <marada@uwaterloo.ca>, git@vger.kernel.org,
	Petr Baudis <pasky@suse.cz>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 03 01:55:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MXku4-0003hH-MJ
	for gcvg-git-2@gmane.org; Mon, 03 Aug 2009 01:55:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754030AbZHBXzk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 2 Aug 2009 19:55:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754027AbZHBXzj
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Aug 2009 19:55:39 -0400
Received: from mail-gx0-f213.google.com ([209.85.217.213]:41252 "EHLO
	mail-gx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753146AbZHBXzi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Aug 2009 19:55:38 -0400
Received: by gxk9 with SMTP id 9so5435366gxk.13
        for <git@vger.kernel.org>; Sun, 02 Aug 2009 16:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=qTFk3IQ3W4/KcCoXIqJqY9bfh0bA9M5BRCXMTq2gk8U=;
        b=sb50LsRqJP1DLFLVw4An+iA3wM3OqrYM1iZfZdulooUU1/pQ4sBHAMEVgNY+Nh13l3
         1wGg8yur7oW5S6ks9M5A2vjRiM+Q8Ckaxhl8U8W5fOvYVncsTnjhPApBK1O0mZTyTjIF
         Fv8f34yW3sgUqYgw4Y+qoH6NfVqXmFLd837Xs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=a2fwKZHwuLlgqEcN/9SstCdTNed9ov7OuM92wFUD2LxWLEKVn2Tw/0Lfj6yjoiNkxo
         eXM3ZsZOiQC9m6UFLJVtd6MsHVW4uFYK4uHZ/JlCv1gwqLUDDPmfr5/y6kVL5sVEbIuT
         EKbkObbwN1VSn/1QfmvYbAm7zWOYfJzmRzIG4=
Received: by 10.231.13.201 with SMTP id d9mr1293829iba.35.1249257337965; Sun, 
	02 Aug 2009 16:55:37 -0700 (PDT)
In-Reply-To: <200908030125.53534.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124678>

2009/8/3 Jakub Narebski <jnareb@gmail.com>:
> On Sat, 1 Aug 2009, demerphq wrote:
>> 2009/8/1 Jakub Narebski <jnareb@gmail.com>:
>>> demerphq <demerphq@gmail.com> writes:
>>>
>>>> FWIW the perl project ripped out all the snapshot generation logic
>>>> from gitweb, and replaced it with a tool that generates snapshots
>>>> correctly for our requirements (if the build process needs additio=
nal
>>>> files /currently/ git-archive does not support adding them), this
>>>> includes a disk level cache for the snapshots since creating the t=
ar,
>>>> adding the additional files, then gziping is quite slow.
>>>>
>>>> If its interesting to people I can post it and the other changes h=
ere,
>>>> although its not a "nice" change, as I literally ripped out the
>>>> existing code.
>>>
>>> Do you mean gitweb serving http://perl5.git.perl.org/ ?
>>
>> Yes. I updated it to a relatively recent version just the other week=
=2E
>
> By the way, if you don't mind, how do you keep your changes on top
> of changing target, i.e. on top of updating baseline to recent
> versions?

Things broke. I fixed them. :-)


>> Also probably there are one or two patches that should be pushed bac=
k
>> to you.
>
> What do those patches consist of?

One has to do with layout problems in the blame, and I think one deals
with broken line number anchor links.

Ill look closer when i have more time.

> By the way, this is one of the only two places where we have to
> use quote_command and 3-argument form of open, instead of list for of
> magic open. =A0It is because of pipeline, piping git-archive output
> into compressor. =A0The other such place is git_object, to redirect e=
rror
> stream to /dev/null (to discard stderr).
>
> I thought about replacing it by list form of open somewhat (you can
> find it in git mailing list archive), but it is not easy. =A0And IPC:=
:Run
> is IMVHO a bit of overkill, especially for "minimal dependencies"
> gitweb (perhaps for Git::Web?).

Lately I have been playing with Capture::Tiny, which seems to fill
some nice niches in this respect.

>> A better git api toolset for perl would make things a lot easier.
>> Especially an XS one.
>
> Well, in the beginnings of Git.pm there was XS interface (to
> git-hash-object or git-cat-file), but it was dropped because it
> used -fPIC, which is not portable enough for Git (this is not present
> in perl/Git.pm history in git.git repository). =A0Git.pm was created
> by Petr 'Pasky' Baudis, author of Cogito porcelain, and creator and
> admin of repo.or.cz (and also creator of first Git homepage).
> But he is not a Perl hacker (correct me if I am wrong, Pasky); both
> Cogito and repo.or.cz duct tape (under name of Girocco) are written
> in bash, not in Perl. =A0Which can be seen for example by using
> Error::Simple in Git.pm...
>
> Also I don't think that Pasky has time for maintaining Git.pm,
> nevermind modernizing it / adding new features.
>
> There was another attempt to make Perl interface for Git, more
> object-oriented, by Lea Wiemann during GSoC 2008 project 'gitweb cach=
ing'.
> You can see results in Lea repository at repo.or.cz[1], and also in
> git.kernel.org gitweb code[2].
>
> [1]: http://repo.or.cz/w/git/gitweb-caching.git
> [2]: http://git.kernel.org/?p=3Dgit/warthog9/gitweb.git

Yeah I recall that being discussed. I see that Git.pm has recevied
some attention since the last time I looked. Which is good to see.

Having lurked on the list I understand that there is some kind of
effort for a git library.  Perhaps at some point that will end up with
an XS interface.

>>>
>>> P.P.S. Could you per chance post announcement of Git User's Survey =
2009
>>> on http://perl5.git.perl.org, just like it is done on http://repo.o=
r.cz
>>> and http://git.kernel.org? =A0TIA.
>>
>> Sure.
>
> Hmmm... I don't see "Git User's Survey 2009" announcement at
> http://perl5.git.perl.org/. =A0Neither at Planet Perl Iron Man, nor a=
t
> Perlsphere

Ah, sorry, I posted it to the perl5-porters mailing list and asked the
relevant people to forward the request on or post it on their site. I
know at least one perl committer already did it. However tomorrow the
main european perl conference starts (YAPC::EU in Lisbon) and I think
a big chunk of the "active" Perl community will be there, so probably
there wont be much action from them until they get back.

To be honest I'm not familiar with Planet Perl Iron Man nor
Perlsphere. Ill have to check them out i guess. :-)

I will try to remember to put up a note on the website as soon as possi=
ble.

cheers,
Yves

--=20
perl -Mre=3Ddebug -e "/just|another|perl|hacker/"
