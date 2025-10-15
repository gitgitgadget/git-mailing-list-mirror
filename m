Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BEE2FE572
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 15:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760542826; cv=none; b=KArKCir+csweWVSMZcjjEajT+8Ghj30EOfTIp/nEnvlvA8Wv51ikQa1PObT4+x6sb0Y22P0Zu3E5jkb4Dh2GJVMtqY2RcUOLrdKf9lFxvZl3DS6jMrJbfsIrXEtECwmu7nxlCeRXbbLTXjjRawCsYU8OOzrh2AJ7kwnHLttrzoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760542826; c=relaxed/simple;
	bh=Yq5d0eegpRR2GcnvxGO/kVwZ9uCcLezOKNPjvVyCck8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NK6jkLEopVJFH9tGcZJsAtEd4ytEhEy7/+jPM5h7JXbY64klv8EVzE8bu3YK9aWRfZAAvCEfNI1rADX+9XhnxBRE/7nrZAEvPeBDzdepfy68MoVQmQe458e0R0NpjswvEXl0twUWjybBTGRdvVC4rqWeTuHeSkacjp/vI9ZXejw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H81E99Ht; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H81E99Ht"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-634cef434beso1888452a12.1
        for <git@vger.kernel.org>; Wed, 15 Oct 2025 08:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760542823; x=1761147623; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yq5d0eegpRR2GcnvxGO/kVwZ9uCcLezOKNPjvVyCck8=;
        b=H81E99HtwxAGslZsbFRjLvlJiwgfulpUU67LZzj1Z5HeSo1/kAzA5xF4bYLxz4RY1a
         rMbdXa15qIUigk6KZo9L2GhYpKEhTmq1MrewwZHo09REPDHvgi/B22wLcGgKE/1xrOK5
         IyAaXZcVmGj3R/YfGDJetD9nRKcy8SIvD0iDUdYd6Zsknd5uf7e2uO4obow2VuxXnMOo
         dIV0Dgk1i+ETD+B0SL64dg+Hrka1qKpzf9DlrCN4S+Dc5x09D0XothHeEKR8sW8Rmxks
         Jl0HdXAukxED2JsPAnvYrNGtIX/yx8R6gPoWz4Z/lIi2ZN3O34XcB5vRx4uLb6kDvx0m
         VFFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760542823; x=1761147623;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yq5d0eegpRR2GcnvxGO/kVwZ9uCcLezOKNPjvVyCck8=;
        b=F5LdLwpQ63e6pltKO4IX/vI1G2pIXOIbspQvkDy/xF/zTkLznswEYo2EkrSCqRldjq
         damyEZArN/6i8r3mej3lR1sX+3sFcXT/ar4EuhobaBQ7nsDPY0J6XvZ9mTj1t0/y2pmq
         ebeZJVU6KeAe16vLWeUHh/QrOvUYqxs3AGc8X+x8cdG3WltycR6JM/hzT9wOKNhDUGYe
         l0SYzomqTT9uoRueZMzOnoHpySy/o4YaRtxKMtcMVzusc2Z9xhkzL2wrMXIAPHY6+tKq
         PZ3TEfXbwunVuGq1C+CQbDu+bk3dRrb+UaH88oWG6UE4GeULAzrRolp+bzPBD4RV8r5m
         xLtw==
X-Gm-Message-State: AOJu0Yz7T5JSR9jupnnKMNe3fSbmK43O0q3zu68upgnNXYe6+3Lr3okX
	q2qsT7SgWoeEiZz9Qz0xsjn1RmYBZVkBmkbS5RBlNXuDTIAcZdajngfd5BuO/ocGuNCNk+AxKJ+
	VSFnJxXtRVUKMItkqg0xGQ/5Htjt9VmuFy3TemD8=
X-Gm-Gg: ASbGncseGZ5tccnr+/PKk+b1uTuTH1bR7jyDwRgle+5CMVZwS+Qi/15IZYv2b3ZNA59
	xsh39Ltcn59dXqjTrWFCrCMBOCNC3w+1llZmJtmlQ+8U3dLC0inteeEGq2/J7tvg6Mvrw15VxTy
	+L5EDqgXdCBI4miEQqWtxKa/38cT1eysC1pdvIjkO77A3IyR33WDTMsbU2gL9qSTpg+SOcbikNo
	jqQf1C5eGwg2VUTea++/6aPVA==
X-Google-Smtp-Source: AGHT+IEKssciGYqlIRArwwvNMScDDIYj6hgFuEsjPF7ZmavnQin9orSMVFru4EpbGD3rewiKDEXq91ke0oObcaxQXlQ=
X-Received: by 2002:a17:907:26c5:b0:b46:57fd:8443 with SMTP id
 a640c23a62f3a-b6053915a0fmr68588166b.24.1760542822808; Wed, 15 Oct 2025
 08:40:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1760490943.git.belkid98@gmail.com>
In-Reply-To: <cover.1760490943.git.belkid98@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 15 Oct 2025 17:40:10 +0200
X-Gm-Features: AS18NWCflmy7cN9wCqCmK7N58hk2tPqwPUDXynaoM3LOJ0za96PbXMujf4H8nlw
Message-ID: <CAP8UFD1paGeMQZ6oOHau4YBiSC8U3csWHFdOx+ro-8xOO+0wTA@mail.gmail.com>
Subject: Re: [PATCH 0/2] [Outreachy] gpg-interface.c: use string_list_split
 instead of strbuf_split_max
To: Olamide Caleb Bello <belkid98@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, usmanakinyemi202@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 4:19=E2=80=AFAM Olamide Caleb Bello <belkid98@gmail=
.com> wrote:
>
> The array of strbufs that calls to strbuf_split_max provides are merely
> used to store the list of tokens gotten from the split and no edit are
> done on these resulting splits making the strbuf_split_max unideal
> for this usecase.
>
> This patchset replaces these instances with the modern string_list_split

A cover letter like this should be used to provide broad context for
the changes. So if there are there patch series or merged commits that
started doing something similar, it would be a good idea to mention
them or give a link. (To properly mention a commit, you can use
something like: `git show -s --pretty=3D"tformat:%h (%s, %ad)"
--date=3Dshort <commit>`.) If there are mailing list discussions were
the topic was discussed, it could be interesting to mention and link
them too.

Thanks.
