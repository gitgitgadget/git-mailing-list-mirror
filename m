Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BF8264A90
	for <git@vger.kernel.org>; Mon, 20 Oct 2025 07:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760945335; cv=none; b=Y9I7cCoGTZyKvDa+bRB+5MyIdgf8TbG20caRFAwJBxU5EuTNr6pm0RX9n6A0O7Udo6iqKpXVHdGO+Pe7SmFu3ON4JyPR1Fr1SPqb6eYHnaIeegCw+61f/ic33hhzJ58iHSt5EE6apd6O4hGnQVHKt5IphS4nJRZcQAu1utdB2EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760945335; c=relaxed/simple;
	bh=/5YV6FFcyNXrIkA7MWg/2xiVkLW5VuleD4yDWz0GKUs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mEFTGw5wpZ1h8Hp0N1N6Zb5sDkvCL7C53gSYI/56mk/sgtD1VKa7/1k5mutivJwX6JX3hT7mvrWlJRlzY8/gJWWLfo0zjUsm1+c7a0HDe/7emqjjF9REP0HIzSBMSNU0IP5F0CiO98WZDiV+JcPZi10vOUhamZ/e8KNo5OFww/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=eficode.com; spf=pass smtp.mailfrom=eficode.com; dkim=pass (2048-bit key) header.d=eficode.com header.i=@eficode.com header.b=GPEZTaI+; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=eficode.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eficode.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=eficode.com header.i=@eficode.com header.b="GPEZTaI+"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b64cdbb949cso627439666b.1
        for <git@vger.kernel.org>; Mon, 20 Oct 2025 00:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eficode.com; s=google; t=1760945331; x=1761550131; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sNJbUgUiBjDM/lT5LBupUfwhktUbOyv1n+9DyXP4Cm4=;
        b=GPEZTaI+61U9aHmkL70WGAdF2aMDwTpiN1bA+aX9fBiub9YkZ8LuByy1C+1IJU7csW
         zq3+3u1K8gFgfMqhJQoSYUNKQ0dxw2dFOaEl2AO2FfvvsWIefhnow2EHxApf0V3TB34s
         2oBVLhZN9WXLXkEjDgRGiVWWCHMnLGXfQNQR9qwv/wMFH5703U8KQGViChhQtDAY6iRN
         ew121FUgM/hmzGWzypoFhN1ccoLT/jiJjnwRBRt8JMlO3i1ud8KNjHNXrurE4rmnVLdm
         jyjkilpKZpSxM/0Zs3QM8JHK9yan2jw4/x/qoUr4I+/8RP31nv6nXyalp/IUJ78YP/p6
         MKAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760945331; x=1761550131;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sNJbUgUiBjDM/lT5LBupUfwhktUbOyv1n+9DyXP4Cm4=;
        b=Buw9ieOs9BDheWAEHK4odC2wllCBWttBVxtp4d93PnrvMth2J63fV94JxSwevkdeoh
         qHkXxvfjhBVdNHI4DOis0I14kILn+Dl4FEljixg/wsfPNO0RQFiefk0AZWBZfd84unhK
         cCuT6IsFfZVS21FNmZYeyjm2lj3VUWL1QU9qPSpllAZrlL4RaruE7MNM3z9SQo2CUsGO
         k9KWAxcpMhvwJ38YvllilEtcD9Cs5xoUR4KU/SVqjEUE5p2+KLfwj7iP4v5uZAGDtZkE
         K/GTMmgxUU5DGwMyR65v3mkxDSZQwKaPy6WrSe949eR97j0ESsKDPkxLFfeORmgWFiFS
         rX3g==
X-Forwarded-Encrypted: i=1; AJvYcCXG0yqEbdBAWkIHZFZqRjaD+4TaOZtAQzBJxX6FAo1iIxOfRvNMKZg0kelydjq4WDb7VSU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywem05Xk+Ezb/m14Fyg0auCNOMeQzBQwHtKkVtDT3PnIXdkC+LI
	z6pvs+uxKj7g1RnbZEIQfkKT/ynzn4CSck1gVWfXSunzCfHWIbQODDCVLvHJIf2fQt36ddvrMKA
	miRq76wI1oh75eR5KASUn2Uy8xVsJ5PwQWTce5z10
X-Gm-Gg: ASbGnctcmu8r1iOcKJ67JRUVreThGM06vXviYjQEcgewAvZaIX3z6na8QUPw1j9Ke6U
	tLBmIxz/6zV7DhwsLkpgJIY26InZj2c5+dRW/ZT8Bg9nmMwMXGxHK9RHZ51PnCmICR5QmzyvyoV
	/hQG3xEJbKZz6OHXYkr4lanmpr4TUduubxYSRl9dHxzFHMN2DqUDHCqoLO4pBm+jXyKT6wSfsoQ
	PKEaO2BixU6t9JCg2ottHyxNATjtrbR/alg6VujqIcRB39cQw+6QaK91kicpNO27fbg3b6oiNAs
	mZjZAQW9VJkuKZHChixRMZeLkHmkcyFfUBAHsIdqPAgktTuiQ3KB1Ah0ELlvZzbr97+jTnR8TSz
	vuFqpd7B/5w+GuMDJ5/ElqvdDHwfNhcbrW3e4M5U=
X-Google-Smtp-Source: AGHT+IHw3VlB6PIwMmpSQWQ6aNRVpcIrKcs5ZHv/cYLNklzWnKxQjjiRpvGmctDgeH7PO9HGEdH6Gz6O8/OWApyjTSs=
X-Received: by 2002:a17:907:3ea3:b0:b33:671:8a58 with SMTP id
 a640c23a62f3a-b6474b37108mr1389841466b.37.1760945331519; Mon, 20 Oct 2025
 00:28:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1987.git.1760818039.gitgitgadget@gmail.com>
 <2688a523-e324-41bb-858f-b32040e1e909@gmail.com> <CA+GP4bpu3SUycG35DU5+NSuiqtfYN9-R=7d01EFhexgGh4sRPg@mail.gmail.com>
In-Reply-To: <CA+GP4bpu3SUycG35DU5+NSuiqtfYN9-R=7d01EFhexgGh4sRPg@mail.gmail.com>
From: Claus Schneider <claus.schneider@eficode.com>
Date: Mon, 20 Oct 2025 09:28:39 +0200
X-Gm-Features: AS18NWDJyde2u1iQPm1nuTFzXYpbOSoZejFzSlJtNpvVvV83-NZT81NI5BoUPRo
Message-ID: <CA+GP4boSRx-FrAppz5oWauPwUxRpLt5u372m1Q4b+JpeeOTUHQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] git-add : Respect submodule ignore=all and only add
 changes with --force
To: phillip.wood@dunelm.org.uk
Cc: Claus Schneider via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Junio C Hamano <gitster@pobox.com>, Brandon Williams <bmwill@google.com>, 
	Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi again ..

I have read the documentation for submodule and reset. See from a
non-git-developer it is actually pretty hard to understand what
happens with regards to the "reset" command.

The only hint I can find which does not mean a lot to an ordinary user:
- "Defines under what circumstances "git status" and the diff family
show a submodule as modified".
- GPT-5 does not say anything regarding "reset", if asked a few levels
of "/explains" regarding "diff family". I find the documentation
inconclusive as an end-user.
- Looking at the "reset" --help it does only talk about
--[no-]recurse-submodules but not really what the ignore=3Dall
- I can find the override_submodule_config=3D1 in reset, commit, status,
add-interactive, read-cache.
.. so I am a bit confused.

From an end-user perspective I would expect this of "all":
- (pre-action): "status" and "diff-of-workspace/staging". It should
respect ignore=3Dall unless overridden or explicit specified
- (action): "add" : It should respect ignore=3Dall unless overridden or
explicit specified(--force)
- (action): "reset", "restore" ..<etc>: It should respect ignore=3Dall
unless overridden or explicit specified and leave it to submodules
--init / --remote
- (action): "clean": It could be argued of the -x option should also
act on submodules - but fair to leave it to submodules --init /
--remote
- (post-action) "diff-of-history", "log" (aka <ref1> <ref2> ) : It
should always tell what happened in history (git-graph) despite what
the current .gitmodules states regards to ignore=3Dall

It could be a new option value should be added like "always" or
"logical" respectively the above and then leave the "all" to the
current behavior.

Best regards
Claus



On Sun, Oct 19, 2025 at 11:55=E2=80=AFPM Claus Schneider
<claus.schneider@eficode.com> wrote:
>
> Hi Philip ..
>
> Thank you for your feedback and for investigating this. I was not aware o=
f the setting that causes `add` and `reset` to override submodule configura=
tion, and I will need to look into `reset` further.
>
> I understand the problematic aspect of not being able to add an update of=
 a submodule reference, which likely led to the overwrite setting. From a G=
it developer's perspective, always adding it might have seemed like the sim=
plest approach.
>
> However, from an end-user perspective, it's not logical for `status` to s=
how nothing while `add` has an effect. A more intuitive workflow would alig=
n with how ignored files are handled even though it is already tracked.
>
> My patch implements what I believe should have been in the first place. M=
y implementation still needs the `overwrite=3D1` set in order to get the di=
ff files list so I can 'operate' on it and make the `--force` logic like th=
e ignore files.
>
> Best regards
> Claus
>
> On Sun, Oct 19, 2025, 17:34 Phillip Wood <phillip.wood123@gmail.com> wrot=
e:
>>
>> Hi Claus
>>
>> [I've adjusted the CC list slightly]
>>
>> On 18/10/2025 21:07, Claus Schneider via GitGitGadget wrote:
>> > The feature of configuring a submodule to "ignore=3Dall" is nicely res=
pected
>> > in commands "status" and "diff". However the "add" command does not re=
spect
>> > the configuration the same way.
>>
>> I was curious why, when "git add" uses the same machinery as "git diff"
>> to figure out which paths need updating, it behaves differently. It
>> turns out that add_files_to_cache() contains
>>
>>         rev.diffopt.flags.override_submodule_config =3D 1;
>>
>> which makes "git add" ignore "submodule.<name>.ignore". Tracing the
>> history of this line, it originates from 5556808690e (add, reset: ensure
>> submodules can be added or reset, 2017-07-25) which made a deliberate
>> choice for both "git add" and "git reset" not to behave like "git diff".
>> If we're going to change the behavior then it would be helpful to
>> explain how this patch series ameliorates the concerns that lead to that
>> commit and why it is sensible to change the behavior of "git add" but
>> not "git reset". It also suggests that a much simpler way of
>> implementing the change would be to delete that line.
>>
>> I'm not convinced that the approach of using "--force" is a good idea as
>> it conflates ignoring changes to tracked paths (which is what
>> submodule.<name>.ignore" does) with ignoring untracked paths (which is
>> what ".gitignore" does). If we're happy to break existing uses that rely
>> on the current behavior then having a new option to override
>> submodule.<name>.ignore strikes me as a better way forward. I don't have
>> much experience of using submodules so I can't comment on whether
>> changing the behavior is a good idea or not.
>>
>> Thanks
>>
>> Phillip
>>
>>
>>   The behavior is problematic for the logic
>> > between status/diff and add. Secondly it makes it problematic to track
>> > branches in the submodule configuration as developers unintentionally =
keeps
>> > add submodule updates and get conflicts for no intentional reason. Bot=
h adds
>> > unnecessary friction to the usage of submodules.
>> >
>> > The patches implement the same logical behavior for ignore=3Dall submo=
dules as
>> > regular ignored files. The status now does not show any diff - nor wil=
l the
>> > add command update the reference submodule reference. If you add the
>> > submodule path which is ignore=3Dall then you are presented with a mes=
sage
>> > that you need to use the --force option. The branch=3D, ignore=3Dall (=
and
>> > update=3Dnone) now works great with update --remote, but developers do=
es not
>> > have to consider changes in the updates of the submodule sha1. The
>> > implementation removes a friction of working with submodules and can b=
e used
>> > like the repo tool with branches configured. The submodule status repo=
rt
>> > could be used for build/release documentation for reproduction of a se=
tup.
>> >
>> > A few tests used the adding of submodules without --force, hence they =
have
>> > been updated to use the --force option.
>> >
>> > Claus Schneider(Eficode) (5):
>> >    read-cache: update add_files_to_cache to take param
>> >      ignored_too(--force)
>> >    read-cache: let read-cache respect submodule ignore=3Dall and --for=
ce
>> >    tests: add new t2206-add-submodule-ignored.sh to test ignore=3Dall
>> >      scenario
>> >    tests: fix existing tests when add an ignore=3Dall submodule
>> >    Documentation: update add --force and submodule ignore=3Dall config
>> >
>> >   Documentation/git-add.adoc       |   4 +-
>> >   Documentation/gitmodules.adoc    |   5 +-
>> >   builtin/add.c                    |   2 +-
>> >   builtin/checkout.c               |   2 +-
>> >   builtin/commit.c                 |   2 +-
>> >   read-cache-ll.h                  |   2 +-
>> >   read-cache.c                     |  54 ++++++++++++-
>> >   t/lib-submodule-update.sh        |   6 +-
>> >   t/meson.build                    |   1 +
>> >   t/t2206-add-submodule-ignored.sh | 134 +++++++++++++++++++++++++++++=
++
>> >   t/t7508-status.sh                |   2 +-
>> >   11 files changed, 202 insertions(+), 12 deletions(-)
>> >   create mode 100755 t/t2206-add-submodule-ignored.sh
>> >
>> >
>> > base-commit: c44beea485f0f2feaf460e2ac87fdd5608d63cf0
>> > Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1987=
%2FPraqma%2Frespect-submodule-ignore-v1
>> > Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1987/Pr=
aqma/respect-submodule-ignore-v1
>> > Pull-Request: https://github.com/gitgitgadget/git/pull/1987
>>
