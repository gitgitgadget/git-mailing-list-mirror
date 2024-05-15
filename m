Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12D013F433
	for <git@vger.kernel.org>; Wed, 15 May 2024 14:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715781615; cv=none; b=Lm8+slxTJ0s1BDWTAZrktEMpSw/Vw4k0zu7Nnuqv8oq0tGo+odOY6taGEc22OLRDyTi8ZdVp1/6Cv/yhLMHgrNsZEcsbIxStPuMkuHwFsZcZRUW5hVufjdndazP0OTCqEYHhpf4uyWjlNrbMi0b0SpiZjGeLryi+gh1JuahJNTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715781615; c=relaxed/simple;
	bh=B59pGDLGg9jjX3TbREn9G3jTUofwfJfB4HbHOu26CVk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pUyYDm3t0vP+kRpubC9730ZE+kIKRajZP2Qv5atS3SDz52/GrLyN4MazQz8D36BmHwOsN2tkO30kUGIPZfETLElFC70XbnWqwrPMOA/OPTzilwox7LGYc7m6uSVisM0jTS3NtwHprMiEiwn3uGZ2lsaYXIkB/FNFjmiOpZssOCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S2n6b3l4; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S2n6b3l4"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a5a5cce2ce6so153120066b.3
        for <git@vger.kernel.org>; Wed, 15 May 2024 07:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715781611; x=1716386411; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e1VncFLzrAsm3KztKx2MeP1p8nMKhS25gMDzIYL2SO0=;
        b=S2n6b3l45AoUXOb24EWSiz1GAH+MHcEUSQEfCy3GeZmM0rND27AsmerqfcJbBDexS0
         lpVR+gGV8SDkbb6p7UcU0TLxzuvbd2qr4WfUP+qlf1CUx85h9WCtJb055BKkjAZtKSaJ
         9x4PdPXEMXQdfO32bY9owVs/CzHpU3ULOFokTlHEM7B8yh3XB0Gocmd50JjiQkWPD/HB
         wm+2N3vXLlLQumircs5t+S501BHMUknwMHFsc2fIO54Gfv3jjWMpNwVpNX04RO8KOJlo
         ut0A+LvUe9KNYUcAI0PEb/rcRFnaV8YuaLZ5Qr1UzkcQuuQLtg+a3qoMscVqedpFOow+
         HcQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715781612; x=1716386412;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e1VncFLzrAsm3KztKx2MeP1p8nMKhS25gMDzIYL2SO0=;
        b=dqCXXbuJSqAArT1q3Y1W3nxAuPSW7MC11OOJTuiKG1gqJpCpxcNvTf5C91EDXdRmwI
         Au70dpX+Br9+ic12TpzYKucJ0wtHgza1tT/dZiQl+95xtT8vrwib1qi47gkLOaZqN4oF
         WrIIdEqu3iZujPkdE1GVXLClA5AfCCeMIJNz+DUL644ob6ZYYYiWLb/FJnWEe/rxKLDv
         gYwE9yDLD42MVjagn28jRo5n49x0zKONLnI+dv69hUxBlqytDY1JbIDqwxYKO7w+8mxr
         2BVNO7ojt8CoJXKVJlS/oTxNyugMAVmi/jpSOvioC7kviTzECYU5p2ruU27vphAjy1fo
         cyVA==
X-Gm-Message-State: AOJu0Yx/r9uxZ9SvR9vjKvfwTMsHuIMsNYmcODLz4SfbWX9fv3lvlbcn
	3J4KEZTnBOSrK87e3fwWSfo9pcTQOMfPB097bbDGDM134jdD+X3zJxUJs+MbRqvI7EKI0DOLKGI
	w+uUdOUmr560Eeu8sW0uUo1hg1lmPUUd7
X-Google-Smtp-Source: AGHT+IEDdSOgMgroVGmr5otmFZJJqZGCMbUQ03rCOKMsNM74vrXUpWnCtO4E8v/yMMU8yWIKPjO5BMKhCoAGqqvKyao=
X-Received: by 2002:a17:906:ee81:b0:a5a:15b6:602a with SMTP id
 a640c23a62f3a-a5a2d680cf8mr1243995966b.74.1715781611247; Wed, 15 May 2024
 07:00:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20221012135114.294680-1-christian.couder@gmail.com> <20240515132543.851987-1-christian.couder@gmail.com>
In-Reply-To: <20240515132543.851987-1-christian.couder@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 15 May 2024 15:59:59 +0200
Message-ID: <CAP8UFD0hGoU_BKDq8+o6J9AT9jQOSRKrRw532MeMXTYebd3rHw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] upload-pack: support a missing-action
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, John Cai <johncai86@gmail.com>, 
	Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry everyone, it looks like I put the wrong message Id in the
--in-reply-to=3D option of my `git send-email` command and this appears
to be part of a different thread. The right message ID should have
been:

20240418184043.2900955-1-christian.couder@gmail.com

Sorry again.

On Wed, May 15, 2024 at 3:25=E2=80=AFPM Christian Couder
<christian.couder@gmail.com> wrote:
>
> `git pack-objects` already supports a `--missing=3D<missing-action>`
> option, so that it can avoid erroring out if some objects aren't
> available.
>
> It is interesting to have `git upload-pack` support a similar way to
> avoid sending some objects in case they aren't available on the
> server.
>
> For example, in case both the server and the client are using a
> separate promisor remote that contain some objects, it can be better
> if the server doesn't try to send such objects back to the client, but
> instead let the client get those objects separately from the promisor
> remote. (The client needs to have the separate promisor remote
> configured, for that to work.)
>
> This could work better if there was something, like perhaps a
> capability, for the client to tell the server something like:
>
>   "I know how to fetch missing objects from this and that
>   promisor remotes, so if you choose to, you may omit objects
>   that you know are available from these promisor remotes when
>   sending objects to me."
>
> But that capability could be added later as other similar capabilities
> in this area could be very useful. For example in case of a client
> cloning, something like the following is currently needed:
>
>   GIT_NO_LAZY_FETCH=3D0 git clone
>       -c remote.my_promisor.promisor=3Dtrue \
>       -c remote.my_promisor.fetch=3D"+refs/heads/*:refs/remotes/my_promis=
or/*" \
>       -c remote.my_promisor.url=3D<MY_PROMISOR_URL> \
>       --filter=3D"blob:limit=3D5k" server
>
> But it would be nice if there was a capability for the client to say
> that it would like the server to give it information about the
> promisor that it could use, so that the user doesn't have to pass all
> the "remote.my_promisor.XXX" config options on the command like. (It
> would then be a bit similar to the bundle-uri feature where all the
> bundle related information comes from the server.)
>
> Another example use of this feature could be a server where some
> objects have been corrupted or deleted. It could still be useful for
> clients who could get those objects from another source, like perhaps
> a different client, to be able to fetch or clone from the server.
>
> The fact that the new `uploadpack.missingAction` configuration
> variable has to be set to a non default value on the server means that
> regular client users cannot hurt themselves with this feature.
>
> As `git rev-list` also supports a `--missing=3D<missing-action>` option,
> the first 2 patches in this series are about refactoring related code
> from both `git rev-list` and `git pack-objects` into new
> "missing.{c,h}" files. Patch 3/3 then adds a new
> `uploadpack.missingAction` configuration variable.
>
> The changes since v1 are the following:
>
>   - In patch 1/3 the refactored parse_missing_action_value() function
>     doesn't change the fetch_if_missing global variable anymore. The
>     clients of this function change it by themselves instead.
>
>   - In patch 1/3 a minor typo was also fixed.
>
>   - Old patch 2/4 that added a 'int print_ok' argument to
>     parse_missing_action_value() was removed, and now callers deal
>     with only the values they recognise.
>
> Thanks to Junio for his review and for suggesting of the above
> changes.
>
> Christian Couder (3):
>   rev-list: refactor --missing=3D<missing-action>
>   pack-objects: use the missing action API
>   upload-pack: allow configuring a missing-action
>
>  Documentation/config/uploadpack.txt |   9 ++
>  Makefile                            |   1 +
>  builtin/pack-objects.c              |  48 ++++++-----
>  builtin/rev-list.c                  |  43 ++--------
>  missing.c                           |  36 ++++++++
>  missing.h                           |  19 +++++
>  t/t5706-upload-pack-missing.sh      | 125 ++++++++++++++++++++++++++++
>  upload-pack.c                       |  19 +++++
>  8 files changed, 242 insertions(+), 58 deletions(-)
>  create mode 100644 missing.c
>  create mode 100644 missing.h
>  create mode 100755 t/t5706-upload-pack-missing.sh
>
> --
> 2.45.1.148.g0f5efb064b
>
