Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98E023C9
	for <git@vger.kernel.org>; Wed, 21 Feb 2024 01:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708480119; cv=none; b=OAJrnhNn5uFPA5dsvnMAniC59XHo7eBOXnhWCpjbeo9Smh3OeDOVPeCdNVwbW+YDwBTdfxBDS5VnoQd1GeZSOsajLIDambWCZr2FVXfOev3VKIobAIbGC4nbJWvOkUbgYLlORyBMnlBmKzH+2D2RiqY/5Guin87PZAQyYCMVeoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708480119; c=relaxed/simple;
	bh=VB4B3gePK5C7TPw0wYNmzMGjz0J0qqnhhjkSmEcfQGg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=J1k8wO8fY1+gdd3saaYSSv1kfnicisvJE8mdiOqUR/kieGVS9FSmVhqbhYhR6gMTSWJbvwwwamKtQXcfZL/j4eBK29ZHnSeaE7kcBGhDNEPuQkDdGYFEpm9ej0WCTK3Kl8iN1jjauainui0DuB3KXu/xlIosLxYUAwXEyD1ZoIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tjnb4fEW; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tjnb4fEW"
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dc753905f1eso1692548276.1
        for <git@vger.kernel.org>; Tue, 20 Feb 2024 17:48:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708480117; x=1709084917; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OriD2WwztGcF77F0z5SypuOlb5O9U5ARVi+6bt3kl3A=;
        b=Tjnb4fEWvXkFe3Q3FNFwTbt32c8Xow7ZcHvqwT6yUZXB/vZ+rgMIvpXzlLf6G5+Js7
         WX0h6YxClU9u6aWKJlyUUUbS+PMd52dsWyp8mENbbUBymXijIvWF1OYyYerr0xe7FhC2
         IEJ3MbErvnpqzxYPQf4E8JIKjyXDETzffvXNpRJaWnSKUHTb2ZewQn+tUpd1J0d7x/hK
         hQ7ukL0QjrNafmyTk9k/eZ157dfV8Qim6cOz5UcEZPEDRGMDxmePQhFtj+8ziNhaU5Fb
         oYeXo+t4wu11Vpp4us7ZcvTuSZ4y8Enl3ZDL8WGilHc68EsQP23RD0GHFLg+Forsn1OB
         aTog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708480117; x=1709084917;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OriD2WwztGcF77F0z5SypuOlb5O9U5ARVi+6bt3kl3A=;
        b=NiRyKPvqdcCblS1OOp3b5d5eDGQf1JG3Mf3au1C2vPFeJPmE4nmfJmdgzB+jTynSZ5
         w9pAMsiTOqE7D7TxKbAOTBfe6zOgRY2pB0Mo29lNC8t+W/FtEEGC6npUKxJ8waIqQ4qk
         Mt96eQWoPdJaoyjcB3OnWvp1ASlY7nguNLWHSyr5HWCu8l9BBaAW/S29SfKKUGkFoTYp
         3r50gMadVX15U4fxJ1q6tY9UByys1QWwjmipXsT2sAX/X07oE0rDdw1YSnOrcwTOJgRb
         nhMODjqvF3Qz1NWIb8kyZxt309b6/fRdcUZ/9zgC4i8grDEzernFBPnSiTplUXerlmHp
         AzRQ==
X-Gm-Message-State: AOJu0Yy1jpfnMP4YBx+Nxwl/2A9jwHcPi78UJfA2+GMnAH+Vl/virYvo
	hN6dgWUTM/kwhmK3tIMRxFfW1ijt94q2C3A7OoK7/Bwow1FeAVpGZcxj65cq3tzExCl953LJaLG
	R5T6W2N+GqJqun1f1UexMybTsjUJlFljay0A=
X-Google-Smtp-Source: AGHT+IFntmjqPxVhK7zJyXObzhUeZSZ73Gt+/nqDEAZg8Ot343631jfoIbXNAidLDPj1TIZkr1j8+GGmFpI1n0GTyvg=
X-Received: by 2002:a0d:e806:0:b0:607:ec77:1efc with SMTP id
 r6-20020a0de806000000b00607ec771efcmr9647253ywe.4.1708480116742; Tue, 20 Feb
 2024 17:48:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yasushi SHOJI <yasushi.shoji@gmail.com>
Date: Wed, 21 Feb 2024 10:48:25 +0900
Message-ID: <CAELBRWK-bZTV0qx6_34HAgpmYwy+5Zo2E0M+4B6yZJJ3CqweTw@mail.gmail.com>
Subject: Segfault: git show-branch --reflog refs/pullreqs/1
To: Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi all,

Does anyone see a segfault on `git show-branch --reflog refs/pullreqs/1`?

It seems files_reflog_path() creates a wrong path with the above command
using REF_WORKTREE_SHARED.

refs/pullreqs is from GitHub if you have the following line in .git/config:

fetch = +refs/pull/*/head:refs/pullreqs/*

(gdb) bt
#0  __pthread_kill_implementation (threadid=<optimized out>,
signo=signo@entry=6, no_tid=no_tid@entry=0)
    at ./nptl/pthread_kill.c:44
#1  0x00007ffff7e101cf in __pthread_kill_internal (signo=6,
threadid=<optimized out>) at ./nptl/pthread_kill.c:78
#2  0x00007ffff7dc2472 in __GI_raise (sig=sig@entry=6) at
../sysdeps/posix/raise.c:26
#3  0x00007ffff7dac4b2 in __GI_abort () at ./stdlib/abort.c:79
#4  0x00007ffff7dad1ed in __libc_message (fmt=fmt@entry=0x7ffff7f1f78c
"%s\n") at ../sysdeps/posix/libc_fatal.c:150
#5  0x00007ffff7e19ae5 in malloc_printerr
(str=str@entry=0x7ffff7f1d22c "free(): invalid pointer") at
./malloc/malloc.c:5658
#6  0x00007ffff7e1b864 in _int_free (av=<optimized out>, p=<optimized
out>, have_lock=have_lock@entry=0) at ./malloc/malloc.c:4432
#7  0x00007ffff7e1e1df in __GI___libc_free (mem=<optimized out>) at
./malloc/malloc.c:3367
#8  0x0000555555625ae2 in cmd_show_branch (ac=<optimized out>,
av=<optimized out>, prefix=<optimized out>)
    at builtin/show-branch.c:801
#9  0x0000555555572250 in run_builtin (argv=0x7fffffffe080, argc=3,
p=0x5555558ca198 <commands+2712>) at git.c:469
#10 handle_builtin (argc=3, argv=0x7fffffffe080) at git.c:724
#11 0x00005555555731b4 in run_argv (argcp=argcp@entry=0x7fffffffde6c,
argv=argv@entry=0x7fffffffde60) at git.c:788
#12 0x0000555555573d38 in cmd_main (argc=<optimized out>,
argc@entry=4, argv=<optimized out>, argv@entry=0x7fffffffe078)
    at git.c:923
#13 0x0000555555571f10 in main (argc=4, argv=0x7fffffffe078) at common-main.c:62

Best,
-- 
             yashi
