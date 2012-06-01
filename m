From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Finding a branch point in git
Date: Fri, 1 Jun 2012 11:15:20 +0200
Message-ID: <CAMP44s1cETpXHMtUsq__FpFSOg9yLmh1A9uYtiTp-K6yEC4AhA@mail.gmail.com>
References: <CAMP44s0f7AJPQSTDgvy0U7vx8nxzq2a3vMhSr2Tcc61fetFkJA@mail.gmail.com>
	<20120528062026.GB11174@sigill.intra.peff.net>
	<CAMP44s04msWMOaaH8U30XXg5yXJnEd=bULJ7VPxWSD0Wfh2=EA@mail.gmail.com>
	<20120528190639.GA2478@sigill.intra.peff.net>
	<CAMP44s0UBsVicuEcwACsm1zTT_jGau_Q20hJv4J_6uvancYJRQ@mail.gmail.com>
	<20120530215415.GB3237@sigill.intra.peff.net>
	<CAMP44s1Q26B9hCdubfDiP2_YUUWGOtyyA=gSwqpGOE4FfZrN8A@mail.gmail.com>
	<CAJsNXTkWKP9xY-yBQF6PuF_YyGshV5xaXG-oBWAO138cFUyT1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: PJ Weisberg <pj@irregularexpressions.net>
X-From: git-owner@vger.kernel.org Fri Jun 01 11:15:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SaNx9-0003PP-Ob
	for gcvg-git-2@plane.gmane.org; Fri, 01 Jun 2012 11:15:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759153Ab2FAJPZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 Jun 2012 05:15:25 -0400
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:45150 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758258Ab2FAJPW convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Fri, 1 Jun 2012 05:15:22 -0400
Received: by lahd3 with SMTP id d3so1384988lah.19
        for <git@vger.kernel.org>; Fri, 01 Jun 2012 02:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=15YnXEDskiEVZs+YZ2HKLCmwgyh9GWGGDIoxYo56t6k=;
        b=nksbCvwYSnIm8vdV80c0F6T/NizDnb9jk+1e/iZxRlFv8Q1DrdK0IY9yXFxeYyvO1j
         rjhdSPmbVk6hqQS7ABUWTbDr3CBTh3/MdQKUINO12xSvc1zJvZwMk4VJaqC1MNkRXgAF
         qni1DwY+TDIQXbGfWXImpgmdl28OzWiBhE7fSO2La8j2dkUxdwxvKc1/buL4EsLpWBPw
         K6BWxrnGeEJvD0+i5QJwRW56MULPuSxnyK/7noBSJCpxo7RrWpVVEZk/TxTJrLU1K6U+
         8Z0I1M1AvqUlSDqUBqp7mXPIzD8fPhvWZZXIAyeDVUJ7hH+yVAMN9/7rESlCqD3hkUEH
         J4tg==
Received: by 10.152.125.236 with SMTP id mt12mr2023529lab.12.1338542120616;
 Fri, 01 Jun 2012 02:15:20 -0700 (PDT)
Received: by 10.112.107.65 with HTTP; Fri, 1 Jun 2012 02:15:20 -0700 (PDT)
In-Reply-To: <CAJsNXTkWKP9xY-yBQF6PuF_YyGshV5xaXG-oBWAO138cFUyT1g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198965>

On Thu, May 31, 2012 at 10:37 PM, PJ Weisberg
<pj@irregularexpressions.net> wrote:
> On Thu, May 31, 2012 at 8:27 AM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> On Wed, May 30, 2012 at 11:54 PM, Jeff King <peff@peff.net> wrote:
>>> On Wed, May 30, 2012 at 07:07:39PM +0200, Felipe Contreras wrote:
>>>
>>>> On Mon, May 28, 2012 at 9:06 PM, Jeff King <peff@peff.net> wrote:
>>>> > On Mon, May 28, 2012 at 02:36:04PM +0200, Felipe Contreras wrote=
:
>>>> >
>>>> >> > What about a history with multiple branches?
>>>> >> >
>>>> >> > --X--A--B--C--D----E =C2=A0(master)
>>>> >> > =C2=A0 =C2=A0 =C2=A0\ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /
>>>> >> > =C2=A0 =C2=A0 =C2=A0 G--H--I---J =C2=A0 (branch X)
>>>> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \ =C2=A0 =C2=A0/
>>>> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0K--L =C2=A0 =C2=A0(b=
ranch Y)
>>>> >> [...]
>>>> >>
>>>> >> Yes, but then you would need to specify a second branch. I woul=
d avoid
>>>> >> that if possible.
>>>> >
>>>> > I agree that is less nice. But I don't think the operation is
>>>> > well-defined with a single branch. If you ask for "when did bran=
ch X
>>>> > split", then in the above graph it is unclear if you meant "spli=
t from
>>>> > master", or "split from Y".
>>>>
>>>> If you look from the context that I explained in the first mail; i=
t
>>>> would be from *any* branch; IOW; find the first commit from branch=
 X
>>>> (G), and then find the parent. That would be the first commit wher=
e
>>>> branch X started.
>>>
>>> I'm not sure that's possible, though, in the face of criss-cross me=
rges.
>>> How do we distinguish the history above from one in which branch Y =
was
>>> forked from master at G, and then branch X was forked from branch Y=
 at
>>> H?
>>
>> That is true, but we could use the algorithm used by name-rev: G wou=
ld
>> have a distance 3 from branch X, and distance 2 from Y, so it would =
be
>> considered part of branch Y.
>>
>> Sure, it's not possible to know _for sure_, but this is a bit like
>> renames; we don't really know if a file was renamed or not, but we c=
an
>> make a good guess.
>
> Obviously G is part of branch Y, branch X, and branch master. =C2=A0I=
'm
> sure I'm missing the whole point of this exercise, because it seems t=
o
> me that it's just needlessly confusing to say anything else.

It's not about which commit is part of which branch, but figuring out
which is the first commit that was created being in branch Y.

I don't see a tremendous value on this, but there is some, for example:

 % git rebase --onto master branch_Y@{tail} branch_Y

Depending on the case, this might not be what you want, but sometimes
it might, the problem is that you can't know automatically if
branch_Y@{tail} is G, or K. So normally you would fire gitk and select
the commit that you want, which is not a big deal, but still, it would
be nice if the tail of a branch was recorded somehow.

To be clear, if I do:

 % git checkout -b branch_Y
 % git commit <- this would be branch_Y's tail

 % git rebase --onto master <- now branch_Y's tail would be right on
top of master

Cheers.

--=20
=46elipe Contreras
