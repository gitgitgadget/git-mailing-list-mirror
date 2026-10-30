Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793374833;
	b=1bO+leBVLXZrxf94yrtpmS9MDofB7tiWqr8IGs+rirkz3lT/meRZdtdYLc2jRQVIk8aM
	 i2NGG3VnSubeC+Ikw7Hodme0vPQFW3LPlPgPlQUmN5JVTmc156AdLXDOTsZnocAAEx1Qe
	 4ZwTCgKUz5aOrCnK+O3vY7Pqo+UAeCN5T3TcACSLSN8cZemAsp3l5rOsKqzJEAA1ACSD0
	 UhmttvCW69vZ/oNbOcMlVzJpBxJwtavzlV+Hj0gfLAIOt+xsKevZYxAmfoRogPEDG0+7e
	 Ilm+N+TnQa6tSOVkqBfK98T81NEdjzzgCHriirpdGA5RZakxV39kV3rXmwtgvo1ph6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793374833;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=rzAtzc18+/Usl69q7NxbFlCd1BXiqYWjhNHuV2U0guA=;
	b=w3Lp3yVMXTTldGd1b5KrMq00phjAyeIDVPxNJcemX/ALBr96cxp7i4XYDqc3K6A30VCv
	 5hUa9RbQewWgZkZnbwdOiQ4F9SH9yYkRA0CW1fQJCxUSaGt988dSaGb6s1Xhaa7WV0xhh
	 8N8oa2Ic8bBCwWj/0MrjimvFbWjaS21TG+CwhFHsb1W+rY3y90aymqbKFPC86uhjjuahB
	 dHrV0G66NYeI/s5O7g0eXpzFFP83C7AS9exvCbUMfOBevKU2F8FTKsXbsRSllIZ83FmA8
	 bOxYxa099CP6V8feWbkEW6JstLlV/kyoTw/iTT+Qw+mprPfWjKfmoDyuTucrHllqUYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Nt76nz1o;
	arc=none smtp.remote-ip=209.85.161.41
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B09606A322
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 15:40:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72B09606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Nt76nz1o
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-6dd059478dcso613742eaf.0
        for <git@vger.kernel.org>; Fri, 30 Oct 2026 08:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793374832; x=1793979632; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rzAtzc18+/Usl69q7NxbFlCd1BXiqYWjhNHuV2U0guA=;
        b=Nt76nz1oWyho9V4d5yaYt1mV3XYdcwMmdlKPWHYyyf4YBn/Zn+5v2WQsUMRJIsdL9J
         o8c/CRjjJue8RmM2Wh6JJ2DkA+Qs5//wdafxL9NkysabbMoWDm26W5oszXYfgoV6yke+
         JAliHMi/jz1U4in303kn6Raoa4RrhOUla2BNp0493j5593iGlSj/VpKulGhKlwunHBpV
         1KRJ67mtDhlaVD8lCYHEhN7QRzKZRTMqkkDCocK3bBwqcKBInKZ86wNsWDzjHJMOUEbF
         jDoIAieu45fs9SSGjxbfdKkUOCsKd4D11e4YqG+JKB5TXSDWeTu4oaofkdBCFzWegeyi
         gUoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793374832; x=1793979632;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rzAtzc18+/Usl69q7NxbFlCd1BXiqYWjhNHuV2U0guA=;
        b=wV962opTVhbQyJdXcCkQflIT1ws4G8dzSgih1kr0Y0GGU0+FclJYgiVUwOHplIIB3O
         A1M9ATP72+Cb2j1Gyq3/gAi444zA0yh3p99xjKNQp7srJTYZCMbw0g1sDUfUIO7oev3p
         d21pvNqzlQWTXmuLuoD0x8chln+r3LjzzmTXGNKw5LS0KjurgDCPwQeCJculym/QOSvw
         Ha6XXpTMyyXYzjDhGgGvI44y/R0dSBLthpqwtI/BgwP2JFxKBwJJhBZasDnV/C3Wka8H
         u/joj9/YPyEYlhIOoVx9jMpgtqIk9yOGQ9/oXTjV+cgel+fyzfkt0vKb1aEddvofLobU
         ht1A==
X-Gm-Message-State: AFq9FYISRVw3R6pZ9yeY9ziSGzSzl+MNqpf3RNtIn5X5ATWsXQJmUyg2
	G/Lkv8+5DW4TD+C6vXl7FGMOeUwWGs8B045MnQtkzttFQI0I7mA7rK59ZKH4vA==
X-Gm-Gg: AYBFou07UGGPdKgSIXoSbitMxBbuF46QijK/JNKb4gfuugBiLXJCoDLVVvciMO5m1M4
	DT7DkTLmcVg5ul25MC5BrMC1s/63+mV9JQ/EAeCRZSyoYKibXkCr6psVfMIvQw1jZnz9IvKrMLI
	XF2nIs/y7wJRVAtZUPxKd8hKi4MhkTEA1VSAVTfGDEpBVwDclPjrc2PyJ2wwmMXCLmTz5WwBXe4
	nFzYcXSBEK28glX46KbotP64CzHvg+6AiHUJfv/TGCvmW2yQbAPEMbvh+mENbkCBocAFs3l9XDW
	n0Nw0KSzOLhy7TYhwLjH9vEAJ8Gr9vCPPPqGr5YYDjBfH+g08rGhwu43J1KGqaUJvUZaBjpMBuN
	Egb/eBEIhEdSAQpuhQfSrb1zT2vRtUdR7Jc7vG3ATqIZrwlAI6DZygBPUmYL4Omn7LvCCGWsuvs
	zCdeDhRXTdNibunS87uPMR9bTL57/0KL2CPYKOK0yc4kGQI7E8ibnXJAcGAO9G2FCI3phxfgx6A
	zjOXd46EtDbTpB2RbpSAQSUxcwwf6EAT7xogd2JZ8ZGmp1LYt5r5wI8UfrIpBsA/QP1sRDtVsiL
	/BGLwulPb9SaiN9ln2ODyji5jocpK+l3daGo5Qa+tFVPNSt3TewXB8VrH/KZJJ0gFM6io3WlYYo
	=
X-Received: by 2002:a05:6820:55c5:20b0:6f8:728d:cb0 with SMTP id 006d021491bc7-714f29dc895mr1218871eaf.46.1793374832326;
        Fri, 30 Oct 2026 08:40:32 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a921997d50sm233885fac.10.2026.10.30.08.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 08:40:31 -0700 (PDT)
Date: Fri, 30 Oct 2026 10:40:30 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3 0/4] loose: fix migrating "loose-object-idx" with
 batch fsync
Message-ID: <auS6XMchhyuTF_VJ@denethor>
References: <20261029002413.3291184-1-jltobler@gmail.com>
 <20261029232220.1245827-1-jltobler@gmail.com>
 <auQ3FTXbn1awcP70@pks.im>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <auQ3FTXbn1awcP70@pks.im>

On 26/10/30 07:20AM, Patrick Steinhardt wrote:
> On Thu, Oct 29, 2026 at 06:22:16PM -0500, Justin Tobler wrote:
> > Changes since V2:
> >   - Reading the src mapping file is now done prior to acquiring the lock
> >     to reduce the critical window.
> >   - Added a comment to `loose_object_idx_merge()` and updated some
> >     commit messages to improve clarity.
> 
> The changes and range-diff both look exacty as expected, so I'm happy
> with this version. Thanks!

Thanks for the review!

-Justin
