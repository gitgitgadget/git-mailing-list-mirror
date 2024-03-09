Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4501F614
	for <git@vger.kernel.org>; Sat,  9 Mar 2024 17:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710006822; cv=none; b=c9WRZkGS2G6nOGguFUiCik2eBOrIIPvVbW2XVrNjxnk6QliA/AQEfBI0P4JpijJjvfEjoEbPYM9WnCzXWUoMt3avHT3yZTC6VBiOYisPev4LmzUZ1qy6fFwggh7OPeO2CoAk1TcheBSwkgzMF/xTgNb4VecdhnD+G9vmZDxj4zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710006822; c=relaxed/simple;
	bh=eHGGgHxWeZVDsl+6YbLy+gzdvMmFE7xSAZtcwCRf+dU=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=JuLJvoLIVgYfVReDWoz/fRDXG8KD5lPm5NMfLlHntUODFwECleCGhMaf8Q8pRtpCukonlCwix1e6gHbLIhThH09ulrZInzz6e4jDvZCnXnu0bGz/Jq0N5yTq02rwa5iYvUUvqBabnZhJ0+a723Elw+6M/IyUO+1rnXi3x/0qniw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hrq+tY/6; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hrq+tY/6"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-78830bba6a4so145393085a.0
        for <git@vger.kernel.org>; Sat, 09 Mar 2024 09:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710006819; x=1710611619; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cu+bAmad0ba5DuGGlKSnNyH3s6pRIkxkFXkfijDe224=;
        b=hrq+tY/6mZQrY3Aga6sG9uhOvFPYJvxGDmFMQZqAkN5YtM6bBhhrkSyg+Hy8WoJ8nn
         Ln0Ge7TwhWmsvYWg/MsGwBid3F3y8Fb3+v+AksXYIQcmLYo0isK07tO/t6b8rSNjEoQq
         FANzHkfUOgW6U5wbvTPkjICZCr4ir7tRI0vabojMKNMDn3HOk9D4ChSUI88uFMJfS6TL
         fqSWfHmbk/0t2LiiVebV1TA/HWCgRjVigkXlx+ZOlpu2C1nq+qrb726gb75/hBqjZSwE
         VZe4fsj8J+CWbpsUbXcv2Jgsq3UcOIVhlYPLyeRAROPcwk8crDRICj+wTj9zEmmpJvNk
         RmVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710006819; x=1710611619;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cu+bAmad0ba5DuGGlKSnNyH3s6pRIkxkFXkfijDe224=;
        b=WoBQG5qqUHjAR2TfyFPJeU2osNw7AOXd1AieXrKhJh58ndWux9h2vgD03TAHwd4rBQ
         9zMkoRYcsyaiMk49mSIieX0N3B2X+ye5iZbfHEBpTpSlROfySdezPgJXHOP/oAigCGy3
         IL/3LWXoovzTeHYKi89avcBsfMlVg/ql6Y2trYCUFoZGI655GdPfweOtfqwZs10lFQ63
         ZgNRbkVJa3dTSUVHrlYNukLNxDp82dOnPk/OvLcTsjma9avDR6RFw+fikZ6ydOee+mNq
         fmr3VbCb4H3ZBaecXhpyzGtJROFkM9SCP4pQWtryvp5CTOo9TcSHGimY4MSXVjAphpeL
         O/VA==
X-Forwarded-Encrypted: i=1; AJvYcCUPPc7u72GpZGxZ0yaMk+asn9RPtZAq5PWkMZaMfvAHSPi/nwuETt6+Xe5XXSedNWQDbBG6OFbH09wbL+kmhfaUa62C
X-Gm-Message-State: AOJu0Yyy2XRBgnRWVbswvRJ0fIazdAB41j5xTltbKxcxjChhVmjpTItt
	yGJGYuXO3FzLIH9CdfjUI8CV7sHqMbTPAaue+bX7Z03yo5PQqv/ZY1U4A/R2
X-Google-Smtp-Source: AGHT+IEyBQ0MCgiwm0RXp1yTmdzg9iJa0ffRmKmr4OOzPw5dZDhfncXx50hrZkXoVy50DMMLuWMvnQ==
X-Received: by 2002:a05:620a:3729:b0:788:22ee:ab6 with SMTP id de41-20020a05620a372900b0078822ee0ab6mr2906849qkb.51.1710006819249;
        Sat, 09 Mar 2024 09:53:39 -0800 (PST)
Received: from ?IPv6:2606:6d00:11:ff90:b1b9:ff9c:b8e:3049? ([2606:6d00:11:ff90:b1b9:ff9c:b8e:3049])
        by smtp.gmail.com with ESMTPSA id 26-20020a05620a04da00b0078838695dfasm1111272qks.59.2024.03.09.09.53.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Mar 2024 09:53:38 -0800 (PST)
Subject: Re: [PATCH] sequencer: allow disabling conflict advice
To: Junio C Hamano <gitster@pobox.com>,
 Phillip Wood <phillip.wood123@gmail.com>
Cc: Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
References: <pull.1682.git.1709396291693.gitgitgadget@gmail.com>
 <3df4790a-7ee1-4c72-a3da-ba8a48d546b8@gmail.com>
 <6a31efcc-c6c2-4729-80b9-eecff4ec9e31@gmail.com> <xmqqy1axq3t1.fsf@gitster.g>
From: Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <12c84208-23a7-5ba7-18a9-822d9a8f66fa@gmail.com>
Date: Sat, 9 Mar 2024 12:53:38 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <xmqqy1axq3t1.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit

Hi Phillip and Junio,

Le 2024-03-04 à 12:56, Junio C Hamano a écrit :
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> ... So we probably do need a new config variable but
>> I think it should have a generic name - not be sequencer specific so
>> we can extend its scope in the future to "git merge", "git am -3",
>> "git stash" etc.
> 
> A very good point.  Thanks for your careful thinking.

OK, I agree we can make the new advice more generic, but I'm lacking
inspiration for the name. Maybe 'advice.mergeConflicted' ? 
Or 'advice.resolveConflictedMerge' ? though this is close to the existing 
'resolveConflict'... 
Maybe just 'advice.mergeConflict' ?

Thanks, 
Philippe.
