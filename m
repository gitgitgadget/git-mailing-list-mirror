Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FA1306491
	for <git@vger.kernel.org>; Mon, 10 Nov 2025 23:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762819123; cv=none; b=iMcVqraNDi5SOzGPcuyhNyAFS1asJjCRalvSKbzz79qbhv/TLthM2pXp7LlDaxyVB9I8sEPsXMU1q5pl0Edhs1FaavUKAfukvskfGNVM8zi7RwxsZGJBxtXAkAWPth7qOK3hMq9hK1/GsPgIi7PWUumM5e7i8a/8sUxgWArr2uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762819123; c=relaxed/simple;
	bh=RG2gsLdLqRIL8eWHd8qZNSSIHGqKo0VfNnAXmxYmMJg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rThCnG0AKne6e0smHumTio3Vve5AWsdJuaAaB+a890qGbAf+fUAzw1rPgVwo7PcHR+wO1nxErsy8VuCI+CG6kyYx1IdPSigiImK/eqkA4ohZsjkDc0tqqTe4fBxyljE+OHUdMTz24LSCR3SUy5iV/Ydq9JKh72Mqm7R1IRoEJFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P3QzEuDM; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P3QzEuDM"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3414de5b27eso2941864a91.0
        for <git@vger.kernel.org>; Mon, 10 Nov 2025 15:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762819121; x=1763423921; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zU93X6KVczRIXrRM/N4qCY6R9y4jgJo0mZ0JXsu3bhg=;
        b=P3QzEuDMJ6A4cVGKClLyWcwM8ayhFZZRt398KY4UJX+VwZkiFXasuCOp1vpqftLfww
         gxgEU3zQJqnXy9dyde5UuUjwuxEwjLEpayf2RJGyGxOjqzZ8LCzzBVFMeTmNjMroIBrU
         UVAT4kbh8JQge9Q2lnljtjQki1UfjurUxhvp0OivjS8IVehhw1VRdRiFntrNy/OqhC2E
         8PfKGgT1a5ZIocgK4RtJLN1ZMnsF4/fsI/SPEMZJCDv6B0j9BcqJRv8as2IR2xJaeARP
         EB4yJfQY0J4mTohfSZQgZn42HAzK0ced/5Na8CdzBoqtjDFay1NShPvNjnzE4b50G2Sd
         j/aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762819121; x=1763423921;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zU93X6KVczRIXrRM/N4qCY6R9y4jgJo0mZ0JXsu3bhg=;
        b=qJ7LZ8V9UPb02xAb/ifgEm8YXRmD6qMT+9nIr8KzyM8xuM6mEciTFpCNWn+WX0nthO
         +JeW7fBVLKaT7peY+VEk3TG3gkK+pjpYwBeeQJhoKxh6PvZ4HeSm0Ts7INIrSsDC+ix3
         xGdnibFXGk+aJJv29bnrHaVoRGaZd1lWLdg7ETyNWaQdNQ6oqOy1Ox34w9r0aUTqVk6v
         q3jZh9M/MrMGN7FlER4diPf3XG8wkMzdPqByF51cCYiOJOeeXQcQb9/IiusnFV9Iu5in
         C698Anx5KvJOC1iYiJD8T9kNyaOJ8WDJt8eLTt7mpo5tRJv1toXH7t1ODfzQzR1/dBSs
         12Kg==
X-Gm-Message-State: AOJu0YxiZyddeLwD3VUKuAEMGn6zUy40c9jRMJ31jpN3Hw5A2rFwD4xB
	z0VNSGeqkOTcC4gdFp05RDA2OV5GlHLGnnMLI8yJYwqRkgEpervn5K5gvHrbuuoMckwpW7ZND27
	XkU4JfYsHhR9VhJgCtkXLK43JoCDbdCk=
X-Gm-Gg: ASbGncsC1GlzfLQahC2znscypvKyW48nIMp+8N9EhTBxW+5fq0g3rwS8KvaWl950szq
	iP8r9zENrn56VUe8Atmn5vxEZufrwjG9dlpSrPMV4D5yU+UREVnFq0f1u4MqkAUT3g3b47Akzje
	S0HtgSLA3deDy7nrLfTqLFNwlzMu8sqbBdh38w9oWOgx6FMD8vI47HQcilVRgOeX8TqV1VjujLv
	PCM+cZgDQ9nJsCXo1nOmnsd1ufJQW11G+AQvAm2F80AQig0UhHhyk37jJLrDi5YJJ7VaDH+
X-Google-Smtp-Source: AGHT+IHiVRn0qQjnyt0MgkrYjuArFAvzc5gWUgIUm2leXUe6IKOez60Tu3hWUIKkU9VBAk0hE5kZaJ18enNuW4xwBkw=
X-Received: by 2002:a17:90b:4b0b:b0:334:cb89:bde6 with SMTP id
 98e67ed59e1d1-3436cb120afmr12802441a91.4.1762819120633; Mon, 10 Nov 2025
 15:58:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALnO6CBsj+aMvHJoUQ+LHAtXhcFhQeH8AuHyrX+rumur6MQQog@mail.gmail.com>
 <8796cd59-2335-4674-823d-d682ce7b7f8e@web.de> <CALnO6CC+ke1L7T+dO13B0FSjLyJqihKHKZaa-B4dh9guxk7z0Q@mail.gmail.com>
 <916cf3cc-185f-447d-845d-a65eddee4a36@web.de>
In-Reply-To: <916cf3cc-185f-447d-845d-a65eddee4a36@web.de>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Mon, 10 Nov 2025 18:58:29 -0500
X-Gm-Features: AWmQ_blBIbmn67lRGr8dPQqonHFOPseDSzXhyb1hKk2kD-tlhJGV8S6XXkrHN8Y
Message-ID: <CALnO6CDxz3eKFfJgG5dQF5sUutT_bRrH0itpLtmRj6cW_=WPBA@mail.gmail.com>
Subject: Re: [PATCH v2] diff: disable rename detection with --quiet
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc: Git <git@vger.kernel.org>, Phillip Wood <phillip.wood@dunelm.org.uk>, 
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 9, 2025 at 1:35=E2=80=AFPM Ren=C3=A9 Scharfe <l.s.r@web.de> wro=
te:
>
> On 11/9/25 6:34 PM, D. Ben Knoble wrote:
> > On Sun, Nov 9, 2025 at 11:43=E2=80=AFAM Ren=C3=A9 Scharfe <l.s.r@web.de=
> wrote:
> >>
> >> This actually fixes the error code when using the options --cached,
> >> --find-copies-harder, --no-ext-diff and --quiet together:
> >> run_diff_index() indirectly calls diff-lib.c::show_modified(), which
> >> queues even non-modified entries using diff_change() because we need
> >> them for copy detection.  diff_change() sets flags.has_changes, though=
,
> >> which causes diff_can_quit_early() to declare we're done after seeing
> >> only the very first entry -- way too soon.
> >
> > This does describe the behavior I saw, but it seems to me that, if we
> > have changes, then we ought to be able to quit early for --quiet, no?
> >
> > So there's some other knock-on effect that causes quitting early to be
> > wrong here, and I'm not exactly sure what it is (other than the diff
> > queues being different sizes when we hit relevant parts of
> > diffcore_std, though it's the working case that has the larger queue).
> > So I'm having a hard time tying this paragraph to the actual issue
> > (mostly due to my complete unfamiliarity with the diffing subsystem).
>
> run_diff_index() calls diff-lib.c::diff_cache() to queue up index
> entries.  As mentioned above it only queues up the very first one, no
> matter if it's a change or not.  In Git's repo this would be
> .cirrus.yml.  That's not the end of it, yet, though.  It then calls
> diffcore_std(), which calls diffcore_rename() to remove non-changes
> from the queue and overwrites flags.has_changes based on whether the
> queue is empty now.
>
> Ren=C3=A9
>

Thanks, btw. Still try to absorb this part of the code, but this helps :)

--=20
D. Ben Knoble
