Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3D143F085
	for <git@vger.kernel.org>; Thu, 16 Jul 2026 01:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784166761; cv=pass; b=rQUHV1gO5/8iUU82SpVbaOYxsEBNsFhjBlxU6ZwRigBEpc2/0wR9TVF0wy3abhxiG9IDfTbwQr6OueztVnVToBwPv0pr66dmxSBaXFVsKJnn/y11VlBDdKT8+KHQK4lyHdjo9NBffgVkppsb61T7FFD1y3abiXeNZMCtwiS1OPU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784166761; c=relaxed/simple;
	bh=ont3tOal9PNJpe/ZKZy1geRqr6p2iMeGRmSSvf2Kqmk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=mZzCGhys64o/fHhFleDf/jof76IKUacL5pCays7uVlvOvjOal1Y80lCMt384T5WsJ5nTlVm2LTuh8PfQ7NV2rwXSWvnNR09Dkn4VlSaIIZa8zKVPA7ffnJlPJfAwFTyAVZJthLKtyw/MZkZjnAIVj/M8JIYfTkd4Dt9TD22veKY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ktn/VKWH; arc=pass smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ktn/VKWH"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-80cebd41372so59368007b3.3
        for <git@vger.kernel.org>; Wed, 15 Jul 2026 18:52:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784166758; cv=none;
        d=google.com; s=arc-20260327;
        b=lDaLdxGZ2NfNDDmeJytYOW1qkbzXw8FyVx3JlhVk0Zfd/ecmzIykT3eePqqI/tZi6V
         UtcHLg/FzsjFTfYUjijYX3Rw1LHVKOToKQXLR5bgRL34z4D/wlq0CiB6IuPg7DpQLm31
         ALrrPEHN7uB/GQtBrSLK4B9itov29B/h5qrv6hPtbxrsiK1+HRpzyzRYO25BqausqhIG
         7XKgkj+Ks3IucMT0z0jSqbcP+EbxRZvt4j2VKhlB3MjJ2GyuUd28l1w+Yt0/NZSdt+fs
         64jSm9uQTgfXHVmq0pkv/SOHb/QN4H0J5LVOMY+KPEjK2prjvtAo4PEXBgbEG2UDRjzN
         a3WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :dkim-signature;
        bh=ont3tOal9PNJpe/ZKZy1geRqr6p2iMeGRmSSvf2Kqmk=;
        fh=DJHZ7itWveYVdfezJsKgr6XLEjDMbfeXEew73fqN9oM=;
        b=l471qPlAGn1gXpxhpcF3ltF1/uLL1HbXsaL6Ui0dHl/kxx3w7A1S3wS7GREmme5dbN
         GM/xOeMaGTJimHrh64BgXElx/rSJrjr0lgCR0hiapNZc1dd8RV7lX06DvPyBzRx2bEVP
         smb3R8NLt4fHDQyTSrNBFcxgZo8pBk58eRfitn+ciJipCdC2JNBh4OZgozuLH3R9Ib/P
         ZiCJX0Cm58k4lI+GXJgsJ5vWQ2Os7kbiMxLBoYPaqawO87ct9JF6KFj73UgJBjMYu3Ad
         IGJV8IVTBa75KzNutlLkCoOEyQ0s317Xag4nxaSo86jaYCkobbtrRliRntpFgfzCaqRp
         eAVg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784166758; x=1784771558; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ont3tOal9PNJpe/ZKZy1geRqr6p2iMeGRmSSvf2Kqmk=;
        b=Ktn/VKWHP1hdhijytCzn8e83XfiVy9ntTD2Ae+6nFIH+nwgUHRdtLbTpQleVvwghw2
         z/SLfqe2q3MJ7iRcDPQR0nb2cMi7wYW1+JmalLbRXL6Ubedc+PCysFMt2NMvwmzri+D3
         d5mrHztG94FtOxdzHBdzdBdaTW6a85SXfsxA2siFClmHRskcGqlolTTm/oBKO9dJF4U7
         GskmIxEmfSu369873Dbm5TtKxzzJCkWmI8A4gPvElEhqBv1CKAqzvzMzszZJQhfbPS6K
         leMLzbeMoax5E8fs4IbQNnpAcNcP8anutCk+w9ZdkytyVpccJYeAPmRonMxmk70O6usg
         B6yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784166758; x=1784771558;
        h=content-type:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ont3tOal9PNJpe/ZKZy1geRqr6p2iMeGRmSSvf2Kqmk=;
        b=tXp5nYVZeLbKNlb5Fb2fWswxTVtvqlLEC3NBzTVo5ovHK7LEaNzA86pgADLITZpetD
         MnCunBwi+9cxIGbq1Br8rv3nnFD9mX4aWRsg73dedu27JHPYSrR6BrFXVnj1muXEOAN8
         dpT/qiHOiZSCTdUiVK+BRpQE28tqxImYyzixe+AoUrsbOrpag3FeryQkrpRv7+YzZ04O
         U5rtwg8JeIgJ23wsLw25bSPRSvViRs4VF0KkUF2nc2pwuxEUYCNVj0/22mPAFxpanjPo
         q/CGx6ZaMVsKATn14gMd9vGfnQTgVL0Dvu3SkD7McYlYeLAQvJbynNMuf/lXZZ8hCb6l
         jOLw==
X-Gm-Message-State: AOJu0YxYHAZj8grvdTjNLAnjeHLsqyZFIeHKDQhliBDVgIwVO3zhk37l
	SFDIsMWAxv2HQ2tgd4Ioln5WET6JCXbb2DujgTtjiuXhGrUuHQASgLKdye+p28Z9nuikbR7Y/vZ
	IrbBXr0WuHsa14ffheS/aHXpyyHD5bTokVFN2
X-Gm-Gg: AfdE7ckfxBjiocbX7Rvux13okeJJrL29dJg+xtRKJjQ4a3DqgIo8wfVkXQa8mKKm00I
	+EV1zPb4SpDLiBz+smrLq03lKU/y99+Uoq0Ks+AAzKX0AUn2QTiSHWyn/LzRTKy42UqbU+0V59H
	lxRXdLIodkIQAbN1A3VQEJkWlIwcX4GYjF3Ud3TAXDBXOgG7BSakY+BzKIJSmlDa9aPgAa8zpMR
	V8FLugFWa+8UjwEDaGNRxdLAqsCnbyXNu/ILbnQqc1cKgvvWGQtKC4QU0bziTyjWLSqYJu3sjTN
	cXmPNeslJh5+HLg3L05M1c2Xk6ex/Th1EqSwkYMvH9vZtskBQG9s6v0qOfWKkMCZJWsKAKnRE1E
	XavB572oHb7wx0Lg=
X-Received: by 2002:a05:690c:6a87:b0:81e:7a60:68c5 with SMTP id
 00721157ae682-81ecfa39c25mr41648497b3.46.1784166758631; Wed, 15 Jul 2026
 18:52:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+rGoLee083Whzi3b9CP3Hxrq_cz58enN67ZQq5r0koczKeU1A@mail.gmail.com>
 <CA+rGoLeNzxaTrq50jE=at=0ecnZ5Diy+Q-0McG-R+XFTQ7oMow@mail.gmail.com>
 <CA+rGoLe+n314hrbKBSU61Hn=uVQN+OqOF5AVt2gPOityUUL_AA@mail.gmail.com>
 <CA+rGoLdOjybHB7w1Wd0Or0wJUKjTOev7f1pZbj7dhAZRbs-2eg@mail.gmail.com> <CA+rGoLePg9MHE+OcVtKo5ho8ziNp9NBWAuWc4ZEZ2kevZf5WKg@mail.gmail.com>
In-Reply-To: <CA+rGoLePg9MHE+OcVtKo5ho8ziNp9NBWAuWc4ZEZ2kevZf5WKg@mail.gmail.com>
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Date: Thu, 16 Jul 2026 07:22:24 +0530
X-Gm-Features: AUfX_myyPhwXAgWni8vdesNRpjHgFubomw5g4-gC1rwHh8FbSX5OWaBzj1WZRFg
Message-ID: <CA+rGoLdMnLfVF91hP3c5bdLnAv9ViW2r9pR0yejK2kQNNWSBUw@mail.gmail.com>
Subject: [GSoC] [Blog] week 6 & 7: Improving the new git repo command
To: GIT Mailing-list <git@vger.kernel.org>, Justin Tobler <jltobler@gmail.com>, 
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi!

My Week 6 and Week 7 GSoC blogs are live!
https://jayatheerth.com/#/blogs/gsoc/week-6

https://jayatheerth.com/#/blogs/gsoc/week-7

Feel free to give it a read and share any feedback ; )

Regards,
- K Jayatheerth
