Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386E33EB7E5
	for <git@vger.kernel.org>; Thu, 23 Jul 2026 21:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784843742; cv=none; b=HC/CSM4OJAhy6hIZ6S3T4Vpl2KPnUeSz8msNxK8i+6SYyoJhTChQaLz6V3AQ2SzcthEpkQn4ZZ4wnu6KYxVKzffrvMJ0O2IQdvH3/d4CSujAO73DX/Eh5/uKnLX1LpFo383HtOPbqFBzkiQdKmLGur51Cm1X1XlkzbeOUGCjqjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784843742; c=relaxed/simple;
	bh=BTWqzcXYLr7gCdQzvweSfu9v9T0X9dIMmovOztdTNHc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:
	 References:In-Reply-To; b=Rg9S8Czy+BoL3FnOmvFX98LO+fSvUfDnspP505Ay9pnI/qwXmeRzPO4RPZL8mSo35HAR/KnDF8q5W83XS7JYoo+mWVvMaM12XGL2BxGeR4JRZcTgelmGGPYl4xcAWf+sKgUGmVlhAvFBvgyzms3s8oGB730V579oLDDW1fjSUXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LLq2RClx; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LLq2RClx"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-495757ccbc1so8933215e9.2
        for <git@vger.kernel.org>; Thu, 23 Jul 2026 14:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784843738; x=1785448538; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:message-id:date:content-type
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=a1fGPQVZ3HicErDv+cR3N49BUTOPB1OKDNN97d9Ros8=;
        b=LLq2RClxvxWTqoKlL9sfKI3CCzJtG6D3dFTWiNRUgHAizGnJvgUgic7wXZXA29+OQc
         nLS6TTWwwXueYuSDG1M3BhVSbqf6x5a8fkMERBa2zfxIlFlFTEqyzFLqtyIwI2Db2jtq
         6V0qiu6b7TncnMXQuthyXGOIgYVljvjkSeM6baVNRAFbGSHNWn4TPvClc4Hsu/M7Ed5I
         wO2sBP6MKVM73GDVVdJTDKJhEl4LulQ604yq/bGE7DMNUWxuAXSUneZo22fhc6n8ECtu
         lYijXkLhS7H0QVmEmyzfi0uBRzBvyPjnoYW1gok+efuWC5QPXdd/m+DaFD7zZKU9HgLO
         fZ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784843738; x=1785448538;
        h=in-reply-to:references:to:from:subject:message-id:date:content-type
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=a1fGPQVZ3HicErDv+cR3N49BUTOPB1OKDNN97d9Ros8=;
        b=G6/lg2Vd5mUDciLaprHs7CsvKHO+7GE0lViYuL7pQSHftax2gPWvRUg5959bKya8zh
         77GPEREProh4K0eVYYrgOO405JMPzgeP5/X7SgJMK5ANVs6/e9JtSBL7sQkJDWwQph5i
         d7tQ8INwaJBFGht4u+3ExF+RCdmrnxzEXGnXCtnACZmoyt2mAeRIreP7lPFUKShW3Vf0
         OpLghpddTt0rFcHo9oVaZ1EhNB4N1f2EAoxzl5WOQKzkJlPUd33uBpEAsA5A69PgdipL
         4Z6P2VfhVlgcgxUuqNcHYMc2lEnum+QXuoKwf1s3FV57+NQtLrPRQHS3XeDZOJDiZ4an
         mnsA==
X-Forwarded-Encrypted: i=1; AHgh+Rr1NcVdp9TNXq6c8KNvU1AvLgRkcOF8FFMkTMZE0bjTq18oLz/Oc858KSD+i9Tvulkvo9k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/xXFakAvgqywvtmoadHHpf2eEXIh9VfoIWYxkNaPGLdrAIkJO
	6sRZRm43A8vah7vZLN7XF9AprRlsMwXKxbK2HzgNx7zawBpqQI7r7yn6
X-Gm-Gg: AR+sD13BtQxKD0l5DGUxBdnAzUux6Zodomdbn8LogHXAl4varmHIRtV/7o/5bkm48JB
	vc8YkF2gFddy+gJU2AqcFfyMKhJ9dRvPNxHaW2eyzvJxyOPec2/y7itL8hMsc9WFsiCZhH60Lq+
	7cyLEZyt9zziUfII0Rh5jjmtQqgc5WmOTis9F5GN6pcvDa4piCl+FAV5/F32UadU/aD91Pt+vIw
	pxR05GhhyqIumgs7NKe37OYSbFp8rEtIf/tyRwk6daRLSwtYtgak9IjmDrC5v8zIjVP7ahkahpf
	kUEdGX9q2aOM9P7ApqfP0Wh9np8CuIu42eX+h+evZX5/5DYY3iu41txxYA3w4ImAxQrS/+kWGra
	kjD9ie0AQLc2rN4FR+8Qdr68A5JdXmAD+Ayb6xg7m8r10HLrByUd16pzkYBAIfP5jR6amvSTSjU
	OzGPkEt8uEANiBkfouWjOHla+Qs5EqfdfI9x8q4d74Hw3nEkTW7uVcb16KbfYDoNv6+ptmfo1U/
	AJb15L9DeZbGYy3coVafmdXgzgW+XyfJuwIFELHVmbjhrc0urt7b+Nlj2GR5zNRdkY5LG2v4B0A
	laT60D8EoQgNMwv7Z7Qm
X-Received: by 2002:a05:600c:35d0:b0:493:e79e:da63 with SMTP id 5b1f17b1804b1-49573d13720mr50192375e9.34.1784843738194;
        Thu, 23 Jul 2026 14:55:38 -0700 (PDT)
Received: from localhost ([148.56.122.71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4957b5f2918sm19983235e9.2.2026.07.23.14.55.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jul 2026 14:55:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 23 Jul 2026 23:55:36 +0200
Message-Id: <DK6AAT0NM6G0.3SP94VJYJWPKU@gmail.com>
Subject: Re: What's cooking in git.git (Jul 2026, #10)
From: "Pablo Sabater" <pabloosabaterr@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>, <git@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <xmqqfr1amnvn.fsf@gitster.g>
In-Reply-To: <xmqqfr1amnvn.fsf@gitster.g>

On Thu Jul 23, 2026 at 4:38 AM CEST, Junio C Hamano wrote:
>
> * ps/cat-file-remote-object-info (2026-07-18) 13 commits
>  - cat-file: make remote-object-info allow-list adapt to the server
>  - cat-file: add remote-object-info to batch-command
>  - transport: add client support for object-info
>  - serve: advertise object-info feature
>  - protocol-caps: check object existence regardless of the attributes req=
uested
>  - fetch-pack: move fetch initialization
>  - connect: make write_fetch_command_and_capabilities() more generic
>  - fetch-pack: move write_fetch_command_and_capabilities() to connect.c
>  - fetch-pack: use unsigned int for hash_algo variable
>  - fetch-pack: drop the static advertise_sid variable
>  - t1006: extract helper functions into new 'lib-cat-file.sh'
>  - cat-file: declare loop counter inside for()
>  - transport-helper: fix memory leak of helper on disconnect
>
>  The 'remote-object-info' command has been added to 'git cat-file
>  --batch-command', allowing clients to request object metadata
>  (currently size) from a remote server via protocol v2 without
>  downloading the entire object.  Format placeholders are dynamically
>  filtered on the client based on server-advertised capabilities,
>  returning empty strings for inapplicable or unsupported fields.
>
>  Needs review.
>  source: <20260718-ps-eric-work-rebase-v20-0-0c13962ac532@gmail.com>
>

Hi,

Karthik reviewed it a few days ago [1] and it looked good to him. Two tiny
nits came up, which don't seem worth a reroll on their own.

I think the series is good unless further issues come up.

[1]: https://lore.kernel.org/git/CAOLa=3DZS8J4t12ab1=3D3-LRYNuZOwqSHG861iYm=
97JjF3mGprvJA@mail.gmail.com/

Thanks,
Pablo
