Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C2313B298
	for <git@vger.kernel.org>; Wed, 16 Oct 2024 21:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729113429; cv=none; b=D8Rotdwj1z8B59o87tbkwWOlHToCz/GZ1fgRzY946UfsXSJ9TO/K8ylODpktLoECrSr8fs/y1TLfisgdz0bYv1knVG9OAgix3GrPl2KKvbL0k1EqqyAcO9vXiACV70bL5ipOnovLcm5uPBtTYLi/AWphtjrzckQlrVXqgHRyXMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729113429; c=relaxed/simple;
	bh=IDyg7eTWfnlc+oV0/jusKLdcwadGN4PAVPWElo7babE=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C9lR1lW3EUnnLGXf9X/y9SZ5672URvLm8764Qj71APD3yG2kCG4GINQ2W1GtKeOkvb21/KtTBZ5dK5Q95ulqqS0gZvE6E++ngsWLIRDzoaOkcGRe0e4Oo8+5vq4lNocoJUpWB315Lr/N7Q/tVaAKoOHrS3Vz61BnCK3gsGzynYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E2cI/vR6; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E2cI/vR6"
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-50d31c41618so94361e0c.1
        for <git@vger.kernel.org>; Wed, 16 Oct 2024 14:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729113427; x=1729718227; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=qyWztn0fmo8ME3RgPlkFrCw1nnEqUomrPFCS306e2aU=;
        b=E2cI/vR60offrsVuoc71pVA+6r5XVfutLhYI4M7Q5jKSggJdNNtqph2swtb9idA9hq
         9Z6KnfuTTOG4G7FB+6qNWm/tinFt3Lo9tjp9LbNBS/HE82OPTtCvy68v+GSzX4LyYDmt
         yB6/r400BV6usYTyQia99vQEXD+sq25VIis2I+77EZTke/hlaCTzhj89wtpQTnVnKGIQ
         CYtJ4bxVYzsfmm9xRfubzuBbj1Lljtdhbb2ymyq60v9prUthiwBdotUggMfX5MnA+v5h
         yPjxgjezsZFk8ScpOiVtMaTXIbbwwosjDQor08YdZZ2OjP6U4puZz1VnJLRnTbm/QMv7
         Rllg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729113427; x=1729718227;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qyWztn0fmo8ME3RgPlkFrCw1nnEqUomrPFCS306e2aU=;
        b=J8VntX/2RisUqCaywNWsEX4dXWs8BnYgw4s5r/4C1inPh0dAVZL2ktTshxMA0PFR6+
         b3QOra1dzpFhfhkgkFdnRUM7NfuyWXjhfDl4qNwoFg/zILWMokOIfQMAAMAfHSyEpUuK
         BaFCLSCxoO1NZVCm5m1OTrZIvO9rGRgsBnA+MpIz0fZ8n4zrdcUf/X88T2t0WjebLF6D
         7Yy4J13ZCYHwBxiGKer3hT9BggW+rEeW29mgPTIBmUDFPXOGKNOfsG8pRzLc/wVWiby+
         tWIT01Tw4j6TvV1bzJiRR8+iwj6cMk3nYlSHDgdMmrvO4N2TwkFIMHyp4ap+fror1qR2
         4pvA==
X-Gm-Message-State: AOJu0YxUyVrVbho0NZqbiATu1BAj1r8TQ7Iri7dMj+Z7wD3e2zrxFW2E
	8IrV4sLkWk2ABhFuopSsFzA8Wa9i58Ilspyh/uffwszv0XHRJPEcrlzCh6Nze5XvcUMPiCPsA+d
	/qFN74aTo9yCjgPcsVLx8oawiDZw=
X-Google-Smtp-Source: AGHT+IGNWvCdWQ3iQHpGhVR3AxMLGRyycvgwylqWd7jEIKsIfL/0zmdAJqe0HChgjG1wze6/HetBD/y0XF15VU9+Edw=
X-Received: by 2002:a05:6122:32d0:b0:50d:39aa:787b with SMTP id
 71dfb90a1353d-50d39aa79f7mr14400673e0c.0.1729113426496; Wed, 16 Oct 2024
 14:17:06 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 16 Oct 2024 16:17:04 -0500
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <CAO_smVjXkpaJOKyvg_mVqxpoK5C=kVpcfGWEH5qC4vfQS=rTgg@mail.gmail.com>
References: <cover.1728697428.git.karthik.188@gmail.com> <74bbd2f9db1ddfd5210be8fde2db84f67acff27d.1728697428.git.karthik.188@gmail.com>
 <CAO_smViSU5KohOqVXp2L_cM3G-jrOGQY=J=qf=-GbiGsOYd9TQ@mail.gmail.com>
 <CAOLa=ZT0qsG7cnnzwg7GDkBuTqZO_e+C5HwT5o9kWZ1Cto=0kg@mail.gmail.com> <CAO_smVjXkpaJOKyvg_mVqxpoK5C=kVpcfGWEH5qC4vfQS=rTgg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 16 Oct 2024 16:17:04 -0500
Message-ID: <CAOLa=ZT-XiadQoUsvhrQO1ts-S9RQMUUyxzbR3Dd2reFQkU8yw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] clang-format: re-adjust line break penalties
To: Kyle Lippincott <spectral@google.com>
Cc: git@vger.kernel.org, gitster@pobox.com, jltobler@gmail.com, toon@iotcl.com, 
	johannes.schindelin@gmx.de
Content-Type: multipart/mixed; boundary="000000000000902f0006249e97e8"

--000000000000902f0006249e97e8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Kyle Lippincott <spectral@google.com> writes:

> On Tue, Oct 15, 2024 at 5:37=E2=80=AFAM karthik nayak <karthik.188@gmail.=
com> wrote:
>>
>> Kyle Lippincott <spectral@google.com> writes:
>>
>> > On Fri, Oct 11, 2024 at 6:50=E2=80=AFPM Karthik Nayak <karthik.188@gma=
il.com> wrote:
>> >>
>> >> In 42efde4c29 (clang-format: adjust line break penalties, 2017-09-29)=
 we
>> >> adjusted the line break penalties to really fine tune what we care ab=
out
>> >> while doing line breaks. Modify some of those to be more inline with
>> >> what we care about in the Git project now.
>> >>
>> >> We need to understand that the values set to penalties in
>> >> '.clang-format' are relative to each other and do not hold any absolu=
te
>> >> value. The penalty arguments take an 'Unsigned' value, so we have som=
e
>> >> liberty over the values we can set.
>> >>
>> >> First, in that commit, we decided, that under no circumstances do we
>> >> want to exceed 80 characters. This seems a bit too strict. We do
>> >> overshoot this limit from time to time to prioritize readability.
>> >
>> > I think that attempting to get the weights right so as to avoid cases
>> > where there was an intentional affordance for readability is going to
>> > be essentially impossible. Areas where there's an intentional
>> > disregard for the clang-format-generated formatting should disable the
>> > formatter for that line/region, instead of trying to find a way to
>> > adjust the rules to produce something that's going to end up being
>> > context dependent.
>> >
>>
>> To some extent I agree. But the issue is that clang-format is still not
>> enforced within the code base. So expecting users to add:
>>     // clang-format off
>> will not hold, at least for _now_.
>>
>> So the next best thing we can do is to get the format rules as close as
>> we can to the current styling, so the actual errors thrown by the CI job
>> is something we can look at without containing too many false positives.
>>
>> > Example: In ref-filter.c, there's 13 lines when initializing the
>> > `valid_atom` array that are >80 characters, and 20 lines that are >80
>> > columns (when using 8-space tabs). Line breaking in that block of code
>> > may be undesirable, so just disable clang-format there. I don't think
>> > there's a consistent set of penalties you could establish that would
>> > handle that well without mishandling some other section of code.
>>
>> While true, we can quantify if it is better or not:
>>
>>       =E2=9D=AF ci/run-style-check.sh @~50 | wc -l
>>       4718 (master)
>>
>>       =E2=9D=AF ci/run-style-check.sh @~53 | wc -l
>>       4475 (with these patches)
>>
>> And looking through the other changes, those look like violations which
>> should have been fixed.
>>
>> > It's also not clear what the reason for the overshoot is in many cases=
.
>> > - difference between "80 characters" and "80 columns"?
>> >     - (1394 >80char lines in *.{h,c}, 4849 >80col lines in the same fi=
les)
>> > - intentional for readability?
>> > - refactorings pushed originally compliant lines out of compliance?
>> > - no one caught it and it was just added without any intentional decis=
ion?
>> >
>>
>> I agree with your inference here, but I'm not sure there is a smooth way
>> to have this information. Either we go full in and say we enable the
>> formatting and every patch must conform to it, or we simply keep the
>> clang-format as a warning system. Currently we do neither. I'd say we
>> should be in a state to reach the latter and then we can gradually think
>> of how to move to the former.
>>
>> >> So
>> >> let's reduce the value for 'PenaltyExcessCharacter' to 10. This means=
 we
>> >> that we add a penalty of 10 for each character that exceeds the colum=
n
>> >> limit. By itself this is enough to restrict to column limit. Tuning
>> >> other penalties in relation to this is what is important.
>> >>
>> >> The penalty `PenaltyBreakAssignment` talks about the penalty for
>> >> breaking an assignment operator on to the next line. In our project, =
we
>> >> are okay with this, so giving a value of 5, which is below the value =
for
>> >> 'PenaltyExcessCharacter' ensures that in the end, even 1 character ov=
er
>> >> the column limit is not worth keeping an assignment on the same line.
>> >>
>> >> Similarly set the penalty for breaking before the first call paramete=
r
>> >> 'PenaltyBreakBeforeFirstCallParameter' and the penalty for breaking
>> >> comments 'PenaltyBreakComment' and the penalty for breaking string
>> >> literals 'PenaltyBreakString' also to 5.
>> >>
>> >> Finally, we really care about not breaking the return type into its o=
wn
>> >> line and we really care about not breaking before an open parenthesis=
.
>> >> This avoids weird formatting like:
>> >>
>> >>    static const struct strbuf *
>> >>           a_really_really_large_function_name(struct strbuf resolved,
>> >>           const char *path, int flags)
>> >
>> > Is this how it'd be indented without the penalties, or would it do
>> > this, with the function name indented the same amount as the return
>> > type (which is, in C, probably going to be the 0th column most times):
>> >
>> > static const struct strbuf *
>> > a_really_really_large_function_name(struct strbuf resolved,
>> >         const char *path, int flags)
>> >
>>
>> It will be indented, so not the 0th column.
>
> I'm not getting that behavior when I try it. Is this only indented
> with your updated penalties?
>
> Currently on ef8ce8f3d4344fd3af049c17eeba5cd20d98b69f, git status is
> clean, added this line (no line breaks, just in case my email client
> makes a mess of this) to top of path.h (chosen arbitrarily):
>
> static const struct strbuf *a_really_really_large_function_name(struct
> strbuf resolved, const char *path, int flags);
>
> and ran `clang-format path.h | head -n20` and got this (where `int
> flags` is indented to align with the opening `(`, but tabs cause
> problems yet again):
>
> static const struct strbuf *
> a_really_really_large_function_name(struct strbuf resolved, const char *p=
ath,
>     int flags);
>
> `clang-format --version` shows it's a google-internal build, but it
> still respects the .clang-format file, so this shouldn't matter? I'm
> assuming it's a relatively recent (within the past 1 month) commit
> that it's based off of.
>

You're absolutely right, this is also what I get. Sorry for the
confusion, but I assumed you were talking about the third line, i.e.
`const char *path, int flags)`.

I also ran it on the CI to make it easier on the eyes (specifically with
the tabs): [1]

>>
>> >>
>> >> or
>> >>
>> >>    static const struct strbuf *a_really_really_large_function_name(
>> >>             struct strbuf resolved, const char *path, int flags)
>> >
>> > Personal opinion: I prefer this over the version that has a single
>> > argument on the first line. My preference for reading functions is:
>> >
>> > return_type func_name(arg1, arg2,
>> >                       arg3, arg4,
>> >                       arg5, arg6, ...);
>> >
>> > Or
>> >
>> > return_type func_name(
>> >         arg1, arg2, arg3, arg4,
>> >         arg5, arg6, ...);
>> >
>>
>> I'm mostly basing my changes on the current state of the 'clang-format'
>> and our code base. I'm happy to change it if everyone agrees on this :)
>
> I'm wondering if tabs have caused some confusion here... [thought
> continued below]
>
>>
>> > or, in some cases, putting every argument on their own line (typically
>> > when the majority of the arguments are already on their own line, not
>> > having one "hiding" somewhere is preferable, but at this point if
>> > that's not what my formatter does, I don't fight it).
>> >
>> > For functions that accept an obvious first parameter, such as
>> > `strbuf_add`, maybe having the first parameter on the first line is
>> > acceptable/desirable, since it's "obvious" what it is/does. But for
>> > many functions that's not the case, and needing to read the end of the
>> > first line, potentially beyond the 80th column, feels weird.
>> >
>> >>
>> >> to instead have something more readable like:
>> >>
>> >>    static const struct strbuf *a_really_really_large_function_name(st=
ruct strbuf resolved,
>> >>           const char *path, int flags)
>
> Does this have `const char *path` aligned with the opening `(`? if so,
> then that matches my first example and I'm fine with it.

Yes, it is. Here is a CI job to demonstrate. I hope this makes it
clearer: [2]


> If this is
> truly "first argument immediately after (, other arguments indented
> one indentation level", then my original comment stands: I don't find
> this readable at all, and I don't see evidence of this being an
> acceptable format according to our CodingGuidelines document.
>
> I also don't understand how the penalties would produce t
>

The penalties define when the linebreak should happen. The alignment is
handled by the `AlignAfterOpenBracket: Align` rule we have in
'.clang-format'.

>> >>
>> >> This is done by bumping the values of 'PenaltyReturnTypeOnItsOwnLine'
>> >> and 'PenaltyBreakOpenParenthesis' to 300. This is so that we can allo=
w a
>> >> few characters above the 80 column limit to make code more readable.
>> >
>> > A few examples, such as by formatting the code using the current rules
>> > (since much of the codebase does not currently comply), and then
>> > changing the penalties and seeing what changes, might be nice?
>> >
>>
>> You mean apart from the example above?
>
> The example above is hypothetical, but I think I was thinking about
> this incorrectly. Our existing codebase isn't formatted with
> clang-format, and formatting it first and then adjusting the penalties
> doesn't really provide much useful information.
>
> Setting the penalties as you have them in this patch, and running it
> on a copy of the line you have there, produces this for me:
>
> static const struct strbuf *
> a_really_really_large_function_name(struct strbuf resolved, const char *p=
ath,
>                                     int flags);
>
> The 80 column limit is still _strictly_ adhered to, it won't even go
> over by 1 character:
>
> static const struct strbuf *
> a_really_really_large_function_named_Ed(struct strbuf resolved,
>                                         const char *path, int flags);
>
> (note: switched tabs to spaces because tabs are difficult to use
> during discussions like this)
>
> Specifically:
> - 80 column hard limit applied
> - return type on its own line
> - continuation arguments are aligned on the next line (which is
> expected since we have AlignAfterOpenBracket set).
>

But this is not what I'm seeing though, even the CI [2] confirms that.
I'm seeing

static const struct strbuf *a_really_really_large_function_name(struct
strbuf resolved,
                                                                const
char *path,
                                                                int flags);

where the consecutive lines are aligned on '('.

(note: switched tabs to spaces too)

Thanks for the back and forth though, I guess I have some feedback for
the next version:
- Add some examples in a file like Toon suggested, showing how the
clang-format would work.
- Clarify the commit message to make it clearer about how the penalties
work with other rules.

[snip]

[1]: https://gitlab.com/gitlab-org/git/-/jobs/8105793089
[2]: https://gitlab.com/gitlab-org/git/-/jobs/8105737945

--000000000000902f0006249e97e8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 10af06063f907f18_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1jUUxVMFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1menYyREFDSUJ4c25DNVBJMUJjaWNSV09OQnhLSm8wZgorM2U5endrZ0lI
aUFBb2gzWFNEak96WHZ5YzFqOGFaQkZPK1N3RHVqLzZOdnIyc3ZxdmZxNDE4dDJBZEpxUGYvClNO
dW9BT3NCSlI0Ky9xWEw0WDNVS3RVTUdKQ3RqWGsyRVN3SFFZQU12UjBTdVdJdWNMeXI1TDg3YWpS
cVVWc2oKOUJEYkF6VngyWTR1MGZFVlc3SXRwWk1ZMEgxaFQwNmpPNVMvVFpqRXY4ZHFVWlM2RTJ5
amxraUFLNXZWNlorMAo1SGtCN1pTeTlUSG9abHhOeUNLc2M0MmJYWkhxU1hidFJVOGNVdWNMQ0I0
Zld5dlYrU05Cbno2SmtkS1JqU3dXCk9TTzZyL1I0WmcxQTk5OGRmK1cwT2NBcDlib1p5Y1RscnQ4
TS90ZHU0V25EVWRkRmorTGxFUko3dUtqYnZHb1MKcDMyanEzVk95WVhpZDhKS01UR2w3MGZsMEdU
YWh6QUc0VnBqRzc0bk9zdVBIcDRBWHRUSkEyNlRBSWJLalZGSgpoZStvL2p4Sy9OTmE3MUtYNGhq
d1RPYWo3VkdQc3dheUtWVEFreDRmRGZyNFM4L0g5eW0rNGVHdGt1c1Q5NHNsCkRreFd1YkpUTVJP
OGpGb0pYcnZhbHZGT1FldGVQK3ErU3RaUUduTT0KPXplb1QKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000902f0006249e97e8--
