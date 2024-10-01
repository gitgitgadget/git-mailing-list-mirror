Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05D41BCA11
	for <git@vger.kernel.org>; Tue,  1 Oct 2024 17:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727805121; cv=none; b=UF0n51FN3UMQJfKGTK6n+MREOKOk7lLmzO4qxXH95znZa8Syuh23/tgjO7CfRjwWn5e4sD5rmMe17b2VR2l+wxLS+cNfbZRFF8c+AaGPHHEFZJiarOoDUPQFTC6N2qodNyyP8Gukj+htdPK0yEhNs8p6OQMb4s4PqMFc5niDK7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727805121; c=relaxed/simple;
	bh=kU1c+Z+BBNO/pf5Cl16Wfu1WEF89KHthv/fj5UQzKww=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rt5zJzGlvznlPQmo9RRSXppm/0k2T3RTweF1L9v8q+GhKdyNVLcf+0jCScFQCxiXsFoKj6pp/r/VSKaid6JyKTmxQexvRpHVO+zF2e10cGiBjvbRjs6NA2YJJJHD3CReBnpJmFPOKThpP31gesdIWTcbs0X7UxIAC5USDzXr+3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gree.net; spf=pass smtp.mailfrom=gree.net; dkim=pass (2048-bit key) header.d=gree-net.20230601.gappssmtp.com header.i=@gree-net.20230601.gappssmtp.com header.b=Bg66cAqG; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gree.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gree.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gree-net.20230601.gappssmtp.com header.i=@gree-net.20230601.gappssmtp.com header.b="Bg66cAqG"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6da395fb97aso42475947b3.0
        for <git@vger.kernel.org>; Tue, 01 Oct 2024 10:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gree-net.20230601.gappssmtp.com; s=20230601; t=1727805118; x=1728409918; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CAp7kHZWywLEFI/8hrySStzZHjRpQIxrIxAoYxPSp9Q=;
        b=Bg66cAqGXnfVye1/O4mMz7M+t1Er7mks1lhWpOmwmfUq6gMbrd4dfa/LoG866kY+gd
         DtzoAlKjK8PYthtDPgiecmhI23q3itquvm4uQY/jW32KD/VGsmmOaYOnqwH9w2xQFZxN
         dPHN+qKY98tTsW4ZWbQ1GLU1R4mW3H1CwdUHWr+E//fio7oxDyAWBtgI6wGkBTJ28lI6
         dP5ZUDW/xsCm0dNimK6Zz80rEgcQXLWRY7YWd0sygzSAHonaU5L3nMfNIfIWFvjTi9v4
         b2MtDckuieGz7tzbzeARSjQntczLTnVGFUtn3+6sHn2wK2NBeMDms/U2Srg8NESZ7rG3
         vkeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727805118; x=1728409918;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CAp7kHZWywLEFI/8hrySStzZHjRpQIxrIxAoYxPSp9Q=;
        b=VBVk1m5X506skNvDoq+zsX29J0EHj0BBFhWpKswYfueIuUTarjjpLt7bCy2i8Bkhjm
         51Q5gWiJx46UQq1lFycUxJYH8jkuQ0BwsXnXnASVOs+61MvgZdn8VkZx6EWxgARCWh4h
         hGztCkVDK0Vrp2a4oLqEQZFEyMSobijbv3fTNn00qFKJzwXZdW5WosCsj3ie1x8155uV
         PY4y6cq+YvS/B1H6F47SxDmf0MWP34gA4htwfp61iLTuOLFIDrLM8Qw/tp8QF7NAgi3O
         ywU3gFMqpErygCzgbRXg8U1v6m+mQgceEGgwc55NlQ0E0S4BNC+ttekvLG+nXDgG/9Eq
         5s5g==
X-Forwarded-Encrypted: i=1; AJvYcCVLI5wDkQPo/COGEYCAjf8IkD5+XVvA6gau0MU3m1qXczTwVbZJ5VpIDcLDbnvBqjGhb9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlmIX+7CEqHczZuuE8241q0y1Ckv5RF0anPGC3IJ9YcTL01ZaZ
	3RZCByT4Mf9/58dd+eiUFNBRqnt4V0ZMGA4oAhddFJqcAu6+kp7e+q33D9e52GDJGcgRJnjwU+u
	iw4O1JXEpzd9EgERoCLC9PhFR7Jvb35qUho0/SOK3VFk/5e5zeZDeSEeUrLnVy2ZIFxwKT5aZgw
	jUvyR0paxA7MllN0PaOoD1AZV2kIt7YqplmQX42WLIQI4pz/i1O6BbVdjPe499D9OHGs3otDPQC
	SpfKQFVcnX7LLUO6+r50Rz1tWH/eNfWd6eK16xfj4lmlhhog2Xgc5xNwAVZs9GPxkarOMMp5KAX
	ph86dZRklU0NhoQ54cP/EYkm
X-Google-Smtp-Source: AGHT+IGWt4f8UX4RsLp4UlMQ4dq/2CjNTsqAp0TmvqFssVWchJbRcS9bij25BZhKffPn3Uk/Y420VL9pxaFcPs7y1Jc=
X-Received: by 2002:a05:690c:4d01:b0:6db:d7c9:c97b with SMTP id
 00721157ae682-6e2a2e3672fmr6465347b3.40.1727805118443; Tue, 01 Oct 2024
 10:51:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1802.git.1727577690390.gitgitgadget@gmail.com>
 <pull.1802.v2.git.1727759371110.gitgitgadget@gmail.com> <xmqqwmis11f7.fsf@gitster.g>
In-Reply-To: <xmqqwmis11f7.fsf@gitster.g>
From: Koji Nakamaru <koji.nakamaru@gree.net>
Date: Wed, 2 Oct 2024 02:51:47 +0900
Message-ID: <CAOTNsDyg2SB-wd+a7vrctXck46jyfqV4uME6nf4YQZEafWbxMw@mail.gmail.com>
Subject: Re: [PATCH v2] fsmonitor OSX: fix hangs for submodules
To: Junio C Hamano <gitster@pobox.com>
Cc: Koji Nakamaru via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 1, 2024 at 8:57=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:

> > fsmonitor_classify_path_absolute() expects state->path_gitdir_watch.buf
> > has no trailing '/' or '.' For a submodule, fsmonitor_run_daemon() sets
> > the value with trailing "/." (as repo_get_git_dir(the_repository) on
> > Darwin returns ".") so that fsmonitor_classify_path_absolute() returns
> > IS_OUTSIDE_CONE.
> >
> > In this case, fsevent_callback() doesn't update cookie_list so that
> > fsmonitor_publish() does nothing and with_lock__mark_cookies_seen() is
> > not invoked.
> >
> > As with_lock__wait_for_cookie() infinitely waits for state->cookies_con=
d
> > that with_lock__mark_cookies_seen() should unlock, the whole daemon
> > hangs.
> >
> > Remove trailing "/." from state->path_gitdir_watch.buf for submodules
> > and add a corresponding test in t7527-builtin-fsmonitor.sh.
> >
> > Suggested-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > Suggested-by: Junio C Hamano <gitster@pobox.com>
>
> In none of the changes described above, I have any input to deserve
> such credit, though.

Your points are very helpful :)

> > +start_git_in_background () {
> > + git "$@" &
> > + git_pid=3D$!
> > + git_pgid=3D$(ps -o pgid=3D -p $git_pid)
> > + nr_tries_left=3D10
> > + while true
> > + do
> > + if test $nr_tries_left -eq 0
> > + then
> > + kill -- -$git_pgid
> > + exit 1
> > + fi
> > + sleep 1
> > + nr_tries_left=3D$(($nr_tries_left - 1))
> > + done >/dev/null 2>&1 &
> > + watchdog_pid=3D$!
> > + wait $git_pid
> > +}
> > +
> > +stop_git () {
> > + while kill -0 -- -$git_pgid
> > + do
> > + kill -- -$git_pgid
> > + sleep 1
> > + done
> > +}
>
> On the "git" side you use process group because you expect that
> "git" would spawn subprocesses and you want to catch all of them,
> ...
>
> > +stop_watchdog () {
> > + while kill -0 $watchdog_pid
> > + do
> > + kill $watchdog_pid
> > + sleep 1
> > + done
> > +}
>
> ... but "watchdog" you know is a single process, so you'd only need
> a single process id, is that the idea?

Yes, that is the idea.

> What is the motivation behind the change in this iteration to use
> process group?  Was it observed that leftover processes hang around
> if we killed only the $git_pid, or something?

Yes, if the issue occurs, three processes remains:

  git fetch --update-head-ok --recurse-submodules=3Don

  git fetch --no-prune --no-prune-tags --update-head-ok
    --recurse-submodules --recurse-submodules-default yes
    --submodule-prefix=3Ddir_1/dir_2/sub/

  git fsmonitor--daemon run --detach --ipc-threads=3D8

If there is no issue, only the fsmonitor process remains.

> > +test_expect_success "submodule implicitly starts daemon by pull" '
> > + test_atexit "stop_watchdog" &&
> > + test_when_finished "stop_git && rm -rf cloned super sub" &&
>
> If stop_git ever returns with non-zero status, "rm -rf" will be
> skipped, which I am not sure is a good idea.
>
> The whole test_when_finished would fail in such a case, so you would
> notice the problem right away, which is a plus, though.

t/README discusses that test_when_finished and test_atexit differ about
the "--immediate" option. As git and its subprocesses are the test
target, I moved stop_git to the current place. This might be however
confusing when someone later reads this test. Should we simply put
stop_git and stop_watchdong in test_atexit?

> > + create_super super &&
> > + create_sub sub &&
> > +
> > + git -C super submodule add ../sub ./dir_1/dir_2/sub &&
> > + git -C super commit -m "add sub" &&
> > + git clone --recurse-submodules super cloned &&
> > +
> > + git -C cloned/dir_1/dir_2/sub config core.fsmonitor true &&
> > + set -m &&
>
> I have to wonder how portable (and necessary) this is.
>
> POSIX says it shall be supported if the implementation supports the
> User Portability Utilities option.  It also says that it was added
> to apply only to the UPE because it applies primarily to interactive
> use, not shell script applications.  And our test scripts are of
> course not interactive.

How about the following modification? It still utilizes $git_pgid to
filter processes, but avoids "set -m".

  diff --git a/t/t7527-builtin-fsmonitor.sh b/t/t7527-builtin-fsmonitor.sh
  index 2dd1ca1a7b..23d9a7c953 100755
  --- a/t/t7527-builtin-fsmonitor.sh
  +++ b/t/t7527-builtin-fsmonitor.sh
  @@ -916,7 +916,7 @@ start_git_in_background () {
          do
                  if test $nr_tries_left -eq 0
                  then
  -                       kill -- -$git_pgid
  +                       kill $git_pid
                          exit 1
                  fi
                  sleep 1
  @@ -927,10 +927,13 @@ start_git_in_background () {
   }

   stop_git () {
  -       while kill -0 -- -$git_pgid
  +       for p in $(ps -o pgid=3D,pid=3D,comm=3D | grep "^$git_pgid .*git"
| sed 's/^[0-9][0-9]* \([0-9][0-9]*\) .*/\1/')
          do
  -               kill -- -$git_pgid
  -               sleep 1
  +               while kill -0 $p
  +               do
  +                       kill $p
  +                       sleep 1
  +               done
          done
   }

  @@ -954,7 +957,6 @@ test_expect_success "submodule implicitly starts
daemon by pull" '
          git clone --recurse-submodules super cloned &&

          git -C cloned/dir_1/dir_2/sub config core.fsmonitor true &&
  -       set -m &&
          start_git_in_background -C cloned pull --recurse-submodules
   '


Koji Nakamaru
