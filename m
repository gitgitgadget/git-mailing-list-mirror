Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E778E149383
	for <git@vger.kernel.org>; Fri, 23 Feb 2024 19:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708717030; cv=none; b=Fguw3skBOv8mK24TvRipaQ2zz/5CuYwfTpaxqBq4U0ONHoEL6apwaU6CtDmFb4UFxIC2gVj1JYeGahdZyA2e1cIh2rOFXsLddXFM5ATG8FAwEoswd+JJ52sKuMZOi2FPm5Z7gP+etySxS1PO1WeFpDT6/Sg1MqXw6cxBIx4rlMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708717030; c=relaxed/simple;
	bh=xsNGPRCxQv4Bv4kthTysVpCAdKuxDgutQx3o310sQKg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:
	 References:In-Reply-To; b=GxOHubGtvDR0s8qlB4/rW99x1mPBOY0m6x2ej97HOYlqIEgllM2KXX6KRGwF1DSS7JJfWFzz418CfpuSq79GKyQrKCtU1dbtrWILwp7W6+YXZm3zIsF////bRrriq+tFtf4YJvUIh+Z6QXFWO5NICpcZYi+eU8jB0VNJ1ALIEzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jOyMitUR; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jOyMitUR"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5ce9555d42eso1000149a12.2
        for <git@vger.kernel.org>; Fri, 23 Feb 2024 11:37:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708717028; x=1709321828; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xsNGPRCxQv4Bv4kthTysVpCAdKuxDgutQx3o310sQKg=;
        b=jOyMitURjBnMjkZH5tMpvxQDwX6SF8cGhLNDc/NUgopztON4UPeOOjMGBI0+oisnEg
         EV1Awdo3Q5NNuhxZtDM49j59k8TyDMOzVAP65lpU5d0ksge4vLQVTR1UhclQ55wGt0Ps
         VAdu21onsGBf1Qbjs5bh/HJdliJHVc2LYqG0JjsWyoZsJCgJ9bngaIZdvQW+2B6vue69
         hUEdcLjJyB8I7zP3xBel9Ec9PIWKg7tfiAr/Gp2G4dMUPl3rpE8W3GgEQjqPyVQxwOtY
         PWh7mTdR7N21/NLOY5tSBi7ns205VflqwDPAh6R/5WphR5U6MFcYbXiFlzdb9ScjgJml
         QNaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708717028; x=1709321828;
        h=in-reply-to:references:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xsNGPRCxQv4Bv4kthTysVpCAdKuxDgutQx3o310sQKg=;
        b=HiD/mYf2z6aBp/i29PRS1hriQPwgHrcimT0/EurHPzK4pzIYtytgInvCJRCIBAXAaE
         T17I50x05QR0OQRyrWszcG6oZXXr2u/Il2zSwnAn6p8aBAEtKg5qHJS3Oc5rKAv7GpE+
         fNdNhiKdYdsViahpiXN/23apddp4dC7pWtE0jpYi3eVtWA1OtKSXKMyFXo9u9IMIhmk6
         +NLnql/ij4y9fMyjzdjRErYDLX45xHuijWLKY3b8puGABWSZzPtqiGJ610K2Koz/igKh
         nezVt6gXITZcfiosLUx+Y5Hz5P0zEwn1OWDlRRdMSWkkap5awV9tNEu36FPqMBMPbCxo
         JGsg==
X-Forwarded-Encrypted: i=1; AJvYcCVDY8KIk7RJaXIiwJm4WIZEKBGM2XqafQnwAv/EODLwyoqPSfH8wtPzXryzD6swxhXkJftrtRkeKd0iUSyIdWT/wUTR
X-Gm-Message-State: AOJu0YwB1GYkC7iN4qx0y5ARgS5Xv9v8pL44GgBQBtDPBdvTKe91+LNw
	pJYCzKmzb7XAf0it7SZDXKGEKLnGoEPRIWq0zX3FsdUZXdXfyJjM
X-Google-Smtp-Source: AGHT+IGJEBXTlktXVRLbUsbKPEEC9fJWm4/S2XBVgTMBQfRf0hGL+p9iMur/ySvPDUGj+WmVDM4q6A==
X-Received: by 2002:a05:6a20:c6cb:b0:1a0:db7e:9641 with SMTP id gw11-20020a056a20c6cb00b001a0db7e9641mr1014505pzb.18.1708717028124;
        Fri, 23 Feb 2024 11:37:08 -0800 (PST)
Received: from localhost ([2402:a00:401:a99b:f188:2dd3:d960:a8ab])
        by smtp.gmail.com with ESMTPSA id t42-20020a056a0013aa00b006e06b8548c3sm4057620pfg.139.2024.02.23.11.37.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Feb 2024 11:37:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 24 Feb 2024 01:07:04 +0530
Message-Id: <CZCPMSA5S0Q8.1M7XX3A8302KR@gmail.com>
Subject: Re: [PATCH] unit-tests: convert t/helper/test-oid-array.c to
 unit-tests
From: "Ghanshyam Thakkar" <shyamthakkar001@gmail.com>
To: "Ghanshyam Thakkar" <shyamthakkar001@gmail.com>, <git@vger.kernel.org>
X-Mailer: aerc 0.15.2
References: <20240223193257.9222-1-shyamthakkar001@gmail.com>
In-Reply-To: <20240223193257.9222-1-shyamthakkar001@gmail.com>

On Sat Feb 24, 2024 at 1:02 AM IST, Ghanshyam Thakkar wrote:
> [RFC]: I recently saw a series by Eric W. Biederman [1] which enables
> the use of oid's with different hash algorithms into the same
> oid_array safely. However, there were no tests added for this. So, I
> am wondering if we should have a input format which allows us to
> specify hash algo for each oid with its hex value. i.e. "sha1:55" or
> "sha256:55", instead of just "55" and relying on GIT_TEST_DEFAULT_HASH
> for algo. So far, I tried to imitate the existing tests but I suppose
> this may be useful in the future if that series gets merged.

[1]:
https://lore.kernel.org/git/20231002024034.2611-2-ebiederm@gmail.com/

apologies for the noise.
