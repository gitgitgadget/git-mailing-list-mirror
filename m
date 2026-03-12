Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B4933A9CF
	for <git@vger.kernel.org>; Thu, 12 Mar 2026 20:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773347455; cv=none; b=JZ/orjAD77DArJOWTXxymG8Sm+VLOmS1XjhZgN6J3FAP8D10E89rMN6xK12asWgSupjZoM7tcYHSF67BPVVV3dXDfd0rhPd4rr4vPKFAOAObudwQyd1wHFNBCMg/5s9Zvhu9m64JNvgizvnD6uvxnJfBfZD8rhoHaA6VWmgV5no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773347455; c=relaxed/simple;
	bh=30oIB3z1X8E0wFMK45y4NycQMMPJNs70dS9emc7hxiI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JzLszMH5mEyITOtkOTPh1hZ2lcsk+bn+p4cas8ohul0hfrea3eYaov4qyRzznxOQkVoyRMzXvGb0w2pyDFzehV384cllmTyPbMjNpjKQHZnzJZ2E8txKeTLmdqhuy9uRqWMO9Eb8iRjzFLXsvC/yT9BGzrJ3lqLvB6ux9G1P/bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EoT4YT/I; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EoT4YT/I"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7d75ed779bfso1592296a34.2
        for <git@vger.kernel.org>; Thu, 12 Mar 2026 13:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773347453; x=1773952253; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nyQzxeupQE8uI+toSSK5Lu/pwuPjprHISRe+NnLbG+8=;
        b=EoT4YT/IrNB8XUJvNiYeV8lHN6w68imM/o3g2I2hE8FVcBnoWWvkgag0ZRX74zOKqs
         l7znPtg6HQvqYZYq/lm60P0tBUzDpLkFeRXeAgMGpoVmLIhV/thmrL9ZWZ7OYu4ogVvn
         xArv3rjNpyV+9KlS+O1NTGU0/XKiy7QUluaHPu87wSazcjORdCZiKXm/ffQyMj0OPNrJ
         ZfzyyIEHXANeaYNki778nX50VJm4V8fzckzc4xOfjV8i/w5NzYthWSe57ydKYwacVDYV
         MQqEC9FHU3NbSqEG3fGWF+E/4M/qhy6Vqqc92292hGRWgxVt+QDw6E6kLwoqLUfZXZk6
         PBag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773347453; x=1773952253;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nyQzxeupQE8uI+toSSK5Lu/pwuPjprHISRe+NnLbG+8=;
        b=SovilxrI3cIGHadeMyqCVfW1wZe+ULK9ricVz/okO+AYgXu4y636l9UUE0OxMXvLJ4
         dopAZujRFy7lgOzNHO5Lv7vgjJ+mBjntciPlTCnHfGWZSke11sk0mdwJefwdkjVfFRoU
         1+M1Opcz+8zOzu79Wjg/KwHTOSsLeceDOh8s/uaQLudpDVBF6y+x1VrtfGkAswR9MpbA
         JsvBKn0w4WNvL8WoiTYID2N2I1YYz7It2DgUha1ZBiGXotccKLaPvk45z8US43DGo0Ec
         WN3KLFbdhdjnBGlzQ81q3USdibJQGGdvYFjswiVtT6hZiuvrcgYdvjKO4gceeDJ3lPjt
         2Xqw==
X-Gm-Message-State: AOJu0YwQHfGxy2rSxJC7bI4EqBUe8vnJAAlvojR0Z5YDwu28RD0hP7GA
	eC6U33G9IlZ+rp9anhQOBU6T1qW+jm77Dlecn4OB1fITwPKOl4JjBd8DuQr1Zg==
X-Gm-Gg: ATEYQzy07oYrQ+vAzKtSC7KIFWMh6I3XnuM4OF8mL7LXPeU8lpPY4AjZlnlsXeKWJmX
	j0CvYQSC1yMR25HZdVMv+AkEgajo1rAVGTRjQaCZh5R4cWr5B62X/t6fOhOlDTvnzOfhMx6jUw9
	AmSdAydnVePlibSCA9FEdHKE6oKogYIhM4WGGgEVOR1W8moK+ZYNTSPOJT/+EVgGLWPu4v4aRkD
	wchBDeMaODKuFYnvzBTtzvn5HUruSCEnqQH4pJaW1HkpU52W2qL13DuuqYW+BCNZFJX6sMbxIm1
	fWAY6SvvhLiKy2G0tv2oesGzv8fsfQjD/bMlspPb4W2UPDEmz1HwhYMozioidup2aUvNnMtH1BY
	kFyBjMQaBcLkGiXnB8TlQtG0zEa84MimWRAMPJv/zrgXwLKQo/+QAgSnHWA+ahVk+/yTiHBT+Ex
	kTIFKCKT0ysK+mbC4D
X-Received: by 2002:a05:6830:3891:b0:7c7:6043:dd8f with SMTP id 46e09a7af769-7d78248abb8mr607207a34.15.1773347453245;
        Thu, 12 Mar 2026 13:30:53 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d76aec661csm5173948a34.26.2026.03.12.13.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 13:30:52 -0700 (PDT)
Date: Thu, 12 Mar 2026 15:30:52 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, sandals@crustytoothpaste.net, 
	christian.couder@gmail.com, ps@pks.im
Subject: Re: [PATCH v5 0/3] fast-import: add mode to re-sign invalid commit
 signatures
Message-ID: <abMiT6J7M2BK9jKi@denethor>
References: <20260311173147.2336432-1-jltobler@gmail.com>
 <20260312192228.481134-1-jltobler@gmail.com>
 <xmqqtsukdclr.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqtsukdclr.fsf@gitster.g>

On 26/03/12 01:20PM, Junio C Hamano wrote:
> Justin Tobler <jltobler@gmail.com> writes:
> 
> > Changes since V4:
> > - Instead of introducing a separate `sign_buffer_with_key()` helper,
> >   extend `sign_buffer()` to support a SIGN_BUFFER_USE_DEFAULT_KEY flag.
> > - Fixed message in die().
> 
> I left small comments on two patches, but everything looks quite
> well done to me in this iteration.

Thanks, I've amended locally and will sent another version a little bit
latter today. :)

-Justin
