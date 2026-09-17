Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD1230100E
	for <git@vger.kernel.org>; Thu, 17 Sep 2026 06:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789628218; cv=none; b=QzMpeEqUMiG8TozuNFNX1KIhI+TcdU4axcQf3wG892owqbJX8Ub2tq/Wy0blo3HNY4+JzhjVINQ2jLzKCU680Wifg7uclR4GfFA1N5ux87fAr4BhjPbOAdAwwYLttkgVkGAxitWpM5bYWRpIO+gTXD89SIHFfUiOgwxmzMvc6wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789628218; c=relaxed/simple;
	bh=Xfp5wtdg1P9XOhc57PD01L3582uacZ6EQZ28ntHGcvY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=s2Wf4FG9/EIZGdANXSLzFSCDCrlmfQaOFzEJYAyXg3f1xIx0ibu07dHKwDSalDqawR0LceSRTOq2Him14cIHAHAxEO/MNOz0slReMvrDxT5ttjKMFsJrxKfcMZFOtjkI8R1+gve+q/rY0Jvka1VwzQEBAu40uzUJiZIALjJeHz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com; spf=pass smtp.mailfrom=brighamcampbell.com; dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b=gOTk6tvP; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=brighamcampbell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b="gOTk6tvP"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc433d52421so274759a12.3
        for <git@vger.kernel.org>; Wed, 16 Sep 2026 23:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brighamcampbell.com; s=google; t=1789628217; x=1790233017; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+3L29UFC/e0kXO+VAhWZOFgQsQpkCjuzIMho3ABoWnI=;
        b=gOTk6tvPEPvkHT60ZbCT/X8RdYNRJHEMKoc4f7a/i84SYXlaaFeEtJmhfQGSeVlscz
         uva8HqpCaclavoZIgpnicZzDU+dKDrBQROTrpzGuEgxKemY/T16K2kbprOAB2PTDW1fC
         CcIxbU0YxdiRJkkCL/EaUsddhiOsyIybQGjVrX+32dUCIKpofa/4i7OgB6+sXu8E189g
         8xR5SmfTOwecurbKh8d+QD1wKUjeslCVDT9OAEHL6VpzrAnWdFTapMsIfmbMOB7VSn1N
         jhESMR2CKhApb3SIeeRhUeCkWqKKvTFsWDBnWiEv5a+SJYSQ2x6ijPTJkSaTcKzLTEpM
         2DTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789628217; x=1790233017;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+3L29UFC/e0kXO+VAhWZOFgQsQpkCjuzIMho3ABoWnI=;
        b=HEnhgKWkspnTXjHY6DrxhUU5LzjpOzdZhK4eeC7NufGAVrGgh9k/5GW7u5czmg+mpy
         q4WlTR5jZU4krfev9rF/n3m0eEqx7OBE5sAPTYb5GwRcKKbO6puwLuV/HQ99B1BiKKD/
         A+AZBNQ3bzfOlRy7Wx5y69EvEjeECt67JuBDUTPPyEAAYiAHLORi2lxTywTb0prcl0lF
         H17CLOed06KBmxZjDhNPMU6BPpedkshyEBFIuBxgGUi01RLmowmP9NaRUuhl5oGqhlEv
         Usjc4dltVH2U/RmICRq/FnLLZ3M8c3qRNWC2K8ogpvZ48Y+TAJbnG4/u0XSSqvCgOc0X
         s6XA==
X-Gm-Message-State: AFuF++mFdpbfpIi+xeVe4uRLKOfjaVh1SbNUx0Gxp700kcXmp7VXrSaj
	PTwit+3JYAzTQE7cQbETPgtHkx5+gqGZyIMa0V/+iDCWQYDVjqzSD0plSwZq5+0y6po=
X-Gm-Gg: AYBFou1FmnRD5Q0vWgd7OMlcp4VGdJs80BwQy3hSgJo1kAz+33LBD+04eIBg2S9BXgV
	HddKqsr4KSy8v6v+paw08ZRPUy5ztVFkVQKO3u7ZV4zgJxwFTjHyZuvEqmp6o8eFhBTsMu2YZGp
	ppgWWkkG0Lgkw0Rvn3jzu2KGiw6ahieb3MvJDLeV1RZa4z4z1+2G6TCknkmFZ3exZ4z4rG6N+9b
	/DE3jpR7jdHY42lEUDbwdzn6ji8MHrIPOuteOBXdCZVyYeugqFVMWGAXYbp7VOQmhzSsB4Bj8w1
	JBw9IiZonZO4y0UmeGJGFxrGpe+EXedtEh9LYAuk0OjQBGqZGHznUxfTLQ4N3AhcMtkPLsBZHoI
	lK2W68QzRKuco8QjwJX1bvAzS4AYPbi5cLjHsOmi8mkngpbUubh3n1U0d5l4HaBBLEfHi53HNo/
	RXqzd05IV8MSn07YsWEEwQUkUdlCmoD526YTWZT4sfnsXtqfVLIM0AOjZ1mKRe8EZ2t3DS9ZB/s
	r0r3c9jAPx2MDR9bja7cOJjAWEYLSHdClYH1xQ=
X-Received: by 2002:a05:6a20:4313:b0:3d0:88f5:f812 with SMTP id adf61e73a8af0-3dd5f455d67mr14148695637.10.1789628216637;
        Wed, 16 Sep 2026 23:56:56 -0700 (PDT)
Received: from brighamcampbell.com ([73.3.69.70])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33bf5aca3fbsm14342766eec.20.2026.09.16.23.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 23:56:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 17 Sep 2026 00:56:54 -0600
Message-Id: <DLHE97Z5RDVA.168ZY5Q3TG8YJ@brighamcampbell.com>
Cc: <git@vger.kernel.org>, "Patrick Steinhardt" <ps@pks.im>
Subject: Re: [PATCH v2] git-contacts: allow inputting patch via stdin
From: "Brigham Campbell" <me@brighamcampbell.com>
To: "Junio C Hamano" <gitster@pobox.com>, "Brigham Campbell"
 <me@brighamcampbell.com>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20260914-git-contacts-stdin-v1-1-9ac628e6fd20@brighamcampbell.com> <20260915-git-contacts-stdin-v2-1-2005061d907a@brighamcampbell.com> <xmqqa4phxogc.fsf@gitster.g>
In-Reply-To: <xmqqa4phxogc.fsf@gitster.g>

On Wed Sep 16, 2026 at 8:25 AM MDT, Junio C Hamano wrote:
> Not necessarily a suggestion to change what you already added, but a
> mere food for thought.
>
> An obvious (and UNIX-y) alternative design would have been to follow
> the popular convention to tell the command to read from the standard
> input stream when "-" is used instead of a filename.  Then this line
> did not have to change, and the command would have allowed arguments
> like:
>
> 	$ git contacts patch1 patch2 - <patch3
> 	$ git contacts patch1 - patch3 <patch2

I considered this approach as well. I may as well have flipped a coin.
My approach to choosing hyphen or no wasn't very scientific.

Naturally, if you'd prefer that I change the approach to instead allow
the user to pass "-" to indicate that a patch should be read via stdin,
I'm happy to send out another revision. I understand why we would rather
get the interface right on the first try, even for something small like
this.

Until you ask me to work a revision that uses "-", I'll await further
review on this v2.

Thanks again for your time!
--=20
Brigham Campbell
https://brighamcampbell.com

