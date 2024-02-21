Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA73D56456
	for <git@vger.kernel.org>; Wed, 21 Feb 2024 23:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708557262; cv=none; b=d08np4CSIyQgvZcEAvl7+9K1bQy7o1KFdNbVtVLfwiLrakUIAWCd4Ra4uaqwQtGNuBbEYI8THAY1qZR/HZFvErbOnHeakdZOOB3gG7U3l4gXJ7dWQyQ8OAT7pB9iwC2XoktpH2qSodon9ds8dJzVD/N4VRGjDPEDYz4CL3HRxl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708557262; c=relaxed/simple;
	bh=kn9SYdIskuxwD10JOg38kwfN5BC8oYcmzzfhVUi/7aA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LWrjyfDuk0DdClE9E/qve+8ezYF7cG7lOKSvhSNJS3nb+cdl3VMXLdxKX9dWWtU4UxRWGCDyHBG73up0+dUllCigtyZaoLNfgzNpLSnOUDUGKmS1aAq9fVrmQd5hVF667Yw4ufLwj6yGLPs8HF41zX7KDsKs8IcTC5Nr+29oAEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ETUiYwQQ; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ETUiYwQQ"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-68f41af71ebso49962546d6.1
        for <git@vger.kernel.org>; Wed, 21 Feb 2024 15:14:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708557259; x=1709162059; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3tbqhfa9WfXY9+VZqSt0EPfZsXogp2sRm6eYbK2+7JI=;
        b=ETUiYwQQXxxI6TlSgwO9rjR/gf9b+TllweTMp7wE9kBqKacWNWFscQiUdV31cOK8cQ
         iEWxtpg47zdh6clii6zHO/3nPBa87nqe6h/O2Jtk9aRdXg4D67I5WhhSBzc2oBZ1cLPm
         SnFFMoLzMe/lp7Gy7KajAB7v3+xtx6l8OjBiOjTg8cgiIGYS0MIIx4EvOINrUdlYqVko
         nxaHXUSRscgBh5RIf6V3dFm/fMfem4jut0p0Fg6e8ayANpE7hgbgShu0qpP7IHjayXDc
         37JxILBE+5HRipOFz5WYUxwjycQ/wYQtO3rRzP1bSA77j83t03PHLZWZ0MZPtkKcnENm
         Sj4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708557259; x=1709162059;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3tbqhfa9WfXY9+VZqSt0EPfZsXogp2sRm6eYbK2+7JI=;
        b=RCEL1MAWfjcQMH6jY4Sr9PaRh68S717vQ5UHFN2RQvlow4/GwMHu65XPd3iwSmD0YG
         Y/h8WVgNTohHO6+nqQiMiSPfndss4YnYvWm5wDe4FzidERl5vi7eAWJjsO4Bn8B+HmP4
         pracLdalPAN12ZYuU8d3T1i2bzML1QarGIgOwuQ7c62Y2N/nhGjMxBVyhTMN2sM+XYIi
         R7mQA8mfeXoKEXlV2Z1UJR7b033dXdsfdUuJPgXcIW0qIr4MnW1iZWs+z1vS3p3uQlhR
         7Y1r0awjd17Qd0ERxPDinkblRrlVKR1OjyK6d4TMCwIkpeKkU57lXxCuryCMCnculNlt
         msDQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQSvd4fyH1UsU9aFMRw3DmvUsnJwTdApWW0gMb6EXCpCi+bDhWH8ieVkbrcoW3FKeOmo/RZFhuBPp2CW+vVAXZoAVR
X-Gm-Message-State: AOJu0YyZ+1XmySwvMeGwc7myD5aWEHiDWyjmjPnyK088+bjRJU7iBTXH
	vfugULw+wIQM+64C7BCuPR+DAjfO3CwCXimIKpgzo1Fx1+mqzDZq
X-Google-Smtp-Source: AGHT+IE/ZtzTFtknbVKv2CDjTQyZd7+XQww0uXiBq2VzpWAzOujvHbZ3CwhbMUdh3CWdUWEbL+WdCw==
X-Received: by 2002:a0c:f291:0:b0:68f:405d:fbb0 with SMTP id k17-20020a0cf291000000b0068f405dfbb0mr13243305qvl.16.1708557259537;
        Wed, 21 Feb 2024 15:14:19 -0800 (PST)
Received: from [10.197.96.0] ([152.3.43.40])
        by smtp.gmail.com with ESMTPSA id oo28-20020a056214451c00b0068f5a5fae64sm4968427qvb.92.2024.02.21.15.14.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Feb 2024 15:14:19 -0800 (PST)
Message-ID: <ec72c1f0-bcac-4982-bb67-cdbc8c47eafe@gmail.com>
Date: Wed, 21 Feb 2024 18:14:18 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] builtin/stash: configs keepIndex, includeUntracked
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>, phillip.wood@dunelm.org.uk,
 git@vger.kernel.org
References: <20240218033146.372727-2-rpc01234@gmail.com>
 <99346639-5a36-4c2e-a5d7-035c3c1fda8b@gmail.com>
 <df020dcc-afe8-4dd8-b476-4ca032206214@gmail.com>
 <78a8733b-c74a-4017-8905-d29b2e05adb1@gmail.com> <xmqqjzmzqb85.fsf@gitster.g>
 <b84e77a1-93e4-4de0-a0cd-4d76a5691a9b@gmail.com> <xmqq4je1o9yu.fsf@gitster.g>
From: Ricardo C <rpc01234@gmail.com>
Autocrypt: addr=rpc01234@gmail.com; keydata=
 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
 jjbjCH/5+g==
In-Reply-To: <xmqq4je1o9yu.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/21/24 15:09, Junio C Hamano wrote:
> Ricardo C <rpc01234@gmail.com> writes:
> 
>> Permanently enabling keepIndex is mainly intended for people that like
>> to stash their unstaged changes before committing (e.g., for testing
>> them independently of other changes). The main issue with what you
>> recommend is that, if they forget to use `-k`, then the entire state
>> of the index is lost, which is especially problematic if the changes
>> were interactively staged.
> 
> Doesn't "git stash pop --index" meant to recover from such a
> mistake, though?  If you stash, because your "git commit" notices
> there is no change after you did "git stash" without "-k", your
> recovery to "pop --index" would apply the changes to the index and
> to the working tree on top of exactly the same commit, so there is
> no risk of losing any changes by doing so, right?  IOW, such a pop
> will always round-trip.

Oh, wow, I didn't realize that was a thing (I mistakenly interpreted the 
documentation to mean that it added the entire stash to the index). This does 
help a lot, thanks! I guess keepIndex is a lot less important, so this should 
mainly be about includeUntracked... but now I'm also longing for a config to 
have --index on pop/apply by default :P

Interestingly, it seems like frontend support for --index is very variable. 
VScode is probably the most popular frontend and doesn't seem to have any 
support for it, while more niche frontends like Emacs Magit and vim-fugitive 
do support it and moreover have it as the default. Maybe the real issue here 
is lack of awareness of that flag, and the solution is just to spread the word 
about it.

Thanks again,

Ricardo
