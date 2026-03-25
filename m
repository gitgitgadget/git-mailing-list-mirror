Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9871B3596E3
	for <git@vger.kernel.org>; Wed, 25 Mar 2026 12:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774441203; cv=none; b=cAebfBE8Al1UE53HMaIDqguTmE3p/6okU4NM2W0dlQfNnpVmKHVtOg/8r5s6O07ZlI72wd2TNWquUKcIbSX+H2vPtY4HbEqQyEQaGnyYw1v11EsPX4aS91UMQ6Rbat9cxFrCQ9qOR7HP8S/mPUOeQFtl4cEh8caGJP0Q/r1BO+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774441203; c=relaxed/simple;
	bh=9awbQyTkAVt8NoGPZrUsPPPNE2eZUa7JnkoE3zvlA+Q=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=NbKPq2lAXlhasLwTbJ7OKW3Uew+IEzB+HaLBnQ4aaF0y9o0qBROx01E4chWUdgWGc/j4ECayzsBGH1RNhRkdJxy/MdQi17m4h8EC5SonbXaWxtPDJ6FulnsH40GgqXv8+hICSXg7jvMdi/2AuP18ktvuV1LV0AQpBsTU5wr7DuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b8VHxT2G; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b8VHxT2G"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-79495b1aaa7so57397347b3.1
        for <git@vger.kernel.org>; Wed, 25 Mar 2026 05:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774441201; x=1775046001; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qEjLsniM25W1o5h9zHc25KxxNquvYujqC0JbXjIcaH4=;
        b=b8VHxT2GDkltXxQax5+Rz7GpYEue1LyTRZ6xCA7BaYXrhL0O+8h4EMSXLAXFfk/jyR
         ODjYsfTNvcER2RvbQxxEEy7cBXhAGoKyh799H7BOjlF8dPZTIqirH5J/rM96tymIpELi
         ij7vCwQAPA1F+FkFjAnMFxiD1Hl9n8lBpNW0i5Pg3i0QXG3Stm8BZY7s3LjzZ0Ed7NqN
         Vf++chYZhrrdxae0N0JJBa7+3sw9VgDjj8Jrl9/yaS1M3SMpBKiU1rATCpVU8HP9WtBj
         mp2OQ15/WrXyMgI1lIG7Vp7tAYgR0DhT1FJOXzhbc6SZMEFBITowskgc7e/WjCtvovyG
         02Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774441201; x=1775046001;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qEjLsniM25W1o5h9zHc25KxxNquvYujqC0JbXjIcaH4=;
        b=Vl/CbDdAooQLQ3uq1CcR2dr7RgFKXOe2Z/wqKsCtdORmxDMLmcSqprU7aAd+rSC6ZP
         hekszJGpTN0Z+z+aK6BVI2ydm4Xy4c+CUx0LACqZ3PwkO5tsj3UbpGD3vkZebI2EORZz
         +1RBgTO9CpkEvhA/Hygvl6wBvzxcCErHcLgT/ifUZ5v/xX5ERsjnPSOaPl2c/3u2W8oY
         Fo08aj3WmZstWmpZGvtFrtDh9wlRlw+Vq0+IswY6Eqbgvqpe8PyuHVkoVaRdkr4Fmtsu
         C1QAC6eSg8c/UJMRigmcHhgq88Lx8QwxHQnGJOUo546q/YiNLW+/zh3b63Xp+gf7WVX1
         LgPw==
X-Forwarded-Encrypted: i=1; AJvYcCXahjUfRjqHYtmyAwF1+mbjaD97Wfu7XtkZdSyqg1C1GCQb6CrY2IIJFQ7gI/AE2n9E6MQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKhShDx79mxBjRb240RAoi26stfsZKxNLZb5/NjxTufyRgCh3d
	0HeSykIp6lbJE+V3QtkLfFKI+r6b53zfiUarmH8KAEYrm0824YxYM7vwvQY94cFh
X-Gm-Gg: ATEYQzztrl1j5WbHFasRRRwrzbiPT+EMjpZwrVcWEsjwzWVvAORFMgCBmKh7BbeYWvU
	sLLO9IUa0Xi3Phiu1anZKfmHTRtNwrP6bNl9N/Gj+iLlwbBKckoDArqgb27nskrmp4nPOAurpLT
	uslnLZn2egLPZy4nuQ/VRwcp9nBwUV3qTl0cSxDc5aT2b0FzidCJlnFqA9lyvmowcHxuF+Es4zZ
	Xb9aSIC/SN1SLXXd4RsAGnL1h7/NTXdI14nVc7tZ9ko4IJjMQ1U2jWyFfZ7pqByF/fwHaCqCCT8
	AeBFl+vGVcXtQK2z4hQb698qJ/al8nAYWkrXg4yNtbDVsl8kjOeozjKNQr66PDejeaVt9MW4ct6
	uiWohfVThnUAw4p2ST2OLfEUFH+htxFeffEq7cX+/tKNgZ6SbFOyVVe9olo1/meq2ZdfDqnKgxq
	xXxcivI0C0Ml+fd0xBP1tRMBs1iDf/p31taYcxtWc2BYaHHRkTBU2lw+jRMTkhlSxrG5iAPn1MM
	zYrU/+rvxLcsqF8EaGyWAql/Tjw6FqHkOiwZcolKCugfg==
X-Received: by 2002:a05:690c:f02:b0:79a:6eda:b24b with SMTP id 00721157ae682-79acf64654cmr36496287b3.35.1774441200511;
        Wed, 25 Mar 2026 05:20:00 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:90fb:c300:1401:5c84:8809:a31e])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79a90552db6sm87289167b3.27.2026.03.25.05.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 05:20:00 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2] replay: support replaying down from root commit
Date: Wed, 25 Mar 2026 08:19:49 -0400
Message-Id: <E0A14573-BBE2-4ADF-989C-E5B2A7E3E166@gmail.com>
References: <CAP8UFD1zJXnsm7POK32GqEu4xSC+VO5mfzUpM-jn+Nr1qvzEFQ@mail.gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Toon Claes <toon@iotcl.com>,
 git@vger.kernel.org, Elijah Newren <newren@gmail.com>
In-Reply-To: <CAP8UFD1zJXnsm7POK32GqEu4xSC+VO5mfzUpM-jn+Nr1qvzEFQ@mail.gmail.com>
To: Christian Couder <christian.couder@gmail.com>
X-Mailer: iPhone Mail (23D8133)


> Le 25 mars 2026 =C3=A0 06:05, Christian Couder <christian.couder@gmail.com=
> a =C3=A9crit :
>=20
> =EF=BB=BFOn Tue, Mar 24, 2026 at 8:56=E2=80=AFPM Junio C Hamano <gitster@p=
obox.com> wrote:
>>=20
>> Toon Claes <toon@iotcl.com> writes:
>>=20
>>> git-replay(1) doesn't allow replaying commits all the way down to the
>>> root commit. Fix that.
>>>=20
>>> Signed-off-by: Toon Claes <toon@iotcl.com>
>>> ---
>>> These changes might conflict Siddharth's series[1] to add '--revert' to
>>> git-replay(1), although resolving that should be trivial.
>>=20
>> True.  This round looks great to me.  Will queue.
>>=20
>> Shall we mark the topic for 'next' now?
>=20
> The patch looks good to me, but I wonder if the docs should be updated
> somehow, especially to try to avoid confusion in case users don't
> properly specify a range.
>=20
> For example, before this, `git replay --onto main topic` would fail,
> but emit "fatal: replaying down from root commit is not supported
> yet!". This would likely help users understand that they might need to
> properly specify a range like "main..topic" instead of 'topic".
>=20
> Now it would likely fail without any error message.

Having used replay in a large monorepo where I juggle many branches (so reba=
sing another in-flight topic without otherwise interrupting my work is valua=
ble), I=E2=80=99ve made this mistake a few times. Some way of handling it mo=
re gracefully would be appreciated: perhaps the root case is rare enough to w=
arrant an option or confirmation prompt (when attached interactively)?

>=20
> Maybe something like the following could help:
>=20
> --- a/Documentation/git-replay.adoc
> +++ b/Documentation/git-replay.adoc
> @@ -23,6 +23,10 @@ instead get update commands that can be piped to
> `git update-ref --stdin`
>=20
> THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
>=20
> +Note that `git replay --onto main topic` replays the topic branch startin=
g
> +from the root commit, not from main. What you might want instead is
> +`git replay --onto main main..topic`.
> +
> OPTIONS
> -------
>=20
> ?
>=20
> And yeah currently `git replay` is a plumbing command that most
> regular users shouldn't likely use, but I think Elijah's goal was to
> eventually make it user friendly enough for advanced users with
> stacked branches.
>=20
