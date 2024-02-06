Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC09134CEB
	for <git@vger.kernel.org>; Tue,  6 Feb 2024 16:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707236655; cv=none; b=Z1vED5n11GcSSS3yL4/0Zm+8bBFtf/y51t1zZdC763299+rUutGERBqo3I6nifk6HmCww/Teu9KqtvD4H6vzVCQYiHJnEXoGwbcmafn9nZmgTXzn/4Bf1SNcY6hzmUgQL03o+ldZFEiMee2srjemv5CUfe4O+hqwKjA/xqPJgng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707236655; c=relaxed/simple;
	bh=hjtvoi6nEncpkFKDNE3JQ8GU4AH9FPTkcIZWxLSUVOw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=qoNiW/fUuYnwBhweduxj6CeoKSWsO9ooxEO4G0egv++uq2ZSz5qIrq/RKaWwO0YKg4M3TinWDT5lPdltr+a0vEf/MqEqTqk9AX9/s1Avzzbi1th+ass2HYTHis+ZMZ2ANaz3sTPDsehfwHPO1gTujGOL4MqpjESWHzQjXmd135o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iENd8nQI; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iENd8nQI"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5d8b276979aso915943a12.2
        for <git@vger.kernel.org>; Tue, 06 Feb 2024 08:24:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707236653; x=1707841453; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hjtvoi6nEncpkFKDNE3JQ8GU4AH9FPTkcIZWxLSUVOw=;
        b=iENd8nQICY704ocFf/vY5F5MoCEevOxqCuW8Jh+iypRDpELP1/uMmsMhu1j2CzTkxm
         RnISdag6nWI/AxyYVjm4XI39Aefq5XkdglQr58ZlFdKarIPGzbc7IITHoZl62/3+lkY/
         7nTWQC5vXRYSXBp037GAMclYWfL+CAffQrbj1bISIvxL8fy6E+YBI31P9dca3TE3Y4q8
         fFwGf9mWyRcyVpb1b86iQVlvFk5nfHy9w6N74Y/G+ihq45qIb0LndrgUyEwiODRpHVno
         5IuMDbn0srEkvNzKB2OPBRfve2JDnjVTgtMg64H+VEDK1IL80kb8fdxyT+RJ5YZF8d/d
         Un/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707236653; x=1707841453;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hjtvoi6nEncpkFKDNE3JQ8GU4AH9FPTkcIZWxLSUVOw=;
        b=MdrEdifVEOwXzpE8iSUJOQD2BJpYaUL+QR0Eq0bzRk32Y3HQwpTegqb8tWo+Bbw64z
         VasDWORb06zTFa3qEaNmQPBdjU52WwszqVldju25kC+sLVMgjmVZXCan8+LVYYji3L2p
         P9fZIE+lZsGny374EkSrqqE0rArKQp8AnT6enGejUZv0psLhsidYnvjghz4TeuGke2wl
         N41jo7wumgFKJNNMsnGGfvlQ76m+rfcBjGQO4yrHVFlB4mMq5RCXM5I5qSZTtY0iAbmZ
         C7YQn1YfVDUI+PiqDsMBmViS4nf3rwoQwYZNeXEF2BjvLGvyblQg0QfUcSv95poSoE18
         nSRw==
X-Gm-Message-State: AOJu0YwCkpegwsGP/LZfGpylOCqj+LCZaqCO4g5IKFeT8xqEhWM3Mqf9
	uss1Q1stPeALaufWkyR1QI9D7RwMFH6Bu6uiC4Q6cj16MxSD4G4Wdiu6NECYCI5BJCMHOqqS4QN
	d54WISqTqqMTCtvlA9w2VQmLfakM2B7uRWE0=
X-Google-Smtp-Source: AGHT+IFB8IkX6GQbNYq4j/+b6BSQjRtnQm6qgC/WXWSPLSvoJbpu2kfc8+uLxv6z+Ip3SirYG1Kl00hLAxMMCvcN0vA=
X-Received: by 2002:a17:90b:3591:b0:296:1ddc:d46a with SMTP id
 mm17-20020a17090b359100b002961ddcd46amr11884pjb.39.1707236652104; Tue, 06 Feb
 2024 08:24:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Sergey Kosukhin <skosukhin@gmail.com>
Date: Tue, 6 Feb 2024 17:24:01 +0100
Message-ID: <CAGMF1KiFNnr1nFBg2+mRqiurXpxOOXAcoWc0GciRKDoWzpJSkA@mail.gmail.com>
Subject: Wrong exit code on failed SSH signing
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello!

There seems to be a bug in the sign_buffer_ssh function in
gpg-interface.c: a possible exit code of ssh-keygen is 255, which is
returned as-is by sign_buffer_ssh. The problem is that, for example,
the function build_tag_object in builtin/tag.c considers only negative
values as a failure. Since 255 >= 0, the error message "unable to sign
the tag" is not emitted and git exits normally with zero exit code. It
might be enough to return -1 in sign_buffer_ssh if ret is not zero.

I am sorry if this has already been reported or taken care of. Thank you.

Best regards,
Sergey
