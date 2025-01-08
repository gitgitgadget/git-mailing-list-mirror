Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BAFB38F82
	for <git@vger.kernel.org>; Wed,  8 Jan 2025 10:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736333042; cv=none; b=EkrfcexNSr5z6hZ4onbzsOPCnow2q+Ai3sYxz6m2b6mBcGxbASBvZ8EospcqQsITYE6iiR9EQYN9rGmcHFv8LwOP+WEzkRgfuxJe7DbswAYA7JdxHaZRVyL5QmmU5u7VFEF8Q1ncKIqm8W4uFCC97RERXfcUpRfMWmO3YSiS8tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736333042; c=relaxed/simple;
	bh=/qu/v5SUTmtj2Hzkz6MQI5jq3EST1fx38Ng1R+OklPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fdGyDftjHGIKJsZadrooQ8vuUQxbNUpnUpmHyK6dFUDGX2fwW49Iuif5Vz5+bcrvL/JKFbF9fOBViS7HfDZOvI0xqjEpcVMpYoRn0GCUhHndwn8zrnvlETSFLfXMpMgZ68ixve4oyouMPIci+/qsbC9qnLi1yrg/kC1XsEGHB+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GeP0YLNq; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GeP0YLNq"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-216634dd574so162325315ad.2
        for <git@vger.kernel.org>; Wed, 08 Jan 2025 02:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736333040; x=1736937840; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MzasMI0MV+QzdmFzcJOEAU9+esdDyIL01+BNdwGFF5o=;
        b=GeP0YLNqbQap2D+IvchMqW3dAqQ//1HTl+f/FH2RO6pUtqA9hH6OtsmngmXWZCPeza
         RZOatlARtoJpnDUAFLcwVmn2VfSZSJHlq1mB5s6pwqxsNEW9wKn/BKIpVgUc61S3ugDn
         CFibye86st2+Pv8HJz8oGVIsRs/VfkD/g6eCsc8B5JoZjr2O/pvWtr80PIgagvYvUAKL
         vKffXdasZGFvsR5ZYVP/yuHV0OanISdeoP9h7zA9mAT5yH0fmODXTNyngll9ufgbKVFP
         JApSv3+FeRC0eZQOspeteUHj5sBo3L6Uz021LAiC+8ADrdCkfTC6HPuQjQ87XCfE/QqM
         Yf6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736333040; x=1736937840;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MzasMI0MV+QzdmFzcJOEAU9+esdDyIL01+BNdwGFF5o=;
        b=iwbe7ttFPMtJMm0JhpwpanZjFpJQCAQejGDARlRfckMaGEDxwl9og23ubmxzLrtn//
         zEP5git7MeHg7EgLSMb9mSzgp6EcMNyjs+qKkaumhhXYvRC7Y/G0UIagSMOKBW7mtd4D
         keNupLVuEXud2KeO9jwdB/IYhDdPc4gmYoN2N9eppL+UTxdvUkboaDKJNwzAncLH7q16
         cyDSrcHG6QYBlUdUsGMUHNvAu7zB89trzahKNbagVyRDrfbTPVmKaqaEHSTNe+RruYcR
         FAdFHLOCYqoh9jIJw4PW9YQsQi1W4DFvEafHVrxt+qQ2QJjCIhD3m/Gf1v4f5Wprl4YV
         KHew==
X-Gm-Message-State: AOJu0YzukhgcRY+SQej1lyL7ijOQXtMmUr56l0iAVVUCP9+wzN4YdYiU
	qvU0pAjYjoUK/OXBs4MnfopWA+RsSDstC1ILOSEeSUI2LnrDNQkbsqRlPg==
X-Gm-Gg: ASbGncvPdciKJ5H8BKw8TI9vp8OZqtg2K6lFT/G0i2+tf9EebskMxj6EnIScafHo0X2
	v9GV4VZUfypRRNNkydI2Bnl6UT5qrQUYSsC+uSZmj4WLakwdvdOgGjh34ZsLAbyv5jAAUWK4Ric
	lL2vBY/0bl8S6zFheWjUNR84fgf3V79J8tCA7xXTIKusC+Rrf8MncxiyFwVcD4Ire7A0eVOjXaf
	PPvW4mRtoFmnCFpS/mHUJ4fwNcIdWQqOVhos/C2cvdRXpzXH0MdpcAzrkpOxQcKl72cGP80+ApJ
	053UHG81Gc58BA9dJw==
X-Google-Smtp-Source: AGHT+IH9xDkw+qsR0KPGdHDKGey+Ae6NI6Xlpjuk1hyg+4efstg/OOZdn2o4F9k7QVESI6E43t+FEw==
X-Received: by 2002:a17:903:1c5:b0:216:431b:e577 with SMTP id d9443c01a7336-21a8400afc8mr33178575ad.51.1736333040326;
        Wed, 08 Jan 2025 02:44:00 -0800 (PST)
Received: from Carlos-MacBook-Pro-2.local ([2601:640:8e80:3680:55e1:e8e6:7b15:8ce8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9cdeecsm317567935ad.123.2025.01.08.02.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 02:43:59 -0800 (PST)
Date: Wed, 8 Jan 2025 02:43:58 -0800
From: Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To: Rhythm Narula via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Rhythm Narula <rhythm.narula26@gmail.com>, 
	Emily Shaffer <nasamuffin@google.com>
Subject: Re: [PATCH] docs: update contributing guide to refer current bugs
 and feature requests
Message-ID: <cwkdvlhhfe6lrgx5pdcrgmgv7cfvkjflazo4k4yorzbuaixlpn@myd7rrdel3w6>
References: <pull.1867.git.git.1736080517950.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.1867.git.git.1736080517950.gitgitgadget@gmail.com>

On Sun, Jan 05, 2025 at 12:35:17PM -0800, Rhythm Narula via GitGitGadget wrote:
> From: Rhythm-26 <rhythm.narula26@gmail.com>
> 
> The contributing guide is updated to include references to the current
> open bugs and feature requests. This update aims to improve visibility
> for contributors on where to find open issues and features that need
> attention.

The commit message (as described in `Documentation/SubmittingPatches`)
should explain the problem in the codebase and then describe (in imperative
mode) how the patch proposes to fix it.

Subject line is also meant to be very short so maybe somethihg like:

  docs: mention source of tasks in MyFirstContribution

> +:mailinglist: git+subscribe@vger.kernel.org
> +
> +Here's where you can find bugs and feature requests existing in the system:

mentioning bugs with quotes might be a good idea, considering that GGG
(your first link below) specifically mentions that only feature requests
should be filed there.

something that encourages people to use the mailing list for reports and
discussion probably worth adding as well.


> + - Unofficial bug trackers - https://github.com/gitgitgadget/git/issues, https://git.issues.gerritcodereview.com/

see #1432

Carlo

CC: +Emily as the original authour of "MyFirstContribution" for feedback
