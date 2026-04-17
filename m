Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628BD2264A7
	for <git@vger.kernel.org>; Fri, 17 Apr 2026 22:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776463366; cv=pass; b=MUXs/5VuVL6WZIHW5DDK1gGiZej02TzxTpRBtS9bfeQhEmMQzsGiYkQw84HPWbuKBJEUHi2w8BNXv5BaYwN12Hu9KPScvz3osGmNrn3dS1FBGd0ovICV6dOzPB5WxBIbOuKMrIViB+jEFi1+4mpd72KekWMsmdFOrCFeTAO6UDg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776463366; c=relaxed/simple;
	bh=xDUDfm7/oEh9DGOXXIlRa0O+uok/jiz0gs4L+gdIvU4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KsA3+woQEECQMG3pLVhrNKs6o/nmA/VJ+ziT1fXr4TVVQNJFYsjJvEgHQB2SPW+CD1pFhQ4fEOarxCvWW2QT3BjMDEoa3lZvupmVtMbbx2ZYBfTnrpyM99yCHdmr12+5uJjB8mxz9c77IM+cf2WtDHuw3yh+19Fh/q27qpB0QJY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JcIQyLjf; arc=pass smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JcIQyLjf"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-479932ccbc8so757317b6e.3
        for <git@vger.kernel.org>; Fri, 17 Apr 2026 15:02:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776463364; cv=none;
        d=google.com; s=arc-20240605;
        b=jnZ0ewi97QtHQidj1WTxdQkYl1XjO9MdOFCkkthplZ59BuV+FCSDtf4RkFE4ami+wo
         MxtxqdOeX7G6uOUMT1c8Z/P7FxSZuPg1xP0+62OiW+jX1NXOMeRSIcGYvZZoIvlvA4Zg
         iLEkJsPSVjYihe579MJPfyzNyc5BAwFOvuGBu1kXhPHN9y8SItPX0KRFxWc6PKxtY17h
         r+nXNRh4hwg+l0voGprtas0eW/ZbHn5wg7EWhKauMny0/Hpr/0gdAzLuRxtoEHE4hdij
         g8oI/Noq2hm8zMFpu2SNAvsPxchhFSmx+3X9OKW/lGrYLZJ9TgSfLxeN2JtDiCPlKWc0
         WGEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EUCrL4/LpDkb0PM/nWSqmE6G3ozR6zt3kJ1nqE/ho2U=;
        fh=HJXOKLvbngItpt/p1MrUoWG2Ov3STV+3cjMweAVE454=;
        b=AEMZA5fs0OM2FQcrlMbWVVLq1zo+362/tW0sPoeUeCHO1BuIZe2hoPCW2wJ5dya/xn
         MT6Mj2UjRqfBw62x8h2UeayAKmRYjSd4+dl2X5v+00Hg3eluUvV4aqevMXMNmtPNH6GS
         ojuktihQu/JDe2xJit6Gzs1cB6GPPAAOcbKxxvdx73lHPHXIqLuTczFzh6NZTc2SlMb2
         jgZRXhNmQ8fbxMPDly7gAiNCt8W8EeHJiUijSWaE+W2EWJrWeH8lak485jSZviSVCCvz
         SpDlprynOAP8d6lQylr5UohwuRd984J+XN94tYK0oN7iBSG5IaKTfoBBQnxvm1DDS1k2
         2Xfw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776463364; x=1777068164; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EUCrL4/LpDkb0PM/nWSqmE6G3ozR6zt3kJ1nqE/ho2U=;
        b=JcIQyLjfFAMj6VPa0z65JSIkWp5P1037dbPZXxwAQHb7i5LN6WVQxHtmJ9xOU0GTDb
         sFVSnNrknvu+HV0oRzjNL5WGpL+1D2wrlYfFgzk1DkPurCFlxJGFMcTzW4yX3xgD6GtO
         0P3mrtKWl93WEEoGXRG0cvxgNNcfLqez7zbfXMrTkZxL1293/oaLIep++FMTScm+gzAz
         zGH2gr6/YCVUmP/QYhvOQ+xE9mBMj2is7XU7TJPzUjd6OMKEj4TyOwSnHLanjVcKjgnq
         yYWR8hlSqrqdSc24VahvP6RnK5UyyaT7HTbkxL4F8W0/OHGx9fmaCj2POQtEy3vDlwQp
         UJYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776463364; x=1777068164;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EUCrL4/LpDkb0PM/nWSqmE6G3ozR6zt3kJ1nqE/ho2U=;
        b=BP58pEU9UT9biJSKod5oi349rBONWsWoHWRGw4ZasN57RUrOzw/2gAZXT+W12Bj1wN
         kw8/vPwxOyqa+YDyk6kPmA/gJ/ZFM5MBjyrl+C/zYZZmlwcN1kRSIa+JK3Z4ApAxxd0o
         CiUNQfdRN6UIEK20o9NkoctJEIioZoSBS/sUU4HCv8KugTlN9/TvhJc8MHm9+g8mQZ74
         ePeXjGy51vU+Ty2IhYS/dvWek2va/Pe21I8j5zB8chu9kzUm5s9hy88zMY638ME3Pih3
         UlGS9yXOyXv1Ayzj71f5SYfaxg2i0e2TbjP8wnXP4ZJD6UgaJjIbyhN6w+DqfBy54shh
         gU1w==
X-Forwarded-Encrypted: i=1; AFNElJ/Y7J9McLJzscZ1Ctxo+FTcUwFE3FYh4bJ7iMcObqzcOZWtw+ZzGnq7S/Qp2L47qJaXV1s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxySYvRpDD3gIA2qlCrGk7cgbtoJIroO9SMuyDOmHz270mFm7XM
	eiSLCyJeDbZSLkuTiYpD8WB78i0lF9BdF0TwBxoojIOMU+1+L74yjFGWmwpk2xA9LYkgFyIve58
	39i6GeJbn0QY5ig8ZauSAcJpKnR5RjAZ01A==
X-Gm-Gg: AeBDievtSsYrDnjT4xSRgMJbbP4UEX8DhJsAg9u0zmSHNbKdo5JZffhH8+vqgOVDliN
	O2JjGk25PwZznpxKONHNjmAOoLPN4LW1TU21dn2GRkPE6JlkDgQk4IlWUQXVWV7Aj1168w8I7C4
	ndEk/s31GmgiF1N8wseJoN7iaB98FUC8aDRCWz0Dr58PfAoGcL65H64uPc+oN4Sb70tBbH5hYW9
	VXx+shkZqC46AUy1RMoV+2wOXGpO6+RUU8rNlL2/G3Q6NbN2P0t6iR6RRp7GP77+LJhqWeZ+CXW
	ZbDcvMsCcBoXK7KFWpdNBFpyVWUP+GB4TmOBKHI7SMJCxg6eUJLIJ383kvjdZjNhcq/PC0HYYq+
	Nmvt6iKY44sytfYfR+fhTNtD9Sg6f1mymoZWu
X-Received: by 2002:a05:6808:3447:b0:450:bcc7:18d7 with SMTP id
 5614622812f47-4799c876d26mr2465228b6e.2.1776463364136; Fri, 17 Apr 2026
 15:02:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2089.git.1776379694.gitgitgadget@gmail.com>
 <610be2a49a17620b2e5cfd3b7d9d38977ef77afb.1776379694.git.gitgitgadget@gmail.com>
 <xmqqbjfhw9fd.fsf@gitster.g>
In-Reply-To: <xmqqbjfhw9fd.fsf@gitster.g>
From: Elijah Newren <newren@gmail.com>
Date: Fri, 17 Apr 2026 15:02:32 -0700
X-Gm-Features: AQROBzC-MeIGIe-A-FTwd--0zduGDNHlI86GOxoBxv5NxES1l5aHAGr01_v5I9E
Message-ID: <CABPp-BGWGBzc23garD_WyveGX+s+SGmNYfWzENnTx656w6raWQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] builtin/log: prefetch necessary blobs for `git cherry`
To: Junio C Hamano <gitster@pobox.com>
Cc: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 17, 2026 at 2:42=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> >  investigations/cherry-prefetch-design-spec.md | 210 ++++++++++++++++++
>
> Did you mean to add this file to the project?  As a document to
> describe how "git cherry" works, it is vastly lacking, and once this
> series lands, I am not sure how others would benefit from being able
> to read it.  Many of the materials in there seem to typically be given
> in the log message, but not to this degree of details, so I am not
> sure where it belongs.

Ugh, no, sorry.
