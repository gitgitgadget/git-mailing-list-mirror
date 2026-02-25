Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315C136C0C6
	for <git@vger.kernel.org>; Wed, 25 Feb 2026 15:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772032280; cv=none; b=QVKyPXHR5E4XWLVbYeUXgJvtKerNguP7e25kcWrC96XZsgnjgmOVNA2HzB5BBZh1pZ2CfVrKeBNIkPdogr2H6vE2LTfs13/ol2z9fL/w2bXSEIA2P661rsakVcsDGGmuuPv6X4bCszOZ/IR0w4eagpJzox1gut397txQzbTKgeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772032280; c=relaxed/simple;
	bh=x0Io7LrhAc32UG4Yve1pnMhQ8LIKUnGKcu+2lnBugwE=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=cBzNet3Ph7y5VwaxuSoMXDkA/G+RZ4WwhLa+rUN19+c12f1d1Z99H3fqs+c/4MmM7sgx9cKiuNy39gNlZl0RtPDR5EqJZ70tP1YDjwI/A7xelJOg+Ho2Kj9wueNW9VkEoRHMi5v5n9vdNDkNiKhyTCzPD6+9jgiC+oQSgXSIVJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HHhMtQRP; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HHhMtQRP"
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-56753dc51baso3110727e0c.1
        for <git@vger.kernel.org>; Wed, 25 Feb 2026 07:11:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772032278; x=1772637078; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x0Io7LrhAc32UG4Yve1pnMhQ8LIKUnGKcu+2lnBugwE=;
        b=HHhMtQRPL7iBCcytJmGtDkXlCx2KpwB80iGSKWpJMTli2CEzh/8QlTj0LZrg29u3ld
         HQC8TjTcqYG4wA2Cm7+Yfi8DDkeIYCjFyv+rc+VXdxqM32RHwlErLOSPTCVEg3dFahvh
         6oSraTSXWcf8FzAkLuSvBh46O5QgxuUz/3kp5Fb2J0Q+DT5nwVaJODHPVt21SDuvtWyb
         XP5CugOuak98+PJvhOAn5H7okPe2EYZN7pFupU3AELsP5G16rLipr6Ef4XjdZ88+Gnbf
         EfJ+U2pBR+j67086v3045SZPtBOEHt+ezMaULlA32AOEpcmRjdtAtaANog1TPuO91EG4
         GcBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772032278; x=1772637078;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x0Io7LrhAc32UG4Yve1pnMhQ8LIKUnGKcu+2lnBugwE=;
        b=E9VWd+QpJ/7Jc5gqQR1lU8EE7rw5Ixeg/MJoP4emqZE0oI6zqwzxZKjleo/kvRQSFB
         OJgFCbfDbRjHMG0EbxZeIMVjP/FF38FKUVMWzrtPOuWfynpVT7Ev66UvM7xURxhYXfS7
         DjzNhG0vkEdDAEUhe5pl5Fn2JfLvyLx35YZ08Mn0RnTl+UaCQJev/ihTtX65XgAt6g1n
         1ti8HkhIHhbvmT6u0rUlbv3j8dHfJo+Tr6suHRtPLF1a4sSpUb/C75EVHY0HOl/jz4Mc
         EMPC2OjmTaKHTDZsG03q5hnFyRpiNLET4ibqCZXlM1o8eiMiYLo3CSpwtkRY0ouhgXB4
         J28A==
X-Forwarded-Encrypted: i=1; AJvYcCXyVN9ZLg+/d/tq6BfuZ9JHQ8w2o39pi2fU+3BxoCbFNuIADztbkzYB6ZZYGeNw+aFwU4c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8j6RtwTdPsKWFnlEQjSRRSE7DpIxpSxAm6J748Xgx3alWoqot
	uh+ufi8z43EgejhCswl8VUjZDAcuuefo77W6m7WH/x90xfrATCkx3VXo
X-Gm-Gg: ATEYQzzVqYKpGepidQdWKKqpzrN3Av5leQZw1i9kftvzQ3xsu31LLiDsZro9TsgJ3Fg
	JHuBHJWG0/6pQGGjNthsuTBVHoVvtSKuIrx+9Si35qcyz80Bl+BBpHxG5CfxgP08HZIrntQdzsO
	+NC0Du7BKcxwugInu1yWJlkeisEGdsZOObKS+syDky77W2+lHtaJ0HLzJJdTeiIHcgSGLBzPjjY
	GUgzV42zS2Kge/UgIdci3AtPqnr7Yiy+45P84wlqbTB2s+YLVX1xv21RjHiL0jXfcU/EFmA9w1L
	I3uj8YiBkZMVK9dnDfxNPfi268ZrelPUiBWmgUNKss4Y1JV0PPPHYE6Nx4LWjAOiC9FeM2j/OQv
	nNtMiJ41z24ohxAKYs7goYrkVBjg38DrxeqYZP+Cc32QL63tbyEHvJATWFrXK+yWw6s+3y1bi2W
	vQBFSCb3cCMzbS0IL42qIU/pt01iXb7fM59EI3ZfMjU9Fg0CvKMlMgG29SGaQh2dFr
X-Received: by 2002:a05:6122:3306:b0:566:37dc:e219 with SMTP id 71dfb90a1353d-568e48c946cmr6343914e0c.15.1772032278047;
        Wed, 25 Feb 2026 07:11:18 -0800 (PST)
Received: from smtpclient.apple ([189.62.150.156])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-94da8a30a33sm12697504241.8.2026.02.25.07.11.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Feb 2026 07:11:17 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: Re: [RFC RFC PATCH] builtin/repo.c: change info default behavior to
 show all fields
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <20260225001439.54954-1-jayatheerthkulkarni2005@gmail.com>
Date: Wed, 25 Feb 2026 12:11:02 -0300
Cc: valusoutrik@gmail.com,
 ayu.chandekar@gmail.com,
 git@vger.kernel.org,
 gitster@pobox.com,
 jltobler@gmail.com,
 karthik.188@gmail.com,
 siddharthasthana31@gmail.com
Content-Transfer-Encoding: 7bit
Message-Id: <4463000C-DB1D-4DBD-A474-95BF1003D36E@gmail.com>
References: <20260224220833.17730-1-valusoutrik@gmail.com>
 <20260225001439.54954-1-jayatheerthkulkarni2005@gmail.com>
To: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
X-Mailer: Apple Mail (2.3864.400.21)


> In the Pro Git book there is a chapter which has a very good description of
> plumbing vs porcelain [1]. It might help.

Indeed, I also think that the entire "What is Git" and "Git Internals"
chapters are worth reading by those who want to contribute to Git.
