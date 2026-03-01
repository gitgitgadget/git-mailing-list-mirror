Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64B11391
	for <git@vger.kernel.org>; Sun,  1 Mar 2026 13:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772371154; cv=none; b=D06Eoei63+HBV+bCLpCxFKI20w+TkSrOVaJCcflpG1/Q7bMVI4C8Ym86I9IWpzFohTbhbDFzZz2g+5PdVbhs9UtF9bQlOxyVTKMM/JHYbc12jGAGo0KOcffEzZ/7dkKoyxJz60aPBr9S5Qoq9lmJda8wP/0o/z4oBjfI7BKeNog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772371154; c=relaxed/simple;
	bh=7stwBom14UF4btE8vmjZ03lKkiC9Kp6SWrLg2bo/cK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tVS+zpmjTqFzezgH9+1i2Frvm2L+/ke1Wd6SLIohNsjpviScgxNWIsXiwph4QGkv71UofeOrep0BghFqTdZb8uWJbaSR3CU6/q0hgfBMZFiwKweTish/c/qLqOAt8DjsdxDD11MUCd0zHCAETMsv1B2JAZQt1SwHzvpdyVSEh60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CZaFg50L; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CZaFg50L"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-48375f10628so23417715e9.1
        for <git@vger.kernel.org>; Sun, 01 Mar 2026 05:19:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772371151; x=1772975951; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=awcBvedtztvo8ExsCM0VOMhRv/u1Y3bhwpBB5W2ALy4=;
        b=CZaFg50LA/M2pWiX+cdZG1EwCqUmreECc5ibZiiUxm0+MjpE5IjJWtqCZbnLZFBSTQ
         NVkimx2NAY7HKcvDfkavY3FpYvlrrasSHcML56s4wfAwRW3a3ZeXkCw3GoBO3vgMX0OD
         OXmPlKlzBbv7XJ8HAzBmKHieSVWPgeoCD75aUHiwGUOF1fkSyWUlzGsPF/xZKCQLudvR
         MzjmO9Hd7is0S7+WDMv/EtE4/karyhtBmz69Ge+u/5Xj1GqPTgKW+JIAaRj4mjKJ8yUY
         ykWAwkfHETUZfceDENI1OADTeE3JtjW2RBYXS6vGoOdQd8JHVkntSMnvUdpMxUpG7B6B
         fsow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772371151; x=1772975951;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=awcBvedtztvo8ExsCM0VOMhRv/u1Y3bhwpBB5W2ALy4=;
        b=AsPQUtYesXYHJyQiFCy1ePPc2RU44B+3BOJJN0Htmiz1uSuhiO8jbnbVAtpk8pvm7H
         xXrT+58irJfjTkC3nmmvz0X6tFlFJVLy24A77EDDGSy3zL2+O6IhmRWEPEGXSaUhoB1P
         aLbFLlDvp/a6YKv5M3+4NwKHnxfoVlIq3LFPnNyfqbdydLQiFk6y9W332Rq15YGfi2tu
         e4r2W89Oy1/iP1Ijym0I1f3KCg0f6VNpMeDkgpC+GdeX/IqopwDeCpZh/uE/xKg3+wQh
         DQRzyR+oq+0Z5Krn0kNbVFaLtEvEByc6wukK1S8p0o/bW8OwudGLRRoZ7AyCV4Vep5CV
         /xRA==
X-Gm-Message-State: AOJu0YzaGG9xrIcP3q9/Os7gKGVTv0vm1Uk89EXunT9jtpO1BpZZau74
	7+XzRsZVwDARGEkT8tUmvEr47Pl0nV/0NaCR9hIFi68zarsK+ogWreka
X-Gm-Gg: ATEYQzwL/9SsLSGd+ytyuCG5oU5cMSxDL6uSZ4YFlAGmAIb0Q7/QSVO5iI7yMhiP9D3
	WJEpnRATeZV3LZyhNemC9YO2kKVWG7bj9/NOmkXFyHYAw9+c/jq0aE6hjLv6TXa44kCsGfaYGDs
	1Q6X4PtqJoC9Cg5bIssItwoRc4Srz/7IoDsGSthkpNrMgUzPMQ6mAECV72N5mT5f8g6TVI7Bb2t
	mv0lIBydxM7pe7s1LarZMvYArgUcjPiqpubUywogkN5KdOWKXDYjUoxceezSRDezpzIqXkvkWk7
	+P0A1tfnIhJVCClqp1LVoTz64PySB7CaOyNiDXH+ApwHiXBnRlbMXSvlw0v5RqVvTIhqJkzzi6w
	Y0fO0x0PJq06x0T9oxAnqPlzqiDmXEQ/18xx+gtHaqIm4wjTW5TFJwqD/rfjrYs09ZfvPXkclj7
	0iqH44ot7ESgCNNaw=
X-Received: by 2002:a05:600c:190c:b0:47e:e8c2:905f with SMTP id 5b1f17b1804b1-483c9ba7b9fmr140231575e9.8.1772371150868;
        Sun, 01 Mar 2026 05:19:10 -0800 (PST)
Received: from fedora ([159.146.42.25])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483c3b3d24dsm191734025e9.5.2026.03.01.05.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2026 05:19:10 -0800 (PST)
Date: Sun, 1 Mar 2026 16:19:02 +0300
From: Burak Kaan =?utf-8?Q?Kara=C3=A7ay?= <bkkaracay@gmail.com>
To: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, christian.couder@gmail.com, 
	karthik.188@gmail.com, jltobler@gmail.com, ayu.chandekar@gmail.com, 
	siddharthasthana31@gmail.com, lucasseikioshiro@gmail.com
Subject: Re: [GSOC][PATCH 1/2] editor: make editor_program local to editor.c
Message-ID: <aaQzlE2lsq4WfFxt@fedora>
References: <20260301105228.1738388-1-shreyanshpaliwalcmsmn@gmail.com>
 <20260301105228.1738388-2-shreyanshpaliwalcmsmn@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260301105228.1738388-2-shreyanshpaliwalcmsmn@gmail.com>

Hi Shreyansh,

I am a GSoC applicant like you. I just wanted to leave my two cents 
here.

On Sun, Mar 01, 2026 at 04:12:58PM +0530, Shreyansh Paliwal wrote:
>+static char *editor_program;
>+
>+int set_editor_program(const char *var, const char *value)
>+{
>+	FREE_AND_NULL(editor_program);
>+	return git_config_string(&editor_program, var, value);
>+}
>+

While moving the global variable from 'environment.c' to 'editor.c'
doesn't cause any behavior change, it still relies on global state.

I think passing a 'struct repository' and using the 'repo_config_get*'
helpers here might be a more robust approach. I know this means we would
catch config errors later (right before the editor start up). However,
since it doesn't seem like it would cause a data loss or serious issues,
this behavioral change feels like a reasonable trade-off.

Thanks again for the patches!

Best,
Burak Kaan Karaçay
