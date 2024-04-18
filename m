Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D59165FB0
	for <git@vger.kernel.org>; Thu, 18 Apr 2024 15:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713452731; cv=none; b=ETpUAUovogVUV+HigmdUbofNdtiSgc7RK1J1Gg/BYmHv8elyGDGTshpu9DFJA671T74FiMyLRRB2pnVhJtn+UGjDTXrf+adhggZC9CxmjF/gbWr6PFu2oKMi1C68GEBO56hHNLQ1DjpPogi7XMWHlYeFGyJrnCFfDefoGGVqu1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713452731; c=relaxed/simple;
	bh=qkjfb3yLqCQDGRW46T6X+24bq0FtmwZiN3Oy758Hvfw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aP9Jpdh4Qunit+3ukvISBfuNEEFJDlO5+BkRRNZWIsAp0pO0IRSHMH8DrtkaEJhhuwKUS9JwvXZUFyaWwAwqUWb6p8NL2HnCvT6gB9Aj+lJhyYz8ExqyusoiABfcTWK6bAuTA/ZWcWjIYa8hv12ElAm2/GppF39vPwt+fgHVOOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KAjQwKtS; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KAjQwKtS"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5196c755e82so1213712e87.0
        for <git@vger.kernel.org>; Thu, 18 Apr 2024 08:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713452727; x=1714057527; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qkjfb3yLqCQDGRW46T6X+24bq0FtmwZiN3Oy758Hvfw=;
        b=KAjQwKtSY5PELpRKOni4I+P+uHjwys3e8jJSg8VjWjOFRVWuwDhWgprfNfzIGEgjku
         ha3l/8r03+uPTlRpXmekz8ShjATerxESjSekBExd7IUQ+YA0SpFeR7rsUNV0ftaPNCUG
         sHkxROJsLCPvfbd+qiKssOwgyYh6gnP/ZzmsuiNCatzXF2s/j0whVaQLZEzLbgxZ0/Zz
         0A6y4r0EfCUBXEILlGWqktc/r2QOHCtLtAg/+rvm7hOURkbWbfkAVl1ncExSpMdGniuh
         0LYC63TEJm8KgxUyQa+JV/cnNkI4uos5pH9ePOFdaXw8jpN7mgUhNw7a0GbMLkZELPS+
         kPSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713452727; x=1714057527;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qkjfb3yLqCQDGRW46T6X+24bq0FtmwZiN3Oy758Hvfw=;
        b=Do60OM/VII0taj3wL3ycRD/24w0scCrojzxINvY3i+JrvmKJWnkks4PlNUpZItna5L
         QLJkM1olIEmxpRjfQTQcPPgyHdaEb9Di6nVC9ZCbS1tVepv1jwX5ePFsaYp/9/LskxNv
         xyzBnk6RO/CSWpZPRqRGt45uDw7+cFouQGA8mifA/uymVHmkMZr65utXjXmkVywOWceo
         PVQyvkdz5gKea7AJCVaVBXzBlypFyBD9U5y7gFMKZ/MFLLv2PJvhXhVLr4dlVBrZh5wL
         Raoxd4ykoQrL7FeSaEn9jmdh/3yuLWyf8qPROiBYrJvSBZWW3CiwsMe7TGxL2LboyPff
         8Q3A==
X-Forwarded-Encrypted: i=1; AJvYcCU+B5y2KKJBwuQihbjwRCBEBICzmzjLrP9VI4w1iJ7IbE/T3US5Xr4yVRL0kkwkLdnM/M65ekYePiUChvCqCQBzadXv
X-Gm-Message-State: AOJu0YzUe+lmEhRfF6xzrGY1arLTxjqfkWzMz4q+nS7J8kpLzWoExQB9
	NCEcvuPQM6TSTm0h7EpaChkthqI7L6E9/g4YgP2m8m0vhPvPD9JTr8N95bXC9di9Pe9eoDXnnbL
	pm1zUepuKm84rsxDgqC7EUURdHjw=
X-Google-Smtp-Source: AGHT+IGkEpBNf3C1b70GZfloNSiAyJsL7N+SiOucZsC4kHX1/5AqdJbW8tFdRZdk+bjBkHePVC43Y4SfVhWLgCf/U5c=
X-Received: by 2002:ac2:520f:0:b0:516:ce00:d05a with SMTP id
 a15-20020ac2520f000000b00516ce00d05amr1670429lfl.25.1713452727361; Thu, 18
 Apr 2024 08:05:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240330224623.579457-1-knayak@gitlab.com> <20240412095908.1134387-1-knayak@gitlab.com>
In-Reply-To: <20240412095908.1134387-1-knayak@gitlab.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Thu, 18 Apr 2024 17:05:15 +0200
Message-ID: <CAP8UFD19J+KY51hVwQbnF8CaK_ZqqjdqW49qjGtJ8A6UtCJeUg@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] update-ref: add symref oriented commands
To: Karthik Nayak <karthik.188@gmail.com>
Cc: chris.torek@gmail.com, git@vger.kernel.org, gitster@pobox.com, ps@pks.im
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2024 at 12:11=E2=80=AFPM Karthik Nayak <karthik.188@gmail.c=
om> wrote:

> The 'symref-update' command can be used to update a symref, create a symr=
ef,
> delete a symref or even convert an existing regular ref to a symref. Wher=
ein
> like the regular 'update' command, the zero OID can be used to create/del=
ete
> a symref.

Is it possible to also convert a symref to a regular ref, like when
HEAD becomes detached?

> 2. The flow is now changedc to send an old_ref, new_ref pair in supplemen=
t to

s/changedc/changed/

> the existing old_oid, new_oid pair to the reference backends. This allows=
 the
> backends to simply do a combination of changes based on what values are s=
et.

I had a number of comments and questions when reading the first few
patches in this series. I also took a very quick look at the rest of
the series, but I think answering my questions about the first few
patches would make reading the rest of the series easier, so I will
take a deeper look later.

Thanks.
