Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9D978C9C
	for <git@vger.kernel.org>; Sun, 15 Mar 2026 07:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773559764; cv=pass; b=SbkzIkijd076j8uzDXWda2ya9fcygf5kNMTTn87uWSVyaHbH+xJ0NIYu33ccNT0jHqeYO6gDcL8eRPFjwz4KwW1JruKcd81hg/xMxhqKHfgYbCibAC2wwv49eJw4TlkRSr1CEffnYUrQDxRNZiQ4UwMVZr5l+xW+OUW0leKytuI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773559764; c=relaxed/simple;
	bh=gA6oJkndRTfQXjVoOubi7YH8nZEZPc7Hv97oGBzTUGw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mnm2rfX42rlThMDzj6xqNXA8wVAEylgKx1cjxk0qFFyOkstvqQ+R0U681Q65sDhKvqRyrFarz5YiM5O5LMJ/4xjTg899KckKYALUedc4rKSdMWBsaEKZhVRaFqqLQcQP/WNcYP2+KbqHMjBbjeEz3df9GSEvM/wJwQwP7mTxAuA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BIlx83vO; arc=pass smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BIlx83vO"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1279eced0b9so4530080c88.0
        for <git@vger.kernel.org>; Sun, 15 Mar 2026 00:29:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773559763; cv=none;
        d=google.com; s=arc-20240605;
        b=WSoEuMlojDLOZTL24kI1UE4YQLOxXW+XulNDTsYX5QqPrmfUbFqx4+LX5LxMJhNtKx
         GUyqSPS0Vnc+mlIjkNyJZk/gCIkA/h5u6IfRwgrMqAPMqzHzSydq7if5JDiASmvAh6MZ
         0mt66qCwq7XgSSBQDZN2ynMuJzAqDGNRmNX2SRKkYLG0ETeARdPIjVDHTQ/vfQPIabrL
         fNuZxTJ9f3MTPuPQ+plctOGFzHQgluWCcX2L7kJG381ZumlNjt0I7FdPzNiw7KlzwIf5
         OJHSJzigx02UXUfMCaJfOeX0ePeASshWVRudZVQ6DwY16BWDsKJM5ydIUM3fdw/2ESwN
         g/qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=gA6oJkndRTfQXjVoOubi7YH8nZEZPc7Hv97oGBzTUGw=;
        fh=F+28c4S1DLBLF8WAKGCbUdQDaSjxlCk8M97gm1UIdr8=;
        b=J+qxdjjrUYE8JqZsas2Hy3nsCTOL0rBinA4aSoEOOfSURy6NxIKx8O1Pt97p0K2ByN
         pBeZJO1ZjiioWIwqRooF4XIqGpAjEfibwqAf9U1ArxejmVoCFi/0W3NOxhZ508nPnNq6
         j+McbZ6vAR9WL8Vpdp6b4uOJP1HuuX8xIdcHf15RSDE2/M8AQtLR0rPMXbRwVxyMLwxV
         jC4gNLcHdfYJxluRzCvl8S9YSJ8oGak06rmCJAbniuDzSuXo4WQoW0WIxX37D68tesrF
         fwxbzMHMr2ec0ch1UotEnU3KQ0I2vkSJqeAH48t2i6nvwqPigPMedRZiAH4+mH20yZLt
         fuvw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773559763; x=1774164563; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gA6oJkndRTfQXjVoOubi7YH8nZEZPc7Hv97oGBzTUGw=;
        b=BIlx83vOhp47rRanVqMDmU548HWTatgVdzM8l+3fFyqSRWOzSzSHUCUme4XKj1CUFO
         E+U5VmXfUu6nyLc4M4Cy/L5BmecF0Kx1zlY9RQ2xdageZWKYe8zkY/13db0N6tlQzE/e
         4C+lzHl7f6CKFB+pyVbQzLiyzBp1eaMxQiGps5qKy93WuE+x8s7z1p7ZubRWA5skDGil
         QP/4G/jyUA7Rka4wB24FtRZ7V9jiAvm9szzq7KH2CaGuH0OQFrafHGrFI+5xM9jfPGPv
         sOjZE6Z2Gay4Rz2Ir8pgjYaUhGgCPEggaTtPLgRrLFQ6jXae0VkvUrgh9jiKeZAZmK8B
         Mjgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773559763; x=1774164563;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gA6oJkndRTfQXjVoOubi7YH8nZEZPc7Hv97oGBzTUGw=;
        b=VawCUUXjaCw7F9xqr5Qtnv/vZp35xhbL13x8tZ7BjmM78jwOhHneTk+lcClfGVXxb5
         z5VgFqYn58Cc28TZF+n7BY03mqHUP/XQXHTSzcmzw7CBt4ro7a4fLBYRlbme0JpSqT57
         HjabgkZFszj4gqSwjnwq/GM85Sef1dtgbPUJY2uJyd+AVrqBbrmQ4jXkIBO7cnwaI8SI
         NPLXaPhKRAXuX4um+6+SWOJe8tBgjnExX5+4jp78Pm0MgRbzISTaIPbkshipmEX+ikJb
         xrJ1asltwL88sLEMvb2HUNmHV/19XBnPB8ipPx+Ppx5ARC6hEJNCjsEbidJt5wlZohll
         sAUg==
X-Gm-Message-State: AOJu0YynjKnyAOtn0NMoMaFqe7OAJw0pBBJRCyAM/GDvoL9EMKFbq8Xe
	FUsH3+5UuSv2n6JjEgavCrZ5fSWgZ1CeehJnaxDztiYe0z/LwY29HMTy9Z61oBUEm38vSmzNTIy
	0PsyC1HxHJSnduQlibnAUvhE+z4OQzGU=
X-Gm-Gg: ATEYQzzjjq6Q83pOolDORN3N1rB5HIhTSswNDEX6nd1J5nlbeeXQDobL+aS5hVg8Zlt
	aBWsOPOlp27NPi5M/QeE5BYUYhdwJnt9QQ62heRvylnz1eksoCP4ppaxLQLG6mgXinbDmCvZBbP
	W5CXV93Zn7CdloKDbx93F2oKdD5KlmB5xU26GVq4XOj4csox+VYr87ivwXZu48bVXPGmd2bhSUf
	8gIb5SXRoftNxjbpNVmSgcYRkfeDWbRqyLZMzVNATZuoxGeBhgWe4kPnNVE58Ltwj3auPi35231
	JdLhKBPh8Je6wnABLVVu5O0omxi1L5yYozPB/7sTGJaNADTUwtQ=
X-Received: by 2002:a05:7022:4587:b0:11b:99a2:9082 with SMTP id
 a92af1059eb24-128f3dacfc2mr3837459c88.15.1773559762468; Sun, 15 Mar 2026
 00:29:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAG7UgESKLMnO_4+PSJUt-TXJxFQyxEEfpCmJfMmTw2+rhT-HWw@mail.gmail.com>
 <20260315025508.GA926820@coredump.intra.peff.net>
In-Reply-To: <20260315025508.GA926820@coredump.intra.peff.net>
From: Deveshi Dwivedi <deveshigurgaon@gmail.com>
Date: Sun, 15 Mar 2026 12:59:08 +0530
X-Gm-Features: AaiRm5370UWJ_SjvS3waFcQ52-hY7RcE8P-9JS5KeLYKG96UAuEpsCJuISa2NpQ
Message-ID: <CAG7UgETB7uPvWuZL08i48JvVgefJAoUqjt96C0dPNV_Qpj8jfw@mail.gmail.com>
Subject: Re: [RFC] coccinelle: detect struct strbuf passed by value
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"

> So the only question to me is whether people who hit the coccinelle
> suggestion might be confused by the patch output, since it doesn't carry
> any rationale. But I would rather catch the problem and risk confusion
> then have it go unnoticed.
>
> -Peff
Thanks for the review. I agree that the patch output may be a bit
confusing, but it still seems useful to flag these cases. I will send
a follow-up patch adding the rule and fixing the stash case.

Thanks,
Deveshi
