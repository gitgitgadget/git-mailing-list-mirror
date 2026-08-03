Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD6641A506
	for <git@vger.kernel.org>; Mon,  3 Aug 2026 17:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785777555; cv=pass; b=XNkj2Zk5oYl4O3pW+cC3cXYHrEz04vfZpu+i4JvnzmyamVavoCQkquVgSQxnzYjOpnzPrMon+mxnDvV9YjswQ8imHcOcbLlvV5gOpfoLDWb0LDD1/mD8cKQOblso6XaaDmQe3Red8meEIs83umMOzB7rhwDAH0TCch07Aniui98=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785777555; c=relaxed/simple;
	bh=doUqj0uEsuwJuyF8+n7VpOija3hCP12UMFfwp/lCj6s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KiGRq84Qb7tAWAKfEEJA1qEU0k7CWIHZdkIDqlQEbIROHnKzUUDNsg+M7JhxspK3h+PEB7qaKPJedUb6U45ekPcHARbDrrHlEkls04XBOcY1lztc0vLBoYFPncUofzjV8+5U60eiH0Vg1lSg7DdiHg9VeGDzi13TlZl3FAwCs3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cFp6hwu8; arc=pass smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cFp6hwu8"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c9b373d5af0so2822313a12.2
        for <git@vger.kernel.org>; Mon, 03 Aug 2026 10:19:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785777553; cv=none;
        d=google.com; s=arc-20260327;
        b=exexuhzFn4HX27yvpqCOy5+rLbkQtnXlIyZWipQ6Go0DHRRQRW1WD83zFciVc1//Ca
         JaI/ujEsmCn4mWWXCcjJimEntEFam2usIrZr1PqXOr9K34a5HtgDwhHJ1+AQdxeFSIFK
         CChP4jn/6Oou4zADIw6y3uT1vnAIIvt/iVmnxROVn0YBH0ZLK77hrS0A6hlU4qo+JenV
         AGOnoe9t0hr7VsmCbMjR1btCTzrV2ubc3B9gn7DL/yaq1Rw8vOhH+8NfH39CWXdsVpjQ
         3rzw0EAexviTUa3IYVz2xQaeSNI70jzvgV5KZ4nR2q1eozMT1itFxb/lSWcM8lg71DAq
         ELIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Tc/Lhgnre0tHt2NZDDRLF5KZSsgsXTr3ZQktVsR46g4=;
        fh=xj50WnDjhkMZcgqGEX8buhQcZkZs0GQjw8JpZg3oSSs=;
        b=eK2Gk18rRR37sImQUY1k6ErgkY7KwssUtLtY03z6p7O/255lua/tn6miKTCyOmerbl
         G7/hznZg7lLJ+pHv39oHxMrRdm5HJqP6w8S6K9bPIhfNMVfmeq7hAjR1mev92VfmRbUd
         sK9R5IPHTaG/D9TswKSyyYDN2x5zqYfHa9ayKcH3KPNk+5KKoVuufrihCQa4WwBO6Bcf
         Cc9bEMawA+SUMxYJcmfVomD9fjEtnI31BVUzw0bRQd0Khn+wUW4iFTM3ojD4+lP/jqId
         TaWDlNsHr3UGStnuHqTfjuW/4GmpooolUZIza4Mnehy6kCswZiBE/lNdTaryGPQu63m7
         xoIg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785777553; x=1786382353; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Tc/Lhgnre0tHt2NZDDRLF5KZSsgsXTr3ZQktVsR46g4=;
        b=cFp6hwu8BNjXGAuhHBLVIPojCazeVtzqMHpta2heSra5e+90LecYKUn88c5W8nGv2K
         N9PpAj8L/CBHT80EIrUDhe5UnJf9Gy2SMvWgNWiEdCETJMHaO61hFrCop3JVWhxl4wi3
         4bH+w1AEONuLoGpHXv4febHpaBichazAZUNJsH5RfzXgB1yiWUPGjc3AXrQHf/Oa+Bl1
         iIsnl/uj9MtG+at0z/Ti6txD20Bh/q8LaYRk+gR4f5UNNli8YUY8G9nIF6jJ9RsW8Wio
         lWpihmyXPyOcbjYhPpHAWYAnJDr7+QHBE++AcivlcFdoRcMWIUlulbBoc6hNt1+TS5Jm
         5QDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785777553; x=1786382353;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Tc/Lhgnre0tHt2NZDDRLF5KZSsgsXTr3ZQktVsR46g4=;
        b=q2KKs8oist5OiFUvFs2C5Df0k/m30QPkWOlCABcyUjHg67aaVWJvjpaCqic6vUT+xC
         5lRhPmHJntDFEs7drebIFJCnvu2rlM9ku5H2iecLhUDKpkQt/2eHst5srHCWyK6MLa5s
         ZR1YmCvyV0A2+tNwJwH+7qpSwLKoQXOvkbcD01FQ3NmWmcrwwbxsoNFpo336A9gXOFEx
         j5x/lqb59JrzYBhNq25T5p5gn6B5+Gv1VC9pMfJLrrft02h4h3Ew0qhEoyuATr5AAz/K
         BlU6ooBiHBpVQFZeSOAxSZkEFfNGpywXipMtsyCptkXFqihs/6g926Ig6sAlrM/qlWsf
         v0LA==
X-Gm-Message-State: AOJu0YzOkldCdEIbBQye96y+jzLCQ9oV9GbZGxiEnsUrnfBAmvE+PIrz
	nZFh0D/BCkEKiKDVbLn0OIcG8KBmU27f6Rz1XuU6G/qRHRcz+CpzDS2e1kHnV5PrnqYdaxLHIal
	b2xEyFFjlh/H6asHVvINlc4JU7yFwVv0=
X-Gm-Gg: AR+sD13SxrhyDZEdaQGHnKNnUKg/qn+BFv8J2+XkGKAh6csgvT5qXUgcu9q6CGcZcrf
	C/IfrsMdXVlfydt06CvDtmn6oppiX7yg6AvFbz8y9esqVHUQVqzfDcNKEj16I/Ngz2fAIH4uHuw
	Kw5NXwaFFtcxcypdjzn4iUdaPqd8snkxPklEuXF4nSeNpE2+VxY+E5GnD8k1IVW1ReCgtBHPmIz
	HEv/G33FrpynJFbmZ6IJzobqBkMciG66Jg20c77887jUlKaMRmCUySOjjXDaA1aNQDvR1/+PdYg
	vS8BJ6zyi7qzILgoPXTicnIYts9NG8r4QidUfUvA7wDbDXgT/8x8hG3ZKRPT7CwCN1KyvBWaWpC
	hK/+AO0es0vkJzteakig/pdvd9CLRw9dWSfmzIX4R
X-Received: by 2002:a05:6a21:e081:b0:3b4:75c0:3ec0 with SMTP id
 adf61e73a8af0-3c92a75521amr9923858637.30.1785777553216; Mon, 03 Aug 2026
 10:19:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716165517.433849-1-christian.couder@gmail.com>
 <20260716165517.433849-2-christian.couder@gmail.com> <xmqqcxwmeiwq.fsf@gitster.g>
In-Reply-To: <xmqqcxwmeiwq.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Mon, 3 Aug 2026 19:19:00 +0200
X-Gm-Features: AUfX_myyOsaop0B1LQqh2j8UwJBhjFMd6AxZoIiUb-zlXlmKRkeBgV04cpmDm-g
Message-ID: <CAP8UFD3hnJLy=pE-K0yy+FisPdLQxAk6457Kur--gv+k4bB6ig@mail.gmail.com>
Subject: Re: [PATCH 1/7] parse-options: introduce OPT_HIDDEN_GROUP
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, Elijah Newren <newren@gmail.com>, 
	Jeff King <peff@peff.net>, "brian m . carlson" <sandals@crustytoothpaste.net>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Justin Tobler <jltobler@gmail.com>, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 16, 2026 at 11:14=E2=80=AFPM Junio C Hamano <gitster@pobox.com>=
 wrote:

> We have been doing this for quite some time, but I just noticed
> that the 'From' address your MUA uses ("Christian Couder
> <christian.couder@gmail.com>") does not match your Sign-off.  Could
> you add an in-body 'From:' line if you plan to keep sending your
> patches from the Gmail address?
>
> I suppose nobody has noticed it so far because .mailmap hides the
> discrepancy once the commit lands.

I hope that this can be resolved by changing my primary email address
to the gmail one in the .mailmap file as I just requested in this
patch:

https://lore.kernel.org/git/20260803170956.1162626-1-christian.couder@gmail=
.com/

I will then use "Signed-off-by: Christian Couder
<christian.couder@gmail.com>" and I think everything should work fine.
