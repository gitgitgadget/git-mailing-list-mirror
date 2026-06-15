Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08F81DF751
	for <git@vger.kernel.org>; Mon, 15 Jun 2026 01:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781488543; cv=none; b=BXF1sw/l4fmcVmNULChDGnjlMvaYrSzfeJDWlJGBiT5aSWQDcXr3nGQY4ce3Cww/IbfUjDrH6to28t8tKbzk9LS3fmTF8CJUx/Zk4sBlMx6ZnMokr1kXDiCGVwcWVFo9CoRYaFG+PNGrUPcypkPD12OKnYkLazUhF1eK12sFtzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781488543; c=relaxed/simple;
	bh=ME66QNP+VEsRaOEB4lE3GFW8IJUlFBKgdMJuYBvfEmY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=LA+iWQAtWK3k/DhtvR9liHa3LMjL6GFnZClXoiZjD3iIGVyYHku2aakSNRkPeTj3+dX3fOrPkx6poLYUgV2vyb4topieRl1z/onTK8y5HJ2qMwF8k2A9kNKt8HEX5AfGYHe2aRIbnOE9s+89piiGJl5ouRF+68Fw1tYVPcqS2Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IgbFgG1f; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IgbFgG1f"
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-6c3099b11a9so1089973137.2
        for <git@vger.kernel.org>; Sun, 14 Jun 2026 18:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781488541; x=1782093341; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hu6Y+YKG4tMaArEqF4HtjGQxFPFUNnINvsH9THkscJU=;
        b=IgbFgG1fd6rovyNsLFGRDLEeQ+kukauhp7ZycbypTZV1tathMzNAJ5e/BUmcWt4jwt
         FIZ/VH8B4GqgBMLuWu7smE547Trj+AVKqRaT1flc87ak4EvuRT/Fh9Ddu8EgQDPuEX6R
         OVu2arJz68XF3F0OLj5wHJjK0NtEi+B4haZkV07Ga7EaaMhMCVUM23P0J6nrnUngX1lj
         Gmz3t1CEWaDFZMzboI3NZBoMW/DXfpDB6YJMT/f87YBKDdhPAc4EOb07aMuyrFwpkpoC
         VCO/6cxGyyMvsIFF3RvxTx/xPGIP6JjFQrh+NhwZZkOelQOrG9XoYPclASnLX0rcGA4Z
         bbrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781488541; x=1782093341;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hu6Y+YKG4tMaArEqF4HtjGQxFPFUNnINvsH9THkscJU=;
        b=Iqvkp3OG/QvKOhFDZkLekGYn4Hu/LkmOCmJkZiqA6h32s9iztFdNKn02kY0kstnE36
         Jx0OVYXn5RSlD0lDYHjQt41mt+jpGx+OntBCnnK9IK6BxlUIvwf8txtutuk6tjTNV0BB
         wuzLR5Z2r72lPfO5JSR9nJMFstBzdcM7X8riYfRqeoSHydkTkWQMQZ2pUv8ZqMIRiMvR
         iGuHsvz8ZIfssLOS+xMQnCGqxVGfpMjh7OE02nNDPMVJdjKqjlFCa9fw2ZkWIlMNq9ce
         Z+SqY7BRXpGrZGGdEZr3WjxGRk6G2XkNp7IkEiDm8l/oSUafmjq/egOp3ySHhsANG8SE
         m3zA==
X-Forwarded-Encrypted: i=1; AFNElJ8Pu70HY/4g+GZxnmZ+CyCG7CmaKE0ZVBnDXcipbVJgR56AcIdaBfRR5Bhk5v5pRsjw5bQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhZPkMhWwJhez1DHkkmm2/1O5J+0b0weorbSklc5afXe0c/783
	d+7Ild8fRGZl6CNHXSS280j7gvXgBhaYY/DGBhgy1Ld4FTLDnMDRKK4b
X-Gm-Gg: Acq92OHeIvr97dcEUFrGAmuxrjnu1V1pn5dtFZZqBUgsrY18mknyPwuOOpA3DZ0n+YY
	M6IPih+Ast7y0DVcNbYWFx/oF0MYtKqCA55ysUeDO6ilAgNkuqjJ3BW+LCQ2p7B2zvMF4q/08rb
	DBcqLuQKK0O3DZL56QJhq0OV1csuXc4mRkrggbb/ebVHKZr+oPx9L7zmfw5GIR8LL/T9yv23lTu
	yThBsEAPh15JbfleOPrZ5dHnZSSy0rRZLwYQkaPy/f8QDYw0TGbVGuraGSWll5B6OR5QBEKNheg
	/xItKilFbzSpsG5qcJdzG6QOyzZIyx+lqhLpCEBe+HihZEewaU4NM9oNAedGB+trnjihU1bdO7P
	mM8nfWmvXMrIB5FMyPcSWKnLDkuG3OsdQ53NvwKWMf2sM/JxAFUe/DGpH2DSZ7UI3wNB/bHFqtn
	zi2ZtTWJ8J6iFtJ5Ad7Tf74D+FG/yiYhuoRhBbEJ8Xtduj/myFuw8N4gn5CPJ3
X-Received: by 2002:a05:6102:4412:b0:634:a573:c097 with SMTP id ada2fe7eead31-71e88c554d2mr5355106137.13.1781488541546;
        Sun, 14 Jun 2026 18:55:41 -0700 (PDT)
Received: from smtpclient.apple ([2804:14c:c4:89c7:b89f:3820:2765:34f6])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-72084dd327esm1781661137.6.2026.06.14.18.55.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Jun 2026 18:55:41 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [GSoC Patch v3 4/4] repo: add path.gitdir with absolute and
 relative suffix formatting
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <20260612182847.562816-5-jayatheerthkulkarni2005@gmail.com>
Date: Sun, 14 Jun 2026 22:55:28 -0300
Cc: a3205153416@gmail.com,
 git@vger.kernel.org,
 gitster@pobox.com,
 jltobler@gmail.com,
 kristofferhaugsbakk@fastmail.com,
 kumarayushjha123@gmail.com,
 phillip.wood@dunelm.org.uk,
 sandals@crustytoothpaste.net
Content-Transfer-Encoding: 7bit
Message-Id: <4F32FD89-2E90-4E85-BE8C-2E2BB4D9E890@gmail.com>
References: <20260601151950.30686-1-jayatheerthkulkarni2005@gmail.com>
 <20260612182847.562816-1-jayatheerthkulkarni2005@gmail.com>
 <20260612182847.562816-5-jayatheerthkulkarni2005@gmail.com>
To: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
X-Mailer: Apple Mail (2.3864.600.51.1.1)


> +test_repo_info_path 'gitdir with explicit GIT_DIR' 'gitdir' \
> + 'gitdir-env' '.git' '../.git' \
> + 'GIT_DIR="../.git" && export GIT_DIR'

	'export GIT_DIR="../.git"

