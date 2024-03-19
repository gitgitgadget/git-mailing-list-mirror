Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D433F9D4
	for <git@vger.kernel.org>; Tue, 19 Mar 2024 20:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710880430; cv=none; b=ZpJIKHWm6aHjF5l+D1tw77KYkLAy0CfE1uOOpYQJ9najstlJ1vuh9qPpAPHW9/DD3kA9nH03+Xr+SvPA/lorYQlagk9lPGVAFM0p0o4/VMGng9hZZ1poXp2eecuNSWZ7R1TrZ06mxuR7phm/u7l0o+M5vrTvDtwhFEIMUq7zs60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710880430; c=relaxed/simple;
	bh=YqXSuv7SwImygpJG9LJxzPyig2Egyc0kxtujMjC1i0M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XNvSW0lPWZtkSRkmIE/lVYZgyK7doDnXGSrItK6fZUdHuRnXpig6jjhbakHtiBMYJnZRA/ijMHmn6ngPnMFuyljvPYqizI0KURpylZ0JuW1BiIjkXAq+t3Drz87nB0lojYIedZ+jAoWIFTbjDLjYrGIeRyY234ar0f+PO12wDtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-4767bcb4ebdso949673137.0
        for <git@vger.kernel.org>; Tue, 19 Mar 2024 13:33:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710880427; x=1711485227;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YqXSuv7SwImygpJG9LJxzPyig2Egyc0kxtujMjC1i0M=;
        b=H10iGiysupH0zFd8zia1SEIFAlsNFzRYRj+gfwiDlMV0rXgl2NDia7SfHLFT9eWd/T
         3dhozbbx+lgQjxlhVFNXJXoBpV1gnv5GEaBv+P4oQLGxYMMyebXHVV9BmoPfFm5+JqFi
         Hby3beJkYEoluuwes7Ibwy+kb5tA0GjXY/189XcpArdvT6HurxQU6+k8b+dcRrrE8YP5
         t4YAT37sEMBxbrNmkwVLqJ4NvZKNj5hWIVUzxG+TV0hfeCyAhOfZtd04NNHxJ5xMgncw
         9ExqeQeWlluHxrHPmMvJoS/WpHFNPgs3eNbUfYwINqDztcn3USPUdcJknDPXqg3+G8UH
         Q7zA==
X-Gm-Message-State: AOJu0YzxO+7tOO9cKZ39V1fAkXgsjPNc9aiQ5MbmLJyPvIXxVoc22IJl
	xSLF5+LhVoy8jpgc4IZ0GqysYaxsUwlIThaFqexrZ8C0DF4LeBAHCNtvfC/47CJayCYsavoLFvz
	HzAWn+qEeOxxxXmLl04SR/qGQkaM=
X-Google-Smtp-Source: AGHT+IGAtNbNio2TBhYp8P7nazf1vp4OZJVcyr6xci9oh51UxBYUADIMTm7Vr1UHkotxyNLL2VEisFUP/Zd1dzeaOfs=
X-Received: by 2002:a05:6102:19da:b0:476:40c:95d with SMTP id
 jn26-20020a05610219da00b00476040c095dmr12402635vsb.14.1710880427147; Tue, 19
 Mar 2024 13:33:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAN7Jk_3_ys4tAJ3B5uy1aUpzknEgQRwdADNxFXDmLxgCL2bZrg@mail.gmail.com>
 <CAN7Jk_0hKTacR4cQiYFW-dcj6ipA=8QcCGrVd7rrJ4vVUxUBKg@mail.gmail.com>
In-Reply-To: <CAN7Jk_0hKTacR4cQiYFW-dcj6ipA=8QcCGrVd7rrJ4vVUxUBKg@mail.gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Tue, 19 Mar 2024 16:33:36 -0400
Message-ID: <CAPig+cS_L=CS7TQhrt5m8M+O-OsdH0oiZkttWp9SxdbZw0Cu6Q@mail.gmail.com>
Subject: Re: [GSOC] Microproject: Use `test_path_is_*` functions in test scripts
To: Sanchit Jindal <sanchit1053@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, 
	kaartic.sivaraam@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2024 at 4:21=E2=80=AFPM Sanchit Jindal <sanchit1053@gmail.c=
om> wrote:
> For the microproject, I can update the file
> `t/t9803-git-p4-shell-metachars.sh` with the `test_path_*` asserts as
> required,the tests only have the checks at 6 locations which can be
> replaced with `test_path_exists`, `test_path_is_missing` and
> `test_path_is_file`, Please let me know if this is enough for a
> microproject.

Utilizing `test_path_*` in t9803 would be suitable for a microproject.
