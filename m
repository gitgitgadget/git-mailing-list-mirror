Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75A61DDA31
	for <git@vger.kernel.org>; Mon, 23 Jun 2025 19:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750705483; cv=none; b=oODKeG4Pi2KQMfJivjr7MsWYtyniI7fpfpvwttK2wLj2exEil6Gcjs+VwJDdWXo6dC5f4m8hJA6ni7+3BgGoYf3Aq+veWX7dK73BLVw+fuVeic2ECy/SVPxvvf7MeyAsQ2npD5eojN6NRWFZ/W302wMq7k0WZqOnnTp4QA1fzr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750705483; c=relaxed/simple;
	bh=pnM+MAIkiQvQvwjXio14NGS94+WIAqr/m0EHZHg56E4=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=fJk4yCRt/Z8HKoMrI03fTDJYTKoWN99YsPpAXE0T7f7Hhy0cdBG9HUtFkSWpnPiZWI+KtklRFn7wDtSiyFXIT6Evu+dcV7bpsWn16TGb13kkV3wy4SY9IpoKmTDv4bDNTvIWga95DPhAy/x5eN4dLWNqWOxwTdknSTtZn9kchf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QAvCPgJC; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QAvCPgJC"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-234bfe37cccso59461495ad.0
        for <git@vger.kernel.org>; Mon, 23 Jun 2025 12:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750705481; x=1751310281; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pnM+MAIkiQvQvwjXio14NGS94+WIAqr/m0EHZHg56E4=;
        b=QAvCPgJCXBfCGD2bcidnkACbpfZ3R0cHKo3qDUW4uQSzuojpvGr7EjWta1qhi4EFP8
         +QnHC6ZGsmEDqmoFs9UVALd7aPW9vsvSb4I5wGihpsUmdjyzTkHTH/aUHsQXYkmWDXOp
         RG2UpR4pQpxI6P8KQiv9YDYGY8pkp0pRVw4eo2xlGvPbgKS9RNRHz/n9Yq8MrfOuaGX2
         AGON1mlmZgOsYOnIdQqyHiABqDPnb9+6oh8WT1nH6gEELlYYhbIjXS8vDAlGGL4bZgGQ
         6zCCyf1EbQomMCaxrw5XyPqDCO0Cc/zieDx1ez0+pxCH1x4qJorCg4Giqwh9KRm/RJBh
         rFtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750705481; x=1751310281;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pnM+MAIkiQvQvwjXio14NGS94+WIAqr/m0EHZHg56E4=;
        b=TbqSsAJipD/PbT/slAL0uZeydJQRYM/u/tbglBd7hdoBKD2d721EmxykucjIBqEKj3
         N6gKFbbnCHJqVF6HHZMWDQz/1Z9ZQwUEbvc3tt38fzpzSUX5/oy7tmdudY811GTcpZ+5
         lDEfj5q2dLmpvPXfIuIzHPM1Xf2GvSHfXptIeSXjufN3E+AqopmuROxjUro2necr3x2s
         hwzI/HcOzBZ+7Lidzm5BwhAIHEMM2cBDKrlyDYYW4abeIekyatOmBZQDsWjlCY08qMxB
         zs9sxDeK4JX1tHo22Ofd0fQo5nPqoC9yS0wCexUKFJ6dKDLDrcqlQWKr01J2Qe7IiaXM
         ckRg==
X-Gm-Message-State: AOJu0YwDM4Ll9flUSE6FMPSNB8GplcvMlAKUBlvibbRFpsac8mxysbGe
	JAewiEaEqTeJCCoio7g3bQTFYrjHBvUwWPkakx0c0Wy5Yv1J4CB2T8LUirjyww==
X-Gm-Gg: ASbGncuHtvOr0l8S9Mi31tlMHxn6FM1fyCMWQT2m0IZNpYBZMQmV+DzMDvPpgdKZEPt
	HKa5KdC6zvxFjVNqRmPWIr4hDn3NEwvvzOq7N3ImsT/B2o4LRYCyQdm887lvPrRYf0ayVbN66/c
	0FeEkhB2Xe58PZyaptjzhzFy60eqON8OQfbB484+7tOrP24wMXXYimBqXU2atdYHAfpZgLSrM2R
	1bFIbekvPYE8IK2mK/E2Ct5peMRTVhrec9SNs2yKhz0JIuPs/z0wq2/pupZ0XdXVB6c8L1o2q2w
	F/Q4IKE87jjSJ6KwXLKl/uhpdbKwIGF/R0mDSD+azOXunvdYhqN4TadgyAF+YP8ZNvY8MSJW3+U
	ty2Y1W02kRpCY
X-Google-Smtp-Source: AGHT+IFUX67flnEnnmz6XIbs7hHVV0dOMVUSfirRapy5AD0Nv2BbajErjs2gIWWkcsIV8tMevek25Q==
X-Received: by 2002:a17:903:330b:b0:238:121:b841 with SMTP id d9443c01a7336-2380121b84bmr16682295ad.17.1750705481090;
        Mon, 23 Jun 2025 12:04:41 -0700 (PDT)
Received: from smtpclient.apple ([191.181.56.196])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d860aa41sm90970335ad.106.2025.06.23.12.04.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jun 2025 12:04:40 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [GSoC RFC PATCH v2 1/7] repo-info: declare the repo-info command
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <CAOLa=ZSgFYXEwdTyAfC2TSgVqpCSq6D1NDBwPU9cY-unX0Jx6Q@mail.gmail.com>
Date: Mon, 23 Jun 2025 16:04:27 -0300
Cc: git@vger.kernel.org,
 ps@pks.im,
 ben.knoble@gmail.com,
 gitster@pobox.com
Content-Transfer-Encoding: 7bit
Message-Id: <036552C3-5448-4CB6-83A1-9504D29F62AF@gmail.com>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250619225751.99699-1-lucasseikioshiro@gmail.com>
 <20250619225751.99699-2-lucasseikioshiro@gmail.com>
 <CAOLa=ZSgFYXEwdTyAfC2TSgVqpCSq6D1NDBwPU9cY-unX0Jx6Q@mail.gmail.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)

Hi!

> Something I mentioned in the previous review, but hasn't been addressed
> is the addition of documentation for the new command.

I haven't wrote a documentation because I thought it would be too early
as this command is still under discussion, but it looks like it is time
to starting working on it.

I'll include that in v3.

Thanks!

