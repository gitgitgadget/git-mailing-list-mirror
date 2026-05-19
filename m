Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A031EEA49
	for <git@vger.kernel.org>; Tue, 19 May 2026 02:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779157911; cv=pass; b=cLl7CfJMVpnmSGxfWvH/2pj7LQo3bDqJfrgNS2gNJQTQd4szKVgMC9/u/fPvqxRPrx14yAlGX8dN9Ajga7VwepsfEJ49Fxif96AaC16urwZQjtoXgEUOlE/fYq+TYqTEAVfQMV8pxyLFOQAiJraqPaQU3E6CYx/24WgdbS/SbTs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779157911; c=relaxed/simple;
	bh=YMwTXszDU2xrsjRHdrQ80knsNFt+gvueSIJVzxaoM/E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C7AKZXP/ivBzxsENYELC8afo72XX6ZvpYtClO9wXiFtnvvOMPC6ebxFg4J2qYvHM9WacFaiXrZFhHoSfA38OQD7CkQTiUSxXJQ91pkjtA2WSzEBT+uTvcjuNFkHLJBS4OkWctSq+ZrfP3vPHUBCC/jB4fs92G7n9/ppcTku75n0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NvLZh+DV; arc=pass smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NvLZh+DV"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5a8d1f43432so5466879e87.3
        for <git@vger.kernel.org>; Mon, 18 May 2026 19:31:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779157908; cv=none;
        d=google.com; s=arc-20240605;
        b=ZI5O2u3sHCNygdqhGzidku2IZjMbBMgsW00Y9yZOivVZsgjO7bPtsd3m6xHbyEpjNd
         wmg8xabONvzZh9U+/INGas/h5NVvgMs5CniR9perYffhSdvS3cRXDqesEkrsYGA5w0+R
         stVjMovgu47cfICV7nZV9Fw4UIFSP9xHGmxPIJVp8I/HSuo4v4Ebb5bkneM80oIVbKId
         z2OwrLqAbIIlUG0VGs1c9WUcJQDrKqIy8yDnZsP2j2XP9jeFuXs47bsUArsn214jRTKR
         E9UV2LPZkoJd39FuOA6sPXr7AwwY+lFXGNbv6f7seUx76hF9dCqeoXkCcLp9vr42/fLg
         Fnuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jOgSxd923ILOu8gLAPvBLWzM7CDE4+gGD7u8rk4QnFM=;
        fh=fGi7tw2ILZiOzsk9sUI0bmKLTL9qem7HyuUZnWN1ULc=;
        b=d2fNnaqhBHlLRQYSz+QXBqtMooNebbePViB3HDoThU8YcwWQ/OsgifV2/mDHmRi59Z
         y2oTdvt+beFnHPMuUhGE3CkniEBnmB7RXaB/CkzRgo+eAluNhoxWlocHF/G6wg/BmBhe
         zmUtjZhq2WO1OD+OHy2k0p9fu2VvI4YI0Y8qnFWYqY1N4l1/+06flEo0WqAW0NB5JQMQ
         Inn61b7cN/RvXTLsxCckoQLM+A8exb/XpsJfBF4i2ElZ1PpuL3YK4ANQ6hIr3qD1mVdI
         lGRJoK7P+nCU20ucC/kjY4+5MMYHmXnM+3HQB89H2wIEsLxDE2kgIRA15Oe970BkNJtB
         QWPQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779157908; x=1779762708; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jOgSxd923ILOu8gLAPvBLWzM7CDE4+gGD7u8rk4QnFM=;
        b=NvLZh+DVO2UevNpV3CLCWc1qOLKkXe6Upv4N3J58FrXVtx3jrivULUgM7gpK4pM6Qf
         FVkaDDxeEr/ma7USfFIxQV8kcu/SgW2ssIR1GB3OrAZYpnckP2WjtEykFyJor08VkHCP
         4Uksmrn7vNixMiR7b03N8R0IfhBNdY5A4LftVp1iDds/eestYLgEW03eaOaUAJQI59qO
         VyImevOKOCfleojtv1js+qp7fdqyijnx1/2jPP993VNw/3qch8EJmK+DU7w6Kb2tivWF
         7ma8ZqqToo6ZQW+V6AUu5dLtC8mqvVM3T1CzBCuc5Ee7tnM+zpRr/UkS62JWPk/v5Bte
         9r1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779157908; x=1779762708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jOgSxd923ILOu8gLAPvBLWzM7CDE4+gGD7u8rk4QnFM=;
        b=I5lMmYNoTDERNA7JXDEiWhjrAJhpOIXfTKnpQiaspOtR5C4IAbl6VZwi5a8dliaCiY
         U/abVgaDURubVESvjH3/pP/0ENt/aMti4sszhhHhWgfzqRIxUiKvrk+6UhS7fBptnHlp
         bjb8JLF1yfB1Zk0xjEXuvxgXeI6NHQhahqvSQ5u9qtu+cRptF8///CriC+UYDfC4idVY
         YYLUpTa+6tKXjPpNlIVtzAUUiwgkuvP33QyH3hi4tb5U3bGEnGNCo/Q7/vQrlfyvGjki
         osFoNkqbAHyM4DDf5bnfPWZLMhP+XBSp6ll9DK2QtUVCEjnIki6bkPqIovHomENDH/OZ
         upXw==
X-Forwarded-Encrypted: i=1; AFNElJ8UiZGKRzDbmaHDcaupdXnM+7PYTm0iZfg0/cAoEwgCUuEq98VoX4M63+dyjmzBTeyGkSA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzsx9be44gQB/2NoeSa2KCeLCOkHqGIQTG+k3nonqPUke3wkf6O
	B2QyT0LF72xddOHEmn2ZkrvdquTm633Y0tJtSitGOPZxF3MB7ZzZhfZpklXwAwxWpKtG+mo5c5j
	a8HOWjFH2k0QaG379xCpPXU320Oj7b8s=
X-Gm-Gg: Acq92OEUwKbm8/vjli5zg4pbVwXd4FjqIh0Ou6hSS6u+Mllt99FqolR39e52rFTHJP7
	u3Z7Khaae3EtR9U2qH9qx9+3K3OFavI4QWsNrnj5l72+AanvOHwyURAG8sNWkRomZjwwDi2Qbk/
	0AfLC3cXiSXPov7IM6AvRxtIYhqb/qpIs4Xt4MtDJHRGplO1ZQN3MLF52Joc8+bNLq3/nrQHHIr
	1JTZlyNNXB1Wduj8dD6g0GDD+enu0aaGbVESpDDMqtvNpJ4jqoo3MFn56FMkBE8utl8uNlStO9S
	srwDQZhz
X-Received: by 2002:ac2:4c47:0:b0:5a8:886a:a734 with SMTP id
 2adb3069b0e04-5aa0e60d297mr5276514e87.5.1779157908143; Mon, 18 May 2026
 19:31:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAC2QwmKRyYfE+30Fh75gvAEmJjk8g-3k+G=RDiEJ-KGNExAEow@mail.gmail.com>
 <xmqq8q9migqk.fsf@gitster.g> <CAC2QwmKORPnsmV4SM_CnmhrbF+X754ae-n9m1fgjvVsL9d-wzg@mail.gmail.com>
 <89224cb5-27b1-45b6-93d8-a0ad5e2447a2@kdbg.org> <CAC2Qwm+BLNf-2kvePKNF-FKQX3raOBzSRmwd0ZEdzmo8TqkMGA@mail.gmail.com>
In-Reply-To: <CAC2Qwm+BLNf-2kvePKNF-FKQX3raOBzSRmwd0ZEdzmo8TqkMGA@mail.gmail.com>
From: Chris Torek <chris.torek@gmail.com>
Date: Mon, 18 May 2026 19:31:35 -0700
X-Gm-Features: AVHnY4LJNBX6amUBXJnIu4XRAvTGVPiHrm1fIv6VNYWGB1nkJw8tZo2pnO8TMvI
Message-ID: <CAPx1Gvd_FqnsjCkpAA5uy7aDz9oQnWx7WTvKk-kLWemkqF9PsQ@mail.gmail.com>
Subject: Re: [BUG] "git diff --word-diff" gives a diff while they are only
 space changes
To: Michael Montalbo <mmontalbo@gmail.com>
Cc: Johannes Sixt <j6t@kdbg.org>, vincent@vinc17.net, git@vger.kernel.org, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 18, 2026 at 7:11=E2=80=AFPM Michael Montalbo <mmontalbo@gmail.c=
om> wrote:
> Yeah, I was trying to explain the difference Vincent saw compared to wdif=
f,
> but I agree with your criticism. In "beating around the bush" regarding
> implementation details / making a direct comparison to wdiff, it has been
> hard to craft a meaningful message.

My opinion is: don't do that, just get right to it.

> > If we document the algorithm in such detail, we cast it in stone. I
> > wouldn't want to paint ourselves into that corner.

> I also agree with this sentiment. I haven't been able to come up with a
> message that threads the needle appropriately, so I'm open to dropping
> the patch or reworking it if others have suggestions.

Call it an "implementation note" (or, if you like, a "practical
consideration"?).
Something along these lines might work...

  Implementation Note

  The --word-diff option currently operates by taking the same
  line by line diff that you get without the option, then massaging
  the result into a word-by-word difference. This may cause an
  unnecessarily-larger diff than you would see with a more-clever
  implementation. If and when Git acquires a more-clever
  implementation, the output may change. Note that this is
  similar to the --diff-algorithm option, which may change the
  output.

  Regardless of which algorithm is used, _any_ diff simply shows
  _a_ way to achieve some particular change. It's impossible for
  any algorithm to tell whether someone deleted two lines and
  then put one back exactly as it appeared earlier, saving the
  resulting text, vs deleting a single line, for instance. Only a
  keystroke-by-keystroke logger would be able to tell what the
  human operator actually typed into some editor. Git does
  not have that information, and having it is not desired.

Chris
