Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0AC3339A1
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 09:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723540907; cv=none; b=SQU1GChH7U5z1+bXEHXUgdocQe+UM0lkqopjtAWTdBrpdo1uTTZ5YcB2spCzBYQkBK4jVcmVNTSCBt2GZo86dZuQrIU9WquStgX8KVGCZqNuHXn6VN3E+qO4FAp+LMpGKHZrlD/5OLSdhYp+40cilTJZBd5pBIzQ4zbqUROFhW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723540907; c=relaxed/simple;
	bh=nBXNv6/sEuQ9dF3vgmA+RUSjLnkLBPcH948efN99edQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S77hFXeefTRJqxUoISL3DzYB2K0Y+h/XEG65bfqXa5Hr0zagdiWb6T+8WfefiW0xwkNme9OHRmYNczuPFM+uKqYbW1CAC4NXwpFw6B5+Elh8fyGEgUPwlkQYN+Fv6KhWB8cAEbxH2lsBeRgqPJvbctSri2d92DD7hHpjA5DjmZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6b78c3670d0so31980336d6.1
        for <git@vger.kernel.org>; Tue, 13 Aug 2024 02:21:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723540904; x=1724145704;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nBXNv6/sEuQ9dF3vgmA+RUSjLnkLBPcH948efN99edQ=;
        b=MLw0KaomlR2CJsi5ilAhpQZAUDzC1h4iDNSQZcHVQExgkKhhGQclfu4vc/u7pPxBsd
         2wIh9OgYwzCQQHvCkfARcBxg1P91ykXl2bWRKtqBpnFKnsoAhdD3Jw7ylMK5vCm144ya
         wUYkHZJvzds48ntOgyEdrnDDtiyAsBhARz2UQ8J891mk5J+Vzzt8pog+LCWu0jpIC3Ab
         iu9Lg/I2UoEPvvi0UXUf3XyaocwF04vP+gcABsmeb6jMQW3DJfIW4aKvyDnFYnXDKWNn
         T5j5tgN+cSvVhIw1ldaZE97u0dBPXZh4ZkjIgMxcOdb++9NlvjXCxjvHC+NQlFWd12Yn
         Af9w==
X-Gm-Message-State: AOJu0YzrIVoXsloTr5VwTfoeZJQSOPv69E0DBGpByFNgV/lzWvWVZHS2
	DTaKJznTqQLp0GVvLb1rg2VObXjc1h9a4QSWUdnUlzqvsA3yLRNcj+mhq1R+h/B9/eHa2V6AWNP
	AEs3/lydsLrkD97TbPrrCDoaoWcs=
X-Google-Smtp-Source: AGHT+IGgwXuavdMDIcB09Ci7UNyQkPx97h+xuCzWOf+iBjvYmYwsvL+PdW1egg+TGEXDel9O6oFSFN7qN481lDgbwlw=
X-Received: by 2002:a05:6214:4a92:b0:6b5:40d:c2d9 with SMTP id
 6a1803df08f44-6bf4f79676emr49398206d6.19.1723540903767; Tue, 13 Aug 2024
 02:21:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <TYWP301MB0563973ECA440E7DAF0F7E89C4852@TYWP301MB0563.JPNP301.PROD.OUTLOOK.COM>
 <cover.1723540604.git.ps@pks.im> <c57e1cca4c7d2a0f52ae8d4e0870e4e0667184fe.1723540604.git.ps@pks.im>
In-Reply-To: <c57e1cca4c7d2a0f52ae8d4e0870e4e0667184fe.1723540604.git.ps@pks.im>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Tue, 13 Aug 2024 05:21:32 -0400
Message-ID: <CAPig+cQiNfD-8ByukhWgSQRBuDWgyQC_zxBF3Dhr0--m1hUFZg@mail.gmail.com>
Subject: Re: [PATCH 1/2] builtin/bundle: have unbundle check for repo before
 opening its bundle
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, ArcticLampyrid <ArcticLampyrid@outlook.com>, 
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
	"brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2024 at 5:18=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
> The `git bundle unbundle` subcommand requires a repository to unbundle
> the contents into. As thus, the subcommand checks whether we have a
> startup repository in the first place, and if not it dies.

Perhaps you meant: s/As thus/As such/

> This check happens after we have already opened the bundle though. This
> causes a segfault when running outside of a repository starting with
> c8aed5e8da (repository: stop setting SHA1 as the default object hash,
> 2024-05-07) because we have no hash function set up, but we do try to
> parse refs advertised by the bundle's header.
>
> The next commit will fix that underlying issue by defaulting to the SHA1
> object format for bundles, which will also the described segfault here.

Presumably: s/also the/also fix the/

> But as we know that we will die anyway, we can do better than that and
> avoid some vain work by moving the check for a repository before we try
> to open the bundle.
>
> Reported-by: ArcticLampyrid <ArcticLampyrid@outlook.com>
> Suggested-by: Jeff King <peff@peff.net>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
