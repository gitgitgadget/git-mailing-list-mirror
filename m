Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CE02BE039
	for <git@vger.kernel.org>; Thu, 17 Jul 2025 16:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752770906; cv=none; b=ZUgCJhExm9Fw2ssgmGoJZEBnIGP7+cr+heOUhNA3K+iq9Oxk8Wb8CBcnPyzp/WAVlydonyF/hLH6q8YeL2qPaXdMthXVSbw+THSBbcegff+r/oWZCJUOP7zIt9fuajtmD7KNnTM/0nnsDEMUcEzSCkQmduwdMc+0ZeK2Xhw3jiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752770906; c=relaxed/simple;
	bh=I/U+wvVuyPVijqFbmAmrFsud5GD9ca///V7f2vql6ss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pIb2Bit0yrrDwCF/I2jLT+Sw12rUhGbG+YmYveBtBCRLzPOy4C7myweTFRRNNJZlweSoJagyuS8SnxZjLR59wsyNgH6rYU/Bm0wOI7n8rfNQQzivBB6P/ZSTcEK6MNaNRz4W1VO6+DPHhqlXmkn1Q/srrDm+aeOH+0py0NYSFaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6fd5f08f2e6so2845076d6.0
        for <git@vger.kernel.org>; Thu, 17 Jul 2025 09:48:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752770903; x=1753375703;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fzTSR1qGIsdstVYiWJ0P5ILmqn5RNivoljNyQDfFWzk=;
        b=l+Ply5aJLTEJpbmq952kHdBouJyCzFdQpEGoQEFns1lPxs+pU25imBqbsC68IQrlDW
         exuqOdEhbeHN2G74UoyKadZz0EWPQOic1N9zmGHaSzytmzqd3Y2TNMwqPa6vi2Ewp8DI
         EkJ8JvLUn8vqPq/pamZvfwRzoo3Fk858M5FzdpNTzc8ghSkNoc7XK+Qvp5wzvo9jyjO7
         XtBf4W0pz/Oe5BW2CvTvlhV1R2VMWKXUb4vP1fn5FQIetDoBwhRCIQKzMlkVEhS/3ZMh
         qnldHsBLhAvfbYV98tN3qIp+aaE9UaXex89L1XEGPUTLGxvCNCOUvIgAPznnXIji342i
         fH8g==
X-Gm-Message-State: AOJu0Ywx/OvK7jMGXrkHh395Ow/5LS9UuYenxN5+uwO9n5QB4uHZ1f0y
	j8VL4OM/VBPsb23LYd+IwMy3jA6kOfRqer/3NJjwJyKkrXWb8zGWOpgbPxY0xfqczfN8oSqBJkj
	6oV3b8O3Nw6FKf0FUWcM9M5x8kqLY99Q=
X-Gm-Gg: ASbGncteZhn8tq302/GELr5M4pRhuI4OUnNTeyrd9lF7eWo9QvnHtH2KR0JhnDzw7rJ
	G8Aa7EJ6sOVy4el4Ycx17Uvt7Lz7RCp0/1lK421t1NgPzuM0hh+vHojoPMSFBKTvq7ASFWTsyG0
	WEopT6kNWigSSuRj102fv4FkUy/kMl0R74lY8Jz5MPvUm5OeH2n3zmC1B5SuT2UTXQOCAPLT0oe
	FEVbbWqqe83GBexjxTwXJLqHmgJDl3fl+U6PbV+
X-Google-Smtp-Source: AGHT+IGFg7gbvIhpJi/b8p73drmMOjyGxK0ch+MvwBdVtvFZm80Ng1Z0g4qGFcojyCdIebh2qkeyjXngBF8X836uj+0=
X-Received: by 2002:a05:622a:1cc9:b0:4ab:6a11:9eb2 with SMTP id
 d75a77b69052e-4ab90cb3c4dmr48999841cf.12.1752770903097; Thu, 17 Jul 2025
 09:48:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250627074934.1761897-1-meetsoni3017@gmail.com>
 <20250717075009.26262-1-meetsoni3017@gmail.com> <20250717075009.26262-2-meetsoni3017@gmail.com>
In-Reply-To: <20250717075009.26262-2-meetsoni3017@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Thu, 17 Jul 2025 12:48:12 -0400
X-Gm-Features: Ac12FXybbTWEn4Wa2lLMJ8Q6Hp2BCjfvcxQ3JwUEBgqgQb1VhJ2WwZGtjB06Z4M
Message-ID: <CAPig+cQgeqz9bNQSFRvTmoyFgqAwEKSV=KpK18DSP7FA-4GDPw@mail.gmail.com>
Subject: Re: [GSoC][RFC PATCH v2 1/2] builtin/refs: add list subcommand
To: Meet Soni <meetsoni3017@gmail.com>
Cc: git@vger.kernel.org, ps@pks.im, shejialuo@gmail.com, karthik.188@gmail.com, 
	gitster@pobox.com, Christian Couder <chriscool@tuxfamily.org>, Victoria Dye <vdye@github.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 17, 2025 at 3:50=E2=80=AFAM Meet Soni <meetsoni3017@gmail.com> =
wrote:
> Git's reference management is distributed across multiple commands. As
> part of an ongoing effort to consolidate and modernize reference
> handling, introduce a `list` subcommand under the `git refs` umbrella as
> a replacement for `git for-each-ref`.
>
> Implement `cmd_refs_list` as a thin wrapper around `cmd_for_each_ref`
> instead of duplicating its logic. Forward all arguments to the existing
> function to ensure behavior is identical.
>
> Add documentation for the new command. To keep the documentation DRY and
> consistent with `git-for-each-ref(1)`, refactor the shared command
> options into a standalone file. Use the AsciiDoc `include::` macro to
> embed these options in both man pages.
>
> This prevents duplication in both code and documentation, ensuring that
> `refs list` benefits from any future fixes to the underlying
> `for-each-ref` machinery and its shared documentation.
>
> Mentored-by: Patrick Steinhardt <ps@pks.im>
> Mentored-by: shejialuo <shejialuo@gmail.com>
> Mentored-by: Karthik Nayak <karthik.188@gmail.com>
> Signed-off-by: Meet Soni <meetsoni3017@gmail.com>
> ---
> diff --git a/Documentation/refs-list-options.adoc b/Documentation/refs-li=
st-options.adoc
> @@ -0,0 +1,80 @@
> +// Shared options for for-each-ref and refs list
> +<pattern>...::
> +       If one or more patterns are given, only refs are shown that
> +       match against at least one pattern, either using fnmatch(3) or
> +       literally, in the latter case matching completely or from the
> +       beginning up to a slash.

Nit: We probably don't want the "// Shared options for..." comment. If
someone needs to know which commands share this documentation, a
suitable "grep" invocation will provide the same information but will
be correct at that point in time, whereas a comment like this one can
become stale over time.
