Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA240530E10
	for <git@vger.kernel.org>; Fri, 16 Oct 2026 18:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792175227; cv=pass; b=UwCp01iyeA2IkkMqhwpQNflrS4LEfUBdsF+anCI12lbQ/wV1T6dwLjQ3SmOLHbPQcA9D7YH/h1LTwQkDsad3W8mX37m5Oxld0wEHV7kc5IijlQF15VVF4P5Qux12m0gPj59UI2Yo1wkoMKAdurTCGpu10YFbD9Ly/EoSBV4kBS0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792175227; c=relaxed/simple;
	bh=gbnuFTrobpBkqFTIYJkfi+ioqz+1UYqcn2LXNUGyP94=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Js33hDKER4RNWBgtrwWIzlXM/aG2D42kntaTi+BBKOud/KtgLIIuffQP46BKp0y9eZpZOhgQTn8mWG2WWlKpuZsHnUTWyBVXUZVslIA2BxXPo/Q88VMMI4K5MZy6PF8/1wseRx5tWZZoFuGbKrn/aB07Gv54QI5+ZBuZeN2G+sM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hmgGvNh+; arc=pass smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hmgGvNh+"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3ab4178ee33so264846a91.3
        for <git@vger.kernel.org>; Fri, 16 Oct 2026 11:27:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792175225; cv=none;
        d=google.com; s=arc-20260327;
        b=Es7othlcd1/f1X7d2QN9CWIKYYzk2Sri7KYWzm5RFYQuqnsxVkI7ZKQaDr9I3cXrOV
         yqXmhkSCDL4Tb4+zC5TvmRSJW5y6NuYyNf/xTFjFksPTVxxkljKTOLDMivox1a6lPSLv
         8wUF0QTcLWDhhLogB/rwgac+47waLPiVeQXkQk81fpTJTYkmQ7zl2wRcH9AQpmQjbQa8
         8L7X86UPdps6ikM/UutVMnjtc+qe0Iv4abOP1sXj24vicJm8uu1+gpA/rfsyIzbSOrYj
         DP8I/MDc6xMDgo/kiaZ+bzmwB4InwMYaajkyQtIcHob1YvR/8O2RvvcDC2tgi5KyxCv+
         g+7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gbnuFTrobpBkqFTIYJkfi+ioqz+1UYqcn2LXNUGyP94=;
        fh=fkS49wI5r2AoayK5qRd9br1J2tMPfUxfyCue8OC5scA=;
        b=iDGNTw3X3LDo0cDLQbCVmb0Q76EUKZcjFGZXhoh7hh8Y+PJxCU0ljg/bq2ADvXJuCq
         IeF27tlLBfZhXVPqp9+atQ+GZ8jnwe1rjvFGbIPCak2PrUOf2C1w/kHvRmVjHubSM+Ow
         +sSPAZcGPpQSFuJcdi+sYQNqqdJQEFM+LAPt3KeLRzTIuQakRLwNmkco7DpX/8jxpjW1
         7bcbJF1JWr5gcJqFCzpaVvrsgvcD84BAcaJxaAXGYDsTwlwF6Rs7YbxrlLWd73qcxPW+
         LjiMMlh2K2LzGrOnDVWdqzWWLrUNlkOQHesvHlmrOnDOS9AyWh5l5s2M6o7WmcmxfxVg
         8OJg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792175225; x=1792780025; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gbnuFTrobpBkqFTIYJkfi+ioqz+1UYqcn2LXNUGyP94=;
        b=hmgGvNh+pzjLX0I2v8/pswp4iF19lbI9ypFUP7QmRvMW69LPSPUNsX7hmtUgF5iMIi
         3vHV5uitPElgHsin1hEMjJtgSc0CPlKMfEEe67J5Y20q+ac8PdCUndJI4QcQfZhZOnL8
         UmLwMYy8qVLxcxhteKICG5RQry4el/dP+6ZrINVd1Bjo0foRfoHUl4BuYYlNdSLUtaoU
         ALMMPat2I2cpE8grcqn+NuwDzDYbLmWStHRBhtuuFcdm3/2NZEtz2jgehCk4mQjLRDDV
         khvUPm9JxxhJI/Dknh+vKxqcG4pPAhtLZLS11/Ew/kufjb+P6mRwvFgPXVjvgWsVrDgK
         3G3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792175225; x=1792780025;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gbnuFTrobpBkqFTIYJkfi+ioqz+1UYqcn2LXNUGyP94=;
        b=Pi4rnTZXzckMsmZ5y43Mrlwgwf1bHU3OF9LyN9r2l4Lg35Tve2ptggXnmzquKI0Gum
         sLJYrBIVBtQBY1dshLZMxnRJUMn2vrhJ0iJPFpiQ+ltnaKPAvuDME0KyLTtRQIjjLyTL
         GloIogh5Y+4X9S7YNmW3EuOCxg7fY/pDqqqfPv0lNg+Hzez2wqMqy3T7veYz+x1hnxIG
         S3F7K+OtY0614K+G6UZ1WuKkr6Qi9n3q0yxbSwRjI4hCGgkASFPyWyfWhUKeRr5IYJye
         jVE/FO4yzoiYGhQOaxZtcZKwA80EiBKMEr9POg36+9fnZvRpOPOpy67P69dKHz0kYTBA
         gYPg==
X-Forwarded-Encrypted: i=1; AKwUvBx9lSvx301MV8dnAIWYtA3RWp2LNX5MQuAzofbifTmfEC4AlS0s1ShpIjajuqyk6+i0QRE=@vger.kernel.org
X-Gm-Message-State: AFq9FYJCDO8FnRfjm5K+qMC3492GCEXrlxfOC1qA2o5qaELP3S5tGY3Y
	BMPordlBJiBTStXs4O/08vz2jQfxj2f5bp+R2lV1DmqC6ICG4+lnzOG/BUgyCfHJBrruhJ69iwz
	T1twVmu3WKtYLE0tzCPdvck/2ibXxNN0ffw==
X-Gm-Gg: AYBFou064Ozr157FHAhYtxHwN7EyJBOMMnVoIzyTycpvJkQLfcwlU44eKCGV6atKbbF
	IU4QE4EXpynU9gn/UPTWIwhmLgtLZ5syodom5P5sgRbYRJ5+L4/8rWuxRJA3InxWiJUYHbMYzXB
	VRKAsBet5zkZt/D47q0KgaJN70aSqm8toL/t0DNNfxuFd4gTXtuUdwV8SDaHJ4YGUWKr/5NqBpT
	NkotS1XiLQigr5K5i8AWkbzvkLKPoYZ3X3Jep6i8o3xgqOt8HHoTWPVs9HGhEf5Uuc3b/9WF5wK
	S5lFY+Lbhcu2PAOiHIRHqoq/8/4UkR1IlZmuGArt0DkXP1XuFs5eCbONi5v4AyTQL6ocE6oNzZs
	jsH71UoHuAL5dS0GgwR8LQ45oGx7GF1ZL9QxvdoH+SJRXr2bLw4RbmVlpKelBn0wxHO98UgMU+y
	YUETY/Zuwfd26qplzOq84L3xBZoZRzsg==
X-Received: by 2002:a17:90b:524b:b0:3ab:5832:72af with SMTP id
 98e67ed59e1d1-3acef14fb1emr499844a91.32.1792175224978; Fri, 16 Oct 2026
 11:27:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2448.git.git.1792070038.gitgitgadget@gmail.com>
 <fbbbabee-c586-4305-bdfe-3f7cb46b7191@app.fastmail.com> <CAHwyqnWyYhRZ0=byi3_yqT2phmVa2DY8XtxA8bQT=pwcetkMAg@mail.gmail.com>
In-Reply-To: <CAHwyqnWyYhRZ0=byi3_yqT2phmVa2DY8XtxA8bQT=pwcetkMAg@mail.gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Fri, 16 Oct 2026 14:26:53 -0400
X-Gm-Features: AclHuK9QqoExya2c_UVXUSCFwVFtXtj7Z-ejFIDm7LSuG6AaK5wo80RkirWt9KA
Message-ID: <CALnO6CC+6r=t_ENdFLBxyR=KWxW8hZ_0MPvH1o79TVLG8N5RGg@mail.gmail.com>
Subject: Re: [PATCH 0/3] reflog: add --operations and --historical-branch
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, git@vger.kernel.org, 
	GGG <gitgitgadget@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2026 at 12:04=E2=80=AFPM Harald Nordgren
<haraldnordgren@gmail.com> wrote:
>
> > This sounds very useful. That you rebase many commits and then the rese=
t
> > points (where each one started and ended) get obscured in the reflog is
> > classic for me. And I think many have had the same issue. This is why I
> > sometimes use `ORIG_HEAD` instead, or maybe make a backup ref.
>
> Yes! I love the reflog. But I'm also endlessly confused by it.
>
> Sometimes I'll just pick all the commits one by one and do 'git show'
> on them to figure out which one to actually pick. Not a great
> experience.

Perhaps `git log -g -p` in that case? :)

--=20
D. Ben Knoble
