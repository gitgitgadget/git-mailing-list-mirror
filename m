Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19EC013D8B1
	for <git@vger.kernel.org>; Wed, 21 Jan 2026 19:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769025298; cv=pass; b=Vo1aUgJ4b9TbIGLtLguDJxUtYaxIUPHYF9wpwlOnO0ssk8ahWiKcr9963HqaDM9F2OiMK3hFNXhv5IYWVrXzVc+wMnlopTBynCEFSfJn9lnhF2bXqerpja4iumCTuOlh2qwSitSNwCEBmSJnoJ3Lxzl3+uS3lHY5QzS3gJ+1V6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769025298; c=relaxed/simple;
	bh=YN9DsesZmXGjYcoVXXDKUG23FgDdmSrjPl0VF+fgAq8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ha5MASEJN6fuO48TJQ4QvuTfW2R3VlLwNbzENPB+M74MLKbfsimirdObPOt44zu2vaq1c4/BxzCQjnoK9ShowQh6A5/rz1dfIfnc1fz4yLug019aJJJ8Z04o9TlYgVsmAqkDSt/GGuVAMnmFLVrhFRJmqP3vAWvXu7lKH7fPQtY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xsji1o+G; arc=pass smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xsji1o+G"
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-5636274b338so106342e0c.1
        for <git@vger.kernel.org>; Wed, 21 Jan 2026 11:54:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769025296; cv=none;
        d=google.com; s=arc-20240605;
        b=hRGiHzrDg+hhsRiYEeEUwDiPm0dY0VPPcrTnQ2090vMaFp8k9pr/qx4qC3xVDEblYz
         Moxe/vMlJB4rO15Xp74dcVvxUUa+S/QdVB2JhNzwT224Qws82mUp3Z4i6+DlG7pIwcCX
         N54auFom2DsDWrR0NqnnrmEz1XcpeALYMqGZzpnjvzUnee6+R2H1yKsT2eXoPvQ4DFH5
         dlA8PJ6x7lCIVdPB3/29AjJIyIcyAjIH3wlQMwPODE3hSLMnbKPLpXmz7MjKx2FmahUx
         xTbU4PKoZ709iOTAR3u9Z9AykLA6Xf3GxKtuC48Nkj6GXd33mtTe4GlLkXTk/cd9vxqG
         t6Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2d+vohXezyHVeVUBkuFasuMrK4Hu+/KvdbdoytIabTc=;
        fh=COgY5n3APlSNcHr1BpK0aRe4grUZ6VynLvBDoxDJ4Do=;
        b=NQA/Hr+PLgJVlAoRMqqSsEbVCL986UHwXlo/4Yoc5BSQyMHnjYertPiEoNbx6Gn30P
         zbzYkEG7aZfXMLZGSQhcuMc7nX+I7OTym+TiXxE58Z5vOY/Q2Es8c0YZgmJk2ET1tGQH
         zw8OtZLfbOM+xvadKkeyQZQrJLFCtaUdWUm8gRIx5Xfg7TepOhFZO0Qpw4it5LQL6hjw
         9GipDgXLFCba5994EMMjNhrmu7b9CzjrQE+DgI9NibEctKd1EPYQYFGFUQHPgexEAERZ
         vyceU2vvUQtXLBYtfmXj5Zv3iRH/4jHGNTO82Q7IT46alScjZ6jrL5WHTiqxkYU/Ln3W
         Jzww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769025296; x=1769630096; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2d+vohXezyHVeVUBkuFasuMrK4Hu+/KvdbdoytIabTc=;
        b=Xsji1o+GyXzKVSrYdqhA65nlyGOqkobaSwyzLfeznboPt2+0iBEyzSddPS7gnTJcH1
         F0enHpeRD9cUHxZZVUnZxev01/dB9GGpNAbP3yZgiA+gp3AeczD/ZIWx6hfyLsAgyJms
         EaDUzHnX2Me6c6yKP2YRFr6XlXlz02HfXuT1x/0+C2xhk75TjIYrgnbbKtoNesTzzCnz
         hPCslpQeIRSMZl4obN1NrRX5vjtYNoPKlmzTwlhyDs3DwFfTVD6cXvJ/Bn60iSqtknG7
         oKfN9TnayMrQfkCdXvATpMHpPCpSBnhbMHJZj0Cfc5sNdRbV1A7O1Bme24RoD/pQS3QV
         mpOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769025296; x=1769630096;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2d+vohXezyHVeVUBkuFasuMrK4Hu+/KvdbdoytIabTc=;
        b=Qs9FjBOJVaAriIIbamLrfo1iuP2Ms51JXggtaZOaWBN9Ky5g0dkSfYwPXx9h5/42lz
         bPDUDoFlI/YwKHew0Vg22yHWJ+2ojxkugRDOZD20/CQj1l0mg1Ox5kyBtsPAKQdO1p0A
         /le1+PxCp7vO4pk/5vuhhsLhXGDwyg6CTBJ3wOixryQ+8DgNmY41ktpoZNEusNUKZC+D
         +Cx3r2UxDWjCOgxRXMCHLrsik7a8xN0EBLbaOyHfTMCQ0VL43NvCowvkxr38YoF5VVoJ
         KluHFhvsWN3sTUrfrpUlLHT5Rmprwm1yWjZYYqRomVWcvN1kKtUkd3kpTzfxLbi9HMWL
         EMDA==
X-Forwarded-Encrypted: i=1; AJvYcCULUbE/bFdemu5XglbRlQmSzYWgZxSKenAbL/cs+uq7LDrQNcIOsua6CLNZKs5+GUO2U/c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyyg23GqWvAVRqhBsv3dlzdFOsUbP2c7+jIn5SXmA2a7f4c3/WR
	kr2CSQe/Ifa4pLIiN7PJtFmP7DlFFzESvCruigniBtpvL7F1jZxptlztTmyC4tRxhTYrV+M1F3V
	fURNhN3f3UMVjRZyTdUFFVxxPsy0nKgQ=
X-Gm-Gg: AZuq6aITHeJkw0nGh6CneZDXhuzEn9NnIUEE7gj5Iwp0jOVD75fViofMn0gpRpyFhs2
	2XZs1Q4Y43PQCRspsolc9N+/+yUI2ZglpIV4qpt+5DGAr5zdkfqbBr1QqJ+HbHc8Z8DD7T6iWdR
	GGzlqlOVUcJo05fNV6Lz/YIA1TFfqEzgXgN/ulhJsXcqdBBahuB8BkJfx5IX/Y9xK+9Ee5+170B
	mMBWsJ617cWS/yEL5kV3ZSpQmXo/R1kIYU+u3ROnD20E5IoGogr1RYBWV7y1rAmvII/dMqYzrsR
X-Received: by 2002:a05:6122:4705:b0:55e:82c3:e1fb with SMTP id
 71dfb90a1353d-5662d14e8eamr187436e0c.10.1769025295713; Wed, 21 Jan 2026
 11:54:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqa4y832ok.fsf@gitster.g> <8a3f0711-2bf0-4991-82b3-b452c892a999@gmail.com>
In-Reply-To: <8a3f0711-2bf0-4991-82b3-b452c892a999@gmail.com>
From: Samuel Abraham <abrahamadekunle50@gmail.com>
Date: Wed, 21 Jan 2026 20:54:57 +0100
X-Gm-Features: AZwV_QiQWc6_PU-GM5hwXekEmo8jrGAVDpO2G09pcTqrfo0Q66yEIvZeXXj8qvU
Message-ID: <CADYq+fZNxRVtrxgzKYwE_cS=CXTDaa1yQPb_sYgxZBPMJ+DEtA@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jan 2026, #06)
To: phillip.wood@dunelm.org.uk
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 21, 2026 at 5:14=E2=80=AFPM Phillip Wood <phillip.wood123@gmail=
.com> wrote:
>
> On 20/01/2026 12:10, Junio C Hamano wrote:
> >
> > * aa/add-p-previous-decisions (2026-01-08) 1 commit
> >   - add -p: show user's hunk decision when selecting hunks
> >
> >   "git add -p" and friends notes what the current status of the hunk
> >   being shown is.
> >
> >   Will merge to 'next'?
> >   source: <aV_IGCld5T_dBxTs@Adekunles-MacBook-Air.local>
>
> What you've got in seen looks good to me, the string is much shorter now
> and still conveys the current status.
>
> Thanks
>
> Phillip
>
Hello Phillip,
Thank you very much for the feedback.

Abraham
