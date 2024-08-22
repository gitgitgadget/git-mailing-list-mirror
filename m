Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7207814EC5C
	for <git@vger.kernel.org>; Thu, 22 Aug 2024 07:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724311956; cv=none; b=Sh6vD8yYf8K9be3Eykap0l6/sD97aX8ADZk5bFuB9SJQke3ddwOLwsoHVG+5RJ8W7Ol8vIuyLB9Itz9jMOCT0DTzHcuM8o52G+HALUVi8ZtpD08pMGp+yPiRpo38dNAHYvSGMdqIAD5jetiOTHuS+r/Scx95SKZcF3VY57MlFHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724311956; c=relaxed/simple;
	bh=8aPwA7V49IZeCaSvP2tmTJK8UKeO89XBhSmGKjuACtU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bHKsjC+FlbiLippSKpCYryW0giJ5SfX9kupNYhpYq/W2D8IhPc6kzF1Z15025936fzolEvj8c1EaPlzyxJCK0/nh7sIBtGknMRnkrJCeOh5pG34bP0ff1AU6Aqx7+0Ln3t5XarlmL1K4qo8SNCOeAeBndc69krpISMEl1W1CVDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bkM/+N/W; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bkM/+N/W"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-27020fca39aso330426fac.0
        for <git@vger.kernel.org>; Thu, 22 Aug 2024 00:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724311953; x=1724916753; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OsTw7oUsU354au7YdVgHTGV3GQcC0GK8B0qwS7kqE8w=;
        b=bkM/+N/WNzJv1F3PgxJI9eVayBEDjHwiHXtIZ4PhGMSVIRv4I7C2Fyd7PY+y4cyybn
         GN2oi6fw537yNmGY4PcUIu5IcF4IQGx7R6H3drJffkqGaGqd9QK51n06onerneDbAJeO
         Jy995DcfGfDvf20thO0YRJslR+0TslO2HQy8OBB10bD9V46dn4vrvt4YuiUVP5d9n/fr
         0eBPnvMQFyWLyBbVbmPrT6oyC08njYhPCHmYSyslOdqrkwgBRuDP75bilqIxSWlGvF0R
         wBan1TpaBA0XRI0BxXd2cdcuLbjcNufSp1z+S3gRn1SSEbuhmEVTv4ybHx1RAD/cjo54
         MYZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724311953; x=1724916753;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OsTw7oUsU354au7YdVgHTGV3GQcC0GK8B0qwS7kqE8w=;
        b=l9HGOBEY1elTCLDXGW+Z41qSa6if6e/e8b0vJVuZJ8LpUsara0IY9/d6hfBQAPAH7S
         MXADRyRXQVj4K6KkVBCb0MXg5Fs7LISY6XyJasRD3ONrJM5oZPsl1FOlGSkC+8eyrWB8
         KzbDKDmMPmt+FgAKPVwuK90P0BuP2Pf7xB6C6KM+XQI2MjZODTHUNhgM5RDm6oQXtXXa
         YlsOPW0nNHn5XGfEwDgjUXKY8RavqDydz1UWQa2WCD8qbjOscUaCF9KPPOm9gxHhUpC+
         x6YNbxZXcLrwdQJmT1oip5G/OoRI56ALhhGLldngtHDWfI2czQ09pr3SS3Rml4RxF9lJ
         r4UQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/i1U+Abyr1IZvJlLOpF0fVkXGsd5lk1r3FwGsYhTmSnhlg+9W3hGp5gs92FgHfo3GY1s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1BWRkSf592n1ScemgTbX0KpQibcVTNIx3jXbMUIv9JoUfahOn
	dhD3IkCBvrzjz0oNOgB7s/DmUI9H7qPgUSwry0nLgxnvxir3GL6JO3oyqxiWTyVs7yPBVHm298Q
	6OQM3nZjv0jJES0uSZ0jYaEKXT6E=
X-Google-Smtp-Source: AGHT+IGdlewsTGPe0+nlfMyMjyO+BXzgbmDKqhrCP6iyqSUvHeToODTCR9A4DtPCGABfcYF8qrO+22Z3AEiRBgKJif8=
X-Received: by 2002:a05:6870:46ac:b0:24e:8987:6f34 with SMTP id
 586e51a60fabf-273cfba64ccmr1448414fac.3.1724311953353; Thu, 22 Aug 2024
 00:32:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1768.git.git.1724232485264.gitgitgadget@gmail.com>
 <pull.1768.v2.git.git.1724234729288.gitgitgadget@gmail.com>
 <xmqqa5h5ztd9.fsf@gitster.g> <CAH64z8+dScuQbvu1aHnodE7VpCvgU2djbJhQDff76iyeFtpdTw@mail.gmail.com>
 <CAH64z8KUWSNii_U5k5fAz3q9cu34+pOWk2Rmw-60x7iOKOD8gQ@mail.gmail.com>
In-Reply-To: <CAH64z8KUWSNii_U5k5fAz3q9cu34+pOWk2Rmw-60x7iOKOD8gQ@mail.gmail.com>
From: Ahmed Akef <aemed.akef.1@gmail.com>
Date: Thu, 22 Aug 2024 09:31:57 +0200
Message-ID: <CAH64z8Ji59amg5Y=cBJzFKt_XiB0A5re35g9jHPWS6AoyGpRWw@mail.gmail.com>
Subject: Re: [PATCH v2] docs: explain the order of output in the batched mode
 of git-cat-file(1)
To: Junio C Hamano <gitster@pobox.com>
Cc: ahmed akef via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, ps@pks.im
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> * "as they have been read from stdin"; drop "from stdin" here, as
>   we already know we are talking about the mode that reads object
>   names from the standard input and there is no need to repeat it.

it is needed to explain that git will not do any optimization to the
order of paths
before printing the output. I entered a discussion with someone who was wor=
ried
that git may optimize the paths order because it is not stated clearly
that output follows
the same order as input.

> * "considered as an object" -> "considered to be an object name" or
>   "used as an object name" [*].  This primarily comes from my
>   spinal reflex against "consider as", plus my desire to be more
>   precise in terminology.

this is not related to my changes, I just moved this line but didn't change=
 it.


Thanks,
ahmed akef


Thanks,
ahmed akef


On Thu, Aug 22, 2024 at 9:20=E2=80=AFAM Ahmed Akef <aemed.akef.1@gmail.com>=
 wrote:
>
> > * "as they have been read from stdin"; drop "from stdin" here, as
> >   we already know we are talking about the mode that reads object
> >   names from the standard input and there is no need to repeat it.
>
> it is needed to explain that git will not do any optimization to the orde=
r of paths
> before printing the output. I entered a discussion with someone who was w=
orried
> that git may optimize the paths order because it is not stated clearly th=
at output follows
> the same order as input.
>
> > * "considered as an object" -> "considered to be an object name" or
> >   "used as an object name" [*].  This primarily comes from my
> >   spinal reflex against "consider as", plus my desire to be more
> >   precise in terminology.
>
> this is not related to my changes, I just moved this line but didn't chan=
ged it.
>
> Thanks,
> ahmed akef
>
>
> On Thu, Aug 22, 2024 at 9:18=E2=80=AFAM Ahmed Akef <aemed.akef.1@gmail.co=
m> wrote:
>>
>> > * "as they have been read from stdin"; drop "from stdin" here, as
>> >   we already know we are talking about the mode that reads object
>> >   names from the standard input and there is no need to repeat it.
>>
>> it is needed to explain that git will not do any optimization to the ord=
er of paths
>> before printing the output. I entered a discussion with someone who was =
worried
>> that git may optimize the paths order because it is not stated clearly t=
hat output follows
>> the same order as input.
>>
>> > * "considered as an object" -> "considered to be an object name" or
>> >   "used as an object name" [*].  This primarily comes from my
>> >   spinal reflex against "consider as", plus my desire to be more
>> >   precise in terminology.
>>
>> this is not related to my changes, I just moved this line but didn't cha=
nged it.
>>
>> Thanks,
>> ahmed akef
>>
>>
>> On Wed, Aug 21, 2024 at 7:19=E2=80=AFPM Junio C Hamano <gitster@pobox.co=
m> wrote:
>>>
>>> "ahmed akef via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>>
>>> >  If `--batch` or `--batch-check` is given, `cat-file` will read objec=
ts
>>> > -from stdin, one per line, and print information about them. By defau=
lt,
>>> > -the whole line is considered as an object, as if it were fed to
>>> > -linkgit:git-rev-parse[1].
>>> > +from stdin, one per line, and print information about them in the sa=
me
>>> > +order as they have been read from stdin. By default, the whole line =
is
>>> > +considered as an object, as if it were fed to linkgit:git-rev-parse[=
1].
>>>
>>> A few "Huh?" I had while reading the above.
>>>
>>>  * "as they have been read from stdin"; drop "from stdin" here, as
>>>    we already know we are talking about the mode that reads object
>>>    names from the standard input and there is no need to repeat it.
>>>
>>>  * "considered as an object" -> "considered to be an object name" or
>>>    "used as an object name" [*].  This primarily comes from my
>>>    spinal reflex against "consider as", plus my desire to be more
>>>    precise in terminology.
>>>
>>> Thanks.
>>>
>>> Nothing mentioned below should be part of this patch, but as I
>>> noticed it while studying the current documentation to prepare this
>>> review, I'll record them as #leftoverbits.
>>>
>>> The description of how lines read from the standard input should
>>> look like needs more work.  Documentation on "--batch" says "the
>>> input lines must specify the path, separated by whitespace", but is
>>> it clear that it expects "<object name>", followed by a whitespace
>>> (not necessarily a single SP), followed by "<path>"?  Without prior
>>> knowledge, I wouldn't be surprised if somebody read the text as
>>> asking for paths separated by whitespace, e.g.
>>>
>>>     README.txt COPYING Makefile
>>>
>>> that gives three paths.  The text needs to be tightened to say
>>> something like "must give the path after the object name, separated
>>> by whitespace.  The path is used to find the textconv and smudge
>>> filter".
>>>
>>> The section also says "See the section BATCH OUTPUT below for
>>> details." but the section it refers to does not talk anything about
>>> this whitespace thing.  It also is unclear what would happen if the
>>> input line says:
>>>
>>>     :COPYING Makefile
>>>
>>> Would it apply the textconv/filters meant for Makefile to the blob
>>> stored at COPYING in the index?  If we say
>>>
>>>     :README.txt
>>>
>>> would the command be smart enough to know that the blob came from
>>> the path README.txt and apply the textconv/filters meant for that
>>> path, without the input repeating the same information twice like:
>>>
>>>     :README.txt README.txt
>>>
>>> or something silly like that?
>>>
>>>
>>> [Reference]
>>>
>>> * https://www.britannica.com/dictionary/eb/qa/consider-and-consider-as
>>>
>>>
