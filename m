Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92CDA346FB5
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 10:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774953485; cv=pass; b=g3a20ZIcv9C+BGvPHvHc5MhyeVPNkj7Vkc86buXeli4ixRRPRK97xKfp6w6ABnX/SA2W182fUl/wq60tnRygl59KzgCBihHaNQa8stlL/Cp0hp29TIbsUuKlXGOlKwAQGzvq9MtJ2ds1oZNycWXNpl3G6Xz0TbxhS9ubsDmqVKE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774953485; c=relaxed/simple;
	bh=SqQtHFtMfxdaFt6k5X5WaTAlSRZeeVlcXa2uiO6M5OE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LaZ9RK/p87lIU3diVnGBsBS9JB/KxGtL8ZXmGJpZfKSQdCb0Lhn80yOotlUSC+BERvSbAC5SakDfBGd3EACXoZLk8OkvARscYSpt46WNGH08Hs+jrJwVLxD7UGzUkdKYM8eVmAsg1AIFElz4U4EsfEKpcKCR30Z/TOE8nRDqSks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=manYi8rK; arc=pass smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="manYi8rK"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-1273349c56bso6785179c88.0
        for <git@vger.kernel.org>; Tue, 31 Mar 2026 03:38:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774953484; cv=none;
        d=google.com; s=arc-20240605;
        b=escb6TFuCqnirxInnUzg3oMSIZ9zmAIaGc426CgRf3ZEPgUXaZbYIFgOPX3LRBdrwv
         lBnOzqKkfzOBnAP6xzbiq84siz3UjHNsXG3i2WGzDqLY6l1/DJghmrpBsatR3wn1o/pV
         tz/J43cO54deAYsTb21P+A8FYgL/NGjoATN0UCHJxuYiGVLq1Rn5ZFh8H41o8NsZMeZd
         arpltmoelggKG8SiqbDY+JTX1absWj2Q1lx+U+h3L6g/ccr2AsgEP5eXGODKbgargmHg
         izyZhxZobLf4MLArnSAyR3lWr7VmjGp/zrt9hqiZRqMR2fL5Di6/05bFjsOzJm+6uqVZ
         R/SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=s53gZVCaaAYZxYRnDrPtP1xQYUsccvxnRHAwHYe9za8=;
        fh=enNsqV2a4HGIPorBj7tfu9+cMpFZ3TdhURhIT8PMJm4=;
        b=WrAlYSstb9760hP+MsSxpVLCnQaFpnLaxzAeGJZD/xtTOdHoZH/azf7NDU+fvPlfny
         gpefu9tmsHWTFT7Dc/qb5d3s83EQTkKLwzF0sh1GgEuB1uXmnRBB1b3jpBXJNmiPqNjm
         WDOR2VZ5lbw4WeCuORWJdhVQDdfqDceQ9tuOE+ClqybaNxLsrxg5M0WEHRsqXexW1AOl
         HqtUcU1siDU+39HK2/q0rraY4wyAfp4Gi7sy5uMVBmh0wbPzgonx/+qyjnb9mWChj/OA
         AnTWWDPNg2YMl5Nnledm9lbMUZyHVFYaRg8v4xAYvIGHX0TxeeApqDrf/HMwEDPLQoNU
         QonA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774953484; x=1775558284; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s53gZVCaaAYZxYRnDrPtP1xQYUsccvxnRHAwHYe9za8=;
        b=manYi8rKrSulA05+aaKUK72m9yHAeqyNXjZQlnqW+AHbokCcJHcFnflozjoF2cdk1C
         XxIJ+qKmuTMmpyxPYRiEmsLP8JhocUSjHqCRNwY1FIxZeuu1iP8/sURlu6j49U7QVTiC
         XPkGpPegoaMXb22VDm4Gk9EV15DRhEmphFtrRHDFk7q2rkXqmO7BJmLkVyOuop5ofm7g
         JSyRHxDYsfGIzbcgx3x8H3vUEaUeHX6QxtD2fNkWx2azSEQ78T+KjCXkwc0OshKkjSXV
         YTJwjhVqjeiDczUnZ2OeG53zFsWReXAVMGZEwkg6m6MxEBARjsP2L013/EhmLu89KEqk
         Soog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774953484; x=1775558284;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s53gZVCaaAYZxYRnDrPtP1xQYUsccvxnRHAwHYe9za8=;
        b=P2YJEgnXouiyt4tse3x26oDRK/tl2IZkj5pXCq5DS+rtz9Dnjd5so/pQRUiX03ux7a
         izxqK4ksViVPAgsoTEfCIDibROQJfwEJEtKNUlqYkQisD3HqRb6geMIRYNMkZ/43xn79
         8CMfWJBXsINJiIUzu3DzBuOfZqUDl5xgA66rVRQskgrpjip77OxTCq4Qginxqqeo6f8e
         XTPA0O0nM5F5Lcc02tu8KZw7boLLl5OngAhQlDDr3QBIgcJbf640ZKg7f89aL3C6gd8O
         ICBTuSRz/lHLRpkPnezSXYFBnucfvUoImLThUXiBlcVy+JzYmiOh4Q+r08bzyZRmzdoV
         Nypg==
X-Gm-Message-State: AOJu0YwVysFgNDaMohtixleeo2+3I4VkSnP+uWSx9yXSEVKDphWVTfUs
	gBpcX46MxiQ8Bn3fcl+TPK/5Yc7krbGWzbc/gQd0hfSD8seuK4JxeWC+mAWkEd3Uz8oLd49xtoy
	DIm75s3bFWtMJiUD5eHrcTqjNnqfI280=
X-Gm-Gg: ATEYQzwvqiqipcWl2olUsW8C0MRAzchPb4LtuoxZZWdoOcoIscYVlGbNytXxVx5BpJT
	HIkclNoVVMz5uG467SGP7gUj1knHa2nk8VP9E21wM1W4EAJ5rx6vNdHb9LO013moLQQFt/WplHL
	IkRFZFl4rY6CpB/vMqGRFyYPBFHIFHhGtMwczAS4X5OOIWQg5hJC51dnOkH+pdfbQzMuU6M3Ujg
	ZTJEPDaM1Fbw2I/0QhvPGnfLV9N6DH8hMh2obj87RJdr6SNDkT+5bFs2zp+8lABjMaEJ4rioEI3
	p+zQBzr/DlWEF0IzoqzTB9AO58uCKbO61mp+fikk08F0SnsP/l9VXAm+v5uCbTuzLxQ1
X-Received: by 2002:a05:7022:6888:b0:128:ba6e:f887 with SMTP id
 a92af1059eb24-12ab2919f7cmr7982694c88.38.1774953483573; Tue, 31 Mar 2026
 03:38:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqq4im2npv2.fsf@gitster.g> <CAP8UFD3kxL5xAcd2OBNmLFMdBaRLgB0WKtvSkuO2m7GP=kZK6Q@mail.gmail.com>
 <xmqq1ph5mesp.fsf@gitster.g>
In-Reply-To: <xmqq1ph5mesp.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 31 Mar 2026 12:37:51 +0200
X-Gm-Features: AQROBzBNmmrFH1hSfr99aaMc9o9mwLsAHu8wwPzTRtl7e_P1gh5Q4txSND5h1zA
Message-ID: <CAP8UFD1=pVB_nHG4or028fvxeSi-iJj0PPnjSS3YRE-pACqaEg@mail.gmail.com>
Subject: Re: What's cooking in git.git (Mar 2026, #11)
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Toon Claes <toon@iotcl.com>, 
	Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 27, 2026 at 5:13=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Christian Couder <christian.couder@gmail.com> writes:
>
> > On Fri, Mar 27, 2026 at 12:17=E2=80=AFAM Junio C Hamano <gitster@pobox.=
com> wrote:
> >
> >> * tc/replay-down-to-root (2026-03-24) 1 commit
> >>  - replay: support replaying down from root commit
> >>
> >>  git replay now supports replaying down to the root commit.
> >>
> >>  Will merge to 'next'?
> >>  source: <20260324-toon-replay-down-to-root-v2-1-34e723489f6e@iotcl.co=
m>
> >
> > As Toon said that the silent failure in case of "topic" instead of
> > "main..topic" will be addressed in a separate series, I am fine with
> > merging as is.
>
> I'll have to go back to list to find the original discussion to
> refresh my memory to know what "main..topic" vs "topic" is about,
> though X-<.

Sorry for not being explicit enough. BTW I just left another comment
on this (see https://lore.kernel.org/git/CAP8UFD3P2Gs0J1FNyKW2URwSEW4ZaTrVO=
7cM1V8sG+zzXctbhg@mail.gmail.com/).
