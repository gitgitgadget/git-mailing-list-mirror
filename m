From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: What should be the CRLF policy when win + Linux?
Date: Thu, 6 May 2010 22:40:00 +0200
Message-ID: <x2s40aa078e1005061340vaf404ab3g30b2b98ca408205@mail.gmail.com>
References: <4BE141E3.2060904@gmail.com>
	 <x2h600158c31005051935i6f379a9j6aa36b4503776b87@mail.gmail.com>
	 <o2ved79be1d1005060029n67f451c6p3b48b83c51031222@mail.gmail.com>
	 <i2i600158c31005060834s72e10fb7te19048e3b174d29b@mail.gmail.com>
	 <alpine.LFD.2.00.1005061009020.901@i5.linux-foundation.org>
	 <h2x600158c31005061300tfe485e01x251ae20b22ef5b27@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: hasen j <hasan.aljudy@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 06 22:40:15 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OA7rh-0000Xw-9Z
	for gcvg-git-2@lo.gmane.org; Thu, 06 May 2010 22:40:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932514Ab0EFUkF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 May 2010 16:40:05 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:58621 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932239Ab0EFUkE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 May 2010 16:40:04 -0400
Received: by wwb39 with SMTP id 39so325891wwb.19
        for <git@vger.kernel.org>; Thu, 06 May 2010 13:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:reply-to
         :in-reply-to:references:date:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=xHVg4xjLSaRk+AIn2oise2LBUWr0gSRM/VSTuZAxpMw=;
        b=ZZdw/PDt1TbCcLHIhuPjrKTCqPu8V9EicZuAJ515Tkc8wB5MzWJmHnjjCwPM9f6a5/
         Se0eWdoUNPx4cptamkG9ohzREqq9HijvuGz+A88bj/Hv5bT9cDDd+Q5fF467xcQgkHoY
         HgVkW04nqulHO7JJFaELeL4Gvsx5l1yoLfi7U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=rdlmxyr7oo6w9l2dCGPqzQweLyTpeav/V+8vqCM0sG69C/Ag/s77P5h5M2pEA1cTKb
         DkJEtHuB3XcK+eJ87FYMrRc8hJXePpdffs+M8oUDVSGb+1gglpOKZrwhnBGq0WVN+j7A
         mn25M0NeWcodnkvg3/F93wFmswL+lIsM8jXTQ=
Received: by 10.216.174.21 with SMTP id w21mr408482wel.60.1273178400903; Thu, 
	06 May 2010 13:40:00 -0700 (PDT)
Received: by 10.216.51.79 with HTTP; Thu, 6 May 2010 13:40:00 -0700 (PDT)
In-Reply-To: <h2x600158c31005061300tfe485e01x251ae20b22ef5b27@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146496>

On Thu, May 6, 2010 at 10:00 PM, hasen j <hasan.aljudy@gmail.com> wrote=
:
> On 6 May 2010 11:15, Linus Torvalds <torvalds@linux-foundation.org> w=
rote:
>>
>>
>> On Thu, 6 May 2010, hasen j wrote:
>>>
>>> I don't know all linux editors, but I've yet to see one that can't
>>> handle CRLF endings.
>>
>> A _lot_ of UNIX editors will handle CRLF endings, but if you change =
a
>> file, they often write the result back with _mixed_ endings. Some wi=
ll
>> also show the CR as '^M' or some other garbage at the end.
>>
>> A number of tools will also end up confused, including very fundamen=
tal
>> things like "grep". Try this:
>>
>> =A0 =A0 =A0 =A0echo -e "Hello\015" > f
>> =A0 =A0 =A0 =A0grep 'Hello$' f
>>
>> and notice how the grep does _not_ find the Hello at the end of the =
line,
>> because grep sees another random character there (this might be
>> unportable, I could easily imagine some versions of grep finding it)=
=2E
>>
>> So I would strongly suggest against CRLF on UNIX. It really doesn't =
work
>> very well, even if some tools will handle it to some limited degree.
>>
>> In short: having 'core.autocrlf' set will likely make it much more
>> pleasant to work across different platforms.
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Linus
>>
>
> When I'm on windows, I prefer LF (unless the project already uses
> CRLF, or it's outside my control).
>

"When I'm on windows" leads me to believe Windows is not your primary
operating system. If not, please excuse me.

> My problem with autocrlf is that, well, it converts line endings in
> the working directory to CRLF, even though I don't always want it to.
> (most of the time, I don't).
>

There's gitattributes for that.

> The other problem is, git will get confused if you set autocrlf *afte=
r
> the fact*; i.e. you already cloned and have the files checked out,
> maybe even made some commits.
>

core.autocrlf being on by default in Git for Windows greatly reduces
the risk for this. I with core.autocrlf was set to "input" by default
on other platforms, though.

> Overall, I ran into many awkward situations with autocrlf (and I can'=
t
> remember them now), but if you google you can find some of the issues
> people are having.
>
> The whole problem would go away if there was no crlf, and that's not
> impossible: any decent text editor can read/write files with Unix lin=
e
> endings.
>

That's probably on of the things that makes a text-editor decent in
your book, but this opinion might not be shared with everyone. Perhaps
not being primarily a Windows-user somehow biases your opinion here?

> I wasn't aware that Visual Studio doesn't have an easy way to have it
> write LF endings by default; I'm sure there are addons to make that
> easier. Plus most open source projects are not usually setup with VS
> as the development environment anyway, so it's really not a big
> problem.

The problem with Visual Studio isn't that it doesn't write LFs
normally... the problem is that when you paste text, it retains the
newline style from the source you copied from. But it is not the only
tool with such issues, so playing the "VS is the problem"-card doesn't
stick IMO.

Even if it did, Open source isn't the only model for developing
software. And again... even if it were, working well together with
visual studio support would be very beneficial for quite a bit of
projects. Visual Studio is probably the most used code-editor among
Windows-developers (with a good margin too, I suspect), so ignoring it
is would just be sticking your head in the sand - or worse, asking for
less contributions from Windows-users (which can often be a problem in
the first place).

So no, I strongly doubt LF everywhere is the better way ;)

--=20
Erik "kusma" Faye-Lund
