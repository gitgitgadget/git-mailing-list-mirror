Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36103FFD
	for <git@vger.kernel.org>; Tue,  9 Jun 2026 02:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780972258; cv=pass; b=UwNfI01JUdtmAolTIrNNmebroQajVxyyXHJGfBuyMmSf0FYdTFcND7OZXXM8KOwbBJpulT4B4RQBtzcZzpToa+8nnZMonfOl4GnEUr/6om1NRCIZk/XpmgtMIt0CcfzyXCVlEmRxpUcIvgBSkQMTsZFz/eyVIZ9hyJ7vap+dFPo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780972258; c=relaxed/simple;
	bh=8q03VdoavhVRhtgZQ3JbguJd3hWOqyCzHN8KeH99lWk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tccwP9h2OVMzpKmu4SFm25p7ENfx1RM+iA2juLJVNFt9iAz+57Le2cJ5NbKw80pq9gHFtjGh4QJnQErIXGLoRVr6UHr727xOxbYx+9FunLt2Hgjdg1Fze4ndm+GT9ZF1sSKXOXeBwrCdBkaO91edbIhxy5mtjKP5pMfniUQaF58=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vzc5saYf; arc=pass smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vzc5saYf"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5aa68cf03bfso5291723e87.0
        for <git@vger.kernel.org>; Mon, 08 Jun 2026 19:30:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780972255; cv=none;
        d=google.com; s=arc-20240605;
        b=H/b7dLIMsRg4JEcBhe10Uq6ue1dmXgCYNdbtxd4/8kaRj09JEmFDAQ/V1TbbjbC1gt
         V0KeXgdtfoomF3YwiQHhZGk6yKQPduOKcWn01KD1C/zKcQZmojHbge1Ii1ih75aU+/70
         7LIhURKd/Exe9P88/CzsVWc+sbL8bY6tmDxY+P529ZB/ScwfANRjaBvPfah0fIPo0XFD
         Gyaj+l/s5pkVdMDQ6L1YMSymV8ZFpvwflmLYWWgyCzeH9dOHaKICyt0EfTPd061SHFYJ
         /PEl73RZLL89tRIsVJoTlU+vzBzLP9o/v2xE1gAmmuQdRD6muj9SCJ32fP2CoiaaD9e1
         grPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=8q03VdoavhVRhtgZQ3JbguJd3hWOqyCzHN8KeH99lWk=;
        fh=II5UFWVA2YVGzjMzHotJOpZ2kHzaEAQlHI0yuZYNT4o=;
        b=Wbj808+KUCtFQR3qQcK5YjfgxUfX3LLZDBYXdF8k83SA2sJJz/pxMP9DQPsniKM8E4
         DQdMPdyOk7Vt8ibkUnn1g53fZ4QdQZna7Ia9/nfFn41O1tlQpXv9ZSIrSrb++vj3U5hm
         HJ0NbEDNdfjL+q3ZDHeVo8z1IjPTdE/PmHtKyv0WucAwTxSrok+csbBWyBaAqcjfE3O+
         8jcAL1YybsadtS3SPSbZl3NE2QdHY5aDeQaI6WMfG3Kf2mKYO3Pei9rO9GQC2EixEQAO
         X2yIBdDdMv2UnbkmB/gOwpcRjeWS1TJU0dyUfPME70yPcDIjJAQi5mq+6zTFgadvWroW
         0JfA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780972255; x=1781577055; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8q03VdoavhVRhtgZQ3JbguJd3hWOqyCzHN8KeH99lWk=;
        b=Vzc5saYfQ9+nBCkFlN0Fu1j6icsCVsPNIehiH5WxWv526uhrQQ+tB3B2kTRkNb28Ys
         cWJtiS8YNy1mBhW2mR1/1iv/sDFLsCcHJTxndvEkXYS5HL9DaggXDpZfacnmfOL/tjaU
         XXAC/2Xs29+1vIw6934B92f6xyZRm3PjlqBlts4h6QO9RNKxCRMaNSP/R8oUoRDs3Ccr
         d2XsyRg9ieoWdfY1L2yQYIhHajzkT2jE2i1cXWUtHfrdaD2QyOUMVZShw0bRjtF+n03f
         ehaRSIFtemzBsVdxd8IPVk7/2PFTS1zgWm0y625Cfc1VgLcYTNh3ThOJKOoMQW/7CG1F
         JHKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780972255; x=1781577055;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8q03VdoavhVRhtgZQ3JbguJd3hWOqyCzHN8KeH99lWk=;
        b=YXtx+iUatp/IfZQaKXmYEg0Iz6EnCzcn0qqSt0Evng36EVLWPtsXq4kw4n8UNycAW4
         9Dyj5BtOrZA5UNvBy7H9+xr0uwR/ID2LYgVOy5DoJhcrmqBqoBbGmijQONbFF0gHBFcN
         Up9KeJWa6e0lOru2tkEiXZKl/5JeWAZBj07ubZd6pawIuS/wCFnTy0AltYwbajDnB6jR
         JyXGvYQRgddlYCzQr9QOdqa0MZS9tSaKYLo+T7CqkGxOH/HEoo5hWkUxI8Ja1o7LPHSR
         PyTaHo88XI6T7hFTvEiX8T/5b2QbW/CQ8VF1MQATnKiXHsI0DBLIqJwptEAcxIFxe3kh
         s3Hg==
X-Gm-Message-State: AOJu0YzkCinF9DlaefPOS6nQ1AxsLJCuO2GwlJr+uIHWeGszGHKwTP4P
	tzqOkBVbulLYaFcgiZqSQ/l1wdq7ps3/voCNfC0tLuR1AVMmy1NJ3NNczkV0Lyd9xC8Z0Nj2uTd
	SrkjBkN+EEw0SK38wSLwX4rmkZEZCOvtPQA==
X-Gm-Gg: Acq92OHyOBMX/DSfDxdo8z2vbl2dFsB9FP3jZYug4STJyGwvVIHlk3x0qo3hmV83u+4
	luUr6tvdC3HuN2UPSxJFu2yQHQHj3vnl3VNqSdN3VhPJGiKWPuvjfyt096gMEHEIBXU6FPD6xaw
	3jX6pf2S+zPIeyZznkVSsAMfmlu5QeN7Wg5slsutCLh8k4tq6YOxNmOPqOBGoraegrdUIPWBB9X
	MlCLkjI6Hd7cUguFjr977XvcxOxPA/ceUwM0HU1VD31OoovbZdQrc12PUowJYy1Jk4pK8b6BGX9
	r8WzvIUqgnabxJDh0uPhZ4ZEO+w4eYZl0aKrAzY9Nfk4Tphs46QRx3DV5SGUKqdUpk85oYB0b4S
	sPlbIkOHKGW2fBCnrsWChpUYag/OtsIhJHWub
X-Received: by 2002:ac2:4c55:0:b0:5aa:7770:8fc2 with SMTP id
 2adb3069b0e04-5acf81f94ccmr86162e87.32.1780972254669; Mon, 08 Jun 2026
 19:30:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260601151950.30686-1-jayatheerthkulkarni2005@gmail.com>
 <20260605163012.181089-1-jayatheerthkulkarni2005@gmail.com> <A67C8C8B-2600-41D2-9E61-0923BFDDD06B@gmail.com>
In-Reply-To: <A67C8C8B-2600-41D2-9E61-0923BFDDD06B@gmail.com>
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Date: Tue, 9 Jun 2026 08:00:42 +0530
X-Gm-Features: AVVi8CcE0ZApOKdlbwzvQr25-8Vv9FbL1bZ9P4_hZEu4sVjd-r7aaA1PleBToOA
Message-ID: <CA+rGoLeRfJXmYRhOTkE=R5JUJBp3LmbACwdt2sezQHqo=1LQtg@mail.gmail.com>
Subject: Re: [GSoC PATCH v2 0/4] teach git repo info to handle path keys
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org, a3205153416@gmail.com, gitster@pobox.com, 
	jltobler@gmail.com, kumarayushjha123@gmail.com, phillip.wood@dunelm.org.uk, 
	sandals@crustytoothpaste.net
Content-Type: text/plain; charset="UTF-8"

>
> I prefer `.(absolute|relative)` at the end. `path.gitdir.relative`
> means that we have a collection of paths, in those collections we
> have gitdir that can be relative or absolute, and we want the
> relative. `path.relative.gitdir` means that we have a collection
> of relative paths and from those we're picking gitdir. The first
> feels more natural.
>

Yes, I believe the same.


> PS: this is a nitpick, but it would be really helpful if you provide
> a range-diff in the cover letter. Check the usage of `--range-diff`
> in git-format-patch documentation (this flag also works for
> git-send-email). Or, if you prefer, you can generate it by running
> `git range-diff` and copying the output.

Alright, I will add that as well in the next series.

Thank you!
