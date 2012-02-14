From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3 0/2] test: tests for the "double > from mailmap" bug
Date: Wed, 15 Feb 2012 00:22:53 +0200
Message-ID: <CAMP44s2v25w=14t8ZK82n-_01UCYWuUr2kAb3jEf2YfRiu2uyA@mail.gmail.com>
References: <1329235894-20581-1-git-send-email-felipe.contreras@gmail.com>
	<20120214203431.GB13210@burratino>
	<20120214211402.GC23291@sigill.intra.peff.net>
	<CAMP44s0Dp9Av+ikFHa=QcqKFA5XL9ESBrzWLY0jkSCdH-NxhMw@mail.gmail.com>
	<20120214220732.GB24802@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 14 23:23:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RxQm3-0000aR-Bq
	for gcvg-git-2@plane.gmane.org; Tue, 14 Feb 2012 23:23:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761060Ab2BNWWz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Feb 2012 17:22:55 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:37716 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754480Ab2BNWWy convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Feb 2012 17:22:54 -0500
Received: by lagu2 with SMTP id u2so454925lag.19
        for <git@vger.kernel.org>; Tue, 14 Feb 2012 14:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=9SbggcaN4IsxinuPmpiIDfiqb1yAD4fXjpgoVn3pHZI=;
        b=F5piiFsccG/6u8s1JA0VFqE1Kr0V4TUtH7GcIrnqXl5p0xIGth0sy60QTl8giaPQ5/
         UxVIQF0wSEDYTDIOrkKDj4V8vFi9wQj5cT54XqAx6DugDk+OzFaWIVJGagA8vdYkwqxt
         RcZtBvJOJ5vOLoenoTmdyr91zIA8h0Nr7ZcFY=
Received: by 10.112.28.169 with SMTP id c9mr7927279lbh.42.1329258173094; Tue,
 14 Feb 2012 14:22:53 -0800 (PST)
Received: by 10.112.41.73 with HTTP; Tue, 14 Feb 2012 14:22:53 -0800 (PST)
In-Reply-To: <20120214220732.GB24802@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190780>

On Wed, Feb 15, 2012 at 12:07 AM, Jeff King <peff@peff.net> wrote:
> On Tue, Feb 14, 2012 at 11:52:11PM +0200, Felipe Contreras wrote:
>
>> On Tue, Feb 14, 2012 at 11:14 PM, Jeff King <peff@peff.net> wrote:
>> > My general review process is (in this order):
>> >
>> > =C2=A01. Figure out why a change is needed. This should be explain=
ed in the
>> > =C2=A0 =C2=A0 commit message. And no, just adding tests is not ass=
umed to be
>> > =C2=A0 =C2=A0 needed. =C2=A0Why did the old tests not cover this c=
ase?
>>
>> As I already mentioned more than once; the first patch is not relate=
d
>> to any fix.
>
> Really? I didn't see it mentioned in your commit message, which
> consisted entirely of:
>
> =C2=A0t: mailmap: add 'git blame -e' tests
>
> Yes, I know you mentioned it elsewhere in the thread. But review shou=
ld
> happen on what is actually in the posted patch. That is what reviewer=
s
> are guaranteed to have read, and it is what people reading "git log" =
in
> a year will see. If there was other discussion or context that led to
> the patch, it's helpful in both cases to summarize it.

Seriously? You want to add a note saying "These tests don't tackle any
known issues". Well, if it did, logically, it would have been
mentioned.

>> > =C2=A0 =C2=A0 The answer can
>> > =C2=A0 =C2=A0 be a simple "nobody bothered to write them", and tha=
t's OK.
>>
>> =C2=A0That can be derived from the word "add". You can't add somethi=
ng that
>> is already there.
>
> Are there already git-blame tests, but not "blame -e" tests? If there
> are already "blame" tests, why do we additionally need "blame -e" tes=
ts?

You are right, it's impossible to decipher that the output of 'blame
-e' is different than 'blame'. Surely, somebody must have made a
mistake when the patch was applied.

Or we can apply common sense.

> I can guess, or I can do my own digging in the history to find out, b=
ut
> that makes review a lot more painful. You already did the digging and
> came to understand the problem when you made your patch. Why not just
> share it?

Because there's no need.

Why would anybody add tests that are already there? Why do you have to
assume the worst?

>> > =C2=A0 =C2=A0 But
>> > =C2=A0 =C2=A0 some description of the current state can help revie=
wers understand
>> > =C2=A0 =C2=A0 the rationale (e.g., "we tested with shortlog, but n=
ot mailmap, and
>> > =C2=A0 =C2=A0 certain code paths are only exposed through mailmap"=
).
>>
>> You are assuming too much. That's not the purpose, that's why I didn=
't menti
>
> Sorry, that should have been s/mailmap/blame/ above. But if I am maki=
ng
> wrong assumptions about the rationale, then isn't that a sign that th=
e
> commit message is insufficient?

If you mean the second patch, this was already pointed out by Junio,
and I already said I would clarify that these are meant to target 'git
blame' output.

>> > =C2=A02. Figure out what the change should be doing.
>>
>> t: mailmap: add 'git blame -e' tests
>>
>> That's what the change should be doing; nothing more, nothing less.
>
> Yes, I think you did describe the "what", which in this case is very
> simple. But as I mentioned before, it is not just knowing the "what" =
but
> evaluating that the "what" meets the "why" from step 1.

The why can be derived. Unless you seriously think Junio would allow
patches that say they "add" tests for something (which imply there
isn't tests for that), where they don't.

>> I wonder why you have to assume the worst. When I see a commit messa=
ge
>> like that, I assume that there were no previous tests for that (thus
>> the word 'add'), and that's all I need to know.
>
> I don't necessarily assume the worst. If I were the maintainer, I mig=
ht
> even have taken your patch as-is, as it's pretty simple. But I found =
a
> description like the one Jonathan included to be _much_ easier to
> review. Whether yours was above a minimum threshold or not, I think i=
t's
> worth striving to be better.

Better !=3D more words. English, like code, is good as simple as
possible (but not simpler).

If you start from the premise that the patch is good; it has been
s-o-b by Junio, and it has been applied, and released, what more do
you need from the summary "t: mailmap: add 'git blame -e' tests". Can
you derive the rest?

Cheers.

--=20
=46elipe Contreras
