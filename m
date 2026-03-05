Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C711E86E
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 22:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772750984; cv=pass; b=oLzTGM+3fPiJEP4XvWyZebpL+2v6miG79e7by4KLXL60DshGCLnLFkQ7mkIhIQb4KxTFrkvzdTh3Wj1cqwyU80N1RGdUV5DE42C8AL2tpPKkkdFkQWXEe5gi8pLAAF1WkdLFNIt8+4pwT11J9TbLxY2DJOk8pEsLZytZE3dlzxc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772750984; c=relaxed/simple;
	bh=W4ya7flV37ZKiqCSx0SXyuOAYT9Sowb0ZxzSTXRrBMc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eKGuS+zkdeXp3DKjc8WbHGkfzOuXtVlVmE4lm4FxSYWlegCh2H6BFSPVLvsSZrB3Srgelnty+4M5LTlluXCZ8DbNSpUh9fOKZ6Tmzh77N/zZINEEcHf9jHHIncmT8J0A/lv/DcZORQyW7qgEbuCoYhm9p5fQ92hXoX0ozGuRt0g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FIKw+SJF; arc=pass smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FIKw+SJF"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-507373bffd9so75140641cf.2
        for <git@vger.kernel.org>; Thu, 05 Mar 2026 14:49:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772750982; cv=none;
        d=google.com; s=arc-20240605;
        b=c22DU5dU7dOs5AcrDNfnD3pevZFcK3hhi7L8jQDuuc0wZglS9ptNSEvrKvSB4vDim+
         1XqCMfzW15vSxCz42vdjIXXmCGHVG0ZPgl53khhW2JurVMpB9bVZTqnuS9hBFrXeFKP6
         zG3qt0nEQQCQ/bsQSLPUXahp9BcCszO7v06UaB2yZ5nIhNZ3XzqC4u4qSVp2iNThKeRG
         pm/cQTcwwtf8pBt8FVEgFS1elwJQTiCJ90PEFl5S5K3w/jwhXbxF6A898umH6RldubC0
         7LAMXNPoF3xHq+uqn9fKgSBAZL5gk77GS9o98iGR+PhZFGIQR/ZCtqGJKa1d4VNrn/ZQ
         s8Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=W4ya7flV37ZKiqCSx0SXyuOAYT9Sowb0ZxzSTXRrBMc=;
        fh=PabIZDesja4kX5BbQRWr9Otn87xEbPZ2gK7uz53JPxU=;
        b=MSVwkzvjFNy8afk2OfFq2H76k2Xi0SKE9gR7/WKhlX66e2JgHg2z4Qbkv/hkjmCB0+
         5su4Fd1HmYCOljVDlYFtctpBDKs8heewJzzIsSOYTNfXRUpGFF3t+xyV+RYAREK3XEaZ
         6wZxYUkrbc/0Odm7BJiD6tcnaUFAI11+oV2iMlt83dcQXQ2LRDHCKBXtg/Wt757cjfVk
         kO4Yr8C+bnBGaCsp/9kkSC0TC10Fe2E2tCYd2PYqatMumx6nOqFmZjZjbROfeKMS3I/6
         IZuWkTHdNSqufMJzH4oJcJZ7K3BEJcEaAHtfMVYI5mgOKdm5T7RcAfjaaQXdFLs/bDAu
         44aw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772750982; x=1773355782; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=W4ya7flV37ZKiqCSx0SXyuOAYT9Sowb0ZxzSTXRrBMc=;
        b=FIKw+SJFWUNKN2iiZWbFb+kSnPyk1fb6Q+JTXgtMY+sI9rtFKXZoITsm+jvIu6tmhV
         9zpXFAFB+UkKvzK1dUX3M3mYnj3cM6HJunf9xT1zRbUYhd+vPxEeEmWvLWUPyZZRgjZo
         SAtjYvbmo+Vq6VuE2wCD0A1PAikfJIvGcN2lljRMbqziY+Usj61PYYPBdM8St3m/xTqs
         BpHN+ElgPPrGtra4DIlNsFnYFZjYY4WdDa7+15FhmDmETzR8Gs07rY4l3v6BoxtNpdVz
         zi+0itxxzOAP6C4jC8BFjzPVSId3MqzWyLIHCKPq6CvMSfyFhaPOjv20kALk8dpYFWFr
         +z+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772750982; x=1773355782;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W4ya7flV37ZKiqCSx0SXyuOAYT9Sowb0ZxzSTXRrBMc=;
        b=UoNGYZe0wvl+9jDfLmqe/ZU0XpipndGL8HbFfhq8rkYh+rmvMPmb57DafDDbBMLF9k
         y1fqZMmE7SqCPgYtzqoptBHDOp+88qxiJri02AVPTe2sUMELF9U5S6DBOz/J4/XchuND
         tfOfvGYoxErzqQlI/NqqeInRAzKHalJqkYSMNXEyNd1tOogiyAjv5sGM/V4yI6QVO0hD
         2D5veIdPmqpd1dan6sZ1e9EltCLCk9cddmXjEzzjL2uXoSnYgSYvvriGsSuPEDkYuYup
         1Jw4gIdOIzTbdFYDxpNwwAvXzQ2qP8SRGk8nlKhb4OsLeY/OJhkAjb6mK0chbh8J+2Tc
         9aSg==
X-Forwarded-Encrypted: i=1; AJvYcCU4F8z1u/Sgddoy+NFkNBP6g+QJkSGwwVyAX58guOPS9EKD9+PSz8o2mRyEIoF8DFhnTgY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0FbyAWQxXBPSU4V5Pn7yo72sXB//1nsTXbBw1nTLrGX4i+Y7s
	XoJYY37l4AutsEz+qPINDMSXRqLLAQz2H0HqljwKi+Tap19rkKysrnYLesmvbULgdt2FbRsNLlq
	iaWG0csMSi55c4tZnIWa0d/WP/MqjNg==
X-Gm-Gg: ATEYQzwSm/OM6pRWklnfz+xcH2yo1OhNxoZYvPu9PBXmUqKdMOYUf+ZtlhXmyWqhB2R
	0j6G3LeDft3Urui6Wuo7OwgF1hN64s1uw2gCDM4dI3mapN1w93iNZqJkIU+S5uPRZ60WpA2usbG
	PgcrZGLYTa9dq6p1T2f4EqrYvEP9Qs311rYN6nnIxHfp/OxbPUkTDI3843gmSLpRbY4aOiNxD1t
	z5kAdo4Rsl/EWWOOPZZM/j/wt5OVbz+ESYuwIHBu0IYTVZCaIfUqJ1wecH/GtBf+QocQjkEQBt7
	fmUqq4JFKFURKFxI9bbvfV6ms+GhfD46SohZ
X-Received: by 2002:a05:622a:1388:b0:501:3d11:18cb with SMTP id
 d75a77b69052e-508f4979e01mr880541cf.73.1772750982310; Thu, 05 Mar 2026
 14:49:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPig+cTHyB2sbBOELPb2=B5sU69OzSPU0JVn0p=2qMp=0=8vEg@mail.gmail.com>
 <20260305090602.22436-1-francescopaparatto@gmail.com> <xmqq5x7a3x9w.fsf@gitster.g>
 <CAPig+cTsYWVg0nrU7kMakOKQaqFSo=i_nZ=_YuCJK_hq5gdZPQ@mail.gmail.com>
In-Reply-To: <CAPig+cTsYWVg0nrU7kMakOKQaqFSo=i_nZ=_YuCJK_hq5gdZPQ@mail.gmail.com>
From: Francesco Paparatto <francescopaparatto@gmail.com>
Date: Thu, 5 Mar 2026 23:49:31 +0100
X-Gm-Features: AaiRm53UbD4lK3xWpTX39n_kndKwgj0umvrQufITIdqicEbIH553-rm_8RxSSF8
Message-ID: <CAEaT9__LELMsCVZoY57+JZ8S0AtcE4n=K2W-rqjJhz2UDPiUBA@mail.gmail.com>
Subject: Re: [PATCH v2] t3310: avoid hiding failures from rev-parse in command substitutions
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Eric Sunshine <sunshine@sunshineco.com> writes:

> What Junio probably means is that you appear to have based v2 atop v1,
> but instead you should squash v1 and v2 into a single patch, and send
> that as v3 so that when the patch is finally accepted into his tree,
> it will appear to have been perfect from the start (because v1 and v2
> will only exist in the mailing list archive, not in the Git project
> history).

Sorry about that, and thanks for the clarification.

I've squashed the changes and rerolled the patch based on your
suggestions. I've just sent v3 to the list.

Thanks,
Francesco
