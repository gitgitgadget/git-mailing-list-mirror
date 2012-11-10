From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: What's cooking in git.git (Nov 2012, #02; Fri, 9)
Date: Sat, 10 Nov 2012 20:13:37 +0100
Message-ID: <CAMP44s2WHZh8Jc6PaM-9h9Hkf3Un_xAC=29TNFF1u9sSEYA7gg@mail.gmail.com>
References: <20121109192336.GA9401@sigill.intra.peff.net>
	<CAMP44s3yVtQ4wGqVTyHN-VfAM7iRo9WfNnAu+ns7Zkc_cPBH3g@mail.gmail.com>
	<20121110003331.GA12567@sigill.intra.peff.net>
	<20121110123250.GR12052@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>
To: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Sat Nov 10 20:13:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXGV6-0004RK-80
	for gcvg-git-2@plane.gmane.org; Sat, 10 Nov 2012 20:13:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752243Ab2KJTNj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 10 Nov 2012 14:13:39 -0500
Received: from mail-ob0-f174.google.com ([209.85.214.174]:45223 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751653Ab2KJTNi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Nov 2012 14:13:38 -0500
Received: by mail-ob0-f174.google.com with SMTP id uo13so5085538obb.19
        for <git@vger.kernel.org>; Sat, 10 Nov 2012 11:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=IEGBit2Msw9RiGsSX/2YYKCOZzuL4Q9bu1JPX4+ou0U=;
        b=hqahFiRg/CDlAZNP3NjWsO8R4w3yLm4VU4UYEcirBPWy2ebw/WzNbZR/2OnRTy8XaD
         KYUOmuwmtPJky9BmR6OZPIwdnlJek8RhfASMcq5OeCSKHz6hrNWKaM9TeCAqFi0yFJJw
         5Q/LPnymwFCPn8Nj5b3hhyqJF6ClZ4JigCEaSwXGJW1prkVsuDIMoMZwkkse5KOi8cHn
         yo33OHY5dkvgVS93/Cl9/tQb4QpAXsTaaP4lZP1YfsERdIxEzq8J7tplDsLjy4fxGekl
         dJHwwu1+jt7aoU6c26c/HYNJ1y1n4qegj0Du/0ZxqqFRuZ2jR9fkgwgodGU3l6HD1NrR
         tcVw==
Received: by 10.60.12.233 with SMTP id b9mr11164286oec.95.1352574817668; Sat,
 10 Nov 2012 11:13:37 -0800 (PST)
Received: by 10.60.4.74 with HTTP; Sat, 10 Nov 2012 11:13:37 -0800 (PST)
In-Reply-To: <20121110123250.GR12052@goldbirke>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209293>

On Sat, Nov 10, 2012 at 1:32 PM, SZEDER G=C3=A1bor <szeder@ira.uka.de> =
wrote:
> Hi,
>
> On Fri, Nov 09, 2012 at 07:33:31PM -0500, Jeff King wrote:
>> On Sat, Nov 10, 2012 at 12:21:48AM +0100, Felipe Contreras wrote:
>> > > * fc/completion-test-simplification (2012-10-29) 2 commits
>> > >  - completion: simplify __gitcomp test helper
>> > >  - completion: refactor __gitcomp related tests
>> > >
>> > >  Clean up completion tests.
>> > >
>> > >  There were some comments on the list.
>> > >
>> > >  Expecting a re-roll.
>> >
>> > The second patch I can re-roll, but the first patch needs some
>> > external input. My preference is that tests should also be simple =
and
>> > maintainable, SZEDER's preference is that tests are better being
>> > explicit and verbose (even if harder to maintain) to minimize poss=
ible
>> > issues in the tests.
>>
>> I think it is better to keep the tests simple and maintainable.
>
> Maintainable?  There is nothing to maintain here.  Users' completion
> scripts depend on __gitcomp(), so its behavior shouldn't be changed.
> It can only be extended by a fifth parameter or by quoting words when
> necessary, but these future changes must not alter the current
> behavior checked by these tests, therefore even then these tests must
> be left intact.

I disagree. If we add a new parameter to __gitcomp(), and we need to
add a new parameter to test_gitcomp(), so be it. Yes, we might change
the behavior of the other tests, but that's what reviews are for: to
make sure we don't alter other behavior by mistake. That's what we do
for code, and that what we should do for tests.

But in this particular case nothing would need to change because
test_gitcomp() would pass whatever arguments it receives, being four,
or five, or twenty. So this is not a concern, maybe some other kind of
change, but not this.

Compare this:
http://article.gmane.org/gmane.comp.version-control.git/208168

To this:
http://article.gmane.org/gmane.comp.version-control.git/207927

If we ever need to make changes to the __gitcomp tests, a small change
is better than a big change; IOW: the test code would be more
maintainable.

Even more, the end result is much less code: less code =3D more maintai=
nability.

> Simple?  Currently you only need to look at __gitcomp() and the test
> itself to understand what's going on.  With this series you'll also
> need to look at test_gitcomp(), figure out what its parameters are
> supposed to mean, and possibly get puzzled on the way why __gitcomp()
> is now seemingly called with only one parameter.

Maybe it's easier for you to understand, but certainly not for other
people: 'declare -a COMPREPLY'? cur? print_comp? What does that even
mean? Chances are most people don't even know what __gitcomp is.
=46ortunately they don't have to dig too deep to find all those things
out, but they can do the same for test_gitcomp().

It might make sense to add some comment on top of test_gitcomp to
explain the arguments and the input to make things easier, but that
would only make it more readable, not less, than the current
situation, because right now you would have to add a similar comment
to each and every block of code that calls __gitcomp.

=46unctions make our life easier.

> So, I don't see much benefit in this series (except the part to use
> print_comp instead of "change IFS && echo", but that's already done i=
n
> this patch:
> http://article.gmane.org/gmane.comp.version-control.git/207927).

Yes, and that version is much bigger than this:
http://article.gmane.org/gmane.comp.version-control.git/208168

Code that allows the later patch is more maintainable.

> OTOH, this series has some serious drawbacks.
>
> It makes debugging more difficult.  While working on the quoting
> issues I managed to break completion tests many-many times lately.  I=
n
> normal tests I could add a few debugging instructions to the failed
> test to find out where the breakage lies, without affecting other
> tests.  However, if the failed test uses the test_completion() helper=
,
> then I have to add debugging instructions to test_completion() itself=
,
> too.  This is bad, because many tests use this helper function and ar=
e
> therefore affected by the debugging instructions, producing truckload=
s
> of output making it difficult to dig out the relevant parts, or, wors=
e
> yet, causing breakages in other tests.  With this series the same
> difficulties will come to __gitcomp() tests, too.

What I do is copy the function to test_gitcomp2() and add the
debugging there, and only call it from the places where I want the
debugging. I don't think this is an issue.

In fact, I think it's an advantage; sometimes that's exactly what you
want, to add the debugging for everything.

> It can also encourage writing bad tests, similar to those that manage=
d
> to cram many test_completion() lines into a single tests, giving me
> headaches to figure out what went wrong this time.

That's policy. We can decide what each test-case contains right here,
on the mailing list. There's no need to have verbose code to slightly
hint a policy.

Cheers.

--=20
=46elipe Contreras
