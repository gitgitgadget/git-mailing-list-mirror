Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793204178;
	b=BPFfRiIBXb08pI36THB7yetctuU4z+PXAkj3EU4RvZKQ6J16qdEocHsbwUMX/Z32+aD3
	 FK1zzjG9QY1Crf4CVzUYaA8LRtAjm/XY9wIAnfafiHDvoOxcGFPXDwJ7N5pj5oPKas+4J
	 +TAXHXvAQw9s8hvBrn7UV9kLMHDYWEyZZqmY0RPriU/MYIC3cVIeTonhBpv5snD5aFIdn
	 iZmfm7UoLJxJa7l1GiW/wuCiECJfDmSw+6/LzWrdHQJRnaZ4zi6vN6QD9tA14v9TKQAQa
	 GSoQAs8RxyKGIdtWFsNSIQ+8GaXTGd32qlFc58F+8eW8aO6sApNElh4V0KsnGdEluQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793204178;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:From:Reply-To:Subject:To:Cc:
	 References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=RioOArtKI7vJ+UmgQunZdPSZkNOzFs6a0i1nxtvYNGU=;
	b=V18CmKN2u9hno3Wz5AcF0i9QaN6ResF4JXJFJNSNfvOEgtf1ils/lAaDixGz8IFTAzwK
	 mBWtaH9ko6ddz+xODLyJeU/fad3P7ogfz2M56/OCSrX3jhaLL4AthAZIONsRohpXwnvMB
	 ZAYUoraaaybQ/k2kp2xqjLoP/hpcZ4Uhg0Y6aM/zdOYac9Es+jcbcw1V+JwITrFAW5EXE
	 3X6tlzjrJFtSB3YLeKZ0zmjiiDnwEByjHZUeVFeQ42Btcodx2uisiS5CUWUqE2kFxQJH4
	 bUVgbzAeryuIACw1h0HK3j6ATB9aDJpCxspdaw3+iC6QsxT1EIgJXarF51MHrUlCOKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SOXcZ2vY;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70745606A31A
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 16:16:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70745606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SOXcZ2vY
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a2084d62cdso10264675e9.1
        for <git@vger.kernel.org>; Wed, 28 Oct 2026 09:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793204177; x=1793808977; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RioOArtKI7vJ+UmgQunZdPSZkNOzFs6a0i1nxtvYNGU=;
        b=SOXcZ2vYos5w3JJ/++gHeZTPnQAn/V0maPwC0A/TlEpqoyVty32fuDauE1H+3s+Ubx
         cNDVmnfZaFSCUy8jjF630e8KJGZm+jYPzzYIRgx2lXaB+T5Lg8xul00sydoBHmtWdaIh
         jiFSplHhsozfeE79JVCnAZYNWNH8KyuaTbx+cr/LegOF11ZjblbEg+n1beL66vp7ulhd
         KOpIvmRFbad5+62sykhiL6EVDWAblnethvEDRaA3ILCQYZ5L1UgwnbZnXi8vg1mmCmO6
         5p7QVJdxOlXYMjOlftKzb17ENKl+RBUJsyS9xfE9aqZk2jCoHKNIGTK6oH/iYm7q55tJ
         sbyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793204177; x=1793808977;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RioOArtKI7vJ+UmgQunZdPSZkNOzFs6a0i1nxtvYNGU=;
        b=MX+g5VcI30nBndr6nymRcCgOKe+oErM3Z+xHHPSFuQLlU0cKGjVLPxUgsMnvHYVkiV
         Op8ninaHmEi/lxJl8hTjg3EnIjARq7M9EuTqjGhtvTGRTrPg7kmP5TW+EY+unhMA+w7Z
         wXJieev0AvpIi0S20GyJitzL+9qzkxZ4DNJor69rLb6b3BuH3iEAECKVqDkkly+FxS5B
         cT+1Y73nem/69XThi8SS3q/0pOcqk2dYTYkJkLN84cwGozn/j47dglRhxUuDI5RN6cIo
         c8u0HP7un4qB97SMY7F6hyx0VE3vm+VKlNsWg68KRja0VLJkYc8BcFO7/NEBfLB8fjqd
         Q24A==
X-Forwarded-Encrypted: i=1; AKwUvBys/lWHKpJT2QlEZR2tCMyrshVOjF7eSbM9OK8nXBrvKhZs2mCvwWenQPsiNi1drsxXGI4=@vger.kernel.org
X-Gm-Message-State: AFq9FYI+P+dG3oxyb80GHay2mJdPGxd7c4bfMCT108UOzD2DVO759oMi
	i8r2/xjL4NvO0cZCweUDOYYolfq8JYdkAHBSS8HX5WnAqDzaE6ZFys7M
X-Gm-Gg: AYBFou0KlgGZ7S4lFGJv7hMQXCL30X/c25djN/cZ1oN7OfAbfDEIQhx0JX/+XOqx0sm
	egpX3sFFvkhnb6s3D4MCMn7WtDTiYuWdGsrXNoBUnS9/RNsYgGgj1Q9oZorFJQXSQNyVVnfr9ym
	go6noDtQjfg7Khyuh6fKC1IBTwvbHlj+0b6Wb1tq6J1+evZ/9xEamOW8qOfTWUqqpGsV0IsDXja
	NU3//fOUOJqX5ysP8w9+A1SmdF4BinAHufNVcbgeVta5/WPSPnrw/EoYPMD+CKFHvO/t/2rLdEJ
	pFO78LGTyO3Z9P1sp+pDDxZFmqZtNGrsO4pp4/hr4tSF69EdmPAPDXWFDB5YNqmevYeFa8TiujQ
	RCX/VMU8MAGZkpwWbjktEVfmgRc20IoZEk0OcNSz0KiJZg/87V+FCWNxa/2g5mv1IICt4+nSOT+
	6+fWTNAXG1Y/YMR6ys8z1du4lUlemBoFV+qr1bOmpkoZREvKSzw0xVf9K2Lo9P5mPy59WA6orTP
	EJlBYugwth5xemQyBKmBPha6LbHDkjhUnU/zwp5vPdtP/9tdkBmEhGVlyGWYk3vMIrdUvkTHIvc
	A0913oQiF2Wk6G8fmRGw/mbK2U5lPsCMSW+YdLzMxKbodLTZ7d7dRVS3AzdSecQJhd4D4FWZnO/
	iLlqb2/s=
X-Received: by 2002:a05:600c:3541:b0:4a1:f68a:9736 with SMTP id 5b1f17b1804b1-4a9672014d4mr66711815e9.26.1793204176634;
        Wed, 28 Oct 2026 09:16:16 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa813d2950sm2012745e9.8.2026.10.28.09.16.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2026 09:16:15 -0700 (PDT)
Message-ID: <241e7bbc-7144-4ebf-af76-84a06a982574@gmail.com>
Date: Wed, 28 Oct 2026 16:16:13 +0000
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v10 1/5] fetch: add remote.<name>.refmap
To: Junio C Hamano <gitster@pobox.com>
Cc: Harald Nordgren <haraldnordgren@gmail.com>,
 "D. Ben Knoble" <ben.knoble@gmail.com>,
 Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
 <pull.2412.v10.git.git.1792503778.gitgitgadget@gmail.com>
 <ba7f1354cd5492ef964ad4d1d398b5ecfc4e0086.1792503778.git.gitgitgadget@gmail.com>
 <CALnO6CAhUNRMf=KZmY6YbC-5g3h8DE6U40HehGwbcRTPhDasrg@mail.gmail.com>
 <CAHwyqnXWxiF6NLh3e4yGq6_y+=A+-_PwKF7D9DJJDxbk_0vF-g@mail.gmail.com>
 <CALnO6CBAEB8=FfZfde0OWvfLJikVkXQ8itP9wZpGHxfxK+y_LQ@mail.gmail.com>
 <xmqq33ttxw9h.fsf@gitster.g>
 <CAHwyqnW=W=XnRs210h1VxA5KWxdObwihCty6Gthiwh6+hDkD8w@mail.gmail.com>
 <xmqqcxswtqd0.fsf@gitster.g> <7438f8e3-4969-49a9-a0b0-41520ee35aa3@gmail.com>
 <xmqqbj8fm54y.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqbj8fm54y.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27/10/2026 17:21, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
>>
>> Doesn't that cause older versions of git to try and update the local
>> branch when fetching, or is it only when pushing that we'll fill in the
>> right hand side of the refspec with a copy of the left hand side?
> 
> I meant in the above example that remote.cabal.fetch should be used
> as if these three refnames are written on the fetch command line
> when nothing is given from the command line.  Now, <refspec> that
> does not have :dst side for fetch stores the result nowhere but
> FETCH_HEAD, so without remote.cabal.refmap (i.e., older versions of
> git), you will get them in FETCH_HEAD, so your "git pull" will still
> work to create an octopus merge ;-)

Thanks for clarifying that

> I was hoping that with refmap, the users can tell the system where
> to store them.  As specifying a shorthand also works,
> 
>             [remote "cabal"]
>                     fetch = master
>                     fetch = next
>                     fetch = seen
>                     refmap = +refs/heads/*:refs/remotes/cabal/*
> 
> would be an easy layout to allow adding different branches than
> having to say
> 
>             [remote "cabal"]
>                     fetch = +refs/heads/master:refs/remotes/cabal/master
>                     fetch = +refs/heads/next:refs/remotes/cabal/next
>                     fetch = +refs/heads/seen:refs/remotes/cabal/seen
That makes sense. What should we do if "remote.cabal.refmap" exists and 
"remote.cabal.fetch" contains a colon? We could just ignore that entry 
but it might be better to error out.

Thanks

Phillip
