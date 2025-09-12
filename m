Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51D332145E
	for <git@vger.kernel.org>; Fri, 12 Sep 2025 16:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757695953; cv=none; b=BqBc72axp66Tk/33ilGWBGOEa4nrqI7tTu0pfe1Glp7xkcRlsXNhAYaOAZ9/wZVYDXJ3LQWPyw76++mwu9e0YBrZDZiI5m4FD+PsTQ6Qmp27UQOq4n41twTMCO9hNQMnhxt0OFTdLcNsRB/z+SjSxWvJmulPbPN/GO5cyK7qlo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757695953; c=relaxed/simple;
	bh=50vOBM9Vp5/nJnpUZajBoDLBx70/fouiWJuDYV3Yp1o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=thyf9WT2MOFNShNlShUt4qR4jtYwnRGODLuFKeoxclG4+coHDNktzioOrGFBLF72oW3AfuFFY/5/nVy5QycJvZ/XEQVFOnZbiBmV/jaCMHnvEFrGvXUd8yr7UchpQTHV+Nn5HtNZ+h6Us8LicJJY/HFXPnCNJLob2fcepDONdLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VY3DisDi; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VY3DisDi"
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e96e1c82b01so1290718276.1
        for <git@vger.kernel.org>; Fri, 12 Sep 2025 09:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757695951; x=1758300751; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=50vOBM9Vp5/nJnpUZajBoDLBx70/fouiWJuDYV3Yp1o=;
        b=VY3DisDi1W8kyXDSnip0PPtw2tqAjsB9AlhipG8/jW6CBA9gbCB+ZjCX25dClgxOhv
         ul1tU26r0rrWTAWoc6vcffTx/UpJJnu9R+dJwHygk2zRbXi99/OLYGg8BD0loWVJTvmd
         KthO42pE9g+Ozg3Ec2dWV2CMxpAva3Hz9n7e/Hffm4/EH7D3u2ABTVOOMsGEr6pQXOMn
         GNxns8BDCOd39CC2EBYNUqQZT//g6Sv41jwMzbtoJRz4fCZFCuOgp3m2cYrWEVvfzG8F
         VeNImT4zYY2PexComG4rB761tUEM5Z1Y2QZsw4FiM8MmgIdIAk4/RBD6NOh/iO/ms58l
         O0YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757695951; x=1758300751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=50vOBM9Vp5/nJnpUZajBoDLBx70/fouiWJuDYV3Yp1o=;
        b=I9xPm2OJSMyYNIjFzuzm0skR0A5dGFzoRZRq5dzei4LNNMyHW389/YCAzLCVDJiFbi
         4mW/DOofy8jx03/kfWlQOUYQ0XWfgjfrwD+lBI5na8oqPfg3bhc1OcH2A4wu8D9+9jvS
         NhzgTXprCHGT0UPYMC9F+u3i0cbvRsJhodlhOS6wCDMqPrSpVfJBf6Bf3xkUXtgu305c
         8RplOaUIHkDg6OxoXJOYueHQetL3LMuSqJmMqXEJn5glV6kNHNGpCiiwgjyfVyFESqJc
         xj1om0aeSXFgk45X5jeVTs8DJLm5SsCInkz2Si4E78gIsyE3GiLvHjYYNcTa29R1V7qW
         HiYA==
X-Gm-Message-State: AOJu0Yz3lQQ010riJbvJq2JrrIfkIGlDvvMpmv3IOz29kFS3lIqcAOc0
	/bUxhcbmWrrDLZn3kXwjMMZxbRUEcojpRkGHQjDdxrwp68F8fX0F2NM4wWx//BWNXB+AnnYQ6M6
	rnlFhmNCQLSYMZkTrW14Kjvny9a5vlylulA3v
X-Gm-Gg: ASbGncsiLtBcouLRdpgf9/ab/2DLWK0SeLneDU8vgh67DAiUp4dV/Zfihzr+eyGaU3j
	doBq9dlbf7m2Vt7MaUa0zWJt9Fzc0MFyZwICsJAm7viz04OiJH2v8X9v70cvHURvdgLol+P7yGM
	pH8XHwZi3UreLTvPUrpdIIlUJpA5pb409HLDjX00JPSdM4HNTjjJYtPlU1HpkgyGzPq+UYHLVOj
	5kPW7Zj
X-Google-Smtp-Source: AGHT+IGe8VOqGcrEabRn598lpsXVic8TVmmkjrXN2w5xsoGYj80pa+MfrR0sDF4FTe2dGwXhcDRsp1xz/Ahjrqlkj4I=
X-Received: by 2002:a05:690c:4d49:b0:71c:1673:7bcb with SMTP id
 00721157ae682-73064434cfemr38578447b3.27.1757695950505; Fri, 12 Sep 2025
 09:52:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJKmQvf-sLxowLJLitvqDmyL1BXXDK+anDE2jaBSEabApMNVoQ@mail.gmail.com>
 <071101dc23f5$fbf06e30$f3d14a90$@nexbridge.com>
In-Reply-To: <071101dc23f5$fbf06e30$f3d14a90$@nexbridge.com>
From: usharerose <ushareroses@gmail.com>
Date: Sat, 13 Sep 2025 00:52:18 +0800
X-Gm-Features: AS18NWBr8HETzSEFG-xKIFETgkPorkZ5zW1jPVPIOmqBCvtQhTtxiMNMd6QM_vw
Message-ID: <CAJKmQvcqLzJDnpYg5K7_eUNCUdLCkkFse-wB+4R8KGxKo_e+0w@mail.gmail.com>
Subject: Re: [DISCUSS] validation on git config user.email
To: rsbecker@nexbridge.com
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 12, 2025 at 11:00=E2=80=AFPM <rsbecker@nexbridge.com> wrote:
> Some customers integrate single sign-on (SSO) via the user.email value. I=
n the case
> of one customer I helped, the value is an SSO token used by GitHub for th=
eir
> integration. The token value does not conform to any valid email address =
format.
> Adding an email validation will lock them out of using git.

Thanks for your reply, Randall.

I've fully understood the scenario you described. My follow-up
question is: was this use case something that was discovered and
utilized later because people found that Git doesn't validate the
email format, or was it a scenario that the architects anticipated
early on in the project's history, leading to the deliberate decision
to skip the validation for flexibility?

In other words, is this more of a case of "exploiting a perceived
backdoor that later became justified" or "a thoughtfully made design
decision from the beginning"?

Thanks again for sharing your insight.
