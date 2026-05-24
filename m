Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D52126C02
	for <git@vger.kernel.org>; Sun, 24 May 2026 02:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779588068; cv=pass; b=K0LqWfeXQ9aPgjoI84ArCP5gJyWTFdrEdReqPZSq61lg1TUwAwX14Fo/xTTQEc/s+ctEW78VFSLXhBZ892KmDwRwbLbeV7uvdOSiqyPoDjenPc5AgE9Ey/OMsa+UdViq40xepAPAoYgh50pdQ6C+WmbwQMxf8L6BqjEocZFZj58=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779588068; c=relaxed/simple;
	bh=FKIkdoB6E+5DDTZtFbpahtHYMHFLbmycTWKiRMxyjfQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cSnIaJSmEWJK2mot2BSHOGPCcwopDf4H4/ZHWrEMbNmNAXZWvHb2Z5U3YQjRwG7/Ap9odre5CZzJI449Q8R+fqJiaSPayNnUrvNqqnbQ+3519AW0CScQ039OuDEkgtolXDwVkJMsDMPev5V0zbFMVv3jyj4V9TtYj5/kS1dvfDE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RKs2L5TL; arc=pass smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RKs2L5TL"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-4855562f32eso700283b6e.2
        for <git@vger.kernel.org>; Sat, 23 May 2026 19:01:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779588066; cv=none;
        d=google.com; s=arc-20240605;
        b=Yvdrb4ropzDF7j6Y5+709NpVi3Yim+afnK3gTvQNN1Z8WHGlKvv/pYquy54KN6zWMw
         SOOur0guwWp13IzTgWo5w9gjVfWzDnIbWW+HZqCe+BPDY9S71Ph62eI8PA9oKxXMPSIZ
         yMjjh/9Ql6t++vGYuLPP05JDn2UfI+eqn+DeZt5WfuxXmVmRxzxQrFP0nRqQY6NGC9SB
         T+RcYJVh44lT3UmOa7ElxOePeCp32YJT/+KX+MBdmq+4HndSFpE+eoet/B8OG8ErhRIm
         wxqelb/1fnq/pHtpQxaDNWaUiHQ8Yybk2qpWVvZTOeMHdDz09C9LyPL9bEotLWZD1Znr
         7/VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aUDBPhOR7ROsQCcd9hJsenwbZGxZD+ozSNxw9VDpapo=;
        fh=FSOlq61IrQOnrAQBg4MimmQ6eofPBtQ8ywxzJ6xRWPw=;
        b=XiqFaRoGtOSuDfYa3nbXVZR8eiSPfQqmlUiHiAUWbIgs5xdnVG83hiSovlMg4xCDXK
         81Exo8kN6/uSd9dQUvR7+LGUYrLVAWWy68L3YHnWZhinCIiWlaI9nMznqXGynUY4Hx/1
         NWb9lImJuLY87EOx+/leUGMnXKnQTr8+Yfe0s+owlK9U+cySLk0Y0gtvQXGqoj3wcw+f
         mi9q8XEB+W/kXHW2qrjBgHDL1VrpCnf3wSiZexqZCKn0wcnjSRTwwVMMnD1uPgrMGRWq
         rkXLMPYDpVQFFbGbGCEVQrVbcQcGucLOn+VWDx7JVLs9cIdeqt8rgKlMomA1uT/2NUGq
         fWCQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779588066; x=1780192866; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aUDBPhOR7ROsQCcd9hJsenwbZGxZD+ozSNxw9VDpapo=;
        b=RKs2L5TLTbssrmVXNs+qcBx30UNEoaf3WBJYh3futE47Sh+JGCa6GUmsfCQUnnG1Nd
         pEkvYreAIKcF3MYpwQqfqANIyhaF5f5vaZ2E6diQGI9oPe7vq1n2AT+2NbWwoOObMkjD
         OSNyYAcrkg0FljbbdQ4mYvRTEJnuDc74CNzS2QDttyX5bhMerdsPF026dSfTKZtCwQ7j
         IogJjiMifNYI3M5POYTQlxUPDVv7Hr5Rksr5Mh0k2+OSTNk338q/xLyff0mHckBnJUOv
         5N5S9hYwjpPrJesgFAGXl2tqQxW51rTgmgReXzcObAYwaNWL+T1CgjniSouOErQ6HS32
         qe1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779588066; x=1780192866;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aUDBPhOR7ROsQCcd9hJsenwbZGxZD+ozSNxw9VDpapo=;
        b=gywi8flTMvRVDrPHPzbG+yFe6GWJC1eMTOM4wFh9T3MbxpPuCpcjBrV69q3+e1+7Y5
         r1Pq7trpqjuxhSU6LiVK7SFLm8Oq0VREnS+0b/9181SGlalR2rO4C7SGbID9PujFmE+7
         s3wRHxkGXezAxRBVfRixCNxN3PPQYZp1Uyw1UlWQmORsxkVqw3ILFC4D8xGwVp/s47dk
         O/41L2HQYWKYWuWJhJtHpmNKFg+li+36TMhsPZzhCmm2f18oabwsdc92gdvgM6zcDWf/
         cRcVBCTJTnyLIl1tQIK2u4lUWBhd5+dMYrrw5V6vg3EJ1MvpLbG5cwMG9mWAJUha4FU0
         vpbw==
X-Forwarded-Encrypted: i=1; AFNElJ88yCzesxCkHyHXIGONmbNS2y8KIcroB5QkFs8qfSO6EokYe0iRkWCzSyJjP4R8OzLYPSI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIIY+ALaTsAoZLtbRGnkZIrwlqgTrvyVBdUSISYDPLJl8WFhIr
	4TPUHE12ap/Fh9BVU9GD+Psqdw9eT35EFSI8bL47+rtQa5XoGHWu/oFpnjbclIi+MqFDS+T3/gr
	mvUw2rRB3PYN6d4cIvCyHeLVtmcFDMrMD1EPV
X-Gm-Gg: Acq92OG1oDoBDMNy8ooQvm+KbBPaGX+oN0lTaxbDLI3azTibE1QjkcMjkd1+4CvTI/n
	385hMxIhwv4QodGZGujvh8Bey11jFrNdWWXoTBBQESN0/XTSv/veqVcoHk+fKFt4c5bW/1XSZ3f
	pHdk/d0sue5ZtpgU3Szq/2AHzbyUdL8lil4sSvUcf1ixAnFy0g/cU4voKx7ifZE1gNOtMtxSuqf
	aTmSZPpez+ARGp00pzIJ0VEpEjF5ScaH94UrjhiZ2o7KGjJdxXtsLOCxpX4Mgr/O02AKvxSKLUg
	0+UulbkHb/EuhBGVIH5xAbMYy8YTFNs5+VzhtRFF
X-Received: by 2002:a05:6808:1787:b0:485:3b64:3174 with SMTP id
 5614622812f47-4854a0e14f3mr5320581b6e.19.1779588066139; Sat, 23 May 2026
 19:01:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2094.git.1777349126.gitgitgadget@gmail.com> <CALnO6CBh7nDCwT=u1xSN2c6_x88t_gNfAaT_B4PzYKr=5i_bNA@mail.gmail.com>
In-Reply-To: <CALnO6CBh7nDCwT=u1xSN2c6_x88t_gNfAaT_B4PzYKr=5i_bNA@mail.gmail.com>
From: Michael Montalbo <mmontalbo@gmail.com>
Date: Sat, 23 May 2026 19:00:55 -0700
X-Gm-Features: AVHnY4IcumKoCJSyV89dRocmqK0hk-0sQApipQrEGge3JqEwj12W-xOVuaClhEY
Message-ID: <CAC2QwmK_aFoeb1dybvkXxO+ZsQ_NoS8wUtYPvKD_=gxgcOEkCw@mail.gmail.com>
Subject: Re: [PATCH 0/3] line-log: integrate -L with the standard log output pipeline
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Michael Montalbo via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 22, 2026 at 11:46=E2=80=AFAM D. Ben Knoble <ben.knoble@gmail.co=
m> wrote:
>
> Hi Michael,
>

Hi Ben,

Thanks for the thorough review!

> On Tue, Apr 28, 2026 at 12:06=E2=80=AFAM Michael Montalbo via GitGitGadge=
t <gitgitgadget@gmail.com> wrote:
>>
>> Since its introduction, git log -L has short-circuited from
>> log_tree_commit() into its own output function, bypassing log_tree_diff(=
)
>> and log_tree_diff_flush(). This skips no_free save/restore,
>> always_show_header, diff_free() cleanup, and means that pickaxe (-S, -G,
>> --find-object) and --diff-filter cannot suppress commits whose pairs are=
 all
>> filtered out, because show_log() runs before diffcore_std().
>>
>> This series restructures the flow so that -L goes through the same
>> log_tree_diff() -> log_tree_diff_flush() path as normal single-parent an=
d
>> merge diffs, then uses that to enable several non-patch diff formats.
>
>
> Cleanup by itself to shrink the number of concepts in the code is already=
 a good thing IMO, so getting additional features out of it is even nicer.
>
>> Patch 1: revision: move -L setup before output_format-to-diff derivation
>>
>> Preparatory reorder in setup_revisions(). The -L block sets a default
>> DIFF_FORMAT_PATCH when no format is requested; move it before the deriva=
tion
>> of revs->diff from output_format so the default is visible to that check=
. No
>> behavior change on its own.
>
>
> Straightforward, nice.
>
>>
>> Patch 2: line-log: integrate -L output with the standard log-tree pipeli=
ne
>>
>> Rename line_log_print() to line_log_queue_pairs(), stripping it down to =
only
>> queue pre-computed filepairs. log_tree_diff_flush() handles show_log(),
>> diffcore_std(), and diff_flush(). This fixes pickaxe and --diff-filter
>> suppression, and aligns the commit/diff separator with the rest of log
>> output. Also rejects --full-diff, which is meaningless when filepairs ar=
e
>> pre-computed.
>
>
> At first I questioned the removal of the DIFF_FORMAT_NO_OUTPUT conditiona=
l in line_log_queue_pairs, but now that it only queues pairs it shouldn't b=
e checking output formats. Good.
>
> I also noted that log_tree_diff() returns the result of log_tree_diff_flu=
sh() in the -L case, which is a bit different from the other patterns. I th=
ink the difference is that the other cases have some conditional logic arou=
nd the log_tree_diff_flush cases (?) but I'm not sure. Perhaps that branch =
should also be looking at opt->loginfo ?
>

Good catch. In practice I think they agree, since `log_tree_diff_flush()`
returns 1 exactly when it calls `show_log()` which consumes loginfo,
but matching the existing convention is cleaner. Will update.

> Finally, I wonder if in describing the removal of the early return:
>
> > - Remove the early return in log_tree_commit() that bypassed
> >   no_free save/restore, always_show_header, and diff_free().
>
> we might want to be more explicit that this is _because_ line-level diff =
is now handled in the regular pipeline?
>

Agreed, will reword to: "Remove the early return in log_tree_commit()
that is no longer needed now that -L output flows through
log_tree_diff() and log_tree_diff_flush(); this restores no_free
save/restore, always_show_header, and diff_free() cleanup."

> [I suppose we could, in theory, split the rejection of --full-diff to a s=
eparate prep commit, idk.j]
>

It felt natural to me to put alongside the integration since
--full-diff is not yet implementable with pre-computed filepairs.
Happy to split it out if you feel strongly though.

>> Patch 3: line-log: allow non-patch diff formats with -L
>>
>> Expand the allowlist to accept --raw, --name-only, --name-status, and
>> --summary. These only read filepair metadata already set by the line-log
>> machinery. Diff stat formats (--stat, --numstat, --shortstat, --dirstat)
>> remain blocked because they call compute_diffstat() on full blob content=
 and
>> would show whole-file statistics rather than range-scoped ones.
>
>
> Short and sweet.
>
> The stat formats are kind of like --full-diff, and I think they should pr=
obably all be rejected or all allowed: since the stats are based on the ful=
l-diff, it makes sense to enable them if we can also make -L + --full-diff =
semantically sensible.
>
> Otherwise, we'd need to find a way to make the stat formats scoped for -L=
.
>

I am working on a follow up series that takes the second path
you suggest: it adds a line-range filter in `diffcore_std()` that
clips insertions and deletions to the tracked ranges before
`compute_diffstat()` runs, so `--stat`, `--numstat`, etc. report
range-scoped numbers. That series builds on top of these three patches,
which is why stats remain blocked here.

For `--full-diff`, thinking about it more, the semantics would actually
be well-defined: "filter commits by line range, but show the full
diff for those commits." Right now, there might be a higher
implementation barrier, though. The line-log machinery fuses
commit filtering with diff generation, so there is no separate
"full diff" to fall back to for display. I will soften the rejection to
"not yet supported" rather than "incompatible," since it could
be wired up if someone separates the two concerns.

>>
>>
>> Michael Montalbo (3):
>>   revision: move -L setup before output_format-to-diff derivation
>>   line-log: integrate -L output with the standard log-tree pipeline
>>   line-log: allow non-patch diff formats with -L
>>
>>  Documentation/line-range-options.adoc         | 10 +-
>>  line-log.c                                    | 30 ++----
>>  line-log.h                                    |  2 +-
>>  log-tree.c                                    |  9 +-
>>  revision.c                                    | 25 +++--
>>  t/t4211-line-log.sh                           | 99 ++++++++++++++++---
>>  t/t4211/sha1/expect.parallel-change-f-to-main |  1 -
>>  .../sha256/expect.parallel-change-f-to-main   |  1 -
>>  8 files changed, 120 insertions(+), 57 deletions(-)
>>
>>
>> base-commit: 9f223ef1c026d91c7ac68cc0211bde255dda6199
>> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2094%2=
Fmmontalbo%2Fmm%2Fline-log-use-log-tree-diff-flush-v1
>> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2094/mmon=
talbo/mm/line-log-use-log-tree-diff-flush-v1
>> Pull-Request: https://github.com/gitgitgadget/git/pull/2094
>> --
>> gitgitgadget
>
>
> A few other comments:
>
> - Tests should use test_grep; some do, but some don't.
> - There is one occurrence of "sed | grep" that I wonder if we want to rew=
rite to avoid issues with exit status one side of the pipe?
>

Will fix both these issues.

> Thanks for working on this!
>
> [Apologies for the unusual review format; this was easier for me at the m=
oment than digging up the individual patches, and I don't think _most_ of t=
he review would benefit from spreading out across multiple mails.]
>

Thank you too! This review format worked fine for me :)

> --
> D. Ben Knoble
