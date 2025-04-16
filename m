Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D751FBEA9
	for <git@vger.kernel.org>; Wed, 16 Apr 2025 16:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744821843; cv=none; b=Xfg+Jj8l4594bwv3SZ7WDAyKGD1Us+smXYarlEjH0OOwluLgx3bL27tuWUlB7MuDrvTM5ojdkwRsuebJPqW7aETcvmwjqmRnhazpwFXs3bQuR//bPbpvGgtn/mSACQHd4ezYuFqUxu09K8VQDMbWOVZ7NGsMA3C/YhdeBuoFw8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744821843; c=relaxed/simple;
	bh=Iz++j8voeUXA5Dss7LlkCjl8jU8ow5+S00sMgTmiZR8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HBXo244sHlw1Gk00lllN+PwZspHLpSjFYRYbXcuCV/6N+9DiPlQx2KuSMc9liCdkQZeWMTs+x/EwFd8gsMsQoF6oOeLLoQFfXPkNqBDXgs0UjhHx8rLICAJvZjAR0H8bFpIXEBWBHaagUXig/9fQ+MSBh0PA8SjWhRVnpP4HiuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TRw/XhXq; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TRw/XhXq"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4774193fdffso98235281cf.1
        for <git@vger.kernel.org>; Wed, 16 Apr 2025 09:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744821841; x=1745426641; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Iz++j8voeUXA5Dss7LlkCjl8jU8ow5+S00sMgTmiZR8=;
        b=TRw/XhXq+yOk9RIhw4MMlIU57FAUvB22XlPz0/YK9xqgvx3jZpV/bTpHAE5X7923EZ
         o/2Dxq01KVh+8PsqkF0iPoaKjgOo107+7D2n9uT8VZr7SHMeqjKI/J37JvjljMT4eqWu
         1sPkvc1aQ1pF0AMO4xbOYiLYViGAHeexJJiT0o54q9EXO5gOG9HHaqGPkZAVcacWKEfc
         icBttMHWGFZXMbIPsDfmfTj/keJQZcZ/DduMCVHuj/XWUml9pvyiLbpRINXcbCFucSTl
         X3pp3pazI6UBZx4IeHNKa7BV9K9kRT5PbXTdJFjhvcwBbesp648I8GaQNmF9It7hJRpN
         v7aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744821841; x=1745426641;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Iz++j8voeUXA5Dss7LlkCjl8jU8ow5+S00sMgTmiZR8=;
        b=ljnstStjbI6aQLul3Uu0VcWIvhPfKxkQ7bM4gB/QopGjEXYpfkf0+EAM42w6qq9kD8
         5Qtlc+BxF6h1Z0k/kHfYSmJBu67kDnsLS79WJcSimwwFSYVJATCeJG0YEGque72Oiogx
         z2swn2SkK5Cp+fa9iPpTMnvbIJXWllEDxuhsDqXGTb4cfwPoYBGYmr9SNNw63JPLEexI
         ajgZqu4F7RRPxQZC3o80tCNd7FRcyII2cc2omckd2ojU8xrrZcRL3SrpvAkCaazxOVCH
         tlHaqxhFaJvD4VFweH5Z6Fx1XttqptdnIlxwjw8FM+rZorthfSnC1k7f27BDM2yzBGWd
         YWBA==
X-Forwarded-Encrypted: i=1; AJvYcCUmh1ddEMCiMjQD3dKv3CHhBGlDGYLUzV/FKsPMkSwN+YXfIV4gqD1v84WeeDl8ed96srA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw735sbMAa8Ie4tSJAE5H7g8L6J/qz6s5amMlPktNYZeR76hU8r
	uBj+peZrKNtOCB8wnhuH0QHnBmkM8H/YmOuPH3IOoTJiZDNfJG4WXvGYoGak/3p6zMgyAKq+gFB
	ZFAb5VQ9SoZU4IOtqRfJfGt/h33Q=
X-Gm-Gg: ASbGncvtREM5cgW98/+QIzuGr+5+HiCib/kUov/JBB3ABd8GIb2hc1erhlyxJARjMIx
	p83dRON3PddQGE+f7DQuPjuNe8MiPu5MxjV24dEMcjElpVAXM4p4YZnNPQgEAAMBniB03WmAVSy
	YfSqV+3Wso6C8bSYhrhrN1QCp26ZSA2KwmFXOKKGdU1jw98ILyhFqsNrQ=
X-Google-Smtp-Source: AGHT+IFi/4R7Apv67Hzf8dZ1Iub2w6tQlqTO8P6fdhQjc+rEy3ZvvLxGrw7Y8yuCzejGTHVRcUbn6z/rt+I7/F6lKpw=
X-Received: by 2002:ac8:5e4e:0:b0:478:de12:14f6 with SMTP id
 d75a77b69052e-47ad80c45e4mr35291071cf.31.1744821840796; Wed, 16 Apr 2025
 09:44:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250412094607.236382-2-jayatheerthkulkarni2005@gmail.com>
 <20250412174051.780148-1-jayatheerthkulkarni2005@gmail.com>
 <Z_7ekhsBzXK6LKuV@tapette.crustytoothpaste.net> <CA+rGoLfAidyuomeNym5WX8Bo7-jPcfHx35wDeZ7W2aorAN-B7g@mail.gmail.com>
 <xmqqa58gjlnk.fsf@gitster.g> <CA+rGoLesZ3nSjruJ8_XRWVsFpMu8mo_4cCOdB-GFHU_qXkXDCQ@mail.gmail.com>
 <717161C8-497D-42C7-8C10-AC112238EEFD@gmail.com> <CA+rGoLeUojJ4BAUDy2kBsMjRCEFTP=so7sDgy1BX6d7RoBusEA@mail.gmail.com>
In-Reply-To: <CA+rGoLeUojJ4BAUDy2kBsMjRCEFTP=so7sDgy1BX6d7RoBusEA@mail.gmail.com>
From: JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com>
Date: Wed, 16 Apr 2025 22:13:49 +0530
X-Gm-Features: ATxdqUGUbK1oICNIABpjenDmew-Zkh5VAlZLvlZm8Z8CA5NmDjkLbFMwWRyvlp8
Message-ID: <CA+rGoLfxtVL7ang320YZ3nN++GCCrPW8E4pTHbWyMu2EEaWz3g@mail.gmail.com>
Subject: Re: [PATCH] t3706: Add test for wildcard vs literal pathspec
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org, 
	peff@peff.net, piotrsiupa@gmail.com
Content-Type: text/plain; charset="UTF-8"

> Something like this
> So I think the argument values are making the difference but I'm still unsure.

I think from ls-files it's how &pathspec values are received,
it contains has_wildcard kinds of variables in the structure

-Jayatheerth
