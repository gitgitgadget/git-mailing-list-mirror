From: Erick Mattos <erick.mattos@gmail.com>
Subject: Re: [PATCH] Changed timestamp behavior of options -c/-C/--amend
Date: Fri, 30 Oct 2009 19:22:46 -0200
Message-ID: <55bacdd30910301422w2a2fa71cw74bd71d9b9383b85@mail.gmail.com>
References: <1256931394-9338-1-git-send-email-erick.mattos@gmail.com> 
	<20091030202628.GA26513@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 30 22:23:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3ywF-0006eB-Pb
	for gcvg-git-2@lo.gmane.org; Fri, 30 Oct 2009 22:23:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932906AbZJ3VXE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Oct 2009 17:23:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932879AbZJ3VXC
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Oct 2009 17:23:02 -0400
Received: from mail-yw0-f202.google.com ([209.85.211.202]:60506 "EHLO
	mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932877AbZJ3VXB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Oct 2009 17:23:01 -0400
Received: by ywh40 with SMTP id 40so3081669ywh.33
        for <git@vger.kernel.org>; Fri, 30 Oct 2009 14:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=Z4SwrCbsWLyE5vIBqqIuDQwkE5lFTpv6vH8tMjrkA4s=;
        b=XWpGwmxwV7i6rtDGGDK9QeGlpXYUsn9rxOu5x5EJNOWC3+5j2SRlhX9guMGegRSYcw
         ytpz82KQuWnTPz3/EPCPywK49PkjpELL1Jgh7M7CK5JZQgWmru3G7CTGtn9Id0weOr6G
         RmCZ/JrtQw+wbbsiFz5J3+u7liPSFl60YHNn8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=bIN3OEORdiPdJ6Na+vBy4y1YNEqPcn10K7/+LBp8NRTK6rcn8swReiLgkqcUuoN4yF
         9RRLazCwdC/KYlWfpTRykFe9uiQ6zlyG4Hv9Cf9VZMzIXBB7SVTdvo0N5+8jJbuL7LUP
         BjQpZzTLq4j1L3v01OqqR/om8e+jUMH54msvs=
Received: by 10.150.172.1 with SMTP id u1mr3894302ybe.300.1256937786286; Fri, 
	30 Oct 2009 14:23:06 -0700 (PDT)
In-Reply-To: <20091030202628.GA26513@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131752>

2009/10/30 Jeff King <peff@peff.net>:
> On Fri, Oct 30, 2009 at 05:36:34PM -0200, Erick Mattos wrote:
>
>> Anyway this update creates new options for choosing the source times=
tamp
>> or a new one. =C2=A0And set as default for -c option (editing one) t=
o take a
>> new timestamp and for -C option the source timestamp. =C2=A0That is =
because
>> we are normally using the source as template when we we are editing =
and
>> as a correction when we are just copying it.
>>
>> Those options are also useful for --amend option which is by default
>> behaving the same.
>
> Thanks, this is something I have been wanting. I have always thought
> that --amend should give a new timestamp, so that while I'm fixing up
> commits via "rebase -i" the commits end up in correct date order.

You are welcome!


> Your patch seems to always use the old timestamp for -C, the new one =
for
> -c, and the old one for --amend. I would want it always for --amend.

About --amend: I didn't want to change the actual behavior and as a
matter of fact it means only adding the --new-timestamp option when
needed anyway.


> I talked with Shawn about this at the GitTogether; his counter-argume=
nt
> was that many people in maintainer roles will be amending or rebasing
> just to do little things, like marking Signed-off-by, and that the da=
te
> should remain the same.
>
> So my suspicion is that there are some people who almost always want
> --new-timestamp, and some people who almost always want --old-timesta=
mp,
> depending on their usual workflow. In which case a config option
> probably makes the most sense (but keeping the command-line to overri=
de
> the config, of course).

As you know you will find people defending both sides.  I am one that
prefers --amend the way it is now.  I really think that having an
option to change it is enough to keep peace.

I don't see a need for more changes in config because it would be imho
more complexity for a small need.

Of course you can do some alias in bash for setting mentioned
functionality up! ;-)


>> ---
>> =C2=A0Documentation/git-commit.txt | =C2=A0 10 ++++++++--
>> =C2=A0builtin-commit.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=
=A0 15 ++++++++++++---
>> =C2=A02 files changed, 20 insertions(+), 5 deletions(-)
>
> Tests?

Yes indeed.  It is a change I am using which I thought it would be
useful for other people.  The code is quite simple too.  Simplicity
always lead to less possibility of bugs.  But yes, I had tested it.


>> =C2=A0 =C2=A0 =C2=A0 Take an existing commit object, and reuse the l=
og message
>> - =C2=A0 =C2=A0 and the authorship information (including the timest=
amp)
>> - =C2=A0 =C2=A0 when creating the commit.
>> + =C2=A0 =C2=A0 and the authorship information when creating the com=
mit.
>> + =C2=A0 =C2=A0 By default, timestamp is taken from specified commit=
 unless
>> + =C2=A0 =C2=A0 option --new-timestamp is included.
>
> We should clarify that this is the _author_ timestamp. The committer
> timestamp is always updated. Yes, it is talking about authorship
> information in the previous sentence, but at least I had to read it
> a few times to figure that out. Plus there are some minor English
> tweaks needed, so maybe:

I see your point but I do not think the way it is is confusing.  Of
course we will be talking about taste so I let it pass.  Anyway who
would think about or want to change the commiter timestamp?  Maybe a
fraudster!...  :-1


> =C2=A0and the authorship information when creating the commit.
> =C2=A0By default, the author timestamp is taken from the specified co=
mmit
> =C2=A0unless the option --new-timestamp is used.
>
>> =C2=A0-c <commit>::
>> =C2=A0--reedit-message=3D<commit>::
>> =C2=A0 =C2=A0 =C2=A0 Like '-C', but with '-c' the editor is invoked,=
 so that
>> =C2=A0 =C2=A0 =C2=A0 the user can further edit the commit message.
>> + =C2=A0 =C2=A0 By default, timestamp is recalculated and not taken =
from
>> + =C2=A0 =C2=A0 specified commit unless option --old-timestamp is in=
cluded.
>
> Ditto:
>
> =C2=A0By default, the author timestamp is recalculated and not taken =
from
> =C2=A0the specified commit unless the option --old-timestamp is used.
>
>> @@ -134,6 +138,8 @@ OPTIONS
>> =C2=A0 =C2=A0 =C2=A0 current tip -- if it was a merge, it will have =
the parents of
>> =C2=A0 =C2=A0 =C2=A0 the current tip as parents -- so the current to=
p commit is
>> =C2=A0 =C2=A0 =C2=A0 discarded.
>> + =C2=A0 =C2=A0 By default, timestamp is taken from latest commit un=
less option
>> + =C2=A0 =C2=A0 --new-timestamp is included.
>
> And:
>
> =C2=A0By default, the author timestamp is taken from the latest commi=
t
> =C2=A0unless the option --new-timestamp is included.

As previously said I wouldn't change the text but anyway...


>> + =C2=A0 =C2=A0 if (old_timestamp && new_timestamp)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 die("You can not use --o=
ld-timesamp and --new-timestamp together.");
>
> Typo: s/samp/stamp/
>
> But this mutual exclusivity implies to me that the option should
> probably be "--timestamp=3Dold|new".
>
> -Peff
>

Now it is a matter of taste again...  I prefer the options as I set up
because it is more the way other options are used so it is more
intuitive.  We use very little --'option'=3D'something' using git.

Thanks for all your comments.  I have appreciated them very much.

The differences in opinion between us about the little details of this
update is not really relevant because we agree in the need of the
customization proposed.

I have really presented it because I thought it would be useful.

So I think the maintainer can accept it as he judges better.

One of the beauties of Free Software is: even if people don't agree on
a subject one can always compile and use the way one wants.  So
everybody gets satisfied!

Thank you very much again.

Best regards.
