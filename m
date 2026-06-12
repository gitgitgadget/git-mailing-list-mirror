Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0BF384243
	for <git@vger.kernel.org>; Fri, 12 Jun 2026 15:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781276683; cv=none; b=uBZRceG4Isk2X2e21G2wH5NY0nF85uplcBBMk4xuNqf47+K7CIHXCjGArv1Sbt54GOa8Dh/SHLtiX5OJYtjP0nQQeVB7pevVtkU83xfZaa4fgekVDlGhCUYhsjC/FpS/CNSfI7vjc+C+Sgia2gjEr8ApxblVmWBvs8VQnfQXwBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781276683; c=relaxed/simple;
	bh=t8hOsG1/MF2Z2EyiUYzVck/IZ/GJszMaVsRaAy3EGcQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KIBwjb4gSUdK3ciHgEhHFyQy7409sVpQwhMrwYUwwNtYO6+jRCC+k0XpRpVabV8db93TIoS9ke4pZu4xl/QLOBaoZpGFPoy+9Qd2AlkyqVSwh4E0SOT+q+oUh+pNtjIpuNFAn/7sIhiAxYWr40A8pEt/1TNPpwRMkeXth3pPK3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CL77kZg6; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CL77kZg6"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-48611ccd5aeso661956b6e.2
        for <git@vger.kernel.org>; Fri, 12 Jun 2026 08:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781276680; x=1781881480; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TtEPmIVzpyGSoNcvIWGkDeNwGl95sAUxRfOX524vGQA=;
        b=CL77kZg6WkK8JwpT0dED7+a65UDlOK5YBMxwb5PfucTKDvCQpb9uDxywBu+bBy7WRM
         8XlAuw7tfwBT8T+JZ23+wpML1Ftb/DB/x5ebnueVJyu8oVqVqm/SQ9p9PtCtdnw3xAY/
         1WZnq0k5uweBGV9eWV0W4A8lfgbJVaapZDSWEkDyhjMA52AHmOcsY0lERtpTiqiUfiUx
         JC5499VE80Z2+vwqc6Ip7Y9z2kxbmIIPJ1XmLQZIcOqPKnce0rETM5OMjh7yYfh3CmPg
         KSBMtKDnGe6yjER3UxPfIO5pCsNwyFet4DESo26cmzUQC+nN8DGAF6OsgVpmVpLv97zh
         iusA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781276680; x=1781881480;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TtEPmIVzpyGSoNcvIWGkDeNwGl95sAUxRfOX524vGQA=;
        b=lLU/Wv+vQtQ3U2x+GzII9LHEmcDT2kqj6adqJj/OlnxcwVHspcGE/adI6zWVxzJ90b
         bdEvy/yqFovqchs2b/8GwQC0PiH02oOpYLd6PHxT8iVd51Gt2DLByUGSaRKiNrPQPPr/
         8aFk10MEQplFbO8yPLZJr6ox3bcLeOalz3hmtQtbG2KnbJtZy0HGHghdoCwUEEORsSkd
         KBGCSjSqI1RmNkiaw7lCKBrPf/dl13Oq+b9DZ2e3qQUBIen4XD+FsI8UC1CPLANPLu8w
         fCjIum5EGRlMMEbs/QVzCXNpIV53dgyvB4+089BnxvweMT/jk8rl206G2EfS9BG77gv6
         6n1g==
X-Gm-Message-State: AOJu0YwISUcglnidvAt0X8raVdy/G691jhHuxg12ShnubdhYz24+lUu1
	0SIf2I8G9uonyMc5bEA/4q4GsHL/s6WdOXMJaVWO7IP1uPu/XqaLkWaz
X-Gm-Gg: Acq92OE0Jp27Wfp5/3es+ebbeVCZFYs26fyJIE08tszdOjBsqUpCOVm+ah7ZyyIvNYD
	LFfTemlrEMnQhIYrRpGayuO4Dr3M1mV14I9E7u7XZhPSWdGBI0lpitZa5eeFvw3AO45ACD1u9bq
	2Nlp9wb/QcwxCvZGODvrpRRynoNum3CIYYMhI8y/cHveIlKhevYfi+lPCC0+KUD0HgcIfkHXrix
	0FhAxtCyYCKgZYoEmxoeNLMiuUQeratAEdyW0r45ZyZJvrDO/rZU8FawCU+VcWzJ2HMOSEKcqev
	B1AMKD9PZ4FJET55VxCqW7gRR4w6SXJwdiTYB5hAewKS30JHZMO9rkPr3m026F72yQwKc07uT70
	4vS1W+jZy8TMt0MQHR2KuuHmHM41gV9JFLvJeES5VOzXNB8ZsmVQxS0001ABdVTCpWINvUruB9G
	6y12aDQ7dNELCioyyEItOwBnsFjkV8NAIecZRRD2i6yszwRxndFSNddxFgPkGJpkY83rv/qcv6o
	wy/EeI=
X-Received: by 2002:a05:6808:6f8e:b0:486:5115:6aa with SMTP id 5614622812f47-4872f36fd35mr2261376b6e.16.1781276679827;
        Fri, 12 Jun 2026 08:04:39 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.86.144])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8d3045773a7sm25471616d6.28.2026.06.12.08.04.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jun 2026 08:04:39 -0700 (PDT)
Message-ID: <8d0902ca-98b7-44a4-a23b-51de44ab6daa@gmail.com>
Date: Fri, 12 Jun 2026 11:04:38 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] commit-reach: terminate merge-base walk when one paint side
 is exhausted
To: Kristofer Karlsson <krka@spotify.com>
Cc: git@vger.kernel.org
References: <CAL71e4Mp7ewv0UGS8j=iTq6quyxLXzrr0uNDbWR8JKaOsTSVyA@mail.gmail.com>
 <0b3f7429-a4fb-4f7a-bf7b-5a0edeb1db52@gmail.com>
 <CAL71e4OmPzpCXh-zZ8NsT6L4zVKnXV1gqiFZ2w0XgMJhD=LArQ@mail.gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <CAL71e4OmPzpCXh-zZ8NsT6L4zVKnXV1gqiFZ2w0XgMJhD=LArQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/12/2026 10:32 AM, Kristofer Karlsson wrote:
> The required condition must then not be simply "one side exhausted".
> The walk must also continue while non-stale P1|P2 commits remain in the
> queue, since those still need STALE propagation - they are still
> merge-base candidates.
> 
> So the actual halt condition would be:
> 
>     no non-stale P1|P2 candidates in the queue
>     AND (no pure-P1 OR no pure-P2)

And since STALE is added only after both P1 and P2 bits, the two
conditions are identical to how queue_has_nonstale() terminates the
loop. 
> If this reasoning is correct, then the walk only terminates after
> merge-base candidates have either been processed or marked STALE,
> and the counterexample should produce [B] rather than [B, C].
That's the correct distinction: we need the set [B] and not [B,C]
but we need to discover that B can reach C to remove it from the
result set.

I think there is potential merit in "switching walk modes" to DFS
when all queued commits have both P1 and P2, but it comes with a
lot of complications. So tread carefully if you go down this road.

Thanks,
-Stolee

