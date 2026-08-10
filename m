Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3562C3D9DD4
	for <git@vger.kernel.org>; Mon, 10 Aug 2026 12:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786365810; cv=pass; b=VntuFlt2eb+ZbKm6IfA118G1caZbEiHBoDUAaOfrIaDkGu+L6tynZF9ZdgqNIs4Wcyzje8aV+PUqZznbmuiVVhvs9KCx7pKc6IMCuRMQOFrHFcXFlymQxem/rtkV9Jy9VYFPZSGzuDVjYSQl5lf1CuiZ/3kdg+GNsrH1YFpaOH4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786365810; c=relaxed/simple;
	bh=A6cXQQXPYNWsFQDZSPtA67W96um/zAJnL4P0FCFK+vE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fnzbjnvej31HIB+31XVVSG88itX23VyXFf6Fm2ecRI3NGJDVQNqgeT3uG9u+OEN0H391liinGnW1MgW0iKVotvvktik/RHHoRTaVtzRzcqN0VyNTOKrDnA5CLwCKfP/1S52lgxh4EllHAgGMH4FFHY+c4o41Esa2HXGv3FbqK4Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HCoj9/+E; arc=pass smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HCoj9/+E"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-84eb992a881so1204063b3a.2
        for <git@vger.kernel.org>; Mon, 10 Aug 2026 05:43:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786365808; cv=none;
        d=google.com; s=arc-20260327;
        b=F2itsuxxKG1IOajATtw6RBfVly69FK1j457snQ8pYoU1a9vVGYw13jGZJeuo0v+DgJ
         Yl9bFPd52GVauWqzPnOstHKnBVComr01rkHYNSAMS/RnzUVHyf1imb1k5NWP00uy0UQ0
         R/+Wig7tk2GTnr3JdmAiaNHogZ0PSZYm7qQlcTH7eMcmTY5VXPSnWyOyMdPeMsognO0v
         0dBzJdY4mkKt3oP9e7agYgUdWxRrr7BA/lPkOsy0SwKKeIMikvnX+B+kv/k9ncHO5Zlg
         kiLa75HgcmofqT3wb0WN5ahTczOPYUTpeD7JSYosm9dLttSYSwJx9+TMlVYHQHSO7jd3
         s3qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=a0IO7txAQxy3sBD9dBRSjOF0m/VNBMEoWk7Ql5n58Yo=;
        fh=HHpaBK97guMS2gKkG00r98qnOxp6kW1N8C3jYoFPpqs=;
        b=XErZMGMxk6JmLDEGCFyrzpU8BKWg+4aNVa0zTG8r8AYuokGTbXLQZmtmCd/2hj2+Wb
         Z1OZ2at3Xpxd2OmoaCpAGPwdV3GLTAlYxqKkcjQRTL2MclbxmufdeFj+naKYP87vABKB
         4slxLv4GJrdLguUzFSaT7aBiXzHXgvReQmio4HyLOd2/PiIGOIPx6yBVHpjT6PT/D8yn
         P7uW/nVFibrzncI9y967CIhvJIRAS1rFkoLTa4lWZxzdge3NVaANTEXfKHzu7St47SvI
         Zg3r1wWAwQXASChj+j9uLPf3XOV6i5lmYZoleM10MiC0yVpvvbstuhvMTnqXgQZtqZGT
         yK1g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786365808; x=1786970608; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=a0IO7txAQxy3sBD9dBRSjOF0m/VNBMEoWk7Ql5n58Yo=;
        b=HCoj9/+EMX2BkJqctAcYdOAmO0Fz8/uMc2ZtJdtUFuu5XP6gSnKNnr90Ls6YjgzJ/+
         8JBWa2rX+hHuaa/MPiXLtWn/jBO1S+9l8PBtHr0aFeCUz5IE+IU/UwWUDWzMzfGcx/rc
         aNlO/pZjp5Rqsa4pgBbF6oC0eMellKngCTz2mqdns98nKXbFM3BnsqRW1vL0OwnSkLTU
         /mrOxiaXgkD78agpC+XY64GoWmcc6QoEdYVHPgRgtfF99IS/ZwLRmdCQf0u8r0h2ETH2
         lYTbFaI5KGOtFxXTU4TdI2G6bUbeF6MYby7NxELHUZc5ETAvWH790SWh9Z//7l0l760R
         tUTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786365808; x=1786970608;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a0IO7txAQxy3sBD9dBRSjOF0m/VNBMEoWk7Ql5n58Yo=;
        b=pacAc0fXxZFwnOPJK9Ck5Fa7fwpsUfzCqvcbxlmU4SEjuG7Cpo40IoTBVQZE1OBZWr
         158KwDVDtMrIfvCKihuN+cRkeIUn13EjJmVxWswnlO9rsa87I6/YqXCZX07UoMuOYqag
         07OoW4QPRYeg6IqhD9ZQRBiKqhwBFbvWzyvRw6oE2fEdCVO9GLDN/tTjJOrKlnJcK2Ak
         XRI0YoCohsDDEovHKv4j87eV6ZPD7N61+Um+gKRPb271qxhkHrnHsPGlQqvjEkc1RFcs
         RmnMjGp+30Eu35F3n+P97h2o3WycnHU9+gSJ9qg/sp+pkn6gf7elDgT3ll0IByVlnjKD
         ITzA==
X-Forwarded-Encrypted: i=1; AHgh+RrZ4ZZfMVyiXYhW65lWQSoA3kYqw9OxnKUbiMHeyixwIbn/h8RLSNIsllJNek2DJR4tt+w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVP6WDhj6KzC5/RhyYrQo/Kcgc5+WvySThnYhRkLWrepxVhm6z
	NqcVfcVUAu1TMHLGvLhWvTOZ5HGFkBbxjGEEOh1vX7iGVznbpWJkAAJlIrBWocnrieGYz/Ifamd
	zHf/KqNOrzh14IShZ17d8AidB6bK0br2VXphl7L5C9w==
X-Gm-Gg: AR+sD12xoq5mh2q4tg7mQ7ll6AFg9+VGB28Bro+mWTKHmm4tm7PxOs7hRwZV4/H7IZR
	7pE0m9g02VTLlFpZv8y8mOw2bkKOfObfLCbeiH7gKd0w2AKjc703R6T4UmOYnegEol8JLzkgoIe
	Fj3iqUnSYFN3F27xnNeOrEBLTSqkBdO2bSLemdH1vFrcXVDNx672SicVgQjLspnR4E14ruazNCe
	D5bvqqXA55Aom7Hn4QNJBDmDVW0lnbft0IwevK9AuyLW/WWjVImKQYx4oJUNSBCzDslxP3uoAVp
	ktvQln/cE0imuuUOllP20EPZ4QIBCtbdFILEIW3sICH0iQ/Io5lYJwVOXKhBEPt1zypC1E1yfEC
	6/j3oDz3oqIYbuSPM8AdAnMsXbIggr+ysotmxmA+3KD3NH0z+KHucPzH6g0ULHpIiJeUeXOll1J
	sszvLXfz9IgVdJ3hbB8gI=
X-Received: by 2002:a05:6a21:920d:b0:3c3:a20f:f729 with SMTP id
 adf61e73a8af0-3cbada5a31dmr36567178637.7.1786365808422; Mon, 10 Aug 2026
 05:43:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806-history_autocompletion-v2-0-7e60f52a1c20@kernel.org>
 <20260806-history_autocompletion-v2-1-7e60f52a1c20@kernel.org>
 <anV7cHblfmGvbl-e@pks.im> <e894cf4e-7df2-489a-a596-96f1d4d95dc0@kernel.org>
 <anWEcfhdzvNQfskU@pks.im> <0ea2cce4-2174-4866-9619-d7f74ae5c91f@kernel.org>
In-Reply-To: <0ea2cce4-2174-4866-9619-d7f74ae5c91f@kernel.org>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Mon, 10 Aug 2026 08:43:17 -0400
X-Gm-Features: AUfX_mwnLAIb2E58wEj6PkXzldk15EhjOw2tCY6WddfqFLnnG_fNUZzIkEjRLrA
Message-ID: <CALnO6CAudrCCr-bZOt5TCo6ZbmxuwE48-Zj-pkcj8Rq2T1-1wg@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] completion: add 'git history' subcommands
To: Vincent Mailhol <mailhol@kernel.org>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Philippe Blain <levraiphilippeblain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 7, 2026 at 4:13=E2=80=AFAM Vincent Mailhol <mailhol@kernel.org>=
 wrote:
>
> On 07/08/2026 at 09:08, Patrick Steinhardt wrote:
> > On Fri, Aug 07, 2026 at 08:44:41AM +0200, Vincent Mailhol wrote:
> >> On 07/08/2026 at 08:30, Patrick Steinhardt wrote:
> >>> On Thu, Aug 06, 2026 at 10:27:36PM +0200, Vincent Mailhol wrote:
> >>>> diff --git a/contrib/completion/git-completion.bash b/contrib/comple=
tion/git-completion.bash
> >>>> index e875787710..7372e2919b 100644
> >>>> --- a/contrib/completion/git-completion.bash
> >>>> +++ b/contrib/completion/git-completion.bash
> >>>> @@ -2137,6 +2137,54 @@ _git_help ()
> >>>>    fi
> >>>>  }
> >>>>
> >>>> +__git_history_has_revision ()
> >>>> +{
> >>>> +  local i
> >>>> +
> >>>> +  for ((i =3D __git_cmd_idx + 2; i < cword; i++)); do
> >>>> +          case "${words[i]}" in
> >>>> +          --empty|--update-refs)
> >>>> +                  ((i++))
> >>>> +                  ;;
> >>>
> >>> This will unfortunately be quite a pain to maintain going forward, as=
 we
> >>> now have to be aware of updating this site every single time we add a
> >>> new option that accepts a parameter.
[snip]
> > Yes, I'm very sure we'll gain more parameters for those commands. Commi=
t
> > signing, sign-offs, handling of notes are all things that are currently
> > being discussed, and they likely will require new options.
[snip]
>
> For the new parameters, indeed. The issue is that these options accept
> two syntax:
>
>   --empty=3D<value>
>
> or
>
>   --empty <value>
>
> The first one falls under the '-*)' switch case anyway, so if you do a
>
>   git history fix --new-option=3Dfoo <TAB>
>
> the __git_history_has_revision will handle it properly. If you do:
>
>   git history fix --new-option=3D<TAB>
>
> you just get no completion until the code is modified to teach what are
> the correct value for --new-option. This is acceptable in term of
> maintainability.
>
> If you do:
>
>   git history fix --new-option <TAB>
>
> then __git_history_has_revision will assume that --new-option is a
> toggle parameter which takes no value and will incorrectly complete it
> with a reference.
>
> Finally, if you do a:
>
>   git history fix --new-option value <TAB>
>
> then the value is interpreted as a reference and the <TAB> gives no
> completion.
>
> For a
>
>   git history fix --gpg-sign
>
> this is mostly OK. Assuming the new --gpg-sign works identically as the
> git rebase option, the --gpg-sign value is optional and default the the
> committer identity. So in most of the cases, the user will not give a
> value and will correctly get the reference completion when doing:
>
>   git history fix --gpg-sign <TAB>
>
> So the only case where we are screwed is if the option takes an argument
> *and* the user specify it as --new-option (without the final '=3D'). In
> that case, the damage is still not huge. I expect most of the users to
> pass option with the final '=3D'.

[later]

> > I'm not really concerned about new subcommands for now, true. But
> > hardcoding the parameters as we do above feels error prone to me and
> > will very likely diverge as the command evolves.
>
> I think that there are two options:
>
>   1. What I did, which work great today and will start to diverge the
>      day we add more arguments which takes a value as you highlighted.
>
>   2. Ignore the '--argument <value>' syntax and only complete the
>      '--argument=3D<value>'.
>
> Point 2. will consistently give incorrect results when doing:
>
>   git history fix --new-option value <TAB>
>
> but is easier to maintain. And the '--argument <value>' syntax isn't
> covered in the manpages anyway, so this option is just a "we implement
> the manpages and that's it!" approach.
>
> My preference goes slightly to 1., but I am OK to send a v3 with
> option 2.

- The manuals (gitcli, especially) recommend the stuck form (-oArg,
--long-opt=3DArg)
- Completion code that I'm aware of completes the string "--long-opt=3D"

So I suspect most folks using completion will end up with the stuck
form. If we want to support the unstuck form, I'm ok with that
(Vincent's (1)). It seems simpler for now to go with (2), which aligns
with the rest of the codebase, and wait to see if anyone complains
though.

Switching topics:

> >>> I don't really have a good idea for how to fix that reliably though, =
I
> >>> have to admit. Maybe we should just mostly ignore this edge case and
> >>> always complete references, unless we have seen a `--`? That can be
> >>> checked rather easily via `__git_hash_doubledash`.
> >>
> >> My toughs are that if such a special case ever surface, we can just
> >> dispatch it earlier before we check for the
> >> __git_history_has_revision, like this:
[snip]
> >>
> >> This seems reasonable to me. Once we know what this mysterious new
> >> command would be, maybe we can find a smarter and more tailored
> >> solution, but at the moment, I would not call this a blocker.

This is similar to what we do stash and a few other
subcommand-commands, where we need to dispatch a bit differently. I
think trying to assume all git-history commands will have the same
shape is both pleasant (consistent interface!) and unlikely to hold up
(something will diverge somewhere).

--=20
D. Ben Knoble
