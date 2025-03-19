Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E15A24F5A9
	for <git@vger.kernel.org>; Wed, 19 Mar 2025 08:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742372278; cv=none; b=V9DDo5KjpRbd4FzY+x8dyfpM7UZMc24l75dU7Km5/H2Qh0Ug/jmaIQeT9ii10enTTTLh7aa5Us39JNwzlMSkUFlzSY7NX891Q6G8V7QboGvK8aJkRsmOszk4Nbb86ysyGif84rTgZFU9CBkLVH54gWzc9F0wBLujqc6X3kS2JOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742372278; c=relaxed/simple;
	bh=6D0cnCQhaDOZ90StdkmlWRwfuHDk6dLOM3zDPQZBqPY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sWojfQ6kYXaXuMzaAiNCSc9JG/vOaSaxFJcAqA2d6fHDSRiqRwf1hRlCoiRRHx1KahDUyU47Djh0WoWJrm7f9J7fvOApdDCZBIYTIvxGnCD9hSzAZI2xohy4a8CzSuKryFyZ8YzpXyy6pFQQJis4bSr2Xh+/C3bzzL6jYkMDMmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RTqVBnbw; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RTqVBnbw"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ab7430e27b2so42245066b.3
        for <git@vger.kernel.org>; Wed, 19 Mar 2025 01:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742372275; x=1742977075; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pTCa5YSJ3e/KSn5nwnU5wd5x5Abv8W/F+aykHtJrNmc=;
        b=RTqVBnbwfNmvPOdCJYDyOoxv5QJ5KIQ+qG77Mruk0HyFHxanI5W6tICSNLRQBjiGbg
         ZI3mhlTnW8/zpghx9Wix5XC2mcXltbi/SkTFL0pQTjYagXoTbRmmg2VaZAlybllZKP99
         M18oVucs1G2uzItxDtWv1ivuGRVbXGTPAq4N4VAmgFmnlsHvX1ZwjgoOMIeNVi6s1lNr
         Zaz2qpV9Wkkp3DCKiyMmTPbeVNcLkA0etmv1Q1KLhZZzgQ24s0mueG4eQ99xG7trj6pF
         BmUZQEfsWot2jUCTLlBeWnQhgJyHuwecqvvT3kLBWFVkgGDw7JNP/HgjNYOLD/h3gbSV
         WwIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742372275; x=1742977075;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pTCa5YSJ3e/KSn5nwnU5wd5x5Abv8W/F+aykHtJrNmc=;
        b=XdjcGTUqyeGFIUmC0u5l7tpC76+ecdgMFzVYxaCtvrBJy1G0KLBJS6N18d9wWf3E8Q
         YVWgWm9V0biDSlN9KN7ZRVYZ9dGr++WXrCgrx6BxF50hbvROyZ9n2NT91wrY9dDx+7RK
         X1Ix7IIfpbaFZE3+Ub+idWXTktTh1uosu8aU+8M9TSkPBabJZVnudUwAI5nWLs02IphG
         yyF0lYXx2Jk61fejScdwj2bFVweQ2TuaikP00kNwLxh8UXPA2o9r5xv7WTcjE9doDFXH
         BetLCEQvb+m/Ew3wpsX7LuS10qA8LwJUTP5okZ9EHVo7U37EkkJFZOChdUkNn7O8cstE
         gwcg==
X-Forwarded-Encrypted: i=1; AJvYcCV6tI2MrLW9NRhC3JtIPFVSfjw8kQXDsVMnwF/wYYlwNmglpENx6b3ybw5M34hRyaXWwKU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzO1BkGxWIkGd1d8RquPUWB36MY0wnes+HKyvT9neKPjQZex6wb
	eIEMdYEZsZNr+HrOIC8J9EeJ/832g0L2gS8oBzdanGUQDo9ESUtGEi1YbLXhf0jXjDtqkfUcz6/
	LmVrXg64Ramuxt2R14A5nMSqZGaE=
X-Gm-Gg: ASbGncuexOkUS4aKSBxdvRHgdEjSl6qCUm2eVqOqaQOBztD8OSuHfpoz4Paw3ka6MUu
	6pti5Gm4PSSjKRJUTW1qYfG6+BgqGzEL0CvqwcK1rogyw1fenHvS12HKFkIggyannxCvnDJTNqD
	ftEOPthCg1wC+e43j1f1f4K5RvdxW6oNgJu+Oz3sUHU5Mb/aRyTpwOrC2whn7PLjeyg6cm
X-Google-Smtp-Source: AGHT+IGdXfETh5cBFZLcUFQDvkyhXLQs38/TMcM6qe90IE+/AupQ5CGPYp4sHQIYdBYApAOblBuY0iJjFWgkbs2+Ehg=
X-Received: by 2002:a17:906:dc95:b0:ac3:3f11:58ff with SMTP id
 a640c23a62f3a-ac3b7f73047mr183274166b.45.1742372274384; Wed, 19 Mar 2025
 01:17:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250314-493-add-command-to-purge-reflog-entries-v3-0-c24e23a6146d@gmail.com>
 <20250314-493-add-command-to-purge-reflog-entries-v3-2-c24e23a6146d@gmail.com>
 <CAP8UFD2+xQQbUevHTQangg__dq2M615pHLhYYUf7b9shpShD9Q@mail.gmail.com> <xmqqsena2pzh.fsf@gitster.g>
In-Reply-To: <xmqqsena2pzh.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 19 Mar 2025 09:17:42 +0100
X-Gm-Features: AQ5f1JqMboNCRlk-Xv4LL5e7Y-UomKZZW4qrG8C2_12ijfhB5AmdMaZy5hWrT5A
Message-ID: <CAP8UFD1vTkPH=5b++6+=koozC31=wD1gQszvdFmzb73B9HM4Aw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] reflog: implement subcommand to drop reflogs
To: Junio C Hamano <gitster@pobox.com>
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org, ps@pks.im, 
	kristofferhaugsbakk@fastmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2025 at 6:44=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Christian Couder <christian.couder@gmail.com> writes:
>
> > It looks like 'single_worktree' is only used here. This means that if
> > a user forgets to add --all and only uses --single-worktree, nothing
> > will happen and it seems to me that the command will exit with code 0.
> > Even if `git reflog expire` already works like that, I think this is a
> > bit unfortunate.
> >
> > Otherwise this patch series looks very well done to me.
>
> In the thread Toon too seems to have noticed the same "what if there
> is no --all and --single-worktree is given?" gotcha.  Together with
> the "current would be better name than single", we can consider that
> these funnies are to be "consistent" with the "expire" thing, and I
> am OK to see us move on.

I am OK with moving on too. We can "fix" the behavior and naming later
in a dedicated separate patch series.

> An alternative is to "fix" the behaviour
> and naming of the "expire" first, and then use the same improved
> behaviour and naming when adding "drop" as a new thing.

I would be OK with that too.

Thanks.
