Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7492110F
	for <git@vger.kernel.org>; Tue, 19 Mar 2024 17:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710868662; cv=none; b=CIvGL9z1MhvhKg1eVAIoiKBFm83dIa0eThbWyMoOvtr4cAmthFqHBQcbjduPfq7HaNrp/tSm/WkZhvPJFehXKnhU93bR9AI797NcyckPZ62qWyUoArap8zAip6PzqRQs8kEFAG87CU0rpxndLOZRejLHLnUYfPx6K+QUCQomdHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710868662; c=relaxed/simple;
	bh=VMa+OXIQyiSoZxkfxlEOUbmX9YGU3DcCawdtefTjYYs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lg3N1c9EHXIsg1zbZDIyVy/qK9Fq3QmfA9uOyi6/nPbbngXfPaV3EfhIVVH/rhaZS23ufz7TWQda6lsKT2WMzfTwKh3bEzcCgXgzHJ0i07KfHHMWkltngUM2KiAuNG3JKUhrDPEJtcZe7x/sTjMhNh36yVVPDTAYHvDHYkmjbkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5a47a9f7755so2671880eaf.0
        for <git@vger.kernel.org>; Tue, 19 Mar 2024 10:17:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710868658; x=1711473458;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=812IJQXkD7Zzpke3xVyboIiTJUmJo9utFBiUQVNlsok=;
        b=Tv/pG0MmoplJi8jPbOfdvlT0JWKwuNF0elSkh/XyhpcGj05lFU4qc98y8LZOc7cHpT
         Emqh2AsUbiaMTAUhByBdEFHrcWFlPfEQm97BJWLyaLFwST0r3YBf30dwAvH1A47nPb5G
         dHusgEITyzvOCSCuagrSLUm+lWS8VSQjEmjVBl+u6PruuIWukBH6W7AHJbiiFKIMEb/u
         vN0mGoH5kf7z/tK4wmFO2lYSZeFxfScp3kOkX9Zg1NwgSEl+U0K4zzMMo6DliJokOkkc
         K5sctgJkDSe86xsZFriLoeqi8jq39eWSbHhgWet7afNIYq3koKKP+DAB39qq5ZtdPjql
         hPUw==
X-Gm-Message-State: AOJu0YxLtgp/mb2IlVh6UWw9xnLc038ZTfpU7Bmt826tP5eikjT8W3gK
	WqlbpQqC6O1Y9px+/C6/Ksw1fzkkHePHSX4tLF8+H3iNAPT6fBDZqjJAuMUFB9KTl250YmxaFZR
	kcr095XuyBedhdttbXjpvXQ7UTqWsv39jSyA=
X-Google-Smtp-Source: AGHT+IGV1TEXaYZdrlg8786dRZ+BH+oc7e6CKs8MrkuNs+fauEPzNqOhIifaiUVatt0z4pdB77l1vDFAj9VxT4whaI0=
X-Received: by 2002:a05:6870:e2cd:b0:220:bf55:b12a with SMTP id
 w13-20020a056870e2cd00b00220bf55b12amr18755886oad.38.1710868658690; Tue, 19
 Mar 2024 10:17:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240318153257.27451-1-mg@max.gautier.name> <20240318153257.27451-4-mg@max.gautier.name>
 <ZfmAfIErHRZVbd49@framework>
In-Reply-To: <ZfmAfIErHRZVbd49@framework>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Tue, 19 Mar 2024 13:17:27 -0400
Message-ID: <CAPig+cSWLoRdTgrrU2SBswnKr82L_BPCKtaP6atMyZVDAU=hpw@mail.gmail.com>
Subject: Re: [RFC PATCH 3/5] maintenance: use packaged systemd units
To: Max Gautier <mg@max.gautier.name>
Cc: git@vger.kernel.org, =?UTF-8?B?TMOpbmHDr2MgSHVhcmQ=?= <lenaic@lhuard.fr>, 
	Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2024 at 8:10=E2=80=AFAM Max Gautier <mg@max.gautier.name> w=
rote:
> I'm working on updating the test in t7900-maintenance.sh, but I might be
> missing something here:
>
> >test_expect_success 'start and stop Linux/systemd maintenance' '
> >   write_script print-args <<-\EOF &&
> >   printf "%s\n" "$*" >>args
> >   EOF
> >
> >   XDG_CONFIG_HOME=3D"$PWD" &&
> >   export XDG_CONFIG_HOME &&
> >   rm -f args &&
> >   GIT_TEST_MAINT_SCHEDULER=3D"systemctl:./print-args" git maintenance s=
tart --scheduler=3Dsystemd-timer &&
>
> Do I understand correctly that this means we're not actually running
> systemctl here, just printing the arguments to our file ?

That's correct. The purpose of GIT_TEST_MAINT_SCHEDULER is twofold.

The primary purpose is to test as much as possible without actually
mucking with the user's real scheduler-related configuration (whether
it be systemd, cron, launchctl, etc.). This means that we want to
verify that the expected files are created or removed by
git-maintenance, that they are well-formed, and that git-maintenance
is invoking the correct platform-specific scheduler-related command
with correct arguments (without actually invoking that command and
messing up the user's personal configuration).

The secondary purpose is to allow these otherwise platform-specific
tests to run on any platform. This is possible since, as noted above,
we're not actually running the platform-specific scheduler-related
command, but instead only capturing the command and arguments that
would have been applied had git-maintenace been run "for real" outside
of the test framework.

> >       for schedule in hourly daily weekly
> >       do
> >               test_path_is_missing "systemd/user/git-maintenance@$sched=
ule.timer" || return 1
> >       done &&
> >       test_path_is_missing "systemd/user/git-maintenance@.service" &&
> >
> >       printf -- "--user disable --now git-maintenance@%s.timer\n" hourl=
y daily weekly >expect &&
> >       test_cmp expect args
>
> The rest of the systemd tests only check that the service file are in
> XDG_CONFIG_HOME, which should not be the case anymore.
>
> However, the test does not actually check we have enabled and started
> the timers as it is , right ?

Correct. As noted above, we don't want to muck with the user's real
configuration, and we certainly don't want the system-specific
scheduler to actually kick off some command we're testing in the
user's account while the test script is running.

> Should I add that ? I'm not sure how, because it does not seem like the
> tests run in a isolated env, so it would mess with the systemd user
> manager of the developper running the tests...

No you don't want to add that since, as you state and as stated above,
it would muck with the user's own configuration which would be
undesirable.

> Regarding systemd-analyze verify, do the tests have access to the source
> directory in a special way, or is using '../..' enough ?

You can't assume that the source directory is available at "../.."
since the --root option (see t/README) allows the root of the tests
working-tree to reside outside of the project directory.

You may be able to use "$TEST_DIRECTORY/.." to reference files in the
source tree, though the documentation in t/test-lib.sh doesn't seem to
state explicitly that this is intended or supported use. However, a
few existing tests (t1021, t3000, t4023) already access files in the
source tree in this fashion, so there is precedent.
