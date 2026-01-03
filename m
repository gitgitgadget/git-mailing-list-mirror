Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB56F17A2E6
	for <git@vger.kernel.org>; Sat,  3 Jan 2026 16:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767457819; cv=none; b=kuZTFBfTmxzmwc6h3Jq6AhqlogxzYu0kvncxJE49fSRNjfCk7z5oG6VvaCT4T8HGlXpk0gOYce2nJ3ENrYDwfV59CXcOakBlLQl7C4p1x3gMc7+ZU+jTWNtqGIarbt22xMif/0MbGwM853NixSP1nWSgIsRRX4rBSeko5bbGw1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767457819; c=relaxed/simple;
	bh=rlnm2b9OCMuEkl45CSoBsR9wWDrZieH5qeAQlsU1l/E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tQzjiL0Vg6utZLh+Lqx+m1LKuovDbXFaPiYAIY8bCQHYBx/NYfvJydGCll95N2qnM7g/LlbSqkj+eb3kXUDoCObhaHNCiE1yR1KrzyZ7hyT9f/wgHN8Ivg1pOozEX7ez+f/qyXZzhGcT0zItDXCGDAeznI8PXRH9UrHFio9SwAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=paultarjan.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=paultarjan-com.20230601.gappssmtp.com header.i=@paultarjan-com.20230601.gappssmtp.com header.b=xd5atzXg; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=paultarjan.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paultarjan-com.20230601.gappssmtp.com header.i=@paultarjan-com.20230601.gappssmtp.com header.b="xd5atzXg"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-78fb5764382so97641427b3.0
        for <git@vger.kernel.org>; Sat, 03 Jan 2026 08:30:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paultarjan-com.20230601.gappssmtp.com; s=20230601; t=1767457815; x=1768062615; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8YcZyACKEGTj057/xAKOrXFjDOUFSABMd+v719gFOFw=;
        b=xd5atzXgoKWzreoFLZP2vcVeudcYCG9ZrVgb4b28N1+KiPfgQ4T6WpCTtwwbf0hYLZ
         JlzS2IrYclD+F0NyQZzzcxp0fZInpHRtmESMBIzXdPQ1/THFkACBaCRb9+LWD1XFUxcw
         SCHqN9mdetTmQwXAVrHQQGgS4yjuGJelEIEzlAI0YSufVdMWsNvhDj0a+co33mPTGB4H
         9S7HrgZkgsqGXYzyD7GcGds7Njvb6RqxS3dIvNx+3oUQyMrm928zcumNv2zSO6SuN9rY
         zQ9vyoe0CjP9kKbASD5MpTJ+ktGSXFik8knVdqNWceaPv8sm2PMVE+BB3QIOOgApOoeR
         Ij7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767457815; x=1768062615;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8YcZyACKEGTj057/xAKOrXFjDOUFSABMd+v719gFOFw=;
        b=Ujd0s6w4KJKcaiKK91rtHge09KSUu5Y/CGJLL8nNfTgqrP+iUne7OWbf/w+PEro1GO
         RTHJvSnxyCQ7yPPVyGq89IRiNZL3PDilA8qkIZZhy8M+wA1/iRS+rsTKLSIz4KT455r9
         X2i+onbwaNt3+MY4DR2ri2wLxxeOF+mimQtMH6BHjlsDCXvH6YMsW0qljinbzS+1Y+YJ
         vu8c6zdpnU6dxh6a31jR+JSHxVoasn/hIftTblrva2XlPVIk5eUZa1H1PHfrfYNQqoXN
         ZRwk7Ln6LXsvOaRLm3dNgQAMb9rEzxo6Oi+MUMriqdyBvfH3BJ+LIMklh/aA/G8TotvS
         7uEg==
X-Forwarded-Encrypted: i=1; AJvYcCXxDdRW79SwYUJLPg1Bl3xHFglz7ho4aXcy9DfEpnZTgKTL5A5RnU2qD/lZG0hSHeiwHd8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRROAYNP+t0v4ZN/EmwExrN+lIt/fe1sCOSBhSosG6Yyw9psCv
	//HX1wmi6jL3MEzbEcXStJXFcM+w52QSrC98PZWQIoTBS3J1KmnQGMUBnnk1X4ymSNjPEtFOyc4
	Lhcvfr8ZjRV12I0OwsO6GbSP+Ek1f/l0=
X-Gm-Gg: AY/fxX4cktE7xy3Yck5wTo9UamBcTE1U4akDQWx+k2IjLm+E9T/3bZPxKP/HwJlToPM
	guOkb8GafQZBg5OUCKiCU01epprwcCVxuzFPlQd/NX4BsDy8sKfiB8fqR6GinSrX+kapELdZj9L
	vJRg8jnWPeIhlrXdmNff54AsfGtzdR/lSD8yNg4+Dk3/Um9kQsmSAACfijBxQHBe1TlananmNrN
	AdJfUPIGqe+Xqi5d4jZa6Q4HmHzoSN8IILSU3/5wdXGjTrTmKdh+As9KXzIEsbXXKPcqHHNmKGj
	q6l1JlL1qmFJAjuMhK2yD9jaW2Vvx/qdc7h9Hg==
X-Google-Smtp-Source: AGHT+IH0VszTI+gr8CPKbWxywSky1feWXkG5RHJc+aBjBEpaLnx3q0fXu0pC6+RmOhBGg7hJZDZY35JoBcgdB5DmtGc=
X-Received: by 2002:a05:690c:7409:b0:787:e9bc:fad5 with SMTP id
 00721157ae682-78fb40294e1mr360913317b3.33.1767457815482; Sat, 03 Jan 2026
 08:30:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2149.git.git.1767219599334.gitgitgadget@gmail.com>
 <pull.2149.v2.git.git.1767292068036.gitgitgadget@gmail.com> <02749b7d-e9a4-4894-a50c-91a7c1a22d84@gmail.com>
In-Reply-To: <02749b7d-e9a4-4894-a50c-91a7c1a22d84@gmail.com>
From: Paul Tarjan <paul@paultarjan.com>
Date: Sat, 3 Jan 2026 06:30:04 -1000
X-Gm-Features: AQt7F2q3tBSV3DzQZ_X2J4dMAa33NRQC6mKWt430UIaji7Pa2u274dL9LPaDa28
Message-ID: <CALvWuB79v3i3zU_g1swqQVS-fH1f-U8Ptr9Z9ObAUgeFJHx++A@mail.gmail.com>
Subject: Re: [PATCH v2] t7800: fix racy "difftool --dir-diff syncs worktree" test
To: phillip.wood@dunelm.org.uk
Cc: Paul Tarjan via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Paul Tarjan <github@paulisageek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I've updated the commit and PR summary for your comments. Should I
re-run /submit to send a no-op patch or leave it as is until code
changes are needed?

On Fri, Jan 2, 2026 at 11:39=E2=80=AFPM Phillip Wood <phillip.wood123@gmail=
.com> wrote:
>
> Hi Paul
>
> On 01/01/2026 18:27, Paul Tarjan via GitGitGadget wrote:
> > From: Paul Tarjan <github@paulisageek.com>
> >
> > The "difftool --dir-diff syncs worktree without unstaged change" test
> > fails intermittently, particularly on Windows CI.
>
> Thanks for working on this. I've seen it fail a lot in Windows CI runs -
> does it fail on other platforms as well?

I did a cursory grep through the Github actions and didn't find any
other failures for this. The fact that you have seen it too means this
is more widespread. I was merely reacting to the fact that it failed
on my unrelated diff.

My guess is this will start failing more once my fsmonitor for linux
merges in since it will be yet another platform to fail on.

>
> > The test modifies a file in difftool's temp directory via an extcmd
> > script and expects the change to be synced back to the worktree. The
> > sync-back detection relies on git's change detection mechanisms.
> >
> > The root cause is that the original file content and the replacement
> > content have identical sizes:
> >
> >    - Original: "main\ntest\na\n" =3D 12 bytes
> >    - New:      "new content\n"   =3D 12 bytes
> >
> > When difftool creates the temporary index (wtindex), the cache entries
> > have sd_size =3D 0 (zero-initialized via make_cache_entry with no
> > refresh). Git's ie_modified() is designed to handle this by calling
> > ce_modified_check_fs() for content hashing when sd_size is 0.
> > > However, Windows has known filesystem issues that may cause this to
> > fail intermittently:
> >
> >   - UNRELIABLE_FSTAT: Windows fstat() on open files may not return the
> >     same information as lstat() after close (config.mak.uname:506)
>
> As I understand it the test is flaky because the file is updated without
> changing any of the stat fields that git looks at. How does that relate
> to fstat() returning different data to lstat()? Also doesn't
> UNRELIABLE_FSTAT exist so that we can work around the problem?

You're right, the UNRELIABLE_FSTAT reference was misapplied here. That
flag addresses a different issue (fstat vs lstat discrepancies on open
files). The actual problem is simpler: when file size and mtime both
match, stat-based detection fails entirely. I'll remove this from the
commit message.

>
> >   - NTFS timestamp issues: The racy-git documentation notes that NTFS
> >     is "still broken" regarding timestamp granularity between in-core
> >     and on-disk representations (Documentation/technical/racy-git.adoc)
>
> That comment is specifically talking about linux so how does it relate
> to a test that is flaky on Windows?

You're right - I conflated unrelated documentation. Looking at CI
history, the failure was only observed on Windows (win test (8)). The
root cause is Windows-specific: Git relies on inode changes as a
fallback when other stat fields match, but Windows lacks inodes.
Johannes linked git-for-windows#5132 showing this affects real users,
not just tests.

>
> >   - Attribute caching: Windows GetFileAttributesExW may cache results
>
> When git refreshes the index it calls lstat() on each path in the index.
> GitFileAttributesExW() provides an API like readir() which returns paths
> in an arbitary order and it also resolves symbolic links so I'm having a
> hard time understating where it is called by git. (There was a post [1]
> on reddit recently about using GitFileAttributesExW in this context)
>
> [1]
> https://www.reddit.com/r/rust/comments/1prkzqg/writing_the_fastest_implem=
entation_of_git_status/

This was speculation on my part that doesn't hold up. The actual
mechanism is straightforward: changed_files() in difftool runs
update-index --really-refresh and diff-files against a temporary
index. When size and mtime match, no change is detected. The Windows
API details aren't relevant. I'll remove this from the explanation.

>
> > Fix this by changing the replacement content to "modified content\n"
> > (17 bytes), ensuring the change is detected at the earliest size
> > comparison in match_stat_data(), bypassing any platform-specific edge
> > cases in the more complex code paths.
>
> This stops the test from being flaky but it is a real bug. If the user
> is modifying the files interactively then they're unlikely to be able to
> update the file fast enough to be affected but if anyone is scripting
> like the test does then they might be affected.

Agreed completely. This fix was to make the lives of git developers
easier, not its users. The fix addresses the symptom, not the cause.
The difftool creates its wtindex via make_cache_entry() and the
subsequent refresh/diff-files path doesn't trigger content comparison
when stat data matches. Anyone scripting difftool with modifications
that preserve file size could hit this silently.

>
> Thanks
>
> Phillip
>
> > Note: Other tests with same-size file patterns (t0010-racy-git.sh,
> > t2200-add-update.sh, t1701-racy-split-index.sh) are not vulnerable
> > because they use normal Git index operations with proper racy git
> > detection. The difftool case is unique due to its ephemeral wtindex
> > created via make_cache_entry() without full stat refresh.
> >
> > Signed-off-by: Paul Tarjan <github@paulisageek.com>
> > ---
> >      t7800: fix racy "difftool --dir-diff syncs worktree" test
> >
> >      In
> >      https://github.com/git/git/actions/runs/20624095002/job/5923174578=
4#step:5:416
> >      this test failed for me on an unrelated commit. I had Claude look =
into
> >      it and it thought that this could be a racy git problem. I'm skept=
ical
> >      but a) I don't know the source well enough and b) the fix is low r=
isk so
> >      I thought I'd send it to you folks. Everything below is the AI gen=
erated
> >      explanation.
> >
> >      The "difftool --dir-diff syncs worktree without unstaged change" t=
est
> >      fails intermittently, particularly on Windows CI.
> >
> >      The test modifies a file in difftool's temp directory via an extcm=
d
> >      script and expects the change to be synced back to the worktree. T=
he
> >      sync-back detection relies on git's change detection mechanisms.
> >
> >      The root cause is that the original file content and the replaceme=
nt
> >      content have identical sizes:
> >
> >       * Original: "main\ntest\na\n" =3D 12 bytes
> >       * New: "new content\n" =3D 12 bytes
> >
> >      When difftool creates the temporary index (wtindex), the cache ent=
ries
> >      have sd_size =3D 0 (zero-initialized via make_cache_entry with no
> >      refresh). Git's ie_modified() is designed to handle this by callin=
g
> >      ce_modified_check_fs() for content hashing when sd_size is 0.
> >
> >      However, Windows has known filesystem issues that may cause this t=
o fail
> >      intermittently:
> >
> >       * UNRELIABLE_FSTAT: Windows fstat() on open files may not return =
the
> >         same information as lstat() after close (config.mak.uname:506)
> >
> >       * NTFS timestamp issues: The racy-git documentation notes that NT=
FS is
> >         "still broken" regarding timestamp granularity between in-core =
and
> >         on-disk representations (Documentation/technical/racy-git.adoc)
> >
> >       * Attribute caching: Windows GetFileAttributesExW may cache resul=
ts
> >
> >      Fix this by changing the replacement content to "modified content\=
n" (17
> >      bytes), ensuring the change is detected at the earliest size compa=
rison
> >      in match_stat_data(), bypassing any platform-specific edge cases i=
n the
> >      more complex code paths.
> >
> >      Note: Other tests with same-size file patterns (t0010-racy-git.sh,
> >      t2200-add-update.sh, t1701-racy-split-index.sh) are not vulnerable
> >      because they use normal Git index operations with proper racy git
> >      detection. The difftool case is unique due to its ephemeral wtinde=
x
> >      created via make_cache_entry() without full stat refresh.
> >
> >      Signed-off-by: Paul Tarjan github@paulisageek.com Reviewed-by: Joh=
annes
> >      Schindelin Johannes.Schindelin@gmx.de
> >
> > Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2=
149%2Fptarjan%2Fclaude%2Ffix-difftool-test-DDxDC-v2
> > Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2149=
/ptarjan/claude/fix-difftool-test-DDxDC-v2
> > Pull-Request: https://github.com/git/git/pull/2149
> >
> > Range-diff vs v1:
> >
> >   1:  dd5b774451 =3D 1:  98bc88f336 t7800: fix racy "difftool --dir-dif=
f syncs worktree" test
> >
> >
> >   t/t7800-difftool.sh | 6 +++---
> >   1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
> > index bf0f67378d..8a91ff3603 100755
> > --- a/t/t7800-difftool.sh
> > +++ b/t/t7800-difftool.sh
> > @@ -647,21 +647,21 @@ test_expect_success SYMLINKS 'difftool --dir-diff=
 --symlinks without unstaged ch
> >   '
> >
> >   write_script modify-right-file <<\EOF
> > -echo "new content" >"$2/file"
> > +echo "modified content" >"$2/file"
> >   EOF
> >
> >   run_dir_diff_test 'difftool --dir-diff syncs worktree with unstaged c=
hange' '
> >       test_when_finished git reset --hard &&
> >       echo "orig content" >file &&
> >       git difftool -d $symlinks --extcmd "$PWD/modify-right-file" branc=
h &&
> > -     echo "new content" >expect &&
> > +     echo "modified content" >expect &&
> >       test_cmp expect file
> >   '
> >
> >   run_dir_diff_test 'difftool --dir-diff syncs worktree without unstage=
d change' '
> >       test_when_finished git reset --hard &&
> >       git difftool -d $symlinks --extcmd "$PWD/modify-right-file" branc=
h &&
> > -     echo "new content" >expect &&
> > +     echo "modified content" >expect &&
> >       test_cmp expect file
> >   '
> >
> >
> > base-commit: 68cb7f9e92a5d8e9824f5b52ac3d0a9d8f653dbe
>
>
