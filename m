From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] GSoC Micoproject: Hunt down signed int flags
Date: Sun, 21 Feb 2016 19:48:39 -0500
Message-ID: <CAPig+cSDG8duN750fbD=RnEaLSQ6OnHc2w77LEdTXuApT97pJg@mail.gmail.com>
References: <1456053189-5221-1-git-send-email-sauravsachidanand@gmail.com>
	<56CA46A3.9060404@moritzneeb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Saurav Sachidanand <sauravsachidanand@gmail.com>,
	Git List <git@vger.kernel.org>
To: Moritz Neeb <lists@moritzneeb.de>
X-From: git-owner@vger.kernel.org Mon Feb 22 01:48:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXeg8-0004MD-Vu
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 01:48:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752577AbcBVAsl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 21 Feb 2016 19:48:41 -0500
Received: from mail-vk0-f48.google.com ([209.85.213.48]:34826 "EHLO
	mail-vk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751296AbcBVAsk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 Feb 2016 19:48:40 -0500
Received: by mail-vk0-f48.google.com with SMTP id e6so116301020vkh.2
        for <git@vger.kernel.org>; Sun, 21 Feb 2016 16:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=QDiR7XDXQh+4tAiVuUMsScPpN+pIHaXCpSG3SwKfpK4=;
        b=ABKEXpV+kbqAobLl2kyahMB6OY/C4gSJ3c1Rd0rSFLioma9i8J9u6nm8cLNFu+RLkQ
         xjTZQhy7/pLHpnmdYAS6RKqT71w0ki8jGSrvCUC5oK9X9Z6BmrIdMKZ2lD7sbFDgXsDS
         WXIB9/Nj27tOUWaog8GSH71rohCj5465mQp3vRpILGlThJK1lY0ChY/iQ7rgYtfOhRnz
         ZyrDywmnZND65wXVKkWUGFnKTTYIiW/xCQk89yeLxGL70CsJusNl3OYfW/10zlWDbXWL
         Atkz8MxBAwbgUkunLs7lDAegdEWgubRfoW9mbUvI9dj2jMqPVU/50Q23iEMcoM0bs4LF
         FTBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=QDiR7XDXQh+4tAiVuUMsScPpN+pIHaXCpSG3SwKfpK4=;
        b=Fpfddwhb1IjIvFv6cNrQqsLyYmvHyRKuU/48Q6ZNxnIAKChuKKGWcJ2TXpzgcSdbwE
         uutpGwglMKh5egqzuWhErCp3CbzcXtF7OhTdlnf90yY8SAg7cb7lACZo5QoVtN7fleXc
         fkVsqZZaNrLXqL9/SEinFClx0MJn6l6MfoWPZB3lii3iGP9LVPGg/ye7VwJaZZ500p2h
         vUTYyGC7HvOUSx55xv+LJ7inisJet4GQ+MJH83YD4B3XRyyCyPCfV6EOI6rLIHO8oMXD
         KwkLEDfsEwtKHQm7pLZNMcfSFD+1uI4XgqRLVg7a09n348Rv+IJv9vJlKdHpWKOnIW8G
         DbgA==
X-Gm-Message-State: AG10YORw3YdP2Eakw1dcq99R3C42TTxTyseWlcKih8AeTrtYFwqgJtW+Nh46jcEwBDijLQ+FIsD/AbvqmPHR5g==
X-Received: by 10.31.168.76 with SMTP id r73mr20972107vke.117.1456102119651;
 Sun, 21 Feb 2016 16:48:39 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Sun, 21 Feb 2016 16:48:39 -0800 (PST)
In-Reply-To: <56CA46A3.9060404@moritzneeb.de>
X-Google-Sender-Auth: zZjQlqjWNQunSx710CuJYEUIjfE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286857>

On Sun, Feb 21, 2016 at 6:22 PM, Moritz Neeb <lists@moritzneeb.de> wrot=
e:
> Thanks for your patch. Just to let you know, this will be my first
> review, but I hope it will be helpful anyway. I will mostly review yo=
ur
> commit text. First some general remarks:

Thanks for taking on this review. I think you've covered everything I
was going to say (thus saving me a lot of time). I agree with pretty
much everything you said, with (I think) only one exception (below).

> The text you are submitting with you email is directly used as commit
> message (the email subject as well, as the first line). You might wan=
t
> to take care that the description is useful as a "bit of history", I
> will give examples of what I mean below. Some guidelines for that can=
 be
> found in "Documentation/SubmittingPatches" section (2).
>
> On 02/21/2016 12:13 PM, Saurav Sachidanand wrote:
>> This is patch is for a suggested micro project for GSoC 2016; namely=
,
>> that of searching for a field of a struct that is of signed integral
>> type and used as a collection of multiple bits, and converting it to
>> an unsigned type if the MSB isn=E2=80=99t used in any special way.
>
> Especially, you might not want to include the fact that this is a GSo=
C
> project. You might want to add this kind of information in the
> "notes"-section of your email after the three dashes "---", this will=
 be
> skipped when the patch is applied.

Correct. That this was a GSoC mini-project is not interesting in the
permanent project history, but it's helpful information for reviewers,
so you'd place it in the commentary section after the "---" just below
your sign-off.

>> Two structs, `pattern` defined in attr.c and `exclude` defined in di=
r.h,
>> have a `flags` field of signed int type.
>
> I have never seen the Markdown-style quotes ` in git.git commits. To =
be
> in the same style as previous git (which helps e.g. in readability
> because it is homogeneous), you can use the "-quote for code. Or even
> leave them out if its clear from context.
>
>> The fields of both structs take
>> on values from the same set of positive integers {1, 4, 8, 16},
>> enumerated through the marco EXC_FLAG_*.
>
> marco -> macro.
>
> I'd say this is a good observation to state.
>
> Maybe it's also helpful to further explain why the two structs are
> logically connected, or if that turns out to be false, to split up yo=
u
> changes into two commits. I am not fully convinced that it should be =
one
> commit.

If I'm reading the code correctly, I think these changes are
interconnected, thus they ought to remain together in a single patch.
Specifically, the change to the signature of parse_exclude_pattern()
in dir.h has an impact on both structs. Thus, it should not be
necessary to explain further that these structs are connected (they
aren't really); rather the changes to both are merely natural
consequence of the change to parse_exclude_pattern()'s signature.

>>`pattern` is used only in attr.c,
>> and `exclude` is used only in builtin/check-ignore.c and dir.c, and =
in
>> those files, either, the value of `flags` is checked using the `&` o=
perator
>> (e.g.: flags & EXC_FLAG_NODIR), or the value of `flags` is first set=
 to 0
>> and then set to any one of {1, 4, 8, 16} using the `|=3D` operator
>> (e.g.: flags |=3D EXC_FLAG_NODIR). And, so it does not appear that t=
he MSB
>> of `flags` is used in any special way.
>
> This is the conclusion that is needed, but you might want state it mo=
re
> direct, like "the MSB is not used...".
>
>> Therefore, I thought to change the
>> type of `flags` in the definitions of both structs to `unsigned int`=
=2E
>> Furthermore, `flags` is passed by reference (of `pattern` in attr.c =
and of
>> `exclude` in dir.c) to the function `parse_exclude_pattern` defined =
in
>> dir.c, that accepts an `int *` type for `flags`.
>> When make was run, it gave
>> a warning for =E2=80=98converting between pointers to integer types =
of different
>> sign=E2=80=99, so I changed the type of that respective argument to =
`unsigned int *`.
>
> I think this explanation can be left out or has to be replaced by
> something less compiler-driven, i.e. why does it actually make sense =
for
> parse_exclude_pattern to have an unsigned int flags as parameter.

Right, the entire paragraph in the commit message could be collapsed
to something like:

    Since the MSB of parse_exclude_pattern()'s 'flags' argument
    is not special, change its type from 'int' to 'unsigned' to better
    reflect this.

Everything else is implied by the above. The reader understands
implicitly that changing the types in the structs is a natural
consequence of changing the signature of parse_exclude_pattern(), thus
need not be stated explicitly. The bit about compiler warnings and
such is equally obvious and need not be mentioned.

One other comment: In this project, I think it is more common to give
these "flags" variables type "unsigned" rather than "unsigned int".

>> In the end, running make to build didn=E2=80=99t produce any more wa=
rnings, and
>> running make in t/ didn=E2=80=99t produce any breakage that wasn=E2=80=
=99t =E2=80=98#TODO known
>> breakage=E2=80=99.
>
> For the tests it is, from what I've seen, just assumed that you ran t=
hem
> (and the reviewers/the maintainer will confirm this for themselves), =
so
> no need to mention it. But it's good you ran them.
>
>> I also thought it=E2=80=99d be helpful to add the comment /* EXC_FLA=
G_* */ next
>> to `flags` of `exclude`, just like it exists for `flags` of `pattern=
`.
>
> I would reformulate this as well more direct to something like "when
> we're at it, document exclude->flags as EXC_FLAG".

Yep.
