Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3631CBE8F
	for <git@vger.kernel.org>; Mon, 14 Oct 2024 23:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728948224; cv=none; b=uHgT7k4Whe4IbJyYtqiPAsCP+9St8FqbSsfIEE1NSzE7wd6DG0haKm+TGsdhX22lJ+J46LeCEPvNJxbB1NkGxwmwJS7+tGWiINswml4uDli7qz3NKSeI9x7CRZowMTUxs6fdSD4cZKXTownyU6pdIiDyxBhce+VLtytNrniwuXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728948224; c=relaxed/simple;
	bh=9mI1ssJLkbY6kEiv28kU4AARU2pAdVPUUPGV7pp1yqU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MxiQLB4//InVr7LTqe0h8xt7EjvedUX16Wwfx0sTq54HTC+uthOfXUF8tbL+6K4OuiIPpjGIaecUh8c5EfcsOhXM6BKg+E/SnBuwR28oRbJu8q4WGEwvcEWnNv4wsusGaYpPx1QfWfcGFegr9djH8kmhp4rFzx1dAhg8cv2RQU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6cbdd42bdf3so6478596d6.1
        for <git@vger.kernel.org>; Mon, 14 Oct 2024 16:23:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728948221; x=1729553021;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9mI1ssJLkbY6kEiv28kU4AARU2pAdVPUUPGV7pp1yqU=;
        b=kOdH9HckE9Vo5N4cCquKcmChsPbrY6NHEOJH/KA4+K4Oun4zwRkYj7RD3/j0LQd2Bm
         eJSCL8zazOCNPmB9fjxZ/pNw7ZeV63/cXEJrwXdnmm95QXWelqZCEFJcd18v9Wjw6Cex
         KQGZzLAKUAhnAPr9ekeOM/3nZthQW8iy3IObv7nUUjWOpWRpGt3ELDP3MU+wqD+TLj7A
         o+YzfWh3LuifZDuihD1QtI7xhybRa89fX7lEbALeVwyuPWd0CY93zgYFnb3yyXCRsKbd
         3n9VkFhw/oAIEoB9+DrVNTE0QUMLFYqd97n6H+yk+1wLJE6MwihHTlkUsH5tNS/wwwbf
         8+UQ==
X-Gm-Message-State: AOJu0YyZrOcUlKult0l7sedqeqQisLy5ZdlHESBNFbSMpD5Lkk4AeXjy
	AESeanY1LzUy0AL6WxUSw/9VlCVrYyJHu7HMiPpiZHO9Hy1HjZYSZyP0Go6Bx59Hb303aZGv9zy
	i0tC8x4CzJrGo5XYvS7SMjVoYPj02tA==
X-Google-Smtp-Source: AGHT+IEPmRqjQaHE6LkiwYP2Zz5xTiUr9WX4mTMyDrzZdKYQ2nc7XTjF8jC6VQaVWF6nA8yfCb5j/G6RnnPP1nDMf5M=
X-Received: by 2002:a05:6214:5292:b0:6cb:e981:d7d0 with SMTP id
 6a1803df08f44-6cbefff7cffmr90362166d6.7.1728948220787; Mon, 14 Oct 2024
 16:23:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1728906490.git.ps@pks.im> <d082cd92af36610af24985ef2279c4176b1f182f.1728906490.git.ps@pks.im>
In-Reply-To: <d082cd92af36610af24985ef2279c4176b1f182f.1728906490.git.ps@pks.im>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Mon, 14 Oct 2024 19:23:29 -0400
Message-ID: <CAPig+cS4X=sX84XOoNiw7jVO5Gaze-155Gcd6sO-UzyFXZ1Z3A@mail.gmail.com>
Subject: Re: [PATCH 05/10] t1401: make invocation of tar(1) work with
 Win32-provided one
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 8:21=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
> Windows nowadays provides a tar(1) binary in "C:\Windows\system32". This
> version of tar(1) doesn't seem to handle the case where directory paths
> end with a trailing forward slash. And as we do that in t1401 the result
> is that the test fails.
>
> Drop the trailing slash. Other tests that use tar(1) work alright, this
> is the only instance where it has been failing.
> ---

Missing sign-off.
