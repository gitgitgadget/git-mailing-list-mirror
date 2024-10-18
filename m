Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4488518D640
	for <git@vger.kernel.org>; Fri, 18 Oct 2024 21:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729287476; cv=none; b=UPpOp5GEN8vNNGH14ilnE+jndzvJ4A2hirM1WTj1np3N81j44tBQ8qz7Tqu6Unbv0zL8T3ANNDd2IC9OiVSGzIl6Fd37KFz0c2eyq/81b8BJe7pUiy8IsqpoDGABWkeDoY4HTeDzQmRZkBARoB+AxAMVASh3KgUGHurR3C1rFbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729287476; c=relaxed/simple;
	bh=NvfgDMudrJ0ahy+xt/e2jknyXWW4MhqXVF4mUN9cEks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PdZY8sVgFZiLnOhDKBl6RnMXhbHDzvMvVZA7S26fPUiyjaRgvo7BqwoRNkBiAQybRqBydltl7KJBVlS1uPnMDqUjUU84kPJxYQWd/JL+g5LJOu1ODl+W19OqK3kJeh4BDr22HYXU8gyK4bOqmBehLgwFE5LIhxHrJrUA0eYgN/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=dSBJRMdE; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="dSBJRMdE"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e2975deea98so2544859276.1
        for <git@vger.kernel.org>; Fri, 18 Oct 2024 14:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729287473; x=1729892273; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aXUVHevPv2xm0YbC70DUT4w9F0YWNFzyG3FXi4HnxIk=;
        b=dSBJRMdE7O/Iyj0hscDLG7mkamXtd7laHwp2oNtFQQDAbe+AtfTuqMDMdm5QmyREh1
         x43AkLScj4PaidAOzzHthZ/N/P+LkjzbZZwVF6SbRyPReNN8A8PGbQUXRabzSeAYhBOG
         JeQfH0pr4oFqEdTFZuqEnERtm30ZkLlmOpQKBb6KD56uJ+RC7ckQJOBh0QyZX7DU2LeO
         n0x66oyHTsdttazF2EQYLuk6im+rOuLDp040CBAr9dKxnTQ0mW5W6ns7SEcmDKxuKb9S
         cmrElSP4aTlCD5qZ0ZERP4sMQFm3aOgJdPhfLJXg6TsHSx6Paaxt98U6IGrarjvAYmD6
         XeCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729287473; x=1729892273;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aXUVHevPv2xm0YbC70DUT4w9F0YWNFzyG3FXi4HnxIk=;
        b=J+/uxBRTv2FeJ/Sf3cyAgYt+ICcRJsUFgEjCW9imJIDVp3H3EjbFw3ploOoFPmLVFd
         RiOFsgCe8i8WYp1DaDLwVtFeTki4549+eVCBcUsGI40Qa19k/z/Vh0S99IdTSNOTTlvC
         LbbGEsV2TK++7tmTNnQ8z6PJQMZR8nQOH2LwqKk1yUb8mtJm/ITvXDN2peCpZIEWmAK+
         v9MPZJzU/N8lEcswamCcldQhGs8ZTcrF/nK3MhTlYzY+06pCr53AUx0Witld9sQ5Uiw5
         5tSV3bfn01igQRJHNjCjjmE5Xi3lpXopuBgEeABD5uKRnKOyYuWXbe3D03ZWV2OsRY75
         QOqA==
X-Gm-Message-State: AOJu0Yzc07rc0EMAxKP2+fD28Y44KE9tCwt0h2VvRldeU2gL9CEGOnaz
	6/8Ry7i2fmE5FXxH/rKOgtRnLUS7+yjLT44tMmJcMebJHiva/D+hC0tAubNeF2iZ5Jvm3Y71C/I
	Q
X-Google-Smtp-Source: AGHT+IFUXrUWmt1lRl9qLhvBZeKME5CbBOu096Hp1qKycX6eyFMzpfFlIwzy9IwZ4XfPakS7WQyUqQ==
X-Received: by 2002:a05:6902:1b86:b0:e29:1627:d4d3 with SMTP id 3f1490d57ef6-e2bb168cc81mr3969093276.41.1729287473083;
        Fri, 18 Oct 2024 14:37:53 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e2bb0204f39sm485438276.17.2024.10.18.14.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 14:37:52 -0700 (PDT)
Date: Fri, 18 Oct 2024 17:37:50 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, jltobler@gmail.com, toon@iotcl.com,
	spectral@google.com
Subject: Re: [PATCH v4 0/2] Subject: clang-format: fix rules to make the CI
 job cleaner
Message-ID: <ZxLVLiiEEj2A5Iws@nand.local>
References: <CAOLa=ZRvFBhageS65uE5enzLBz7H_CAvvnEcPsi_QAi0exRx2w@mail.gmail.com>
 <cover.1729241030.git.karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1729241030.git.karthik.188@gmail.com>

On Fri, Oct 18, 2024 at 10:46:44AM +0200, Karthik Nayak wrote:
> Karthik Nayak (2):
>   clang-format: re-adjust line break penalties
>   clang-format: align consecutive macro definitions
>
>  .clang-format | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)

Thanks, will queue. Are we ready to start merging this one down?

Thanks,
Taylor
