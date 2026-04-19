Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E9941760
	for <git@vger.kernel.org>; Sun, 19 Apr 2026 19:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776625960; cv=pass; b=kpCG0fhilSlERKJ8M3N9mdd367WpX69kGv2vgu8W4BmsZkhXNa6oW2imkrbdXqNfSaaedHKBz0cFx/hh/B0iV+ce1ZwJRJNGWs0CX0VoAbF75nM/b3kdUKJe0/LS/+lpqxDeXRIioeiaoelIQdTugWTBk2vzYpL44gKy187RCcM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776625960; c=relaxed/simple;
	bh=/z29xzOeACyd/VyrcgTf9HYdzgTzpOwCINAR50un5f4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ltzh/3KSC7Avi/Pbq/HPOFTvHuxC4u6Gty1ReHTDRJoQiKlKFsystH0NQK/8CqO4H18fWYOAvWuRBIAxhHyohKF4DV7WtBpK//5nDEXStwSak1wCJpnv2A6T+N/afX2fy/jCVcrlzyUIv3YFHqpstCBH30Oo1o3tp5wYSZeu5Og=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D3qIFyo1; arc=pass smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D3qIFyo1"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ad4d639db3so12154025ad.0
        for <git@vger.kernel.org>; Sun, 19 Apr 2026 12:12:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776625959; cv=none;
        d=google.com; s=arc-20240605;
        b=TQCLjaXE1atU0n8nSW3N9xECeWKH7Zj0pSbuCfmD48GJGzWwLxgsyxjH32qykGn72T
         QMSiSAwF9gF50d9BvIq5PlVPsYXA8gJ4OaAR6xcDOtNFubhx1AtNj4kJ0LSKBS89P3Br
         1dB3UNdhMjQLEOIFvakJj1D79rpzNy/DLTJ9SudgWVfT284+6BGJoNAbeHAWWd3ZgdtA
         yVEcMSTQN1o2j5ec2AkJZ4anp8c0YL6CmTI4xl1XB931vdhwBGFBgVdnqTyGGJc4B7Xs
         UJvXbDKV5HEBbs8tZtl5PqjGqp2xlyguOuF/wc0nDkj4VInVL2r8VSTNmpSYZ4pbKplT
         UBYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QgxSyBYIWOohcjlsbbSg77aqYKZBbrPhM8slOsZRQoE=;
        fh=YRp4XrKOda7rMviyQmVtSvJ26XINAn4+UTwSfHRS0Hg=;
        b=JzD+TF7V8KzuteMTAZx/i4z1gPOs9J8reuUtL6oZSRr1tNN0+evejo1Mn3QJmQ7hwP
         welcIsvzrTiMxtkO935ZFpyJrj2xOOXqn+ICRtTboQ2pRTyzv63trMGRPuYw8tiAKWHr
         idLKYHzOemehq7XHDIzfpXNNdyP871r14TL50TemH+Jl1Uu2wYf0ip1rBKRH/uA/jW6m
         zi17d+uT0wUMsQz4//Mwav9lvN6RdUl+24uzUs+jsqgcOcIXKx9lQ2eF6m+vfUKq9lDi
         peC9I6AhCcxredlOstFoIDNgyNU/j47sfBjxDGZBAcAF3Vd2pcSPyNK4hmaCLWNO2aoQ
         Wr9w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776625959; x=1777230759; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QgxSyBYIWOohcjlsbbSg77aqYKZBbrPhM8slOsZRQoE=;
        b=D3qIFyo1C2iDpHFrutI/lz1I/VksJTn4hoSKlEAzmfZzgzD3Wg6Y6Zn3FKTFj4y7EM
         PSSsK5MqiRzvDa4VzHn+RL4UDWZdXJt7xUClokDjJPnbDOZv3ddUUF2FYAFQV3dl0jyL
         JxIkqkSgujf08J/CqtQtxOGYQIPPcUyOnwX1z3Vaw0odtYzSY/UMMc5tGzkduo2oiYl+
         1H0wJiyz0zAX+SSAHmW45CdLJ5jz6fmEuTqRhNcph3Os4K3LQyNXs9O2IZi3IFoNuDYA
         RRzUrVL2k1kVhdbsv6CWOEwN8pxmqq90AxSEVbzH6EVerUFPUmOrf4E9/KhSnpU1fNwq
         wRoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776625959; x=1777230759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QgxSyBYIWOohcjlsbbSg77aqYKZBbrPhM8slOsZRQoE=;
        b=SRP/SXpMSbBTgttqSM3SYVlc/cRQp9IMlQgesTFqBN58U5EBpy761yA9stsAmiXAhk
         CW6N7+1mNRamBxvRImz2+Xkypl77f/Ww0rm+HHpACkFjQmfxXtNcJWdNuCJr3Ul/nnsq
         J6qpXwGwfl1j4pSH+VVL25bOpfqnypVNlNXgxvRa4611HkD62A+/3suawkTpgQ6efs0/
         mdztgIilKK7TNEpsSLUTLsPlPWbB6o/Lm1inMejnY9mVfwilbTQN2eo1qzdOkqcW+54M
         8OYf9JilKAv3xJmwfZTwsupag2QfDO3eJetoQJws708gQV4ZE9jH+8oui5QD5UIeufJX
         nneQ==
X-Gm-Message-State: AOJu0Yz5IwPoeLQxBvAkCnWgNjoCEWOkJqZReEDgXrQ/LDUBIUZWtPrD
	bLcxG8n6GdbV6AtqsjCyr6LTQ87BwV8BEq0LeSUEjwiMWIb0DnmrkC9OBqNMkzakuH1K5O2y2h0
	T42QC3deKaq6oIZrWzSEB5Pd5IjYW6wQicIHf
X-Gm-Gg: AeBDietWGHL5zyrXVj/dE3Dua+2gMjxY4/WJfnIIy5ADlWMS/t0K+wjC3kGGLsagA55
	Z62jEIFlrxYLRA10tHdP/Hywyf8zfPap2uZZUQNvXuVnY4rcPkXJ840+Pt9g3KoqRsliX9JcBAo
	+ze9+oKkNK9wXrjKg39zVqbBj/JlNop5bz1Gh6ghcGDrbe4hLdaQGjIu9XIOzhomNfOixDOAn/h
	OlDGb4yZCYaODnhq3YAYeFyg6xRoGEIZTF6+F+KBtAkK3Vs0z4J+Zy5VZgL5zLghQ2nz4w/vaMm
	C7kNVdF4aJtR1vgymFlPK3BxLt2qGabGk0HludvM6KEszPn6eXn4dkT05oAiLAoYFLdcflCYd7l
	H+riDVL9wkSWABbEtJ4OtyM5gvyYDsuiUM8sciw==
X-Received: by 2002:a17:902:e746:b0:2ae:504c:ae8a with SMTP id
 d9443c01a7336-2b5f9f08601mr134289935ad.16.1776625958695; Sun, 19 Apr 2026
 12:12:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260418164736.2367523-2-mroik@delayed.space> <C60EE993-97DA-45F7-89DE-2F97ABB0F685@gmail.com>
 <aeUZUqSQI8FvRUco@exploit>
In-Reply-To: <aeUZUqSQI8FvRUco@exploit>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Sun, 19 Apr 2026 15:12:27 -0400
X-Gm-Features: AQROBzAVFgEqzdJdjkfAuyxWvgIehP-LvAFlp42K5ekhfcF4kE5YMLUg7JphWWE
Message-ID: <CALnO6CACfSyzyguX4623Dk3y+QEM_Dbmfko8dTyM1p3JxBjZFg@mail.gmail.com>
Subject: Re: [PATCH] revision.c: implement --reverse=before for walks
To: Mirko Faina <mroik@delayed.space>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, 
	=?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>, 
	Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 19, 2026 at 2:11=E2=80=AFPM Mirko Faina <mroik@delayed.space> w=
rote:
>
> On Sun, Apr 19, 2026 at 08:06:24AM -0400, Ben Knoble wrote:
> > The original handles multiple reverse options inverting each other=E2=
=80=A6
> >
> > > +    } else if (starts_with(arg, "--reverse")) {
> > > +        if (!skip_prefix(arg, "--reverse=3D", &optarg)) {
> > > +            if (argc < 2) {
> > > +                revs->reverse =3D 1;
> > > +                return 1;
> > > +            } else {
> > > +                optarg =3D argv[1];
> > > +            }
> > > +        }
> > > +
> > > +        if (!strcmp(optarg, "after")) {
> > > +            revs->reverse =3D 1;
> > > +        } else if (!strcmp(optarg, "before")) {
> > > +            revs->reverse =3D 2;
> > > +        } else {
> > > +            revs->reverse =3D 1;
> > > +            return 1;
> > > +        }
> > > +
> > > +        return optarg =3D=3D argv[1] ? 2 : 1;
> >
> > =E2=80=A6which I don=E2=80=99t see here.
> >
> > I=E2=80=99m not familiar with this parsing code though so I can=E2=80=
=99t add much about the test other than to say it is a bit hard to follow :=
/
>
> Given that it is no longer binary handling multiple reverse can't simply
> be inverting bits, it wouldn't make sense. This is done before the walk
> itself, so even from the POV of the user it wouldn't make much sense to
> reverse multiple times as the order of the applied options before this
> patch (commit limiting options then reverse) doesn't change.
>
> This doesn't break any tests so I assumed it was fine.

I think I mean that

    git log --reverse --reverse

shows commits in the same order as "git log"; what should

    git log --reverse=3Dafter --reverse

do? Or what about preserving the behavior of the original "git log
--reverse --reverse," which I don't think is done here?

Granted, I don't see this ability documented, and I cannot tell how
many may scream if we change this behavior, so it's a bit
hypothetical. But there is an argument for backward compatibility as a
default, which I think we'd need to justify changing. Perhaps in the
proposed log message?

(The original seems nonsensical to type, but of course you can imagine
alias.A=3Dlog --reverse <other-stuff>, and then sometimes you want to do
"git A --reverse" to un-reverse the commits.)

> > >    } else if (!strcmp(arg, "--children")) {
> > >        revs->children.name =3D "children";
> > >        revs->limited =3D 1;
> > > @@ -4525,19 +4543,35 @@ struct commit *get_revision(struct rev_info *=
revs)
> > > {
> > >    struct commit *c;
> > >    struct commit_list *reversed;
> > > +    int max_count =3D revs->max_count;
> > > +
> > > +    if (revs->reverse && !revs->reverse_output_stage) {
> > > +        if (revs->reverse =3D=3D 3) {
> > > +            BUG("allowed values for reverse are 0, 1 and 2");
> > > +            revs->reverse =3D 1;
> > > +        }
> >
> > Is this possible? I guess I can see from the expanded bit width that it=
=E2=80=99s a valid input, and there=E2=80=99s no protection stopping other =
callers accidentally adding this.
>
> Current code should never generate a 3, but in case it happens I assume
> the user wants to use the original behaviour of reverse, so I set the
> value accordingly instead of stopping the program and notify that
> there's a bug.
>
> Should this be changed?

I don't have any strong opinions on this.

> > I haven=E2=80=99t looked, but it would be nice if we could use an enum =
instead. Unfortunately that would probably take up more space in the struct=
, and I suppose the bit-packing is done intentionally for performance.
>
> Could define new macros so that the readers don't have to mentally keep
> track of which value rapresents what. I didn't think that was
> necessary, should I change it?

Yeah, a few `#define`d constants would make things more readable to
me, at least, since we can't use the enum without space concerns
(unless there's a way to bit-pack the enum to only 2 bits?).

> > >    if (revs->reverse_output_stage) {
> > > +        if (revs->reverse =3D=3D 2 && revs->max_count =3D=3D 0)
> > > +            return NULL;
> > > +

PS: something I spotted on a second read. [Ignoring reverse=3Dafter
mode] This hunk looks to me like a nice little optimization (return
nothing if we know max_count says we yield no commits). Of course, I
could see that being viable early in the function, right? When asking
get_revision for commits, if max_count is 0, just return NULL.

For reverse=3Dafter mode, this condition is only true if the max_count
was 0 in the previous conditional, also, since we use max_count=3D-1
before iterating get_revision_internal. That means the original
max_count isn't touched. At any rate, it _seems_ to me that the whole
function could benefit from this optimization=E2=80=A6 but I wonder if it i=
s
_necessary_ for correctness of reverse=3Dafter in some way that I'm not
seeing? Since the current version doesn't need the early bailout, why
does reverse=3Dafter?

> > >        c =3D pop_commit(&revs->commits);
> > > +        if (revs->reverse =3D=3D 2)
> > > +            revs->max_count--;
> >
> > Hm. Why do we decrement here? Again, not an area I=E2=80=99m familiar w=
ith, but a bit surprising.
>
> get_revision() (in revision.c) handles the reverse option and updates
> the "struct git_graph". get_revision() then calls
> get_revision_internal(), which handles commit boundaries and max_count,
> here is where it gets decreased. Since max_count gets decreased
> everytime get_revision_internal() is called, if we were to leave
> max_count as is before the walk (in get_revision() at line 4558), the
> walk would stop before reaching the root commit. This is why the current
> --reverse option is applied only after commit limiting options. So
> instead we set max_count at -1 walking the whole history and storing it
> in 'reversed'. Now we're in "reverse_output_stage =3D 1", and in this
> state we never call get_revision_internal() again, instead we pop
> commits from 'reversed'. Because of this we have to handle max_count
> outside get_revision_internal(), so we decrement it in the snippet of
> code you referenced.
>
> A bit verbose but hopefully it'll get my point across.

I don't 100% follow, but I'm out of my depth :)

I think I see that get_revision() effectively has 2 modes pertaining
to reverse: reverse and reverse output stage (the former falls
directly into the latter, though).

After some setup, the reverse mode calls get_revision_internal() as
you said. That decrements max_count as a way of counting how many
commits we've seen through the loop, so if we asked for 5 we'd only
process 5 commits.

Then we fall into the output stage mode, which pops a commit [1].

With this patch, in reverse=3Dafter we disable max_count in the first
(reverse) mode, as you said. Ok: we get the whole (filtered) history
then, at which point we can now shrink. That makes sense.

Then in the reverse output stage mode, we pretend to have one less
max_count. That's what I can't figure out. Is it because of the
pop_commit()? I guess I'm not totally seeing how that interacted with
the max_count in the original code: does the current code yield one
extra commit in get_revision_internal() ?

You wrote that "we never call get_revision_internal() again," but I
don't see why that's true with this patch and not true before it.

I do agree that _somebody_ has to handle max_count after
get_revision() returns with reverse=3Dafter. I'm just not sure what

    if (revs->reverse =3D=3D 2)
        revs->max_count--;

is doing.

Of course if I'm the only one confused and others make sense of it,
that's ok, too.

> Thank you

Thanks!

--=20
D. Ben Knoble

[1]: I traced this to 498bcd3159 (rev-list: fix --reverse interaction
with --parents, 2008-08-29), but I can't fathom what the pop is doing
there.
