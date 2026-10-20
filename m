Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792513656;
	b=bQHpGAExwa49CuaE1faSM2bIB+EqLP3EA/hsITM0JQw6hXCT2vOMGvWtQ5DlvZEG3Frc
	 zXc/NHWpyoTe4KrsHkYuA/NSzIeaF3siCYLLv0nhdDz+wWaJmtCyPDR4F154h6bgEkgJz
	 1/epI/cFF1Wn7PFnskIYPW0LHpafz4JhU1ugP8r6SX7MTk49MsnawSVfqi3MRN2MputJE
	 cMuZK+x/TZbZrZNHUaNrd3LIl94u49usz/6ovISBlhZJncgYA/SxYQ67M4HiXJAkDefGm
	 guAfvJovcgLXE1lGUp6ZRHqvhMtDM9rRZusuD8TbZYa2NkK3szuWDTykq7EuRwn65Dw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792513656;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=3a1LGaT5uc30hHPnw5+FBo7Bb47Kiyyq0msL1rHpuVw=;
	b=fL36Y4PO3J29jzBfW2EYd9RVeSdNSV8SmLO8iKzRR5bEYcEB8r4I1T3Pstsw03wpauK8
	 IezYMmrCkS7tnYXWCl94kShvxdoshBNIhRIthZgQvJgWMfQWbJhF+ljlVt7e2Cyl8Pxv9
	 wh4NQLfvqi6qE3IbS2+LFUnqGHlc8Hu3kIlMGdEcUyXZgbsk4dQ99j5vSv2M9v4j9XlWG
	 mm9o1YxdRkOhViGIfbe/UqlqcmgrMi1PQUuX5VY37fY4CrSAITg7+0wHTNVpUzzQxep6r
	 Pv3juT/LaCe/LxCr41ph206r1bqhF5hViyAwOjer1ys37dUryYywBg66jPkR3Q1cvXQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=cb0e0ZFs;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.43
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2CD606A31A
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 16:27:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BC2CD606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=cb0e0ZFs
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-990703f817fso1597121241.1
        for <git@vger.kernel.org>; Tue, 20 Oct 2026 09:27:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792513655; cv=none;
        d=google.com; s=arc-20260327;
        b=Te13WU+2voRZmXb42fRDocK1Inmj/TqUL9b9f1r37sfGjHnhHt1KF39r4vxOsnHLVK
         WhB2ijolKQGZRXbkEkhVZFBBy6rQ+RvWpVziqlAyFzqRI4sV1ZXS3ivXh10SdeGxTiJP
         c3Z6XDt4LbkahUhQMo0D/Ikz0kMEQlbTBJLJQdgl5ipzF4+W1g0J9JWDA7N4eKMJtOw4
         sTtpVXTxQrSZyLcylsjpdH/S1SZjUuaniGsNgw6Q5GvDhFvVqMVas4q66axdYefRqDRZ
         Qa+yRLJHthmhauT06Hfy7JXrlw7DGUSM3KgoKxmSyBkXYLm30pJqoCRAo1rwZ0kESmZA
         fGSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=3a1LGaT5uc30hHPnw5+FBo7Bb47Kiyyq0msL1rHpuVw=;
        fh=5xr0cGgPS8M64IKVOhcqO3ruuKmnppeaJg6alQ1/M4o=;
        b=RLfl7WR/Kb/mxVPwzGP6TtKzb0+VACvvLYQywu3uarqQrsSSPBzGBziqQ7vB3qv2EU
         FR2lbMbXE/3CJcQulN9VTC5FCZx9nspbKoDFffJaSj2vvGL8TnbXAU26Zf68AWLhGVeB
         zwAmc3jQEOiHmO+8xbzru/A5bSuFropDlyKk6iJkQ4UUchsREL1lckO31IzxJH61LCIz
         GeEdkh/tkqflD2/yMDHYtx7MlwOFroiKh+aBiabzil+ImEUeTcbwiC6npyyYIK1bbhbN
         V+vgKdpYKvDRAFM3yAzwgRoUyBsXkXd9sko+NgF1OhUx5zbZ843kv4yqdXWvJVg0Eb+F
         dgww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792513655; x=1793118455; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3a1LGaT5uc30hHPnw5+FBo7Bb47Kiyyq0msL1rHpuVw=;
        b=cb0e0ZFs2IO3ngR6TtxCm3bJuL2mBzdxDWsKAQPbfVLRIxAVInCiGhKtxgW6k0ekvj
         vQ4t0+eNSJs4oN4Q6XnnVbxYieUcyUMtw6zVjBVr4XO/6Fp+fooubCmUVPRMxXiyoKUz
         xo+3d1o8uqw/3Jno0Xqg6NFfSqLzgcHKrUAj/gRVM3aLv9RZoNf8601iiH3y5CfjrG+e
         U5pcR72cwnTWinT3+UjnOoFXR27E4/VbfR/pbn6kLLYL+y+8KXeemmQ1EKeH38YBBrmF
         993kAeRSYaShIhBv5Hy09UPQNB9FUhD58GZ/zdVB4dKHDUbLM7QYTs2W1+gQ8mUCMtJb
         Ttew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792513655; x=1793118455;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3a1LGaT5uc30hHPnw5+FBo7Bb47Kiyyq0msL1rHpuVw=;
        b=nA2+YbKrZ2jNP5AuVERYXEDOCbjP+j9JlCo7gtm7HWvjlowvGP4hEJhHjMIsgaHYju
         9ypINYsFFV3XFMqEgqcSrgIx1d5zyWVDswy9mgvEYaARDEqy4eq222/hwpKq4ecKq2Um
         xOzPKaggFH7rP4I61hWYgFq00Ti0V/sEFRbfeBXgjvm8QNOHle7zUlvPoxqDXzXI/nGJ
         abdiLyU6EyhCDFGR7O6yQxinta1Rra2qFh0bszvTANg5Um1bPFBzGbz3EwNT5UrIFD3p
         e/Qi+OKxbc9rafLesznZ7duP+uM7NWip/jKVhWXrsvBoA9v0bnWdq7wftc2MICt5lNJQ
         fqew==
X-Forwarded-Encrypted: i=1; AKwUvBxxDa9pdnZP/aleN6WvspCW4PqUUGIxFgDFu3SBtKHfcjAwyQbEylo+h9sQOoJ7Aro/fbc=@vger.kernel.org
X-Gm-Message-State: AFq9FYKJJCKIRR76sXgeQxQwXiJrGBs2/Nx7vrjB2gPupO49LmQEPsJO
	N9ve2RJZWgHP9zxbeWXdpPqlSc7wnQO35o2rDBBO85VQrU3FSmHr7PlNe4qYV56QB3r31i0kS+9
	D17wRbzFkzaAVJNF7OTa9UJD+UL7Qc7HjXlaVPDY=
X-Gm-Gg: AYBFou3i8b7RqeSiaqC++dgrGIXGo+EAD8UiwQh2n6+rhtwDhF614G2yd7w2fWyGECH
	wJZXF8n+ofNDid1IdOq3YXU5BIL7ZBMYQ1E4kDuih/1UJf3bXL2JhBDev6ZeLpBUzWojXL8gRu9
	4AftFpjt62zGeY5EJoKINKao3eN5ya+zv2GjlhfJ/3rai6VXIZPNrMPxJCdcm4UdGQohJ2DnexA
	zehrv0//Qha/XXfr0U0uAW6ArQcq700MZuYny3+G8jQnouKdOSTNhgcbe764JrruZc1IEc6T1Sx
	HFBQDxzRcMwmgotSY0LY6lVBO4zFj8nva5SxvUNGODrTSvj1zLDBzo4=
X-Received: by 2002:a05:6102:3f0f:b0:7cc:16e2:c1a8 with SMTP id
 ada2fe7eead31-7cc3691f500mr3855259137.8.1792513654633; Tue, 20 Oct 2026
 09:27:34 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2266.git.1792341073005.gitgitgadget@gmail.com>
 <atXCFxxe3Lg7fV2W@pks.im> <CANHmUQTj8nR1GmPD2FW3+yfsgdgNh_vwRCcxRhS8GcY4VHDb8g@mail.gmail.com>
 <xmqqqzhl2yfq.fsf@gitster.g>
In-Reply-To: <xmqqqzhl2yfq.fsf@gitster.g>
From: Shashank S <shashu8660@gmail.com>
Date: Tue, 20 Oct 2026 21:57:23 +0530
X-Gm-Features: AclHuK9qvvxQxE_H5OKIIF2vnKT7EuS-OlDPRBWXXiM-DRgswNzPIuZfLHGi498
Message-ID: <CANHmUQR2RG+4AGvxN2mPZoBeNn4HUpTivXm5bck0yVXyb+RuOg@mail.gmail.com>
Subject: Re: [PATCH] prune-packed: remove USE_THE_REPOSITORY_VARIABLE
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, Shashank S via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, Christian Couder <christian.couder@gmail.com>, 
	Siddharth Asthana <siddharthasthana31@gmail.com>, Usman Akinyemi <usmanakinyemi202@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 20 Oct 2026 at 02:35, Junio C Hamano <gitster@pobox.com> wrote:

>
> Shashank S <shashu8660@gmail.com> writes:
>
> > I have checked git.c file in that file I went through this commands .
> > prune , prune-packed and repack which are .
> > { "prune", cmd_prune, RUN_SETUP },
> > { "prune-packed", cmd_prune_packed, RUN_SETUP },
> > { "repack", cmd_repack, RUN_SETUP },
> > All this commands are all registered with a special flags '
> > RUN_SETUP'. This flags search for .git folder . If it finds a .git
> > folder Git successfully initializes the repo struct and passes that to
> > valid pointer to your builtin . If it does not find a .git folder (if
> > they ran it outside the repository) Git immediately stops and shows
> > the error . It never run the code .
>
> The analysis is not entirely correct.  Assuming that your system
> administrator is not insane enough and did not make the entire
> filesystem as a working tree of a repository,
>
>     $ cd / && git repack -h
>
> does call cmd_repack() with "repo" set to NULL.
>
> The call to parse_options() will give the short help and exit.
> Becaues the references to "repo" you added all happen after the code
> already called parse_options(), your update will not make the code
> dereference NULL.  Some subcommands with tricky call sequence into
> parse_options() _may_ have to be a bit more careful than just
> checking "are we using RUN_SETUP?".  Of course RUN_SETUP_GENTLY is
> an explicit sign that you have to be prepared to see NULL in "repo".
>
> Thanks.

Thank you for the correction and the detailed explanation.

I had not considered the parse_options() and the behavior of the -h
flags outside of a working tree. It is great to know that while
RUN_SETUP isn't an absolute guarantee against NULL on its own (unlike
RUN_SETUP_GENTLY), the fact that parse_options() exits before my
modified function calls ensures repo is never dereferenced when NULL.

I appreciate you taking the time to explain this to me.

Thanks.
