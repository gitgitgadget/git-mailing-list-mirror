Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98341255F27
	for <git@vger.kernel.org>; Tue, 30 Sep 2025 08:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759220645; cv=none; b=Hrpkhqla63zE+PbpquysEIkdXWay4Jo47P1L4mYG4RiEtjyBZlZTX7f0W8qjGnufbL92MnZYMa/dOXlA7uSkI+rwvqzCjyYPqqwBvhu2m+/MkSELVwsW61qz+fbOGS+j8odBMAgA1/wVxGua/1TcZl+ptDG5O16Y0Vb8kDtuUp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759220645; c=relaxed/simple;
	bh=Ufn0Xr3FahiwH215+EKEB4X7Yt+ckA3Tyg4GGoXQnWY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AOVift6oR8nZt8/UdvMVxz2+/0HuUZQaMG1jHk1Q5AIoaP9LpQ0zUUjr0muoUqsIx7ypxRZ4BAkEGpeynTFbpoYDrsLNmdy4CmaY8HprZr4oTNdhL8csVd82Zl61JjeKvfa4UatrpUsbig91+DyPuhKNI21j9R0U0e0xyiI3DjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QV8KpSNf; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QV8KpSNf"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b07d4d24d09so1089661366b.2
        for <git@vger.kernel.org>; Tue, 30 Sep 2025 01:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759220642; x=1759825442; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VuovjUlR+a4GqDcQ5ZUmsK6bb+k3SHggIqK5PFIotV4=;
        b=QV8KpSNfWiBLO/4biuWhHbcUa0qZ6cZy7dlR8XQKdjBrymf9s2jltc2kVV/8tEmf2w
         CwqrsIRtQCYVPNFI6ddjEjOFBeELtrRP0zXV4iFNqfLvJGoDnO+C4C59JM6rXb+xls+q
         udKkIewHDbayCiqpQ+zLH+GKqpFmLnXApNjUXUzPbyOQkdtWEw/lM5D8m/oZFiZu9KyA
         HNlCAIDqKHQ4YxdPoLsPl1+3cltQwFVNoffBnpYlUJC2JzgILO5LfZRd6scl5Mvm9JEh
         YouMdIgPByh8Ykp0iSMbKOFKnQ5MCPH3hZOxOIW7kkOoC69GiNQX1QkAkF2bsB8p3SY4
         RWkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759220642; x=1759825442;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VuovjUlR+a4GqDcQ5ZUmsK6bb+k3SHggIqK5PFIotV4=;
        b=r2YNIam0l/y3KT8gkw7CmzVwjf/py9ghCIB5lFe9csAIQ/Hoh0zoEpsnhEEMj43wP8
         1B72FKGDmLCzyVxYVPE8Z97XSEoN6VSGh0nfMHQ8FRlnNimfI+YV2V9UPMrDO+4ox2Ie
         K0lNkKpEFJZKXbP61g6zhuJ99o7754wcIc/nwXF+k0rykzc1GEwH/66l4ZzuEIky32FV
         NEFjW5cjxIZac9Y0NeqqxiXtckT2Lksag+mxWSdN4thX4gzg3LGZnUnSdc0JshGvW8Vz
         t7Os6hrrplihGVeho8Qam0fqiASkWQntQeMrFpWmSQuv21Mily+Sci0QgIxMzJhx0M3U
         SZhA==
X-Gm-Message-State: AOJu0Yzvn/ex8VuLGpBpvhsGMdbhMyqDw+3MK76Xc7tf4ZDkbjrS3avB
	mI9LIf8KDfbhkmZtMfJqOfrlObVUbdzV1Fc2TDtCauuBeB/EDmPn/5YJmGUb9cEVEOJXSuBywxP
	wu+OWwM9KSb8s1q3srNC6sdf9B67H7X0=
X-Gm-Gg: ASbGnctGE4xV6dfR+iOOoZzFAHPl4tjtz1aEvIi6GXzjarIkEedPq7VuOS1HRxaMrgo
	ncy7DCJzV4nfZBgHuKmBirDFqlC8ROYGAepWWJ8aAPqz22n/TVgsLwA+ArojMHtbLpiGi4EYbTX
	X7WjkVOr4//fZpBrebCGae0mrDl+9Ntpsy3254TLI62e5hg8g8EiF9mL2MDsphQm2ZGRHDyfYxc
	jOP0i8xnLtpqf0pxSWOTnyLOaCVP5XeDW3iXsWtIQ==
X-Google-Smtp-Source: AGHT+IE7ayt++JKrdpHU6zggTPPHbxf/CCjNvmXjMEz9elMI2hKFQXZcGBnLis2hgSBYLE6BO4dx8OrFDWVQrSqExYE=
X-Received: by 2002:a17:907:961e:b0:b3f:c562:fae9 with SMTP id
 a640c23a62f3a-b3fc562fdcfmr637879066b.53.1759220641616; Tue, 30 Sep 2025
 01:24:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908043620.57848-1-siddharthasthana31@gmail.com>
 <20250926230838.35870-1-siddharthasthana31@gmail.com> <20250926230838.35870-2-siddharthasthana31@gmail.com>
In-Reply-To: <20250926230838.35870-2-siddharthasthana31@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 30 Sep 2025 10:23:49 +0200
X-Gm-Features: AS18NWBNs1T1-0n7i19V5SJ6lE4dr8KYaLEoePn8Y5VJ6y1Yf7tf3ZYJRW-4nNI
Message-ID: <CAP8UFD0POvYDgGtEx8GBhvKkd8XzzWQsy8XxAKL9M3+uz3ka+w@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] replay: make atomic ref updates the default behavior
To: Siddharth Asthana <siddharthasthana31@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, ps@pks.im, newren@gmail.com, 
	code@khaugsbakk.name, rybak.a.v@gmail.com, karthik.188@gmail.com, 
	jltobler@gmail.com, toon@iotcl.com, johncai86@gmail.com, 
	johannes.schindelin@gmx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 27, 2025 at 1:09=E2=80=AFAM Siddharth Asthana
<siddharthasthana31@gmail.com> wrote:
>
> The git replay command currently outputs update commands that must be
> piped to git update-ref --stdin to actually update references:
>
>     git replay --onto main topic1..topic2 | git update-ref --stdin
>
> This design has significant limitations for server-side operations. The
> two-command pipeline creates coordination complexity, provides no atomic
> transaction guarantees by default, and complicates automation in bare
> repository environments where git replay is primarily used.

Yeah, right.

> During extensive mailing list discussion, multiple maintainers identified
> that the current approach

When you say "current approach" we first think we are talking about
the behavior you described above when you said "The git replay command
currently ..."

> forces users to opt-in to atomic behavior rather
> than defaulting to the safer, more reliable option.

But here you are actually talking about what the previous version of
this patch did.

> Elijah Newren noted
> that the experimental status explicitly allows such behavior changes, whi=
le
> Patrick Steinhardt highlighted performance concerns with individual ref
> updates in the reftable backend.

Also the commit message is not the right place to describe what
happened during discussions of the previous version(s) of a patch.
It's not the right place to talk about previous version(s) of a patch
in general. Those things should go into the cover letter.

If you want to talk about an option that was considered but rejected,
you can say something like the following instead of the whole
paragraph:

"To address this limitation, adding an option named for example
`--atomic-update` was considered. With such an option `git replay
--atomic-update --onto main topic1..topic2` would atomically update
all the refs without having to use a separate `git update-ref --stdin`
command. The issue is that this would force users to opt-in to the
atomic behavior rather than have it as the default safer, faster and
more reliable option.

Fortunately the experimental status of the `git replay` command
explicitly allows behavior changes, so we are allowed to make the
command atomically update all the refs by default.
"

> The core issue is that git replay was designed around command output rath=
er
> than direct action. This made sense for a plumbing tool, but creates barr=
iers
> for the primary use case: server-side operations that need reliable, atom=
ic
> ref updates without pipeline complexity.

I think this paragraph should go just before the "Fortunately the
experimental status of the `git replay` command explicitly ..." that I
suggest above.

> This patch changes the default behavior to update refs directly using Git=
's

s/This patch changes/Let's change/

(See our SubmittingPatches documentation where it suggests using
imperative mood to describe the changes we make.)

> ref transaction API:
>
>     git replay --onto main topic1..topic2
>     # No output; all refs updated atomically or none
>
> The implementation uses ref_store_transaction_begin() with atomic mode by
> default, ensuring all ref updates succeed or all fail as a single operati=
on.
> This leverages git replay's existing server-side strengths (in-memory ope=
ration,
> no work tree requirement) while adding the atomic guarantees that server
> operations require.
>
> For users needing the traditional pipeline workflow, --output-commands
> preserves the original behavior:

I think something like:

"For users needing the traditional pipeline workflow, let's add a new
`--output-commands`option that preserves the original behavior:"

is more explicit and makes it clear that it's a new option added by
this patch and not an existing option.

>     git replay --output-commands --onto main topic1..topic2 | git update-=
ref --stdin
>
> The --allow-partial option enables partial failure tolerance.

In the same way, something like:

"Let's also add a new `--allow-partial` option that enables partial
failure tolerance."

> However, following
> maintainer feedback, it implements a "strict success" model: the command =
exits

I think you can remove "following maintainer feedback" here. The cover
letter or a trailer like "Helped-by: ..." at the end of the commit
message (but Junio will add his "Signed-off-by: ..." anyway so adding
an Helped-by: ... about him is redundant) are the right place to
mention people who helped or suggested changes.

> with code 0 only if ALL ref updates succeed, and exits with code 1 if ANY
> updates fail. This ensures that --allow-partial changes error reporting s=
tyle
> (warnings vs hard errors) but not success criteria, handling edge cases l=
ike
> "no updates needed" cleanly.
>
> Implementation details:
> - Empty commit ranges now return success (exit code 0) rather than failur=
e,
>   as no commits to replay is a valid successful operation

Nit: as all the sentences in this "Implementation details" list start
with an uppercase, I think they should end with a full stop.

> - Added comprehensive test coverage with 12 new tests covering atomic beh=
avior,
>   option validation, bare repository support, and edge cases
> - Fixed test isolation issues to prevent branch state contamination betwe=
en tests
> - Maintains C89 compliance and follows Git's established coding conventio=
ns

I am not sure this one is worth mentioning here, at least not like
this. You may want to say in the cover letter that compared to the
previous version this patch doesn't use 'bool' anymore and explain
why. Or maybe you want to explain here that using the 'bool' type was
considered but rejected for some reason. But in both cases, you should
be explicit about the reason.

> - Refactored option validation to use die_for_incompatible_opt2() for bot=
h
>   --advance/--contained and --allow-partial/--output-commands conflicts,
>   providing consistent error reporting
> - Fixed --allow-partial exit code behavior to implement "strict success" =
model
>   where any ref update failures result in exit code 1, even with partial =
tolerance

This should probably go to the cover letter, as we should not talk in
the commit message about changes since a previous version of the
commit.

> - Updated documentation with proper line wrapping, consistent terminology=
 using
>   "old default behavior", performance context, and reorganized examples f=
or clarity

This also sounds like a change compared to the previous version of the patc=
h.

> - Eliminates individual ref updates (refs_update_ref calls) that perform
>   poorly with reftable backend

This also sounds like a change compared to the previous version of the patc=
h.

> - Uses only batched ref transactions for optimal performance across all
>   ref backends

I think you can remove "only" in the sentence as in the
--output-commands case no transaction is used.

> - Avoids naming collision with git rebase --update-refs by using distinct
>   option names

This also sounds like a change compared to the previous version of the patc=
h.

> - Defaults to atomic behavior while preserving pipeline compatibility

This has been discussed above. It doesn't look like an implementation
detail to me.

> The result is a command that works better for its primary use case (serve=
r-side
> operations) while maintaining full backward compatibility for existing wo=
rkflows.
>
> Signed-off-by: Siddharth Asthana <siddharthasthana31@gmail.com>

Adding "Helped-by: ..." trailers for at least Elijah and Patrick would be n=
ice.
