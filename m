Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62AE431064B
	for <git@vger.kernel.org>; Sat, 21 Mar 2026 19:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774120291; cv=pass; b=n1JbjviNdCLMmRkN5xTu8/E20htpmKbUwDBIZ0Fw0thT1KJJEcNLOYV+A5KCCFJvwRmjENqnDub/ME4K5LGpJRazB4Zwj9dlEa9Wz/lKqaDeExG1Pvxz70o5AJTt0O2KiwlruaLqjdqFxXuubX9E/d+M1pmjuxBA3BdasDAB8/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774120291; c=relaxed/simple;
	bh=aqF4woLHJrBkyE+DoS1nJ8Xf9XSp9/sokFKvQ/tzTI8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=ga+iV0IVc2qc8BDfERrU5HxR42YDOYugQOquvTQgdlRh+eSA0ZAnC4tharpXxzjLjmZoXtWBrUcZik1sN75XqNQuqi4GcYzYTUm+Hm/8CucWpMhFDBwwoPjVn4ThJmeSPPxdmNJavLDnzlnJ7f8jitMLDWniBDGAqNw2/reyYpU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XTERvYsF; arc=pass smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XTERvYsF"
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-5fff13d5a19so2549106137.0
        for <git@vger.kernel.org>; Sat, 21 Mar 2026 12:11:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774120289; cv=none;
        d=google.com; s=arc-20240605;
        b=XqrJBSlbh6QH1wtpxUb/CRdETsh5UFSLAonjujRIOSVIpBiQXVIz3AUAnagu3vSDp9
         6s8vg+XPB08OlTQ9YGquMUBwoekMjMQKKKgHfUdoLo2m51NT3qTlIXsMSSWqTs6uaQy0
         KZUQkxHFdJN5wSV+4g4bnROFCMkZc1YMeMPES7lfPfjl9t6zoonnLgBOGnQNt/EUn86u
         XmNqe5vC56cqxy4L+WpLx9m5Rr5iZmUXNKEG1MWk2QgjO6+In38qDBwKr5ups5MHJVvM
         QzBcJ1BRUSi4XVv1ZgNjwNB2dfTuUm/xiCBuk4pyxtda7vuLk5rdqfkSGWe6YdSZJisu
         7viQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=fxf9WYdv8FRAOcyuF/nn0PcJgoUq1VOCJWNfQ3DM890=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=UqjIC7b++g2KcwKvs86Hd4i6TdGG7EmKJryDqy17i4mH9HcM+Y4QGj39oFGst4ztw9
         dvsMFzaqBVrdtAt8gr+VCT1/a6iSwHrjKMRcSvn743AwWYrznYyG5urghUd0g8F12gzM
         pHncVPeSP/8szgOVAOJ+7xuniovocqFwNtn+bphZWwhZJFsEx7oIc8oDMvwKBDxfRWWS
         nABUAYRcpUbFKU1XK6quwkhZNIkXYh617RMg3NZm7jYEz/Ka5nF74v38++63kD3Orkcq
         lSla9RJQmrp1/OmUR5YaUyYv1QlLKv+jFuFWwQmQACCa7bUdMn+PeDej88Y3KMiqJI76
         Tiag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774120289; x=1774725089; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fxf9WYdv8FRAOcyuF/nn0PcJgoUq1VOCJWNfQ3DM890=;
        b=XTERvYsF9D53erwxTkz7pZi/7R581k1IcxHS7QXxLf7I7sk4lFHgQirpzq0h9fhcNt
         jgfF0VXWl84b/YxR9DA9PnlZoHBz8T8QnCYG5dvs0ZuKn75pG35s1LNpufex0VMVvvpW
         IlmMP8Q5x5JbVRe/CaFVhQJqPeaNnE8kOkAGbHQlP91c22q1RbIjhuXADB7JQ16nRYwo
         6Th4cFMz+3djlPJNep00exjzoGMo1cYBbhG32XL2hFAeDRlxnZqz5bY1bJIZXSssbWr8
         PIO7bBYKPpEYoneYQJCPI+8uQjSHRSEBqkV7ArEiCFxAiJjEaNhx4jTfbm0KmQYem3TR
         1N7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774120289; x=1774725089;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fxf9WYdv8FRAOcyuF/nn0PcJgoUq1VOCJWNfQ3DM890=;
        b=VizCpGH4/8DdEV/K8jxTnJNH5qrri1viwtDweCNtDaY3QRyYIOjFpP0Ugl6ZXeP1SD
         L7LfWXdbl1sFbreVhH7u2Oa/q7eam0gRGiEcN0mbvupTxOY5hsy3NLRhQ7aoYoVx7eAN
         cG0vig4APnWeQ9Aizr6UfzdDCUE8f1kLckuv8+qpZ3/X545HZK6xoiiCVEYPHYk8Gh8w
         U3kuJ5kNIGGbJRTHlRKg/UI8clGOanJYas/4DvMBz+mXjTdIGkzqv22cxhJlKmNTJIQ2
         dKxoSHO0OueoK0w2f/GpqxJLjNdAtdcijnKtiGI1EKGpgMustX79tjGoj2gDjv6Z2fLy
         ELSA==
X-Gm-Message-State: AOJu0YxZKWYzw8WeG+Uc9oiFb7QSzPGuYYgCiD3CDUvI8hs66MXsGQ5o
	kaz8G90DbOe/QTpHxDmhNfxHxZToTBzqIRXnTz8HdzKyPP8+RlsI9M3syVbpNn+mMLGGDDHEy11
	d8bMBhgFnvXBg6MdTPwmZmMiY6nHWQ2TcWY4e+Ro=
X-Gm-Gg: ATEYQzw5ihRypyYm3cfQzdyqNAYdWKXRJCcKQX/7BZiuegtdUcUt59GockLgiKOhr4E
	brVSa/i6Jx4ZnUcp/C82VV6lfJcFHJnpR6RNoIBcuHpztl9r2nd9ltLvmx9XZUN/I/3p6CogWN0
	kGTs1YBg8ZLLILmOwYMcwIGg0F/3bbxCuFoh14BM7M8xb7gs0U6VzEcQ6EtZ4aksLgXuzlsKKmV
	ABjoCKwCbuT/FugZ/Oeq3JHsNGyr1emdcWIKhgpbQhzW9LHM68z8M9wWyKpnvvx0zguixVVXLHe
	+SmlOg==
X-Received: by 2002:a05:6102:dd1:b0:5ff:e10e:b9fb with SMTP id
 ada2fe7eead31-602af4b1767mr2855594137.4.1774120289117; Sat, 21 Mar 2026
 12:11:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jo Liss <joliss42@gmail.com>
Date: Sat, 21 Mar 2026 19:11:18 +0000
X-Gm-Features: AaiRm52Z61UhFDo7VLWpp8kP9GiWjL55BJJI219-tsfUEfBKQbEkUtDJQJeppCM
Message-ID: <CAN=xy38zCRdOAnMtBXtRyUHE=+gtS8J6mwUWFQqxDAaBLAm7dA@mail.gmail.com>
Subject: remote-curl: segfault parsing remote.<name>.fetch outside a repository
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi mailing list,

I ran into a bug and thought I'd report it! The following command
segfaults for me (where ~/src/git is my clone):

env -C / \
    GIT_CONFIG_NOSYSTEM=3D1 \
    GIT_CONFIG_GLOBAL=3D/dev/null \
    GIT_CONFIG_COUNT=3D1 \
    GIT_CONFIG_KEY_0=3Dremote.repro.fetch \
    GIT_CONFIG_VALUE_0=3D'+refs/tags/*:refs/tags/*' \
    ~/src/git/git-remote-http repro

In other words, this is happening when the shared remote-curl code
(here, git-remote-http) is called outside of any repository, while
`remote.<name>.fetch` is set.

I can reproduce this on Ubuntu and macOS, with git master
(7ff1e8dc1e16) and git 2.51.0.

The way I actually ran into this was by running `git ls-remote -h
<url>` outside of a git repository, and my `remote.origin.fetch` is
globally set to `+refs/tags/*:refs/tags/*`.

Here's a backtrace:

~/src/git $ make clean && make DEVELOPER=3D1 CFLAGS=3D'-g -O0 -Wall'
...
~/src/git $ env -C / \
  GIT_CONFIG_NOSYSTEM=3D1 \
  GIT_CONFIG_GLOBAL=3D/dev/null \
  GIT_CONFIG_COUNT=3D1 \
  GIT_CONFIG_KEY_0=3Dremote.repro.fetch \
  GIT_CONFIG_VALUE_0=3D'+refs/tags/*:refs/tags/*' \
  gdb -q -batch \
  -ex 'set debuginfod enabled off' \
  -ex 'set startup-with-shell off' \
  -ex run \
  -ex 'bt full' \
  --args ~/src/git/git-remote-http repro
[Thread debugging using libthread_db enabled]
Using host libthread_db library "/lib/aarch64-linux-gnu/libthread_db.so.1".

Program received signal SIGSEGV, Segmentation fault.
parse_refspec (item=3D0xffffffffda88, refspec=3D0xaaaaaadf0650
"+refs/tags/*:refs/tags/*", fetch=3D1) at refspec.c:104
104 else if (llen =3D=3D the_hash_algo->hexsz && !get_oid_hex(item->src, &u=
nused))
#0  parse_refspec (item=3D0xffffffffda88, refspec=3D0xaaaaaadf0650
"+refs/tags/*:refs/tags/*", fetch=3D1) at refspec.c:104
        unused =3D {hash =3D "
\n=DF=AA\252\252\000\000\031\000\000\000\000\000\000\000
\332\377\377\377\377\000\000\300I=CA=AA\252\252\000", algo =3D 2866743840}
        llen =3D 11
        is_glob =3D 1
        lhs =3D 0xaaaaaadf0651 "refs/tags/*:refs/tags/*"
        rhs =3D 0xaaaaaadf065d "refs/tags/*"
        flags =3D 3
#1  0x0000aaaaaaca49dc in refspec_item_init (item=3D0xffffffffda88,
refspec=3D0xaaaaaadf0650 "+refs/tags/*:refs/tags/*", fetch=3D1) at
refspec.c:161
No locals.
#2  0x0000aaaaaaca4a04 in refspec_item_init_fetch
(item=3D0xffffffffda88, refspec=3D0xaaaaaadf0650
"+refs/tags/*:refs/tags/*") at refspec.c:166
No locals.
#3  0x0000aaaaaaca4c08 in refspec_append (rs=3D0xaaaaaadf0a90,
refspec=3D0xaaaaaadf0650 "+refs/tags/*:refs/tags/*") at refspec.c:203
        item =3D {force =3D 1, pattern =3D 1, matching =3D 0, exact_sha1 =
=3D 0,
negative =3D 0, src =3D 0xaaaaaadd49d0 "refs/tags/*", dst =3D 0xaaaaaadd4b9=
0
"refs/tags/*", raw =3D 0xaaaaaadf0b20 "+refs/tags/*:refs/tags/*"}
        ret =3D 43690
#4  0x0000aaaaaab64c00 in handle_config (key=3D0xaaaaaadd4810
"remote.repro.fetch", value=3D0xaaaaaadf06d0 "+refs/tags/*:refs/tags/*",
ctx=3D0xffffffffdb80, cb=3D0xaaaaaadeeb70) at remote.c:528
        v =3D 0xaaaaaadf0650 "+refs/tags/*:refs/tags/*"
        name =3D 0xaaaaaadd4817 "repro.fetch"
        namelen =3D 5
        subkey =3D 0xaaaaaadd481d "fetch"
        remote =3D 0xaaaaaadf0a20
        branch =3D 0xaaaaaab98654 <cmp_strmap_entry>
        remote_state =3D 0xaaaaaadeeb70
        kvi =3D 0xaaaaaadd48f0
#5  0x0000aaaaaaac12f0 in configset_iter (set=3D0xaaaaaadeeb20,
fn=3D0xaaaaaab645e4 <handle_config>, data=3D0xaaaaaadeeb70) at
config.c:1639
        i =3D 0
        value_index =3D 0
        values =3D 0xaaaaaadf0698
        entry =3D 0xaaaaaadf0680
        list =3D 0xaaaaaadeeb58
        ctx =3D {kvi =3D 0xaaaaaadd48f0}
#6  0x0000aaaaaaac3134 in repo_config (repo=3D0xaaaaaadc9e70 <the_repo>,
fn=3D0xaaaaaab645e4 <handle_config>, data=3D0xaaaaaadeeb70) at
config.c:2300
No locals.
#7  0x0000aaaaaab6537c in read_config (repo=3D0xaaaaaadc9e70 <the_repo>,
early=3D0) at remote.c:637
        flag =3D 0
#8  0x0000aaaaaab65b3c in remote_get (name=3D0xffffffffe465 "repro") at
remote.c:823
No locals.
#9  0x0000aaaaaaab2164 in cmd_main (argc=3D2, argv=3D0xffffffffde88) at
remote-curl.c:1568
        buf =3D {alloc =3D 0, len =3D 0, buf =3D 0xaaaaaadca368 <strbuf_slo=
pbuf> ""}
        nongit =3D 1
        ret =3D 1
#10 0x0000aaaaaaabc688 in main (argc=3D2, argv=3D0xffffffffde88) at common-=
main.c:9
        result =3D 65535

It looks like the immediate crash is in `parse_refspec()`, where
`the_hash_algo->hexsz` is dereferenced while
`the_repository->hash_algo` is still NULL.

Best,
Jo
