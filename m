Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35553612DB
	for <git@vger.kernel.org>; Sun, 12 Jul 2026 17:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783875603; cv=none; b=TxDKh22Q30JqW0fhBSfnKWbD2rF79sByuqLKw0X4w+W8xekwobQYuzsfSt/AJKA3ziVLF4kMWPqd0kRQp1XbeBxEIGoOPPsurM8asMz87wkiSEAFxfhKPhF8dmY6+Q3siBdY6eh+sY1iucpSfxXQBZ7g3CkKxaKo5bSgwz9yg5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783875603; c=relaxed/simple;
	bh=uMMzzVv/fxAn84IK1XOY6dyN5obe6KD/5otONlXrHzU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=soPKcM87ixjUzSHLAHJNuAsJ6oHUO1/YfbiiV8C6nTlRo5mhSsB3Nhmk0i6Wdmav3kOQnQIt2jexsrP9ASnnogW5gfvhcxKArhTwbmjoOqHOzel9gqYtQzWoIAmOpe5NyLcB3F4aaBWoDzuIIgUCiX5Y5gtqzKKKygkbCHN4FbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BSXkCZXZ; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BSXkCZXZ"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-493e8d4f4dcso18731115e9.0
        for <git@vger.kernel.org>; Sun, 12 Jul 2026 10:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783875600; x=1784480400; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=sOiHYuZ13nOgoJ9UQbROledSenKt2jHNovA0j+59SKY=;
        b=BSXkCZXZQ4JRFWuiyNbugHb6HFa4KRa7ebjmXYI5waiTbt+g4Xgbq5QKaUri9SW5b8
         wKnGb2X5eUCfh3y9TLhD5O1/CV4E/9nK2vBDRq9UirOylBSAYmEQI7oISXM38yI33y3s
         /aIFBxXXV+kodzHV7rKvTydHZJfLf1qZNWXd0BoPLtZKKMCrTIvE92j5k4vubNwyXjEa
         LuFNrWP/H5wyKkuGPRgjk5k9bK46qngH+yLXCGGag9GEbGgDClRoat+CotPguOwojZz1
         YxX1nDnnefPYKvxC+6i3cjASEa10netrr8QMZm2NbCV5YT/z4vKqYQv/QanboJWXpVhy
         yjCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783875600; x=1784480400;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sOiHYuZ13nOgoJ9UQbROledSenKt2jHNovA0j+59SKY=;
        b=CUzm26Vm3gGDoGSZsRXCtdtMw/i95oGRjTnDqeVEgcFuapw8ab39nauvakF9RXOdzf
         wI+00hCIumLcoNiK5z5BaQWxa6AHdzT/T4WAWVUce4NqipdlhzcOVz80MbncuTgUN4Vc
         dv/c9559TPOzePuCpXy4XzS1U8jm37aOo7stRJzDnNDGx694RhcVtYeBFAIkMLrb3nAM
         n9e8CIVsLqtqj8OxubGpx2NBC52zjSVW5YxYfBccLmyPuNBszA2CH2s5QoS8DBW67P6M
         JTOLbv1lMPDSZtQTm/gdelZgVQwgXqAvor2xIMGcr0VmpZsqcXAaSBR3CkvuMHVn+qli
         LV+A==
X-Forwarded-Encrypted: i=1; AHgh+RrM4wL12QjvJHGexCmzvHIgsqT7A12u0XzADjsy/XskjYYmOXkuuY4/2GiyglVI+tsTQOo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8m2+pV+5f4a0FVkspn9AStAwp9HJ1Z68ZmfGAFv6rKKppu8Tf
	fLLJMEujB/epcbgX+HgjUPFXmS/vGOW9MaFJ9EGBq6HsMXLA+0Zgj/lNUqpqDMGp
X-Gm-Gg: AfdE7cnhr3RwtiISt2eI3mMLrP3tZERg67wcBTdy2xdfk4fEktV4Jh5W+yU5sMnPjtW
	OvYr9ualOSL7PTwz+WRafDvYeQyTtRsIjEJUBND2b67/FhC8be4yn8ew5z3cAVAhxlw9ogESvzn
	QNxHbAZ1QvIthNGv/mr1O81OHQT2ZNdoivZDKOnX1kOBURLKPhVNqlG/U3fVk0C8ttomxArHr0m
	iKsJIehnseEzYamqiDFEJtLkmD/HQ1qbt8y4Adf0liTuAWIsiTm1ZBiC2TjE0lRG2khQpEMMawV
	u3rdfX32HgD87luuKeZznxokXYVFwoIM4EKPX2UFubnoDPclHkEBVpK/IDeSuX0+sWC9z9IWCmG
	+RyzdhSqQOtpFjJBE+RHUHbFJX5SEPRBnYHY7krC6KJ8cwIYB2Cu6dANI5f240S2Vef9463Ydsc
	YQ05H9nLql2C3do/GgytmTgHAy59WX0G6bY3dvdm8PUn026pZ+pZpZCHELMKee9diYmsgWuLf9m
	UQr7zZpek2n3O0ZWd8M3AbLX00f+ms+/Ot3RUpSWG6mVRWmXIu427Pj99FnrY0nf9umJ8dknuY3
	wyxFWX8P4Fe8ckbyga279KKcxoO5VJqrRuqtEqlZoD533y+E2FRWvLewcXtPPiZYwBtUeg==
X-Received: by 2002:a05:600c:828d:b0:493:b307:6777 with SMTP id 5b1f17b1804b1-493f8824389mr53469835e9.22.1783875599773;
        Sun, 12 Jul 2026 09:59:59 -0700 (PDT)
Received: from localhost (62.174.240.101.static.user.ono.com. [62.174.240.101])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb6f373csm500833425e9.14.2026.07.12.09.59.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Jul 2026 09:59:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 12 Jul 2026 18:59:58 +0200
Message-Id: <DJWR4GEV14P4.3G9N0ZL1R8VDL@gmail.com>
Cc: "Pablo Sabater" <pabloosabaterr@gmail.com>, <git@vger.kernel.org>,
 <ayu.chandekar@gmail.com>, <christian.couder@gmail.com>,
 <gitster@pobox.com>, <jltobler@gmail.com>, <karthik.188@gmail.com>,
 <krka@spotify.com>, <peff@peff.net>, <phillip.wood@dunelm.org.uk>,
 <siddharthasthana31@gmail.com>
Subject: Re: [PATCH v9 0/4] graph: indent visual roots in graph
From: "Pablo Sabater" <pabloosabaterr@gmail.com>
To: "Mirko Faina" <mroik@delayed.space>, "Chandra Pratap"
 <chandrapratap3519@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260710-ps-pre-commit-indent-v8-0-d3b636463bf4@gmail.com>
 <20260711-ps-pre-commit-indent-v9-0-eab6676e82f7@gmail.com>
 <alJOgYmAfGg37hsB@exploit> <DJVUU76PUXR4.2BYRTA8SEEBVC@gmail.com>
 <alJpjTXfZmYQccwk@exploit>
 <CA+J6zkQcHu-LVKE-1ypfT=59gEzo4qBzi-pmhSJNC_udCDCJZg@mail.gmail.com>
 <alOOXKGIB8BqACxR@exploit>
In-Reply-To: <alOOXKGIB8BqACxR@exploit>

On Sun Jul 12, 2026 at 3:10 PM CEST, Mirko Faina wrote:
> On Sun, Jul 12, 2026 at 11:26:27AM +0530, Chandra Pratap wrote:
>> Tying graph-drawing logic to specific formatting flags could introduce
>> inconsistencies. For example, if a user relies on a custom format like
>> --format=3D"%h %s", the output is functionally single-line and suffers
>> from the exact same ambiguity, but it would miss the fix.
>>
>> Even in multi-line formats, relying on the absence of a '|' character to=
 spot
>> unrelated commits requires active effort. Indentation provides an immedi=
ate
>> visual cue that breaks the vertical lineage, which is helpful regardless=
 of the
>> commit message length.
>>
>> I agree with Pablo: for users who strictly want the old behavior, an opt=
-out
>> flag keeps the graph logic decoupled from the formatting logic.
>
> In that case, together with --[no]-graph-indent, a configuration
> variable like "graph.indent" could be introduced to reduce the usage of
> --[no]-graph-indent for those that would like to retain the old
> behaviour for most formats.
>
>> > > Apart from having an option to disable indentation.
>> > >
>> > > We could have the cascading to have a limit or make it zig-zag:
>> > >
>> > > instead of:
>> > >
>> > > A
>> > >   B
>> > >     C
>> > >       D
>> > >
>> > > We could do:
>> > >
>> > > A
>> > >   B
>> > > C
>> > >   D
>> > >
>> > > This would have its own edge cases like:
>> > >
>> > > A
>> > >   B
>> > > C <- if we zig-zag here C and D become ambiguous, currently we are
>> > > D    indenting only the last commits (visual roots) here we would ha=
ve
>> > > D    to chose between continuing cascading or indenting the first of=
 D.
>> > >
>> > > I'm not so sure if I like the zig-zag solution because we need to th=
ink again
>> > > if it causes an ambiguity, but I wanted to mention it.
>> > >
>> > > I think we need some more opinions about the design.
>> >
>> > I don't dislike the the current solution but I can see it degenerating
>> > if someone contributes a lot of one-patch series.
>> >
>> > Maybe you could indent commits that are both head and tail up to two
>> > levels and then on the third go back to the beginning of the line. Tha=
t
>> > way you kind of have a zig-zag but without ambiguity. You'd only have =
to
>> > add a counter to keep track of the level of indentation.
>>
>> Not sure about this. A zig-zag pattern visually mimics branching and
>> merging, which makes unrelated commits look like a complex merge topolog=
y.
>>
>> I also have a feeling that this will end up recreating the exact ambigui=
ty this
>> patch series is trying to fix.
>
> While a zig-zag pattern might be ambiguous, what I proposed is a little
> different.
>
> What I proposed is effectively a wrapping for anything that goes beyond
> two levels of indentation. I don't think it would look anything like a
> fork/merge pattern.
>
> * A
>   * B
>     * C
> * D
>   * E
>     * F
>
> The difference between two indentation levels and no indentation is very
> noticeble, I don't think anyone confused this. This would fix the
> staircase pattern on adjacent one-patch series.

I agree that having an infinite stair is not a good solution. the 3
column wrap looks reasonable.

I see two cases with this wrap:

1. No conflict case:

  A
    B
      C
  D
    E
      F

No ambiguity, this would be the ideal case.

2. Ambiguity:

If it happens that the visual number on visual roots meet the condition
(number_of_visual_roots % 3 =3D=3D 0) and the next commit is NOT a visual
root this would happen:

  A
    B
      C
  D
  E
  E

Which would be ambiguous. The solution is to check with the lookahead
buffer that we have since patch 3 if the next is a visual root, if it's
not we indent D anyway:

  A
    B
      C
    D
  E
  E

Which I find the pyramid effect uncomfortable.
What about capping at 4 columns?

1.

  A
    B
      C
        D
  E
    F
      G
        H

2.

  A
    B
      C
        D
    E
  F
  F

I prefer the 4 column wrap because it looks more abrupt and IMO shows
better that the commits are unrelated.

What do you think?

Also, about the no-opt option "--no-graph-indent" is still wanted
regardless of the final design that we choose?

Thanks,
Pablo

