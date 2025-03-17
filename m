Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACBB1FECB6
	for <git@vger.kernel.org>; Mon, 17 Mar 2025 22:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742250264; cv=none; b=JaFfuiyv/FznyQ9lAPXZU7M7hcU0VnpBqzqmisGSf/Y91G8NEqvUG11uA35Ig/+dV6kVcyOVdVqUM6XwZxpLrDXgV3WhFfMElGUdv7Nat3zInLetlu4KwKx6gFyu9liruvgbJpXXNX9xs88Zluvh2peBBs+IkovUtqhI+M8DHZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742250264; c=relaxed/simple;
	bh=nkn/JGhbKIX0cOIqRGb8J+RTErQ2d3vBuXmSoG+mU08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XcgEKPfZTT2jXmJvPD4cR2aV9sbYCdomla/5mQbogEgl+PCM7+vx7c87nt1Je+pc4bh17ZgxiRJ8PiDXZIDPeZNeqyzLF/5RTMT3aj8NsbSPaUPEj27pbBeLM5Lgp59yo4LtZGilfKOeYNORc5q4BEnwWCyWGhRy+a1ztPrNEkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=m3LfaZYB; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="m3LfaZYB"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7c3bf231660so588964485a.0
        for <git@vger.kernel.org>; Mon, 17 Mar 2025 15:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1742250261; x=1742855061; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aL7jlaGfCoQozccNsG3Yr70aSABzjXaxP6rqw6tZ3mM=;
        b=m3LfaZYBD3qYawE4H5TF4oWkfm9CLMJoxdYQCXwW2FqwWZ8/jiUQHiDbzRjvYT3iLR
         Zj3gNAGHBuS5XrSDIhfCCgmpSuO7emgYeWmjPJahGzsyFDi6DiTqkCWCukbGID/OPYDL
         qFOOCHiBrIEwBNgPtG8AY/w6/36JI3svMhu1H03ESSbfnOgnKm11+zOcPhPwpO/jHtIM
         KqDU7RYw1TIqKi24ujY0q6slios9kqNbv0rv9fT7wP9+T9iFDDDCUk8iMbMo3euGA3QN
         1IEniJtipgjZjYP5rSBZLM7H+NZXWv83Hb73byAMlq/OlNpu5q93FSBPy6BfkJScM+WQ
         DNwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742250261; x=1742855061;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aL7jlaGfCoQozccNsG3Yr70aSABzjXaxP6rqw6tZ3mM=;
        b=PHhFt1C3A6D5DEUGylkkWGujNRddudIU2ZJ+//XK/jTkZkxFTEpWd1cpOZwGQrgWbK
         xr6JElCKxeIO/5r8+PyJncO7rPyk/ZeifAj5X8qC5HuBwuhel5o0VBj9Iuos+feATV1+
         mDnt5kq47BeRIwREVKUwWflf/rgsF4EISaJivSzQa++QGyc6W+KHWT2lhc80vvUwmCdy
         EH08N3d+HNeGTYO1oc6E1PK3w5Z/QTx9G7Q+1y3v6tXKLdHw7H+VhkmTXDH8mhnrZKl5
         b1bn5PEnHt4bh1oCNtj+UFdGkM3KgsqsY6KZgpR1LTZfNYSK6EYHG0hDTsM/jZsSVTCF
         sQSQ==
X-Gm-Message-State: AOJu0Yzcq22aEQNFnkIyn2R19zXx2OhMjmPz7wuc3u4by/5xw7lk6eVo
	U5N8h7sFNqquwyQ9botg2SU2JyP4V08INNXJLpF5A4qkOKYHJsRRcu/7Sgsq2ty3AVTwztrvG5C
	recg=
X-Gm-Gg: ASbGnctv9euL+i+rKNPtNrx0oP5lTXuGZ2Qc+6xGw+p/IOpnhvpXgyx7E5m5JUqZ6Qn
	M296kjFLoQe/act97n8IX2EPHkfBS3Vj3dLGbqaJUOt1uUcRD0x5yrhCN5FE4+IMw6WY2s1XuZf
	njWIWPpegUqpF/OT5DPsx5ACo9xofQLGRusZrE70dQR0gcNEqJHa69zxSSgq7K0kebuBO4oj9bz
	AUd1I2P9jdRhrkm/rLPCT1zhAkm1yk+bh/VLZlI0W0MZyW81HYhYloNcatlq02uqanbgID7hvvw
	zXtcuZ9rFm88Q2Ok7JwBLtsn/2s5mWxD9IcSV37REGaJRPWVZa5Ej6GW9yu182mYTfxC1CdRXUi
	9TZg6JrZVBktVb9qdR0m2cy5LEoI=
X-Google-Smtp-Source: AGHT+IF440WyOhvNB2b8Y90I3kOsL1Nrf67RnWujAVSeZLGsaVX3US5S4ImfjvQN2qOZQCcQuMcmAA==
X-Received: by 2002:a05:620a:601b:b0:7c5:5670:bd6f with SMTP id af79cd13be357-7c57c8fb8f5mr2297050185a.53.1742250261440;
        Mon, 17 Mar 2025 15:24:21 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c573d8a062sm636463685a.94.2025.03.17.15.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 15:24:21 -0700 (PDT)
Date: Mon, 17 Mar 2025 18:24:20 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Igor Todorovski <itodorov@ca.ibm.com>,
	Bence Ferdinandy <bence@ferdinandy.com>
Subject: [PATCH 0/4] refspec: treat 'fetch' as a Boolean value
Message-ID: <cover.1742250259.git.me@ttaylorr.com>
References: <xmqq5xkdrrhs.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq5xkdrrhs.fsf@gitster.g>

This series explores treating the 'fetch' field of 'struct refspec' as a
Boolean, instead of taking on values called "REFSPEC_FETCH" and
"REFSPEC_PUSH".

The refactoring takes place in a couple of steps, but IMHO the end
result is pleasing and an improvement in clarity over the existing API.

For reference, in one of the patches above, I had suggested replacing
something like:

    if (refspec->fetch == REFSPEC_FETCH) {
      /* something */
    } else {
      /* something else */
    }

with a switch/case-statement, only to realize that 'refspec->fetch' is
really a Boolean in disguise.

I am not overly attached to these patches one way or the other. I think
they do improve the refspec.h API, but they're also ripe for
bike-shedding. So if we agree that they are good, I'm happy to see them
move forward. But if not, I'd rather not spend the list's time
bike-shedding here, so I'd just as soon drop them.

Thanks in advance for your review!

Taylor Blau (4):
  refspec: treat 'fetch' as a Boolean value
  refspec: replace `refspec_init()` with fetch/push variants
  refspec: remove refspec_item_init_or_die()
  refspec: replace `refspec_item_init()` with fetch/push variants

 builtin/fetch.c    |   2 +-
 builtin/pull.c     |   3 ++-
 git-diff-pairs     | Bin 0 -> 12166200 bytes
 refspec.c          |  38 +++++++++++++++++++++++++++-----------
 refspec.h          |  18 +++++++-----------
 remote.c           |   4 ++--
 transport-helper.c |   2 +-
 7 files changed, 40 insertions(+), 27 deletions(-)
 create mode 100755 git-diff-pairs


base-commit: c702dd48567cfebca3d4a06b691de97da3f8dc4a
-- 
2.49.0.rc2.13.g95783265fd
