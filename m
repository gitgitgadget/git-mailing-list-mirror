Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EADC1149E17
	for <git@vger.kernel.org>; Wed, 22 Jan 2025 22:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737583724; cv=none; b=ca9WzFhYJSkUbSvIs9G1u0OJzTBLUD8uYWavK2PpFHgEDtONqhECVdNebduQ2PS93KBOFSCAZ6jOLvyJY2uJ1Pr7Kf6cu33YE7DubSGFioVxXe3vEg9MxGFgJkKYkn6wvxKIlow5MZH+6NKxOZhdr7wI85iurxQtt2WGrFTv8nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737583724; c=relaxed/simple;
	bh=IRRO6NcDWBClZ4DYXim7P5j2UY9/jQ7ZVKVwAyRDyME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ua1Y757QAPXIpn5fiwlQXA7zJMbe+42pkmTD5/3Fz+NpjMD1zx8D/Gk3rdvf8onolHsZQD/xUgh1tJjkpCuMvjo0UpP5fftvrhUOp3X5P4Y704CkWR+3hilgmzN/GL5XVMsCMtEe9yR1+B0rYreqeZZU0pn0rX/3AXTpYOHX7so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=rFP7albm; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="rFP7albm"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e5372a2fbddso392562276.3
        for <git@vger.kernel.org>; Wed, 22 Jan 2025 14:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1737583722; x=1738188522; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IRRO6NcDWBClZ4DYXim7P5j2UY9/jQ7ZVKVwAyRDyME=;
        b=rFP7albmNZGO8qogxmEPaKJFw7zMU+Hd1GSNBZVgMffCnPuWIdKI9HZRafngsKbajq
         FG7z+q4cHrSctRXP552qfI0kO8b6RB2iNymPjdJC533oG5CNfP+Sf4CCbEx+AMm8uYRu
         R5BBuZ2w6/aDMkyaCJQ4PuyzS2y0cwcJPLZ+/45IKddljaJPeq4zSdMbDYE+AUPANOxe
         GR5TAIMttcnEF4TY1fM1LP5Wp29S05qfBImSgZF+fv8qwT1v1MCSk49f9rCo+/RiTuVf
         nK8kk9PRcJNlqvt9gcWsgjEU7QQFgH7ftawZsV2a4sOsL90Wq8mEtE5bvSBQRbCaoOTu
         07xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737583722; x=1738188522;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IRRO6NcDWBClZ4DYXim7P5j2UY9/jQ7ZVKVwAyRDyME=;
        b=UY3ncBZTuxibQs1+1ibF633mq3vCsxjYOcO4UzMVtkBZCIS7qTII+RlmvoiiVrDUdo
         28vU3Lv1T7g3ax2C46CmbSjmj1pmgUcrrrBUp817iqrrYflGQlROqQvhwWH+BRLGYpIo
         rs9zvnKHMzNaTnXO4naj7283goy4o5x8crbspktIZr4eChu7/sNT/hqQrXROsPsXzjL0
         /fVwbG34t2mOchwIYDpx0Xdp7jNV11BH6Lc+Mr26EfbK5bWPxRBQY9riDBhVloWdvv5M
         R6bnvapTLOndM5CHS5XwgavPRAPskYdFdvH1k/Efv7kUIPccZc2xyS/xSj0PK8haovJc
         XiyA==
X-Gm-Message-State: AOJu0YxYk4PpN6pbcVj/Tc60rT/iQQh6TnUu/2j52fa5eJ8srd3WI6S2
	OIulqV/spjEPoQ7Mi7ajZEgaW3YaSQqyTqyFni/U1nDBKc/EyHzKW9/Tdkco3Zs=
X-Gm-Gg: ASbGncsg1306SMvYCRkRK7w0WxGZ0X8m3x8pd0FBdqJx0D55kQDCLkA4/KV06DPAj1w
	fZcLChFWMaPA9lSRqXyzc1yy6Pe3Z6zae9RV3TBsDW8cqo/LhrcxrbnTBgkjHFgfaDVucSnCraa
	Kld0GRgViHvlr6i9mNXJ108yOGc0EdMCefyZVZmSZMrrDrzTjeJRM1+3hljqQvS6ME8qmWNGpJ8
	Lln4uj19JLpQarw80aGBA5ow9BGlfHG//4k6FGpSvwCvr4LO4H8vXlaTVcdO0lN68rCpoFIYf5Q
	bO9+oppuTSJ12p9wMEoKRgTvo0wBKp4SqJxTWUxY2A==
X-Google-Smtp-Source: AGHT+IH9t6GomHkJlI/754HAzOhh/DPvbK/dIt48/5wlQ0fORPj8X7keOocgU0i6Lkl4J8Tc1+/Q6Q==
X-Received: by 2002:a05:6902:841:b0:e39:95e8:31be with SMTP id 3f1490d57ef6-e57b1035d33mr17461249276.8.1737583721740;
        Wed, 22 Jan 2025 14:08:41 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e57ab313b53sm2245418276.31.2025.01.22.14.08.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 14:08:40 -0800 (PST)
Date: Wed, 22 Jan 2025 17:08:39 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Jonathan Tan via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
	peff@peff.net, ps@pks.im, johncai86@gmail.com, newren@gmail.com,
	jonathantanmy@google.com, karthik nayak <karthik.188@gmail.com>,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v3 1/8] pack-objects: create new name-hash function
 version
Message-ID: <Z5FsZ7MK6YcmeYIV@nand.local>
References: <pull.1823.v2.git.1733181682.gitgitgadget@gmail.com>
 <pull.1823.v3.git.1734715194.gitgitgadget@gmail.com>
 <68b4127580e2d475bec0d7cd0f6a9ae5e626b3c9.1734715194.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <68b4127580e2d475bec0d7cd0f6a9ae5e626b3c9.1734715194.git.gitgitgadget@gmail.com>

On Fri, Dec 20, 2024 at 05:19:47PM +0000, Jonathan Tan via GitGitGadget wrote:
> The first change is to be more careful about paths using non-ASCII
> characters. With these characters in mind, reverse the bits in the byte
> as the least-significant bits have the highest entropy and we want to
> maximize their influence. This is done with some bit manipulation that
> swaps the two halves, then the quarters within those halves, and then
> the bits within those quarters.

Makes sense, and seems quite reasonable.

> The second change is to perform hash composition operations at every
> level of the path. This is done by storing a 'base' hash value that
> contains the hash of the parent directory. When reaching a directory
> boundary, we XOR the current level's name-hash value with a downshift of
> the previous level's hash. This perturbation intends to create low-bit
> distinctions for paths with the same final 16 bytes but distinct parent
> directory structures.

Very clever, I love this idea.

Thanks,
Taylor
