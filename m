Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED19A5F
	for <git@vger.kernel.org>; Tue,  6 Aug 2024 02:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722911511; cv=none; b=Hsp/9wdTv+8f7DxQwLXOlrrSt9jziQ7DDvB9HFnY7kUMkWgqi/cVX7LF9Fa15IEK4VbsWdc7B5DpBD6o1PqWvuXNMoEAuABc1GwM5b8sBEx5bB645mziLv6I6qniJxsQt/kuK3or1CDuL6kCqO+il0bUP3umljGo0KroCTTV8z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722911511; c=relaxed/simple;
	bh=mRr229+VVmC9dX0zE5Fulcli8TBFbbB7Yc0yJpxzP7Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mYsXz+VdfR8OzcHxGII+GYTZB5xBIFmb4blANBqDgtypQ5KekaVkztBIUj+WZe+XpZGPyDLdspucG+F903VL4L/CPotBhsu68WsbAgTDHnpgn6aOWeUVen2RJBZTwh9nlLEuFNI1l7PoyuR0vSJfrk6ccHVzKy1VQFpyHbDtb+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7093705c708so297595a34.1
        for <git@vger.kernel.org>; Mon, 05 Aug 2024 19:31:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722911509; x=1723516309;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=swiDNaQAJDE47X4RKzcYGHJO4weLEPK4OuM8kXY7sZg=;
        b=vqFCIgFaP2TTFiyn6xiwA0UaG/nwfx6aPjIYQFrTA7jqBn3JzJGpTDaKv4aHVbHrkI
         bJr5EITQJ7unZeNFRekUBz5mEEFoWBcWXBdGm9EfdSP6JNQPQLrolP3aff4xidfLmx64
         VE6YYkf3hAJiwxucMO9hUyqRxaMPd4UNwi7U6oEhYQohwKNiPA9elrH9W0pfpn/sp/Yj
         pHXW1UT0li+6GUP3NTpmypwvMbEIT3Iq2/LWMRy3qi9Sq9vzzUcyjgs8UVIXWaaZ6eAi
         68lPE6g9iEOUGX+5czKwg5O9Ttqcl/9QgoWFnYbx69C3JSLUbli9E1SiuzMXO+5kk2VJ
         aXUw==
X-Gm-Message-State: AOJu0YyZGwKs8R4Mzshoa/xhiyOTouA3Xi7TmMvjrj4GglpyAnlrgGUU
	Q9lV3vis2BFKNwqAZBubahy0X6b5ux4YnAVgXH6nY7Io62Oxi7RQdzWcBucudEjOyc0MToMkP60
	mq8qPM2JkISBvywn0HHmtv8WJ+I5gsA==
X-Google-Smtp-Source: AGHT+IGhhuqzTmkAcKA3TlnSZPnft6CPiV4W5q0NwKOMzWN204JlwM34ULYTFd/MPJGMPT52SwD1C0EYfB+QrucRb98=
X-Received: by 2002:a05:6358:9147:b0:1a6:84aa:13f with SMTP id
 e5c5f4694b2df-1af3baa129dmr1622136655d.24.1722911508638; Mon, 05 Aug 2024
 19:31:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240806003539.3292562-1-gitster@pobox.com> <20240806003539.3292562-5-gitster@pobox.com>
In-Reply-To: <20240806003539.3292562-5-gitster@pobox.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Mon, 5 Aug 2024 22:31:37 -0400
Message-ID: <CAPig+cQ563EVtWEYxZDaQ4awrOcemc4a9a6OSmGN2wVFeMidwA@mail.gmail.com>
Subject: Re: [PATCH v1 4/4] miscellaneous: avoid "too many arguments"
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 5, 2024 at 8:36=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
> Imagine seeing your command failing with "too many arguments" when
> you run "git cmd foo bar baz".  Can you tell it will work if you
> said "git cmd foo bar"?  Or is that trimming your command line too
> much?  Too little?
>
> Instead, if the command reports "unknown argument: 'bar'", you'd know
> that "bar" and everything after it is unwanted.
>
> Let's make it so for a few remaining commands.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> @@ -2503,7 +2503,8 @@ int cmd_receive_pack(int argc, const char **argv, c=
onst char *prefix)
>         if (argc > 1)
> -               usage_msg_opt(_("too many arguments"), receive_pack_usage=
, options);
> +               usage_msg_optf(_("unknown argument: '%s'"),
> +                              receive_pack_usage, options, argv[0]);

Is this supposed to be referencing `argv[1]` rather than `argv[0]`...

> diff --git a/builtin/tag.c b/builtin/tag.c
> @@ -641,7 +641,7 @@ int cmd_tag(int argc, const char **argv, const char *=
prefix)
>         if (argc > 2)
> -               die(_("too many arguments"));
> +               die(_("unknown argument: '%s'"), argv[2]);

...similar to how this references `argv[2]` when the condition is `argc > 2=
`?
