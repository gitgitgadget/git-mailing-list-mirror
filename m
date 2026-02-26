Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17CEB46BF
	for <git@vger.kernel.org>; Thu, 26 Feb 2026 14:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772114621; cv=none; b=mcMeIbtzvxipXf0tjGb7pHvHtLka51jNW0P8IWFdX3VGCXNF4ozhLtc6kCsUvssw4Wn01eCzhg925fMrluvbzNFGYQdq4rjlv66GAGosyz/fvLKI/Hp5DcFE+HtskzAgrGM/oFoeLBaldGcYwyfu31iMDDL9lU10g5qo6oz0NFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772114621; c=relaxed/simple;
	bh=ENqNeUUPUvoc9vN0oCsQytIBSgHaX8DltnwsfpP/M04=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZXxQde1sqsNpiUljOkppXrxKcdnhrU1AcYMsNKemPbUaznjSWgymxDmBBdBUmNfRG26k/BIpjTZeJ3jdbBDxPKSYjS3JEUmGr+aMl45IPuMCAa49NxqBdkxwZcnyBKxLMs9rMPf0XXH/eKjkZl/kYSZk26aex2gvvQe/H/oxP60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C0nmNVpH; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C0nmNVpH"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2aae38670daso476855ad.3
        for <git@vger.kernel.org>; Thu, 26 Feb 2026 06:03:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772114619; x=1772719419; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c7k2DX8IcoJEmYBc7usy2wmH2gyYsTAH1PxIxTeCyKY=;
        b=C0nmNVpHlW+2gne8pqccpbtm1F1bvGl1pEWPpDGCm4AUfrcGP/k5mZuKt8IQ6h15lM
         ODDDTWkq71lWOa9EmjWTvp4HRE0hoUc0VLIB5mHtrq5+wU1XAr/wHYhH60uV2VM3YYMR
         xUxOWso/hJDQ7MxBzozM3Dn5MWBXa4mwIbxSAAdKKHswVcjNdQqPjdNAqabc788LZWB3
         QiFbgyHKXsEPQ1XijJ3wUMfLnweDnanKFz+0pdNf8R0mOu7TMgFrTv6WjPh+GlbRTyLd
         Wa0CZq0nfvPZS2kKXGrUtlLlhkR7iz9x9Z1kPr6gvupfZ9WC9e5dBzbPiF27zuXmJfMk
         MtyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772114619; x=1772719419;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c7k2DX8IcoJEmYBc7usy2wmH2gyYsTAH1PxIxTeCyKY=;
        b=r7b8ZbyTWie9oh/DATvu60MtIOOYafXVFKqpb7B3ZJPRu9wgMZQPux73vqzB+qtboH
         FalMj9EJU0M/0ek868LIYRZKkICCQvIXlPcTFa6BRhly8qWtJ9R7Lx5Oix++HKucKMos
         Gq3midsBAhEUBJBpIFMoxJ5F9lyqpgSzDIqGHJgvUKuSqdh4fBY5uhmUNSCu3QebQpOK
         bK+2nd/q9etGIl6d7L9hlPZwpj0TQbykzYdVo++ocquOEEubfRu7VTtPqzJgafQzWx8m
         EYyo+/r+TixqFDEdQ5FD5FrAObsrAsUOquGGi+pG9dO+5QVETHGWFJs3p1FvWiW1bibG
         4qcQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJaMwtsAu04qH5D/AeTVk3c3VGGCD3K961yMXs6bhISeVSUnBYDFSIEZNKcvokeyf+Eb4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzW9BWL9XGZOAX1etYHCSkMTsXCfkfNJFB/TwbWEPtvjv40emB
	wKKaGm3JFjMfcnfYDm4Y7qj/5ABW58/+VfDinQQz1ku3gT2iNveQY9A8Bk41GXYE
X-Gm-Gg: ATEYQzw3HnC1I0mfjtNXOtoscezLYFw+OBjG6RFjo4xP6onK3dMB7WyvWcK5dur4xP0
	NGMZKodKTvLluV0PnmqiqfMtvDwVyxXzQdTX6sq0Un+v5ka/TkF+xY54DYA1nbcEQzO8fxguAc3
	HaPN3w2rv2pMsD9E3pOrujVgyH9HENDtX0Bii8AsKSTge5UDssIf936fkaeew8U6TfH+psBVL5U
	3kUKuAXROH7EZvh4kV4qehNYv+VMOzhZjUWF1Q1WCOPThCNtn/MT2roke+4EfRLFAgpiyYQM70F
	yI8ZJlSHVFfnuD4SyMmAz3U1RXZusuYd5GeAUJerri66dsVttHQ7dQC7VK7BSUEBo8H65quXDJV
	xeY73UDVtg9e7/4OH7eNlKFlumywSQljAj2O8cQXkkFh2mm/lVno0g3OFyG/VDlg/Za86eAHFMd
	BQ2gHKaGU4LBo52QGaFowVtAzZ0vM=
X-Received: by 2002:a17:902:cf05:b0:2aa:de29:65c with SMTP id d9443c01a7336-2ad7452014emr140311595ad.6.1772114619396;
        Thu, 26 Feb 2026 06:03:39 -0800 (PST)
Received: from [192.168.0.109] ([155.69.180.3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb6f2161sm29369005ad.86.2026.02.26.06.03.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Feb 2026 06:03:38 -0800 (PST)
Message-ID: <2c0ff47a-0501-44b3-8fab-1ed93116d9ef@gmail.com>
Date: Thu, 26 Feb 2026 22:03:35 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GSoC][Draft Proposal v3] Refactoring in order to reduce Git's
 global state
To: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
Cc: Christian Couder <christian.couder@gmail.com>,
 Justin Tobler <jltobler@gmail.com>, Ayush Chandekar
 <ayu.chandekar@gmail.com>, Siddharth Asthana <siddharthasthana31@gmail.com>
References: <ab45758c-fbcf-42b2-96df-030eef8526c3@gmail.com>
 <b98780d7-3aa9-4838-9234-290b1d72ffd7@gmail.com>
 <CAOLa=ZSyeNg7kSGV4=5wg02FYomGe0CbJ7GzCzT6okC64UWHMA@mail.gmail.com>
Content-Language: en-US
From: Tian Yuchen <a3205153416@gmail.com>
In-Reply-To: <CAOLa=ZSyeNg7kSGV4=5wg02FYomGe0CbJ7GzCzT6okC64UWHMA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi karthik,

Thank you so much for the review.

> Well it depends, we already have `struct repo_settings`, and individual
> settings within the `struct repository` struct. It would be a very case
> by case basis, to understand which variables fit where.

That makes sense to me. I will update the approach to emphasize a 
case-to-case analysis & mapping variables to their rightful existing homes.

> Yes, we also have CI jobs for GitLab and GitHub which do this already,
> you can run them locally too, meson makes it very easy to do this too:

Thank you for providing the information above. I have integrated this 
into the V4 proposal. It indeed looks much more robust in terms of 
memory leak auditing and other checks.

> I think you're missing a reference in this sentence.

Sorry that was a typo. While writing the proposal, I went back to the 
source code to confirm the function name here, but I forgot to add it 
back in LOL. I meant 'editor_program' :)

> What is the 'core context container' here?

Emmmm...It was referring to the 'struct git_env' idea (or something like 
that), which is flawed as you mentioned earlier. Will revise the 
timeline: the bonding period will be spent categorizing the targeted 
global variables and determining their appropriate stuctural 
destinations (via RFC patches? I don't know if it's proper behavior).

> Thanks for the proposal :)

Will incorporate all these refinements and send out V4 within ~3 days (I 
have midterm tests these days). Thanks again for your time and patience ;)

Regards,

Yuchen

